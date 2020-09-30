Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5C27E369
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgI3IPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:15:32 -0400
Received: from z5.mailgun.us ([104.130.96.5]:35673 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbgI3IPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:15:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601453731; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ApJUWDC1QKKLVAUh8ABFaKlfJlW6qV/8Lk11jnQS6H4=; b=ANOibEKOLU0Pp01dPg+AbMM8O2Wp3BUdLNu6NgFEMHnmgJ1xU1CrXtplb0SvZQFKX1p9JOrJ
 6kVeV6iZGHMkLMbFvBNgw8lXJfDk6Bngqr4JozK+ZiCPCHeiUGk7K0DOxICTmMVOm+ozcZSy
 wRRWje+DIj4p/AtUKM99AGC8UAY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f743e6e809bd330147cd1dc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 08:14:38
 GMT
Sender: schowdhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11F5BC433C8; Wed, 30 Sep 2020 08:14:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-525.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: schowdhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D7D0C433CA;
        Wed, 30 Sep 2020 08:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D7D0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=schowdhu@codeaurora.org
From:   Souradeep Chowdhury <schowdhu@codeaurora.org>
To:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Souradeep Chowdhury <schowdhu@codeaurora.org>
Subject: [PATCH V1 0/3] Add LLCC support for SM8150 SoC
Date:   Wed, 30 Sep 2020 13:44:11 +0530
Message-Id: <cover.1601452132.git.schowdhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLCC behaviour is controlled by the configuration data set
in the llcc-qcom driver, add the same for SM8150 SoC.
Add the compatible for SM8150 SoC

Souradeep Chowdhury (3):
  dt-bindings: msm: Add LLCC for SM8150
  soc: qcom: llcc: Add configuration data for SM8150
  arm64: dts: qcom: sm8150: Add LLC support for sm8150

 .../bindings/arm/msm/qcom,llcc.yaml           |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  9 +++++-
 drivers/soc/qcom/llcc-qcom.c                  | 30 +++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h            |  6 ++++
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

