Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A42A7E88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgKEM1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:27:16 -0500
Received: from foss.arm.com ([217.140.110.172]:59310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKEM1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:27:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66D67142F;
        Thu,  5 Nov 2020 04:27:15 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAFEC3F719;
        Thu,  5 Nov 2020 04:27:13 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org
Cc:     souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v3 0/3] arm64: cppc: add FFH support using AMUs
Date:   Thu,  5 Nov 2020 12:26:59 +0000
Message-Id: <20201105122702.13916-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Sorry for the issues introduced and reported by 0day testing, and for
taking a bit longer to sort them out. I hope I've done this in this
version.

The only ones I've not solved are the unused function warnings:

arch/arm64/kernel/topology.c:140:1: warning: unused function 'store_corecnt' [-Wunused-function]
COUNTER_READ_STORE(corecnt, 0);
[..]
arch/arm64/kernel/topology.c:141:1: warning: unused function 'store_constcnt' [-Wunused-function]
COUNTER_READ_STORE(constcnt, 0);

After the 3 patches are applied, these only happen for
!CONFIG_ACPI_CPPC_LIB. Therefore I thought fixing these might not be worth
the ifdef guarding required to fix it. Let me know if you think otherwise.

v2 -> v3:
 - v2 can be found at [3]
 - Sorted out part of the issues flagged by 0day testing in patches 1/3
   and 3/3.
 - This version is based on v5.10-rc2.

RESEND v2:
 - Rebased and retested on v5.10-rc1.

v1 -> v2:
 - v1 can be found at [2]
 - The previous patch 1/4 was removed and a get_cpu_with_amu_feat()
   function was introduced instead, in 3/3, as suggested by Catalin.
   Given that most checks for the presence of AMUs is done at CPU
   level, followed by other validation, this implementation works
   better than the one initially introduced in v1/->patch 1/4.
 - Fixed warning reported by 0-day kernel test robot.
 - All build tests and FVP tests at [2] were re-run for this version.
 - This version is based on linux-next/20201001.

[1] https://documentation-service.arm.com/static/5f106ad60daa596235e80081
[2] https://lore.kernel.org/lkml/20200826130309.28027-1-ionela.voinescu@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20201027163624.20747-1-ionela.voinescu@arm.com/

Thank you,
Ionela.

Ionela Voinescu (3):
  arm64: wrap and generalise counter read functions
  arm64: split counter validation function
  arm64: implement CPPC FFH support using AMUs

 arch/arm64/include/asm/cpufeature.h |   8 ++
 arch/arm64/include/asm/topology.h   |   4 +-
 arch/arm64/kernel/cpufeature.c      |  13 ++-
 arch/arm64/kernel/topology.c        | 132 ++++++++++++++++++++++------
 4 files changed, 124 insertions(+), 33 deletions(-)

-- 
2.17.1

