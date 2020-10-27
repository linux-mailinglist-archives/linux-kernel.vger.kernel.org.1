Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58E529BD13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811720AbgJ0Qkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:40:53 -0400
Received: from foss.arm.com ([217.140.110.172]:46078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1811001AbgJ0Qgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:36:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CBA0139F;
        Tue, 27 Oct 2020 09:36:41 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0A8D3F719;
        Tue, 27 Oct 2020 09:36:39 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/3] arm64: cppc: add FFH support using AMUs
Date:   Tue, 27 Oct 2020 16:36:21 +0000
Message-Id: <20201027163624.20747-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for CPPC's delivered and reference performance
counters through the FFH methods by using the AMU equivalent core and
constant cycle counters.

This support is added in patch 3/3, while the first 2 patches generalise
the existing AMU counter read and validation functionality to be reused
for this usecase.

The specification that drove this implementation can be found at [1],
chapter 3.2.

RESEND v2: rebase and retest on v5.10-rc1

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

Thank you,
Ionela.

Ionela Voinescu (3):
  arm64: wrap and generalise counter read functions
  arm64: split counter validation function
  arm64: implement CPPC FFH support using AMUs

 arch/arm64/include/asm/cpufeature.h |  11 +++
 arch/arm64/include/asm/topology.h   |   2 +
 arch/arm64/kernel/cpufeature.c      |   8 +-
 arch/arm64/kernel/topology.c        | 132 ++++++++++++++++++++++------
 4 files changed, 121 insertions(+), 32 deletions(-)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.17.1

