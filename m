Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12B0273F44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIVKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:12:33 -0400
Received: from foss.arm.com ([217.140.110.172]:32916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgIVKMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:12:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60E0D6E;
        Tue, 22 Sep 2020 03:12:31 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAF253F718;
        Tue, 22 Sep 2020 03:12:29 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf: arm64: Support ARMv8.3-SPE extensions
Date:   Tue, 22 Sep 2020 11:12:20 +0100
Message-Id: <20200922101225.183554-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ARMv8.3-SPE extensions" add some bits to SPE to cover newer
architecture features, most prominently SVE.

Add the new bits where needed, mostly to perf's SPE packet decoder.

Cheers,
Andre

Andre Przywara (5):
  arm64: spe: Allow new bits in SPE filter register
  perf: arm_spe: Add new event packet bits
  perf: arm_spe: Add nested virt event decoding
  perf: arm_spe: Decode memory tagging properties
  perf: arm_spe: Decode SVE events

 arch/arm64/include/asm/sysreg.h               |  2 +-
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 86 +++++++++++++++++--
 2 files changed, 81 insertions(+), 7 deletions(-)

-- 
2.17.1

