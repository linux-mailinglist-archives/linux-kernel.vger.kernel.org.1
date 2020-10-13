Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8128CF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgJMNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:40:23 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:44389 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgJMNkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:40:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602596423; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lGt94tJR4p8z2VZENAYILwPd3XBTRqEWZsrbh+IenL4=; b=HHo3Wbc76CO3IBtHlVg03/nbGcyFEox/wOuL653EZj+YtmX1h5MWPD6qlg31rr3O9d7wlR2B
 PtbRnb4by4sjTtjkcfWYZxerpFC8KSLXIXKe1cjpcpzMVu1BD9IQGn2SMVVZSTeup5715ebX
 WqEYsCVZW37gY6MZJykbb7VFbm8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f85ae3942f9861fb11fe624 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Oct 2020 13:40:09
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9EEBC433CB; Tue, 13 Oct 2020 13:40:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03A6AC43385;
        Tue, 13 Oct 2020 13:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03A6AC43385
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH 1/2] Asoc: qcom: lpass-cpu: Fix clock disable failure
Date:   Tue, 13 Oct 2020 19:09:46 +0530
Message-Id: <1602596386-9886-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>

Disable MI2S bit clock from PAUSE/STOP/SUSPEND usecase
instead of shutdown time. Acheive this by invoking
clk_disable_unprepare API from cpu daiops shutdown to
cpu daiops trigger.
This Fix is update to the below patch.
https://lore.kernel.org/patchwork/patch/1308101/

Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index ba2aca3..2dfb921 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -88,8 +88,6 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
-
 	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 }
 
@@ -324,6 +322,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 		if (ret)
 			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
 				ret);
+		clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
 		break;
 	}
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

