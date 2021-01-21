Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7EE2FE1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhAUFP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhAUFKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:10:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84DE3238D7;
        Thu, 21 Jan 2021 05:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611205792;
        bh=YbN9Rjpu9+5amNEx8O6+cJGQ454I7ra1ehKAt1GioBM=;
        h=From:To:Cc:Subject:Date:From;
        b=dtXCriKiOvwgoc+79Hpjy63w5et/LfmSXYXfJCBYaialIgbyoJ4JRSJckgxnVgXgd
         jlvAFkBwgJh/EojnlipCY7Is/VZnYtu+QuMDl2jk+JP33Hqy//Z2cPPS4vPnFXuKoZ
         pLv2YCVm8d2U3fEmry5eZCkETUJrdAwrtTmwnig3ShORRMw63Ufxj1TOZjTSrJjNPA
         iEv1KqTF+9kQ2lqsewbEnGrVHEqd8K2Twg2xiQiyI8fiAHVtbZygSO+9S7klbx8MSL
         CCTSqYaAZL8W2VPxRHEv00nj9vxHlKdbIo9Dal8UoD118ZEWmP/+qlw+BVRaoN52Ko
         0F/WOC/w9IHnw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 0/4] x86/fpu: Reduce unnecessary FNINIT and MXCSR usage
Date:   Wed, 20 Jan 2021 21:09:47 -0800
Message-Id: <cover.1611205691.git.luto@kernel.org>
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

Changes from v2:
 - Tidy up the if statements (Sean)
 - Changelog and comment improvements (Boris)

Changes from v1:
 - Fix MMX better -- MMX really does need FNINIT.
 - Improve the EFI code.
 - Rename the KFPU constants.
 - Changelog improvements.

Andy Lutomirski (4):
  x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
  x86/mmx: Use KFPU_387 for MMX string operations
  x86/fpu: Make the EFI FPU calling convention explicit
  x86/fpu/64: Don't FNINIT in kernel_fpu_begin()

 arch/x86/include/asm/efi.h     | 24 ++++++++++++++++++++----
 arch/x86/include/asm/fpu/api.h | 27 +++++++++++++++++++++++++--
 arch/x86/kernel/fpu/core.c     |  9 +++++----
 arch/x86/lib/mmx_32.c          | 20 +++++++++++++++-----
 arch/x86/platform/efi/efi_64.c |  4 ++--
 5 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.29.2

