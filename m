Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CFE2FE881
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbhAULQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:16:04 -0500
Received: from foss.arm.com ([217.140.110.172]:60006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbhAULMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:12:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D51E811B3;
        Thu, 21 Jan 2021 03:11:25 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.35.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0083F719;
        Thu, 21 Jan 2021 03:11:24 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:11:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210121111117.GA48431@C02TD0UTHF1T.local>
References: <20210121072031.23777-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy, Paul,

On Thu, Jan 21, 2021 at 08:20:22AM +0100, Willy Tarreau wrote:
> Hi Paul,
> 
> as per the recent discussion with Mark, I've updated the nolibc header to
> reflect latest upstream which is needed to build on arm64, and I performed
> the few cleanups that Mark rightfully suggested.
> 
> The following patches were taken from the upstream code and this time I
> carefully copied the original commit IDs in hope not to miss such fixes
> anymore in the future.
> 
> I've build-tested these on x86_64, i586, arm(v5 & v7), arm64, mips and
> mipsel, using compilers ranging from gcc 3.4 to gcc 9.3 so I think we're
> good for these archs now.

I've given this a spin atop v5.11-rc4, building natively on arm64 on a
Debian 10.7 system, and with the whole series applied I'm able to run
the rcutorture kvm.sh script without issue (the CONFIG warnings are
unrelated to nolibc):

| [mark@gravadlaks:~/src/linux]% ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs "TREE03"  --kmake-arg "CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64" --duration 1
| Creating a statically linked C-language initrd
| Done creating a statically linked C-language initrd
| Results directory: /home/mark/src/linux/tools/testing/selftests/rcutorture/res/2021.01.21-10.53.24
| ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs TREE03 --kmake-arg CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 --duration 1
| ----Start batch 1: Thu 21 Jan 10:53:24 GMT 2021
| TREE03 16: Starting build. Thu 21 Jan 10:53:24 GMT 2021
| TREE03 16: Waiting for build to complete. Thu 21 Jan 10:53:24 GMT 2021
| TREE03 16: Build complete. Thu 21 Jan 10:56:25 GMT 2021
| ---- TREE03 16: Kernel present. Thu 21 Jan 10:56:25 GMT 2021
| ---- Starting kernels. Thu 21 Jan 10:56:25 GMT 2021
| ---- All kernel runs complete. Thu 21 Jan 10:57:35 GMT 2021
| ---- TREE03 16: Build/run results:
|  --- Thu 21 Jan 10:53:24 GMT 2021: Starting build
| :CONFIG_HYPERVISOR_GUEST=y: improperly set
| :CONFIG_KVM_GUEST=y: improperly set
|  --- Thu 21 Jan 10:56:25 GMT 2021: Starting kernel
| QEMU 3.1.0 monitor - type 'help' for more information
| (qemu) Monitoring qemu job at pid 258620
| Grace period for qemu job at pid 258620
| 
| 
|  --- Thu 21 Jan 10:53:24 GMT 2021 Test summary:
| Results directory: /home/mark/src/linux/tools/testing/selftests/rcutorture/res/2021.01.21-10.53.24
| ./tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 255 --configs TREE03 --kmake-arg CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 --duration 1
| TREE03 ------- 475 GPs (7.91667/s) [rcu: g5737 f0x0 total-gps=1713]
| :CONFIG_HYPERVISOR_GUEST=y: improperly set
| :CONFIG_KVM_GUEST=y: improperly set

So FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]

It would be great if this could be applied soon so that it's possible to
use the rcutorture scripts without applying local hacks.

Willy, thanks for sorting this out, especially so quickly!

Thanks,
Mark.
