Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7B26E2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIQRnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:43:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40603 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgIQRlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:41:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600364463; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cPHkj+a/0Rl2xRJ1IzjV1BjMb2iMw5KcPWUXja2H2B8=; b=P9aEP/uQXjmzltj0t4E1RmIXIZrx78gpztFqQVLD2ovL8Hzun8xHcDYl7YHDs95IsB9LtYJ8
 oNnMZWLn492UeO26XCXV9h8VN+LTdRmkDoUTbKfgPv6VYZsIZIcB3p7PWI4n4suw+3AfUd2R
 TBp3FMOH0hJ3RjeHAWYgw2rYlPQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f63669b0915d3035792bf2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Sep 2020 13:37:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF5A4C43387; Thu, 17 Sep 2020 13:37:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FB9DC433F0;
        Thu, 17 Sep 2020 13:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FB9DC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v5 0/5] Qualcomm's lpass-hdmi ASoC driver to support audio over dp port
Date:   Thu, 17 Sep 2020 19:07:03 +0530
Message-Id: <1600349828-10727-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are to support audio over DP port on Qualcomm's SC7180 LPASS Asoc.
It includes machine driver, cpu driver, platform driver updates for HDMI path support, 
device tree documention, lpass variant structure optimization and configuration changes.
These patches depends on the DP patch series 
https://patchwork.kernel.org/project/dri-devel/list/?series=332029
Changes Since v4:
    -- Updated with single compatible node for both I2S and HDMI.
Changes Since v3:
    -- Removed id in lpass variant structure and used snd_soc_dai_driver id.
Changes Since v2:
	-- Audio buffer size(i.e. LPASS_PLATFORM_BUFFER_SIZE) in lpass-platform.c increased.
Changes Since v1:
	-- Commit messages are updated
	-- Addressed Rob Herring review comments

V Sujith Kumar Reddy (5):
  ASoC: Add sc7180-lpass binding header hdmi define
  ASoC: dt-bindings: Add dt binding for lpass hdmi
  Asoc:qcom:lpass-cpu:Update dts property read API
  ASoC: qcom: Add support for lpass hdmi driver
  ASoC: qcom: sc7180: Add support for audio over DP

 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  74 ++-
 include/dt-bindings/sound/sc7180-lpass.h           |   1 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-cpu.c                         |  39 +-
 sound/soc/qcom/lpass-hdmi.c                        | 596 +++++++++++++++++++++
 sound/soc/qcom/lpass-hdmi.h                        | 129 +++++
 sound/soc/qcom/lpass-lpaif-reg.h                   |  52 +-
 sound/soc/qcom/lpass-platform.c                    | 468 ++++++++++++----
 sound/soc/qcom/lpass-sc7180.c                      | 116 +++-
 sound/soc/qcom/lpass.h                             | 119 +++-
 11 files changed, 1447 insertions(+), 154 deletions(-)
 create mode 100644 sound/soc/qcom/lpass-hdmi.c
 create mode 100644 sound/soc/qcom/lpass-hdmi.h

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

