Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A468727EF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgI3QbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3QbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:31:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923CCC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:31:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f092a00869c7b979af15d7f.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:869c:7b97:9af1:5d7f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 161D51EC0445;
        Wed, 30 Sep 2020 18:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601483483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Dx1aQOyK27/HcHW28nNDA9Vv+UI+LGYZbrAVg6hlBNU=;
        b=WbG9D0/S4P0UhShhqC9MRCNUOGYilohzf2HkpJ/Alj9K8N/LHWblgOtEluODfrBPQxbPda
        C5L6HMe1zsOGC0yzYL14TP5RvWT9j0kMZnbgAYgYFWzg7/r4sWuITBR/8gyoJZ2JKOIKqc
        lKe8uDPCSIFsNes3ukIwx4aaoRje+Co=
Date:   Wed, 30 Sep 2020 18:31:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: general protection fault in perf_misc_flags
Message-ID: <20200930163120.GJ6810@zn.tnic>
References: <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic>
 <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic>
 <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
 <20200928202353.GI1685@zn.tnic>
 <20200929083336.GA21110@zn.tnic>
 <CACT4Y+bfKwoZe3SC-BKJkOET1GxGp9tCpLzkae8q1sjWYnmgmw@mail.gmail.com>
 <20200930161711.GH6810@zn.tnic>
 <CACT4Y+Zc7kD431Aed49U4R6cqzWGAWqEXevnheRHKQRQoEnh7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zc7kD431Aed49U4R6cqzWGAWqEXevnheRHKQRQoEnh7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 06:23:44PM +0200, Dmitry Vyukov wrote:
> Here is the answer:
> https://github.com/google/syzkaller/blob/master/tools/create-gce-image.sh#L189
> 
> # rodata=n: mark_rodata_ro becomes very slow with KASAN (lots of PGDs)
> 
> I have some vague memory that there was some debug double checking
> that pages are indeed read-only and that debug check was slow, but it
> was always executed without rodata=n.

Sounds like debug_checkwx() which is disabled by turning off
CONFIG_DEBUG_WX.

You could either disable it in your .configs or, provided there's even
such an option, disable KASAN checking around it until that one-time
boot test completes and then reenable KASAN.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
