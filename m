Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E209E2542FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgH0J76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 05:59:58 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:24127 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728663AbgH0J74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:59:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598522396; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+B5wb6/5W73FKeRbPz+9O5/FmXiWurQF800ttHrQ3mQ=; b=YKc23FJKRlds+At4T6qsyTpPofkGERpnnUpQWimWbgHPuUwGQsiAvwdM3m2Phs219xcyYxRi
 9knV2Jk4oEN79XEn8a4BF/1AYrx9WULcQUeML5Tp+VmmjWe9WFgFsGZMwGMA/G+FsfT5ejDU
 e9BhXvebhejLoUpSBhf5I2zzlN4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f47841b7ea9bd29093d5132 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 09:59:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30CA3C4339C; Thu, 27 Aug 2020 09:59:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AF61C433C6;
        Thu, 27 Aug 2020 09:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AF61C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH 0/5] Qualcomm's lpass-hdmi ASoC driver to support audio over dp port
Date:   Thu, 27 Aug 2020 15:29:38 +0530
Message-Id: <1598522378-28963-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are to support audio over DP port on Qualcomm's SC7180 LPASS Asoc.
It includes machine driver, cpu driver, platform driver updates for HDMI path support, 
device tree documention, lpass variant structure optimization and configuration changes.
These patches depends on the DP patch series 
https://patchwork.kernel.org/project/dri-devel/list/?series=332029

V Sujith Kumar Reddy (5):
  ASoC: Add sc7180-lpass binding header hdmi define
  ASoC: dt-bindings: Add dt binding for lpass hdmi
  ASoC: qcom: Add support for lpass hdmi driver
  ASoC: qcom: Add support for audio over DP
  ASoC: qcom: Optimise lpass variant structure

 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  51 +-
 include/dt-bindings/sound/sc7180-lpass.h           |   1 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-apq8016.c                     |  25 +-
 sound/soc/qcom/lpass-cpu.c                         |  92 ++-
 sound/soc/qcom/lpass-hdmi.c                        | 685 +++++++++++++++++++++
 sound/soc/qcom/lpass-hdmi.h                        | 129 ++++
 sound/soc/qcom/lpass-ipq806x.c                     |  25 +-
 sound/soc/qcom/lpass-lpaif-reg.h                   |  51 +-
 sound/soc/qcom/lpass-platform.c                    | 287 +++++++--
 sound/soc/qcom/lpass-sc7180.c                      | 147 ++++-
 sound/soc/qcom/lpass.h                             | 123 +++-
 13 files changed, 1472 insertions(+), 151 deletions(-)
 create mode 100644 sound/soc/qcom/lpass-hdmi.c
 create mode 100644 sound/soc/qcom/lpass-hdmi.h

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

