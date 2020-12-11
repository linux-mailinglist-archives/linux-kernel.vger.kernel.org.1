Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190402D7B20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgLKQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387512AbgLKQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607704676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PtVyYY9nnquN+aBfs+/yQ1OYbTNln1k2UMH3Bn2/FdM=;
        b=YXrbJtroMyuLaNBfMVgId8m7n+MTTiZWnI/v6Yl3M9dayFfVNmjSSxDaTzlYrHUxZvCKBX
        bXh/2ZQECfaeGaOpc2iaS9NLoI5MVRsJAbwnxZuAtxKaxQH0DZqx8qZz7WTVWpaLHk7+Sd
        bwa18sbSd29hkVR9gNXjmE9LV95RCFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-9Eb3NqLeNCy0Dhg_xbUbBw-1; Fri, 11 Dec 2020 11:37:54 -0500
X-MC-Unique: 9Eb3NqLeNCy0Dhg_xbUbBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F490801817;
        Fri, 11 Dec 2020 16:37:53 +0000 (UTC)
Received: from treble (ovpn-115-21.rdu2.redhat.com [10.10.115.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7FD25D72E;
        Fri, 11 Dec 2020 16:37:50 +0000 (UTC)
Date:   Fri, 11 Dec 2020 10:37:48 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool crashes with some clang produced .o files
Message-ID: <20201211163748.b37gashl6an6misu@treble>
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
 <20201211093205.GU2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201211093205.GU2414@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:32:05AM +0100, Peter Zijlstra wrote:
> Looking at elf.c, it seems we're missing an STT_SECTION symbol for
> .text.
> 
> And indeed, when I add -fno-asynchronous-unwind-tables to clang-11, that
> goes missing from the readelf .symtab listing. Help ?!

I had a similar problem with ORC relocations:

  e81e07244325 ("objtool: Support Clang non-section symbols in ORC generation")

If Clang strips the section symbol then we have to find the function
symbol instead.

Does this fix it?

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..9bc18864154f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -472,8 +472,25 @@ static int create_static_call_sections(struct objtool_file *file)
 			return -1;
 		}
 		memset(reloc, 0, sizeof(*reloc));
-		reloc->sym = insn->sec->sym;
-		reloc->addend = insn->offset;
+
+		if (insn->sec->sym) {
+			reloc->sym = insn->sec->sym;
+			reloc->addend = insn->offset;
+		} else {
+			reloc->sym = find_symbol_containing(insn->sec, insn->offset);
+			if (!reloc->sym) {
+				WARN_FUNC("can't create static call: missing containing symbol",
+					  insn->sec, insn->offset);
+				return -1;
+			}
+
+			reloc->addend = insn->offset - reloc->sym->offset;
+		}
+
 		reloc->type = R_X86_64_PC32;
 		reloc->offset = idx * sizeof(struct static_call_site);
 		reloc->sec = reloc_sec;

