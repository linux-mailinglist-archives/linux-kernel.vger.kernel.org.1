Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF23002FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbhAVMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbhAVMEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C23C235F7;
        Fri, 22 Jan 2021 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611317007;
        bh=JcKppLzJr0drhQ41nHOie5/bT8t3gv1bfMh7vgZ7EuM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tjT3qqtTtA/oeUgiEFpcNqCJt4dUZ7o6aRbuep2lthKSIciP4qdP1VoWAl/gzWdev
         oSVV0sMTzBOZ2kbG0G5x559fR2o310YS+UuZvadE6mrxlK2keI1EhHT0oi9TwI1WC9
         i5jCGHvgkJtVcvDp1DaRoNtqpQf7KdebCfJDWOaILeZJ7QYe2CKIt/ifS8uCUxnmZh
         vrwJVsgi1gY8vv4Mwyx82vu6IA9N0otoYhCYIBQNFDJY8RcnA1TysJnc6sz+8gN3ZL
         56IAWcC3HRH57DhGNy1NNAWvbdluu+g2TxoSEPDc5n8g/prE/M1dwQ7Oy74vcPHqy3
         sTRr5rrsPy59g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AEE773522649; Fri, 22 Jan 2021 04:03:26 -0800 (PST)
Date:   Fri, 22 Jan 2021 04:03:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Willy Tarreau <w@1wt.eu>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210122120326.GA4848@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210121072031.23777-1-w@1wt.eu>
 <20210121111117.GA48431@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121111117.GA48431@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:11:17AM +0000, Mark Rutland wrote:

[ . . . ]

> I've given this a spin atop v5.11-rc4, building natively on arm64 on a
> Debian 10.7 system, and with the whole series applied I'm able to run
> the rcutorture kvm.sh script without issue (the CONFIG warnings are
> unrelated to nolibc):
> 
> | [mark@gravadlaks:~/src/linux]% ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs "TREE03"  --kmake-arg "CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64" --duration 1
> | Creating a statically linked C-language initrd
> | Done creating a statically linked C-language initrd
> | Results directory: /home/mark/src/linux/tools/testing/selftests/rcutorture/res/2021.01.21-10.53.24
> | ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs TREE03 --kmake-arg CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 --duration 1
> | ----Start batch 1: Thu 21 Jan 10:53:24 GMT 2021
> | TREE03 16: Starting build. Thu 21 Jan 10:53:24 GMT 2021
> | TREE03 16: Waiting for build to complete. Thu 21 Jan 10:53:24 GMT 2021
> | TREE03 16: Build complete. Thu 21 Jan 10:56:25 GMT 2021
> | ---- TREE03 16: Kernel present. Thu 21 Jan 10:56:25 GMT 2021
> | ---- Starting kernels. Thu 21 Jan 10:56:25 GMT 2021
> | ---- All kernel runs complete. Thu 21 Jan 10:57:35 GMT 2021
> | ---- TREE03 16: Build/run results:
> |  --- Thu 21 Jan 10:53:24 GMT 2021: Starting build
> | :CONFIG_HYPERVISOR_GUEST=y: improperly set
> | :CONFIG_KVM_GUEST=y: improperly set

These two (apparently harmless) error messages are due to these lines
in CFcommon:

CONFIG_HYPERVISOR_GUEST=y
CONFIG_KVM_GUEST=y

It looks like CONFIG_HYPERVISOR_GUEST is specific to x86, while KVM_GUEST
is specific to x86, powerpc, and mips.  (It appears that arm64 doesn't
need anything here?)  Given this variety, I need to make rcutorture
know very early on what arch it is building for.  My current approach of
looking at the vmlinux file won't work because I need to get the config
right before building the kernel.

One approach would be to look at the initrd/init file, but doing this
reliably would mean removing the ability for users to supply their own
initrd file trees.  Another approach would be to look at the current
environment, perhaps using "uname -m", which will work until someone
wants to cross-build.  Yet another approach would be to parse the target
line from the output of "${CROSS_COMPILE}gcc -v".

Left to myself, I would parse the output of "${CROSS_COMPILE}gcc -v".

Thoughts?

							Thanx, Paul

> |  --- Thu 21 Jan 10:56:25 GMT 2021: Starting kernel
> | QEMU 3.1.0 monitor - type 'help' for more information
> | (qemu) Monitoring qemu job at pid 258620
> | Grace period for qemu job at pid 258620
> | 
> | 
> |  --- Thu 21 Jan 10:53:24 GMT 2021 Test summary:
> | Results directory: /home/mark/src/linux/tools/testing/selftests/rcutorture/res/2021.01.21-10.53.24
> | ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs TREE03 --kmake-arg CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 --duration 1
> | TREE03 ------- 475 GPs (7.91667/s) [rcu: g5737 f0x0 total-gps=1713]
> | :CONFIG_HYPERVISOR_GUEST=y: improperly set
> | :CONFIG_KVM_GUEST=y: improperly set
> 
> So FWIW:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
> 
> It would be great if this could be applied soon so that it's possible to
> use the rcutorture scripts without applying local hacks.
> 
> Willy, thanks for sorting this out, especially so quickly!
> 
> Thanks,
> Mark.
