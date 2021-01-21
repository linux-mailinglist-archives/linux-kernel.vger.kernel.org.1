Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5B2FE893
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbhAULId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:08:33 -0500
Received: from foss.arm.com ([217.140.110.172]:59806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbhAULGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:06:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACDA911B3;
        Thu, 21 Jan 2021 03:05:54 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3A1D3F719;
        Thu, 21 Jan 2021 03:05:53 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after unistd cleanup
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 11:05:48 +0000
Message-ID: <jhjzh1235yr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 08:20, Willy Tarreau wrote:
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
>
> Just let me know if you prefer a pull request, as I can do that as well.
>

This lets me run the following invocation without a hitch:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs "4*SRCU-P" --trust-make

where before I would get some errors building the initrd due to missing
__NR_foo.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks for having a look at this! And kuddos to Mark for nudging the
right people.

> Thanks!
> Willy
>
>
> Willy Tarreau (9):
>   tools/nolibc: the definition dup() was missing
>   tools/nolibc: make dup2() rely on dup3() when available
>   tools/nolibc: make getpgrp() fall back to getpgid(0)
>   tools/nolibc: implement fork() based on clone()
>   tools/nolibc: implement poll() based on ppoll()
>   tools/nolibc: get timeval, timespec and timezone from linux/time.h
>   tools/nolibc: remove incorrect definitions of __ARCH_WANT_*
>   tools/nolibc: emit a detailed error when missing alternate syscall
>     number definitions
>   tools/nolibc: fix position of -lgcc in the documented example
>
>  tools/include/nolibc/nolibc.h | 153 +++++++++++++++++++++++++---------
>  1 file changed, 115 insertions(+), 38 deletions(-)
>
> --
> 2.28.0
