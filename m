Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521A92FE3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbhAUH1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:27:17 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49245 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbhAUHVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:21:32 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7Kf0l023826;
        Thu, 21 Jan 2021 08:20:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after unistd cleanup
Date:   Thu, 21 Jan 2021 08:20:22 +0100
Message-Id: <20210121072031.23777-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

as per the recent discussion with Mark, I've updated the nolibc header to
reflect latest upstream which is needed to build on arm64, and I performed
the few cleanups that Mark rightfully suggested.

The following patches were taken from the upstream code and this time I
carefully copied the original commit IDs in hope not to miss such fixes
anymore in the future.

I've build-tested these on x86_64, i586, arm(v5 & v7), arm64, mips and
mipsel, using compilers ranging from gcc 3.4 to gcc 9.3 so I think we're
good for these archs now.

Just let me know if you prefer a pull request, as I can do that as well.

Thanks!
Willy


Willy Tarreau (9):
  tools/nolibc: the definition dup() was missing
  tools/nolibc: make dup2() rely on dup3() when available
  tools/nolibc: make getpgrp() fall back to getpgid(0)
  tools/nolibc: implement fork() based on clone()
  tools/nolibc: implement poll() based on ppoll()
  tools/nolibc: get timeval, timespec and timezone from linux/time.h
  tools/nolibc: remove incorrect definitions of __ARCH_WANT_*
  tools/nolibc: emit a detailed error when missing alternate syscall
    number definitions
  tools/nolibc: fix position of -lgcc in the documented example

 tools/include/nolibc/nolibc.h | 153 +++++++++++++++++++++++++---------
 1 file changed, 115 insertions(+), 38 deletions(-)

-- 
2.28.0

