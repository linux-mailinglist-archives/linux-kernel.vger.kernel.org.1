Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987112918B2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJRRuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:50:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37584 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRRuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:50:00 -0400
Received: from zn.tnic (p200300ec2f250700329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F9ED1EC0249;
        Sun, 18 Oct 2020 19:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603043399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SbE868tEU7gQHKQ0mIlsGDQikJ8XI0dl4ksEKyh2LKI=;
        b=baWm0yBXxtPAEzeNqadcs7KN+z+Lwlfu3TUg9gfHRBjo8OveGmKVQ12yOX66Fmzp+YzSOG
        8SKHGnW42L2K4LKsk3SrMd4gbI4s2PqkZT+odci2/mRTI86thTHRUWDrQTownkh9XBI+9g
        5DRD/xm2Rbrt2X07TywIKZ0/xyF6OgQ=
Date:   Sun, 18 Oct 2020 19:49:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        jpoimboe@redhat.com, mbenes@suse.cz,
        "peterz@infradead.org" <peterz@infradead.org>,
        shile.zhang@linux.alibaba.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [WARNING AND ERROR]  may be  system slow and  audio and
 video breaking
Message-ID: <20201018174948.GC8364@zn.tnic>
References: <959da1eee73f58a824fe4913b5cacda6de0f392e.camel@rajagiritech.edu.in>
 <b4533bcbb095cf11f01d0adfd50912c52242eb02.camel@rajagiritech.edu.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4533bcbb095cf11f01d0adfd50912c52242eb02.camel@rajagiritech.edu.in>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 10:42:39PM +0530, Jeffrin Jose T wrote:
> smpboot: Scheduler frequency invariance went wobbly, disabling!
> [ 1112.592866] unchecked MSR access error: RDMSR from 0x123 at rIP:
> 0xffffffffb5c9a184 (native_read_msr+0x4/0x30)
> [ 1112.592869] Call Trace:
> [ 1112.592876]  update_srbds_msr+0x6f/0xb0
> [ 1112.592880]  smp_store_cpu_info+0x8e/0xb0
> [ 1112.592883]  start_secondary+0x93/0x200
> [ 1112.592887]  ? set_cpu_sibling_map+0xcb0/0xcb0
> [ 1112.592891]  secondary_startup_64+0xa4/0xb0
> [ 1112.592898] unchecked MSR access error: WRMSR to 0x123 (tried to
> write 0x0000000000000000) at rIP: 0xffffffffb5c9a264
> (native_write_msr+0x4/0x20)
> [ 1112.592899] Call Trace:
> [ 1112.592902]  update_srbds_msr+0x98/0xb0
> [ 1112.592904]  smp_store_cpu_info+0x8e/0xb0
> [ 1112.592907]  start_secondary+0x93/0x200
> [ 1112.592911]  ? set_cpu_sibling_map+0xcb0/0xcb0
> [ 1112.592914]  secondary_startup_64+0xa4/0xb0
> [ 2915.106879] show_signal: 6 callbacks suppressed
> [ 6089.209343] WARNING: stack going in the wrong direction? at
> i915_gem_close_object+0x2fb/0x560 [i915]

This looks strange.

Please send

- full dmesg
- output from the "grep -r . /sys/devices/system/cpu/vulnerabilities/" command
- /proc/cpuinfo
- .config

Privately is fine too.

> -----------------x---------------x----------------x------------
> Linux debian 5.9.1-rc1+ #4 SMP Fri Oct 16 16:48:04 IST 2020 x86_64

What kernel is that exactly?

Can you reproduce with plain v5.9 too?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
