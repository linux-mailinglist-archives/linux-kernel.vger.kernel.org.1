Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D804A2D7B88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbgLKQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391013AbgLKQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:50:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7+tL5lcFLpDv6gWJyhR8469+Mw9E43J1weoLYydVaO0=; b=QvKZKplAkUrX6wkf6X5/eqTXkT
        XecIIgi77PGSPoRNM+P+CM6TDkUjnaM9o99ISv2jRIoW1t+1oaVVIUXg+IGN5/wEhabz83fyNVER5
        w1Y/IMuGRnDysXQ8x/HiW31MT7PZsAXImSNY1Hz6gYALg9cPKIEg7+GqCnZGm7pX1xPdQp8Bw7Bk9
        SURGGupwbc9BVnif4v51nAosafcpPkiChHhT6e3rPuOj//8K+m/2zMFVGPYhnZwb/4YublcUSYmkv
        BRXYjgLim4gMV4WpgbwXBEtvU0xmSL2+RaugEDmC3lDGBBWDAgdqsTFaM/tjWqftD735bAzTeJR5n
        /qlJVNmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knlba-0001pI-Dk; Fri, 11 Dec 2020 16:49:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DB6F3003E5;
        Fri, 11 Dec 2020 17:49:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67DA620270BBA; Fri, 11 Dec 2020 17:49:15 +0100 (CET)
Date:   Fri, 11 Dec 2020 17:49:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool crashes with some clang produced .o files
Message-ID: <20201211164915.GA2414@hirez.programming.kicks-ass.net>
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
 <20201211093205.GU2414@hirez.programming.kicks-ass.net>
 <20201211163748.b37gashl6an6misu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211163748.b37gashl6an6misu@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:37:48AM -0600, Josh Poimboeuf wrote:
> On Fri, Dec 11, 2020 at 10:32:05AM +0100, Peter Zijlstra wrote:
> > Looking at elf.c, it seems we're missing an STT_SECTION symbol for
> > .text.
> > 
> > And indeed, when I add -fno-asynchronous-unwind-tables to clang-11, that
> > goes missing from the readelf .symtab listing. Help ?!
> 
> I had a similar problem with ORC relocations:
> 
>   e81e07244325 ("objtool: Support Clang non-section symbols in ORC generation")
> 
> If Clang strips the section symbol then we have to find the function
> symbol instead.

Argh, I knew I'd seen something like that before, but I couldn't find it :-/

> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index c6ab44543c92..9bc18864154f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -472,8 +472,25 @@ static int create_static_call_sections(struct objtool_file *file)
>  			return -1;
>  		}
>  		memset(reloc, 0, sizeof(*reloc));
> -		reloc->sym = insn->sec->sym;
> -		reloc->addend = insn->offset;
> +
> +		if (insn->sec->sym) {
> +			reloc->sym = insn->sec->sym;
> +			reloc->addend = insn->offset;
> +		} else {
> +			reloc->sym = find_symbol_containing(insn->sec, insn->offset);
> +			if (!reloc->sym) {
> +				WARN_FUNC("can't create static call: missing containing symbol",
> +					  insn->sec, insn->offset);
> +				return -1;
> +			}
> +
> +			reloc->addend = insn->offset - reloc->sym->offset;
> +		}
> +

Do we want to capture all that gunk in something like
elf_reloc_to_insn(reloc, insn) instead of duplicating the magic?
