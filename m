Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4775D1A5F15
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDLOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 10:50:28 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59015 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgDLOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:50:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586703028; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qjJJNbET8NJxy8ittj6XHkTYSNoyUKWIf/Bw5ZazOAM=; b=qi7tl224aKAqya0rX4jBoHqKCtRHFqxGLVlGQ4F+zEphnTd3YpEYRChM1jHo5XKgGP8W1kl7
 VRNQC/2LNOWZ007R9hvwpn72Hh9qIZUV8s/FxeYU6Mr5HdfM1Oh94XBqCvavnH5HUNLpW3y3
 j1AuT0UNvgrCACJwPvFW374oTX8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e932ab1.7fe9f88d8fb8-smtp-out-n03;
 Sun, 12 Apr 2020 14:50:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42873C432C2; Sun, 12 Apr 2020 14:50:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDB89C433CB;
        Sun, 12 Apr 2020 14:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDB89C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, dianders@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v17 0/6] Invoke rpmh_flush for non OSI targets
Date:   Sun, 12 Apr 2020 20:19:58 +0530
Message-Id: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v17:
- Address Stephen's comments on change 3 and change 4.
- Add Stephen's Reviewed-by on change 5.

Changes in v16:
- Use base address in probe only, drop change to save it in drv->base
- Address Doug's comments on change 5,6 and 7.
- Add Doug's Reviewed-by.

Changes in v15:
- Address Doug's comments on change 3 of v14 and add Reviewed-by
- Split change 4 of v14 to save drv->base in a new change
- Address Doug's comments on change 4, 5, 6 of v14
- Add missing NOTIFY_OK for rpmh_flush() success case
- First 5 changes in this series can be merged without change 6 and 7

Changes in v14:
- Address Doug's comments on change 3 from v13
- Drop new APIs for start and end transaction from change 4 in v13
- Update change 4 to use cpu pm notifications instead
- Add [5] as change 5 to enable use of WAKE TCS when ACTIVE TCS count is 0
- Add change 6 to Allow multiple WAKE TCS to be used as ACTIVE TCSes
- First 4 changes can be merged even without change 5 and 6.

Changes in v13:
- Address Stephen's comment to maintain COMPILE_TEST
- Address Doug's comments and add new APIs for start and end transaction

Changes in v12:
- Kconfig change to remove COMPILE_TEST was dropped in v11, reinclude it.

Changes in v11:
- Address Doug's comments on change 2 and 3
- Include change to invalidate TCSes before flush from [4]

Changes in v10:
- Address Evan's comments to update commit message on change 2
- Add Evan's Reviewed by on change 2
- Remove comment from rpmh_flush() related to last CPU invoking it
- Rebase all changes on top of next-20200302

Changes in v9:
- Keep rpmh_flush() to invoke from within cache_lock
- Remove comments related to only last cpu invoking rpmh_flush()

Changes in v8:
- Address Stephen's comments on changes 2 and 3
- Add Reviewed by from Stephen on change 1

Changes in v7:
- Address Srinivas's comments to update commit text
- Add Reviewed by from Srinivas

Changes in v6:
- Drop 1 & 2 changes from v5 as they already landed in maintainer tree
- Drop 3 & 4 changes from v5 as no user at present for power domain in rsc
- Rename subject to appropriate since power domain changes are dropped
- Rebase other changes on top of next-20200221

Changes in v5:
- Add Rob's Acked by on dt-bindings change
- Drop firmware psci change
- Update cpuidle stats in dtsi to follow PC mode
- Include change to update dirty flag when data is updated from [4]
- Add change to invoke rpmh_flush when caches are dirty

Changes in v4:
- Add change to allow hierarchical topology in PC mode
- Drop hierarchical domain idle states converter from v3
- Address Merge sc7180 dtsi change to add low power modes

Changes in v3:
- Address Rob's comment on dt property value
- Address Stephen's comments on rpmh-rsc driver change
- Include sc7180 cpuidle low power mode changes from [1]
- Include hierarchical domain idle states converter change from [2]

Changes in v2:
- Add Stephen's Reviewed-By to the first three patches
- Addressed Stephen's comments on fourth patch
- Include changes to connect rpmh domain to cpuidle and genpds

Resource State Coordinator (RSC) is responsible for powering off/lowering
the requirements from CPU subsystem for the associated hardware like buses,
clocks, and regulators when all CPUs and cluster is powered down.

RSC power domain uses last-man activities provided by genpd framework based
on Ulf Hansoon's patch series[3], when the cluster of CPUs enter deepest
idle states. As a part of domain poweroff, RSC can lower resource state
requirements by flushing the cached sleep and wake state votes for various
resources.

[1] https://patchwork.kernel.org/patch/11218965
[2] https://patchwork.kernel.org/patch/10941671
[3] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=222355
[4] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=236503
[5] https://patchwork.kernel.org/patch/10818129

Maulik Shah (5):
  arm64: dts: qcom: sc7180: Add cpuidle low power states
  soc: qcom: rpmh: Update dirty flag only when data changes
  soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes before flushing new
    data
  soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
  soc: qcom: rpmh-rsc: Allow using free WAKE TCS for active request

Raju P.L.S.S.S.N (1):
  soc: qcom: rpmh-rsc: Clear active mode configuration for wake TCS

 arch/arm64/boot/dts/qcom/sc7180.dtsi |  78 +++++++++++++
 drivers/soc/qcom/rpmh-internal.h     |  25 ++--
 drivers/soc/qcom/rpmh-rsc.c          | 220 +++++++++++++++++++++++++++--------
 drivers/soc/qcom/rpmh.c              |  79 ++++++-------
 4 files changed, 305 insertions(+), 97 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
