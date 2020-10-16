Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF76290B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392785AbgJPSoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:44:07 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:60314 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392758AbgJPSoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:44:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602873845; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=12+N9Ofs4vDd/K1DaE9mgI4Xg6xM+6FDR7mLAtVA9WQ=; b=vxXpO3Ll0MkTD/pUvYBlO2SuLexgAILhF0ehTpHT9CGBl9EFiasXjaLoQepccP+mmIOcu0M0
 n9ORCJpEJi7GOtGK3sx9dQQiZiXUPdg9N0b/GxNmg5OgHjGCey2gJk9H68isqacV3wEKWguQ
 ifQ0RU8/fqwVOvZBQQvw0S0ejmA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f89e9e542f9861fb11fe82f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 18:43:49
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF6B6C433FE; Fri, 16 Oct 2020 18:43:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02D33C433CB;
        Fri, 16 Oct 2020 18:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02D33C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v3 0/4] Add Camera clock controller driver for SC7180
Date:   Sat, 17 Oct 2020 00:13:31 +0530
Message-Id: <1602873815-1677-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v3]
 * Introduce helper functions to be used across pll configure and pll rate
   margins.
 * Update the Agera PLL configure/set rate to use the new helper functions.
 * Update documentation binding to update the header inclusion.
 * Update the vco table to 'const'.
 * Fix the failure path of probe.

[v2]
 * Update PLL set rate function : clk_alpha_pll_agera_set_rate
 * Remove mb()

[v1]
 * Add support for Agera PLL which is used in the camera clock controller.

 * Add driver support for camera clock controller for SC7180 and also
   update device tree bindings for the various clocks supported in the
   clock controller.


Taniya Das (4):
  clk: qcom: clk-alpha-pll: Add support for helper functions
  clk: qcom: clk-alpha-pll: Add support for controlling Agera PLLs
  dt-bindings: clock: Add YAML schemas for the QCOM Camera clock
    bindings.
  clk: qcom: camcc: Add camera clock controller driver for SC7180

 .../bindings/clock/qcom,sc7180-camcc.yaml          |   73 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/camcc-sc7180.c                    | 1736 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |  217 ++-
 drivers/clk/qcom/clk-alpha-pll.h                   |    4 +
 include/dt-bindings/clock/qcom,camcc-sc7180.h      |  121 ++
 7 files changed, 2072 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
 create mode 100644 drivers/clk/qcom/camcc-sc7180.c
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sc7180.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

