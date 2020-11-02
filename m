Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D422A3528
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgKBUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:35:01 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:37757 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgKBUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:35:01 -0500
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Nov 2020 12:35:00 -0800
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 02 Nov 2020 12:35:00 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 4C4F01948; Mon,  2 Nov 2020 12:35:00 -0800 (PST)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v5 0/3] Add support for VBUS detection
Date:   Mon,  2 Nov 2020 12:34:56 -0800
Message-Id: <cover.1604349076.git.gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to enable VBUS detection in the pm8941 extcon driver.

Changes from v4:
- Drop addition of new compatible string in both bindings and driver.

Changes from v3:
- Split bindings into direct conversion of txt file, and addition of VBUS
  detection support.

Changes from v2:
- Fix YAML errors in dt binding document.

Changes from v1:
- Change bindings from txt to YAML.


Anirudh Ghayal (1):
  extcon: qcom-spmi: Add support for VBUS detection

Guru Das Srinagesh (2):
  bindings: pm8941-misc: Convert bindings to YAML
  bindings: pm8941-misc: Add support for VBUS detection

 .../bindings/extcon/qcom,pm8941-misc.txt           | 41 ---------
 .../bindings/extcon/qcom,pm8941-misc.yaml          | 62 ++++++++++++++
 drivers/extcon/extcon-qcom-spmi-misc.c             | 99 +++++++++++++++++-----
 3 files changed, 142 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

