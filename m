Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6D2F99CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbhARGVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbhARGVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:21:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA9922513;
        Mon, 18 Jan 2021 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610950843;
        bh=24hfdJRWZcqPyS24ESJ7iEzXUdt5YM+29ZgucCMPL7o=;
        h=From:To:Cc:Subject:Date:From;
        b=W/QPVTZ2vFs86y6/yPOc0+d2EHDWg+hJLyovMkNWqysIBrRta8PRdzl5zO4URQ/2L
         jTSbFuW6Q22WJU8iDLM1mXnklomiTNHdFxPZDKyE4BK46qwkp9rvGEDTvAFC1Qxx7X
         6MC/mY+sXN77YFQ6Cg1zdYKPXbpa80NTrGE6c5WYLl4f9esx0jjw3K0OzZHyoP9XqD
         J1yzmEHBk2G+KyhWjV6VgM10zlvE85zWM+geSPTz/+GcBMQXkjuVfcCICn+7PnkEGv
         wDf0qQjYnl+YkCNO2tHE1rQhRKpB8j9uCkbasAnOnW5Pu31DZVXfZjErHoYY1WTDSA
         VH3IMj01zd4MQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/4] x86/fpu: Reduce unnecessary FNINIT and MXCSR usage
Date:   Sun, 17 Jan 2021 22:20:37 -0800
Message-Id: <cover.1610950681.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes two regressions: a boot failure on AMD K7 and a
performance regression on everything.

I did a double-take here -- the regressions were reported by different
people, both named Krzysztof :)

Andy Lutomirski (4):
  x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
  x86/mmx: Use KFPU_MMX for MMX string operations
  x86/fpu: Make the EFI FPU calling convention explicit
  x86/fpu/64: Don't FNINIT in kernel_fpu_begin()

 arch/x86/include/asm/efi.h     |  4 ++--
 arch/x86/include/asm/fpu/api.h | 35 ++++++++++++++++++++++++++++++++--
 arch/x86/kernel/fpu/core.c     | 17 +++++++++++------
 arch/x86/lib/mmx_32.c          | 10 +++++-----
 arch/x86/platform/efi/efi_64.c |  2 +-
 5 files changed, 52 insertions(+), 16 deletions(-)

-- 
2.29.2

