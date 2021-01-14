Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E631C2F6F20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbhANXtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:49:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731085AbhANXtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610668071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gjwyOUiSUpCSsJCrPVANVQOkwMWYIbGT02bwnsYs1vM=;
        b=EV/t8AoizdCqiWsKQK2zKsrD9gjgJlHeudj2z7nszg8VFAIs1eFBz4/JMGsIXNWQaaTj+x
        +OYnbqh6CAreDbvyBKs5oVUTl8YoOkoiSm36vG1YF2cGB5C8lFA/h7RkAp41iunnrAw6fb
        f+lO49h3d8EZhcCGqOtrZEAWxNzGKEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-nua4-psjMg-xq2q7Ki0vvQ-1; Thu, 14 Jan 2021 18:47:47 -0500
X-MC-Unique: nua4-psjMg-xq2q7Ki0vvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CE1015720;
        Thu, 14 Jan 2021 23:47:45 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 969DC5F9AC;
        Thu, 14 Jan 2021 23:47:42 +0000 (UTC)
Date:   Thu, 14 Jan 2021 17:47:37 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 17/21] x86/acpi: Convert indirect jump to retpoline
Message-ID: <20210114234737.xpltgdu3vpa6spgb@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <a1e4f5620deb81fc644b436eca5f51ec3a694459.1610652862.git.jpoimboe@redhat.com>
 <5017a6c5-55fa-0767-b1ed-2bd9e2a5efc1@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5017a6c5-55fa-0767-b1ed-2bd9e2a5efc1@citrix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:59:39PM +0000, Andrew Cooper wrote:
> On 14/01/2021 19:40, Josh Poimboeuf wrote:
> > It's kernel policy to not have (unannotated) indirect jumps because of
> > Spectre v2.  This one's probably harmless, but better safe than sorry.
> > Convert it to a retpoline.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/x86/kernel/acpi/wakeup_64.S | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> > index 5d3a0b8fd379..0b371580e620 100644
> > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > @@ -7,6 +7,7 @@
> >  #include <asm/msr.h>
> >  #include <asm/asm-offsets.h>
> >  #include <asm/frame.h>
> > +#include <asm/nospec-branch.h>
> >  
> >  # Copyright 2003 Pavel Machek <pavel@suse.cz
> >  
> > @@ -39,7 +40,7 @@ SYM_FUNC_START(wakeup_long64)
> >  	movq	saved_rbp, %rbp
> >  
> >  	movq	saved_rip, %rax
> > -	jmp	*%rax
> > +	JMP_NOSPEC rax
> >  SYM_FUNC_END(wakeup_long64)
> 
> I suspect this won't work as you intend.
> 
> wakeup_long64() still executes on the low mappings, not the high
> mappings, so the `jmp __x86_indirect_thunk_rax` under this JMP_NOSPEC
> will wander off into the weeds.
> 
> This is why none of the startup "jmps from weird contexts onto the high
> mappings" have been retpolined-up.

D'oh.  Of course it wouldn't be that easy.  I suppose the other two
retpoline patches (15 and 21) are bogus as well.

-- 
Josh

