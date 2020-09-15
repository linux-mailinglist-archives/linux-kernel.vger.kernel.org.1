Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAA26A22D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIOJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:30:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F6FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XzUi3jRhwCVjmcIYOoG7xXZTJwSeZPto842Bw8VZXYU=; b=FH0Md3tKGEKRS7XLMNpr3M+306
        pPgBT9IISx9r5i8/aLjRStX7JwnD9YRMoe/Bc76iotWqiqWWBohqZF/212lIciuhlWzsL9OEO0ODR
        HohS0ISt9MxSyVyonGg85rfXgg9uye5IXc0iuQCetXyB9XKbm7+tr7F4Skra/0if4WT6FjiyYOHNF
        KBiSSGIbjfuyPzIoNZEUHtkTLZBkp4PefC2kCdtcAAixgwmWMW8XhgKSdX9iy7M33mmzZ04hhNufi
        QOUvMf1Wafv5GbaJHuv+8HeKJdiGWJnW084YXTJ8g5EQTnsekMK32yUNHOb4tekW1gbebWM4EdqZC
        gSQaTldQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI7I4-000212-2E; Tue, 15 Sep 2020 09:30:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A28B3019CE;
        Tue, 15 Sep 2020 11:30:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3763214EDD49; Tue, 15 Sep 2020 11:30:16 +0200 (CEST)
Date:   Tue, 15 Sep 2020 11:30:16 +0200
From:   peterz@infradead.org
To:     Hugh Dickins <hughd@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mark@klomp.org
Subject: Re: Static call dependency on libelf version?
Message-ID: <20200915093016.GV1362448@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.11.2009142337530.1550@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2009142337530.1550@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:50:54AM -0700, Hugh Dickins wrote:
> This is just an FYI written from a position of ignorance: I may
> have got it wrong, and my build environment too piecemeal to matter
> to anyone else; but what I saw was weird enough to be worth mentioning,
> in case it saves someone some time.
> 
> I usually build and test on mmotm weekly rather linux-next daily.
> No problem with 5.9-rc3-mm1 from 2020-09-04, nor with 5.9-rc5, but
> (on two machines) 5.9-rc5-mm1 from 2020-09-13 could not link vmlinux:
> 
>   AR      init/built-in.a
>   LD      vmlinux.o
> ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
> ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
> ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
> ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
> ld: init/built-in.a: member init/main.o in archive is not an object
> make[1]: *** [vmlinux] Error 1
> make: *** [__sub-make] Error 2
> 
> On the third machine, a more recent installation, but using the same
> gcc and the same binutils, I could build the same config successfully.
> init/main.o was the same size on each (49216 bytes), but diff of hd
> of the good against the bad showed:
> 
> 2702,2709c2702,2709
> < 00bfc0 000001db 00000001 00000003 00000000  >................<
> < 00bfd0 00000000 00000000 0000b316 00000000  >................<
> < 00bfe0 00000018 00000000 00000000 00000000  >................<
> < 00bff0 00000001 00000000 00000008 00000000  >................<
> < 00c000 000001ee 00000004 00000040 00000000  >........@.......<
> < 00c010 00000000 00000000 0000b330 00000000  >........0.......<
> < 00c020 00000090 00000000 0000002d 00000030  >........-...0...<
> < 00c030 00000008 00000000 00000018 00000000  >................<
> ---
> > 00bfc0 00000000 00000000 000001f1 00000000  >................<
> > 00bfd0 79732e00 6261746d 74732e00 62617472  >..symtab..strtab<
> > 00bfe0 68732e00 74727473 2e006261 616c6572  >..shstrtab..rela<
> > 00bff0 7865742e 722e0074 2e616c65 61746164  >.text..rela.data<
> > 00c000 73622e00 722e0073 5f616c65 6172745f  >..bss..rela__tra<
> > 00c010 6f706563 73746e69 7274705f 722e0073  >cepoints_ptrs..r<
> > 00c020 2e616c65 74617473 635f6369 2e6c6c61  >ela.static_call.<
> > 00c030 74786574 65722e00 692e616c 2e74696e  >text..rela.init.<
> 
> and 217 other .os in the build tree also "corrupted".
> 
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_STATIC_CALL_INLINE=y
> stand out as new in the .config for 5.9-rc5-mm1, and references
> to objtool in static_call.h and static_call_types.h took me to
> tools/objtool/Makefile, with its use of libelf.
> 
> I've copied over files of the newer libelf (0.168) to the failing
> machines, which are now building the 5.9-rc5-mm1 vmlinux correctly.
> 
> It looks as if CONFIG_HAVE_STATIC_CALL=y depends on a newer libelf
> than I had before (0.155), and should either insist on a minimum
> version, or else be adjusted to work with older versions.

Hurmph, I have no idea how this happened; clearly none of my machines
have this older libelf :/ (the machines I use most seem to be on 0.180).

I'm also not sure what static_call is doing different from say orc
data generation. Both create and fill sections in similar ways.

Mark, do you have any idea?

