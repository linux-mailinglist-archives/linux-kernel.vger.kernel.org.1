Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77782121D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 13:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGBLKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 07:10:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32038 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728574AbgGBLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:10:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593688205; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bTuN57vJilTOX0pADiPZZNPd5sonb/cXm6sf/c1qdWo=; b=XfChI975rKc8obDOrdkGdrQxvGfHHg97y6Jo9ruoYE2UT9KJhGHmdBbpXYZKmU+OhgiDBs8r
 523CkG3RG+FDPY7YRKVCbJGSzNbLAGeMJI9l1so5PirvyDgf9dwU7BhqdhLzlxc+hnDJycI5
 UHQ+7k3qvPYOCsqWZD8GUkjcAZU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5efdc07ca6e154319f817b62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 11:09:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EC51C433C6; Thu,  2 Jul 2020 11:09:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5892BC433C8;
        Thu,  2 Jul 2020 11:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5892BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 0/4] DVFS support for dpu and dsi
Date:   Thu,  2 Jul 2020 16:39:07 +0530
Message-Id: <1593688151-22616-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2
- Patch 2: Dropped dsi_link_clk_set_rate_6g_v2 and dsi_link_clk_disable_6g_v2 as suggested by Matthias

These patches add DVFS support for DPU and DSI.

These patches have no other dependency. Patch 1 and 2 will need to be merged in
via the MSM DRM tree.

DT patches will need to land via the msm tree.

Rajendra Nayak (4):
  drm/msm/dpu: Use OPP API to set clk/perf state
  drm/msm: dsi: Use OPP API to set clk/perf state
  arm64: dts: sdm845: Add DSI and MDP OPP tables and power-domains
  arm64: dts: sc7180: Add DSI and MDP OPP tables and power-domains

 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 49 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 59 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 26 +++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |  4 ++
 drivers/gpu/drm/msm/dsi/dsi_host.c            | 26 +++++++++++-
 6 files changed, 163 insertions(+), 4 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

