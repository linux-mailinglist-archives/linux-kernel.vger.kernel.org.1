Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1171D300ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbhAVPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbhAVPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:43:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9511B20702;
        Fri, 22 Jan 2021 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611330161;
        bh=dK9nnuPqdk7eCdORc2NRCuDOAvgY9SiLb3IbZNmLcmw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mYXAIjTGPyGtg5PU1co9IFTCJ1tMXFTaNuWUP2bhGscuar+2eIbAfcJQoOuU6rpCf
         0OTiZGvDnSoJ1xwt1lMEmyuzwrUyZQmu6tCzxfSjXroXnQYhonPtlgcYJMIkvVRpDq
         hFWuH2Swfl4JIbUJwh6fHT9kGBhRuc0XZdb5f9Ruw2brRdgh9tC9NQwCeg9zyXBFiu
         FZ48jY/lpKThhbXoXeJne8Fsum/9tFgsQ4jAbL6fPCjpPoMLui80kwUbiIZB2tXST8
         xSw6qVBtSb2om6x+0GxQ9+adPCyJZoltKnlPZZRl4QYyZ6XSxnLuShEW4WnJuFNC9x
         EsZpw11J/DZQQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 591763522649; Fri, 22 Jan 2021 07:42:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 07:42:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Willy Tarreau <w@1wt.eu>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210122154241.GH2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210121072031.23777-1-w@1wt.eu>
 <20210121111117.GA48431@C02TD0UTHF1T.local>
 <20210122120326.GA4848@paulmck-ThinkPad-P72>
 <20210122122542.GA31304@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122122542.GA31304@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 12:25:42PM +0000, Mark Rutland wrote:
> On Fri, Jan 22, 2021 at 04:03:26AM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 21, 2021 at 11:11:17AM +0000, Mark Rutland wrote:
> > 
> > [ . . . ]
> > 
> > > I've given this a spin atop v5.11-rc4, building natively on arm64 on a
> > > Debian 10.7 system, and with the whole series applied I'm able to run
> > > the rcutorture kvm.sh script without issue (the CONFIG warnings are
> > > unrelated to nolibc):
> > > 
> > > | [mark@gravadlaks:~/src/linux]% ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs "TREE03"  --kmake-arg "CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64" --duration 1
> > > | Creating a statically linked C-language initrd
> > > | Done creating a statically linked C-language initrd
> > > | Results directory: /home/mark/src/linux/tools/testing/selftests/rcutorture/res/2021.01.21-10.53.24
> > > | ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs TREE03 --kmake-arg CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 --duration 1
> > > | ----Start batch 1: Thu 21 Jan 10:53:24 GMT 2021
> > > | TREE03 16: Starting build. Thu 21 Jan 10:53:24 GMT 2021
> > > | TREE03 16: Waiting for build to complete. Thu 21 Jan 10:53:24 GMT 2021
> > > | TREE03 16: Build complete. Thu 21 Jan 10:56:25 GMT 2021
> > > | ---- TREE03 16: Kernel present. Thu 21 Jan 10:56:25 GMT 2021
> > > | ---- Starting kernels. Thu 21 Jan 10:56:25 GMT 2021
> > > | ---- All kernel runs complete. Thu 21 Jan 10:57:35 GMT 2021
> > > | ---- TREE03 16: Build/run results:
> > > |  --- Thu 21 Jan 10:53:24 GMT 2021: Starting build
> > > | :CONFIG_HYPERVISOR_GUEST=y: improperly set
> > > | :CONFIG_KVM_GUEST=y: improperly set
> > 
> > These two (apparently harmless) error messages are due to these lines
> > in CFcommon:
> > 
> > CONFIG_HYPERVISOR_GUEST=y
> > CONFIG_KVM_GUEST=y
> 
> Yup; I had figured this out, but since this wasn't getting in the way of
> actually running the torture tests I had assumed we could deal with that
> at some indefinite point in the future, or simply ignore it. ;)
> 
> > It looks like CONFIG_HYPERVISOR_GUEST is specific to x86, while KVM_GUEST
> > is specific to x86, powerpc, and mips.  (It appears that arm64 doesn't
> > need anything here?) 
> 
> Yup, we don't need any special options -- arm64 doesn't stricly need any
> guest enlightenment to run under a hypervisor, so we never had a need
> for KVM_GUEST or HYPERVISOR_GUEST. We have all the common
> paravritualized drivers (e.g. virtio) in defconfig too, so that should
> all work out of the box.
> 
> > Given this variety, I need to make rcutorture know very early on what
> > arch it is building for.  My current approach of looking at the
> > vmlinux file won't work because I need to get the config right before
> > building the kernel.
> > 
> > One approach would be to look at the initrd/init file, but doing this
> > reliably would mean removing the ability for users to supply their own
> > initrd file trees.  Another approach would be to look at the current
> > environment, perhaps using "uname -m", which will work until someone
> > wants to cross-build.  Yet another approach would be to parse the target
> > line from the output of "${CROSS_COMPILE}gcc -v".
> > 
> > Left to myself, I would parse the output of "${CROSS_COMPILE}gcc -v".
> 
> Heh, I hadn't considered parsing the target line from that output, and I
> guess that works for native builds where "${CROSS_COMPILE}" = "". Neat
> trick!

Credit to Willy Tarreau.  Me, I just realized that he needed to do
-something- to create rcutorture's initrd.  ;-)

> That sounds sensible to me!

Let me see what I can do.

My thought is to add optional CFcommon.<arch> files, and pull them in
when there is a match.  But I will give it more thought.

							Thanx, Paul
