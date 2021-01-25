Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682CA302D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbhAYVSX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 16:18:23 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:54302 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732089AbhAYVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:14:45 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23697578-1500050 
        for multiple; Mon, 25 Jan 2021 21:13:58 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210125210456.GA196782@linux.ibm.com>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com> <161160687463.28991.354987542182281928@build.alporthouse.com> <20210125210456.GA196782@linux.ibm.com>
Subject: Re: Linux 5.11-rc5
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Date:   Mon, 25 Jan 2021 21:13:59 +0000
Message-ID: <161160923954.29150.8571056944016500691@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Rapoport (2021-01-25 21:04:56)
> On Mon, Jan 25, 2021 at 08:34:34PM +0000, Chris Wilson wrote:
> > Quoting Linus Torvalds (2021-01-25 01:06:40)
> > > Mike Rapoport (3):
> > ...
> > >       mm: fix initialization of struct page for holes in memory layout
> > 
> > We have half a dozen or so different machines in CI that are silently
> > failing to boot, that we believe is bisected to this patch.
> > 
> > 17:56              tsa : ickle: dolphin: I hit the following patch in my bisection, and the hang is also dependent on kconfig
> > 17:56              tsa : first bad commit: [d3921cb8be29ce5668c64e23ffdaeec5f8c69399] mm: fix initialization of struct page for holes in
> >                          memory layout
> > 17:57              tsa : couldn't reproduce on older CI kconfig, current one does it
> >                          https://gitlab.freedesktop.org/gfx-ci/i915-infra/-/blob/master/kconfig/debug
> > 
> > Here's a boot dmesg from some affected machines from just before the merge
> > with rc5:
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/shard-skl1/boot18.txt
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-skl-6600u/boot.html
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bsw-cyan/boot.html
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bdw-samus/boot.html
> 
> Is there any way to get early console from these machines?

12:16 tsa : none of those have good hook for serial

Nothing on the console and no serial console option, and panics before
netconsole.

Maybe some early_printk and boot_delay if you think there's something to
see with those, but I'll have to ask Tomi nicely tomorrow.
-Chris
