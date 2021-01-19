Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307222FBF86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbhASSy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbhASS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72FB823382;
        Tue, 19 Jan 2021 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611077947;
        bh=fQ8cPHRGRF+GCX++UouMADtg5PnfwR+E6puxFz1iVGg=;
        h=From:To:Cc:Subject:Date:From;
        b=Ox/tzsSk1yTqgCJVeSdEzp13i/9son2f0VyRVLy9z4TkapPZP4BrJdlu4bGzfl5HR
         +UzuE+ykHAndP16U4KZCj8+A0gIOUMiqbPxiRoRZ98pJEfUntUG2MB5glbaf4klBkz
         TLJ3/X0qyhpGYpJFJar6CzmmeWbvr/ttOeBY9w4/47L5gnuzA4I7cqoxFIWYuGNVl8
         hpVlhyKBaKw/2s4SVNOTqbPNbxHbqhpF47S62+bKUPDv3cuzW/bpDl45RJ6bTrCdSy
         ed/rhXapQINnzM/NEvzch4cLpGup+jRqtHDgvHeP/rh4oyyDwbertE2+FjVr7HvftM
         F3VBXMjSBK5UA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/4] x86/fpu: Reduce unnecessary FNINIT and MXCSR usage
Date:   Tue, 19 Jan 2021 09:38:58 -0800
Message-Id: <cover.1611077835.git.luto@kernel.org>
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
 arch/x86/kernel/fpu/core.c     | 17 +++++++++++------
 arch/x86/lib/mmx_32.c          | 20 +++++++++++++++-----
 arch/x86/platform/efi/efi_64.c |  4 ++--
 5 files changed, 73 insertions(+), 19 deletions(-)

-- 
2.29.2

