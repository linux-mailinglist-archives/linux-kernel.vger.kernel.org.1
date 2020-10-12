Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2A928ACA9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 06:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgJLD7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:59:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43301 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgJLD7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:59:51 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09C3wlP9011315;
        Mon, 12 Oct 2020 05:58:47 +0200
Date:   Mon, 12 Oct 2020 05:58:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
Message-ID: <20201012035846.GB11282@1wt.eu>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
 <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Sun, Oct 11, 2020 at 07:05:55PM +0200, Enric Balletbo i Serra wrote:
> For arm64 (i.e : arm64_defconfig):
>     1. Someone renames CONFIG_A to CONFIG_AB, sends a patch, and as he did a
> grep, the patch modifies all the defconfigs.
>     2. The patch is accepted and merged in linux-next.
>     3. KernelCI builds linux-next, boots the kernel on the hardware and all the
> tests continue passing.
> 
> 
> For x86:
>     1. Someone renames CONFIG_A to CONFIG_AB, sends a patch and as he did a grep
> the patches modifies all the defconfigs.
>     2. The patch is accepted and merged in linux-next.
>     3. KernelCI builds linux-next, boots the kernel on the hardware, and some
> tests start to fail or are skipped.
>     4. The maintainer is noticed about the behavior change, so he will need to
> look at the problem, and find it.
>     5. The maintainer sends a patch.
>     6. The patch is accepted, but he needs to tag the release as per kernel <
> x.y.z version it should use CONFIG_A and for kernel > x.y.z it should pick
> CONFIG_AB.
>     7. KernelCI builds linux-next, boots the kernel on the hardware and all the
> tests pass again.

Previously I thought I understood your needs, but now I don't anymore. You
seem to be saying that you're not testing *anything* outside of defconfig,
and that as such you'd like defconfig to be complete enough to provide good
coverage. This sounds a bit odd to me. And what if in the arm64 case, the
CONFIG_YOUR_V4L2_DEVICE is *not* added to defconfig ? You're in the same
situation.

We all know it's not fun to have to deal with local config snippets, but
as soon as you plan to boot on a specific hardware, this is unavoidable.
Also, config symbols are rarely renamed. Most often they are moved under
new entries (e.g. CONFIG_VENDOR_FOO) which are enabled by default, so
that updating your old configuration using "make olddefconfig" is enough
to update it.

What I'm understanding from your proposed change is not to support
KernelCI, but to support Chromebooks by default. This could make more
sense if that's a relevant platform whose support is currently limited
by default, I'm not able to judge that, but at least it seems to me
this would make more sense than having specific configs for KernelCI.

Just my 2 cents,
Willy
