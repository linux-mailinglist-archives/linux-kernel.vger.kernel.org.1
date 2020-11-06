Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF92A967A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKFMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:54:06 -0500
Received: from foss.arm.com ([217.140.110.172]:37720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgKFMyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:54:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA6D1474;
        Fri,  6 Nov 2020 04:54:05 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 234D03F718;
        Fri,  6 Nov 2020 04:54:04 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, will@kernel.org
Cc:     morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v4 0/3] arm64: cppc: add FFH support using AMUs
Date:   Fri,  6 Nov 2020 12:53:31 +0000
Message-Id: <20201106125334.21570-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Many thanks for everyone's review.

This series adds support for CPPC's delivered and reference performance
counters through the FFH methods by using the AMU equivalent core and
constant cycle counters.

This support is added in patch 3/3, while the first 2 patches generalise
the existing AMU counter read and validation functionality to be reused
for this usecase.

The specification that drove this implementation can be found at [1],
chapter 3.2.

v3 -> v4:
 - v3 can be found at [4]
 - 1/3, 3/3: Modified counter read functions as per Mark's suggestions.
 - This version is based on v5.10-rc2

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
[4] https://lore.kernel.org/linux-arm-kernel/20201105122702.13916-1-ionela.voinescu@arm.com/

Thank you,
Ionela.

Ionela Voinescu (3):
  arm64: wrap and generalise counter read functions
  arm64: split counter validation function
  arm64: implement CPPC FFH support using AMUs

 arch/arm64/include/asm/cpufeature.h |   8 ++
 arch/arm64/include/asm/topology.h   |   4 +-
 arch/arm64/kernel/cpufeature.c      |  13 ++-
 arch/arm64/kernel/topology.c        | 129 ++++++++++++++++++++++------
 4 files changed, 124 insertions(+), 30 deletions(-)

-- 
2.17.1

