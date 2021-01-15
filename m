Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3462F7F12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbhAOPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727335AbhAOPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:09:46 -0500
X-Greylist: delayed 70072 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2021 10:09:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610723299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJb6ukKVIDGK20PzckBJC7srAf03mNvPdQ0z7RPLWw8=;
        b=LyGfAwQiJ0frKOHsMR4tLA48DYTpEK+1hEx0bvq2AvEmqUS63JoN2XDcgO/08I9y6yc7kt
        dY8tGaCYnd+czOIIiIhfD+ttc5J6Ib4mMA+8rNUPbQUj3ohDb2fQWhzO8zQ/g8P6eL4TOt
        BisY5V2HnhYHoK3Jcdh9p4mYTWViCJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-iMfeSiUpMzKE07biV3KWzQ-1; Fri, 15 Jan 2021 10:08:15 -0500
X-MC-Unique: iMfeSiUpMzKE07biV3KWzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C759CE650;
        Fri, 15 Jan 2021 15:08:14 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9DD60BF3;
        Fri, 15 Jan 2021 15:08:12 +0000 (UTC)
Date:   Fri, 15 Jan 2021 09:08:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 15/21] x86/xen/pvh: Convert indirect jump to retpoline
Message-ID: <20210115150811.abom3lkutyrwetpi@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>
 <12afb52c-f555-656e-d544-c2965a616bdc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12afb52c-f555-656e-d544-c2965a616bdc@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 06:24:10AM +0100, Jürgen Groß wrote:
> On 14.01.21 20:40, Josh Poimboeuf wrote:
> > It's kernel policy to not have (unannotated) indirect jumps because of
> > Spectre v2.  This one's probably harmless, but better safe than sorry.
> > Convert it to a retpoline.
> > 
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >   arch/x86/platform/pvh/head.S | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> > index 43b4d864817e..d87cebd08d32 100644
> > --- a/arch/x86/platform/pvh/head.S
> > +++ b/arch/x86/platform/pvh/head.S
> > @@ -16,6 +16,7 @@
> >   #include <asm/boot.h>
> >   #include <asm/processor-flags.h>
> >   #include <asm/msr.h>
> > +#include <asm/nospec-branch.h>
> >   #include <xen/interface/elfnote.h>
> >   	__HEAD
> > @@ -105,7 +106,7 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
> >   	/* startup_64 expects boot_params in %rsi. */
> >   	mov $_pa(pvh_bootparams), %rsi
> >   	mov $_pa(startup_64), %rax
> > -	jmp *%rax
> > +	JMP_NOSPEC rax
> 
> I'd rather have it annotated only.
> 
> Using ALTERNATIVE in very early boot code is just adding needless
> clutter, as the retpoline variant won't ever be active.

Yeah, Andy pointed out something similar.  I'll be changing this to an
annotation.

-- 
Josh

