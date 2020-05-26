Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82D19C2D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbgDBNk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 09:40:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48220 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388704AbgDBNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:40:56 -0400
Received: from zn.tnic (p200300EC2F0A0E0081B68A69B956B416.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e00:81b6:8a69:b956:b416])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1280B1EC036E;
        Thu,  2 Apr 2020 15:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585834855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uvDwDvayPnasF2wlj/alAw6qSHbI8V86P3t492TnSQE=;
        b=p9NdyyponqEKJhwCaYtXDMl6RzVPPouWs1gryeBcmwkiGFQmuSZm/1SpTar/1mUxX2Wgn7
        16eVmTYc4jlSTBLH1fo1zcMWpJWG9biAmGJp5E8LidojFGQOHTlImtru2fZzDM0vYVcjdl
        bTvcn3/YQkDsy0FnP4TYSTl4BHZJ++U=
Date:   Thu, 2 Apr 2020 15:40:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Matz <matz@suse.de>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
Message-ID: <20200402134051.GC9352@zn.tnic>
References: <20200331080111.GA20569@gmail.com>
 <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
 <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
 <87v9mioj5r.fsf@nanos.tec.linutronix.de>
 <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 05:16:24PM -0700, Linus Torvalds wrote:
> Nobody else has a working compiler to even test that patch, because
> even upstream tip-of-the-day llvm mis-generates code (I have a patch
> that makes it generate ok code, but that one isn't good enough to
> actually go upstream in llvm).

Btw, looking at this:

https://reviews.llvm.org/rG50cac248773

and talking to a gcc guy (CCed), it should be also relatively easy to do
the fallthrough variant in gcc too so you could open a feature request
for that in the gcc bugzilla.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
