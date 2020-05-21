Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288BC1DD10B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgEUPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 11:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbgEUPUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:20:07 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAE320826;
        Thu, 21 May 2020 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590074407;
        bh=f1nY7jMdmh7McepRPv1Zarzh/Gloc+JyYZU3lokNqRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1X0EAO5sYAiIS6QlUdEH52gOZOm948HKqbAmgyDoW3t0QgRZKNjh7F7ocqqR55sS
         bldU9fFYFue5Ov5s0b/tw80ZCMdwoccF2LmPyw19HXmdsqXnYKe+K1Hx5p0h3VvYpr
         hxBsW8VxOT+dmePNZna11IYbp9hZMN65jdcmOt+s=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        maz@kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/17] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1, ID_MMFR5 and other changes
Date:   Thu, 21 May 2020 16:19:58 +0100
Message-Id: <159007243559.201193.1705879548179051424.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 15:10:37 +0530, Anshuman Khandual wrote:
> This series is primarily motivated from an adhoc list from Mark Rutland
> during our previous ID_ISAR6 discussion [1]. The current proposal also
> accommodates some more suggestions from Will and Suzuki.
> 
> This series adds missing 32 bit system registers (ID_PFR2, ID_DFR1 and
> ID_MMFR5), adds missing features bits on all existing system registers
> (32 and 64 bit) and some other miscellaneous changes. While here it also
> includes a patch which does macro replacement for various open bits shift
> encodings for various CPU ID registers. There is a slight re-order of the
> patches here as compared to the previous version (V1).
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[01/17] arm64/cpufeature: Add explicit ftr_id_isar0[] for ID_ISAR0 register
        https://git.kernel.org/arm64/c/2a5bc6c47bc3
[02/17] arm64/cpufeature: Drop TraceFilt feature exposure from ID_DFR0 register
        https://git.kernel.org/arm64/c/1ed1b90a0594
[03/17] arm64/cpufeature: Make doublelock a signed feature in ID_AA64DFR0
        https://git.kernel.org/arm64/c/e965bcb06256
[04/17] arm64/cpufeature: Introduce ID_PFR2 CPU register
        https://git.kernel.org/arm64/c/16824085a7dd
[05/17] arm64/cpufeature: Introduce ID_DFR1 CPU register
        https://git.kernel.org/arm64/c/dd35ec070457
[06/17] arm64/cpufeature: Introduce ID_MMFR5 CPU register
        https://git.kernel.org/arm64/c/152accf8476f
[07/17] arm64/cpufeature: Add remaining feature bits in ID_PFR0 register
        https://git.kernel.org/arm64/c/0ae43a99fe91
[08/17] arm64/cpufeature: Add remaining feature bits in ID_MMFR4 register
        https://git.kernel.org/arm64/c/fcd6535322cc
[09/17] arm64/cpufeature: Add remaining feature bits in ID_AA64ISAR0 register
        https://git.kernel.org/arm64/c/7cd51a5a84d1
[10/17] arm64/cpufeature: Add remaining feature bits in ID_AA64PFR0 register
        https://git.kernel.org/arm64/c/011e5f5bf529
[11/17] arm64/cpufeature: Add remaining feature bits in ID_AA64PFR1 register
        https://git.kernel.org/arm64/c/14e270fa5c4c
[12/17] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR0 register
        (no commit info)
[13/17] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR1 register
        (no commit info)
[14/17] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR2 register
        (no commit info)
[15/17] arm64/cpufeature: Add remaining feature bits in ID_AA64DFR0 register
        (no commit info)
[16/17] arm64/cpufeature: Replace all open bits shift encodings with macros
        (no commit info)
[17/17] arm64/cpuinfo: Add ID_MMFR4_EL1 into the cpuinfo_arm64 context
        https://git.kernel.org/arm64/c/858b8a8039d0

Note that Suzuki had comments on 12-16, so assume you'll respin those (I fixed
up the trivial comments on earlier patches myself).

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
