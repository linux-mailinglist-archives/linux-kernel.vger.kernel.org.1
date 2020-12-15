Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7792DB40C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgLOSwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:52:18 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:43177 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbgLOStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:49:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608058163; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gjXhSwXH130CypwYTgpPnsoVSha5jxJGBuVYFcoIQGU=; b=pT3Hf76BRrlDe06vXISBCSS0o0sUU0/rmfNzCN7GMsU45y+odFPfgCA9/IIUExabcZNPIvvN
 3lvbWtUEmKnktJTc5w+M6SKdInump8kueFvNacT/b4XgVPyC4AVUC8kRyY3IrmTH2+uZhrAY
 G/y3Io3DcZMEmQYSQqju/RrS3b8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fd90511253011a4b869c92c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Dec 2020 18:48:49
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49F05C43462; Tue, 15 Dec 2020 18:48:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA5E2C433CA;
        Tue, 15 Dec 2020 18:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA5E2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 0/2] Add Global Clock controller (GCC) driver for SC7280
Date:   Wed, 16 Dec 2020 00:18:32 +0530
Message-Id: <1608058114-29025-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for Global Clock controller for SC7280 and also update
device tree bindings for the various clocks supported in the clock controller.

Taniya Das (2):
  dt-bindings: clock: Add SC7280 GCC clock binding
  clk: qcom: Add Global Clock controller (GCC) driver for SC7280

 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |   85 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-sc7280.c                      | 3361 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sc7280.h        |  215 ++
 5 files changed, 3671 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
 create mode 100644 drivers/clk/qcom/gcc-sc7280.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7280.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

