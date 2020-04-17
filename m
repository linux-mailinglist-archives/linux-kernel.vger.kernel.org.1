Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE01AE6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 22:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgDQUUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgDQUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:20:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC658C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:20:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPXSw-0006dZ-Jf; Fri, 17 Apr 2020 22:19:58 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1CCE3100C47; Fri, 17 Apr 2020 22:19:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Dionne <marc.c.dionne@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: Re: FreeNAS VM disk access errors, bisected to commit 6f1a4891a592
In-Reply-To: <CAB9dFdtBqrcmKcV=zxPyV5uNB7WeKOqqC4k5KtY+9vxS9ooKoA@mail.gmail.com>
References: <CAB9dFdtBqrcmKcV=zxPyV5uNB7WeKOqqC4k5KtY+9vxS9ooKoA@mail.gmail.com>
Date:   Fri, 17 Apr 2020 22:19:58 +0200
Message-ID: <87d085zwy9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

Marc Dionne <marc.c.dionne@gmail.com> writes:

> Commit 6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity
> race") causes Linux VMs hosted on FreeNAS (bhyve hypervisor) to lose
> access to their disk devices shortly after boot.  The disks are zfs
> zvols on the host, presented to each VM.
>
> Background: I recently updated some fedora 31 VMs running under the
> bhyve hypervisor (hosted on a FreeNAS mini), and they moved to a
> distro 5.5 kernel (5.5.15).  Shortly after reboot, the disks became
> inaccessible with any operation getting EIO errors.  Booting back into
> a 5.4 kernel, everything was fine.  I built a 5.7-rc1 kernel, which
> showed the same symptoms, and was then able to bisect it down to
> commit 6f1a4891a592.  Note that the symptoms do not occur on every
> boot, but often enough (roughly 80%) to make bisection possible.
>
> Applying a manual revert of 6f1a4891a592 on top of mainline from
> yesterday gives me a kernel that works fine.

we tested on real hardware and various hypervisors that the fix actually
works correctly.

That makes me assume that the staged approach of changing affinity for
this non-maskable MSI mess makes your particular hypervisor unhappy.

Are there any messages like this:

 "do_IRQ: 0.83 No irq handler for vector"

in dmesg on the Linux side? If they happen then before the disk timeout
happens.

I have absolutely zero knowledge about bhyve, so may I suggest to talk
to the bhyve experts about this.

Thanks,

        tglx
