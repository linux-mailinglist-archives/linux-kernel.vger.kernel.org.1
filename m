Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953FF1D8E74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 06:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgESEFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 00:05:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45886 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgESEFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 00:05:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B203200097;
        Tue, 19 May 2020 06:05:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 08879200073;
        Tue, 19 May 2020 06:05:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 07712402AF;
        Tue, 19 May 2020 12:05:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 0/3] Covert i.MX GPT/TPM/SYSCTR timer binding to json-schema
Date:   Tue, 19 May 2020 11:55:44 +0800
Message-Id: <1589860547-3207-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts i.MX GPT, TPM and system counter timer
binding to json-schema, test build passed.

Changes compared to V1 are listed in each patch.

Anson Huang (3):
  dt-bindings: timer: Convert i.MX GPT to json-schema
  dt-bindings: timer: Convert i.MX TPM to json-schema
  dt-bindings: timer: Convert i.MX SYSCTR to json-schema

 .../devicetree/bindings/timer/fsl,imxgpt.txt       | 45 ------------
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      | 80 ++++++++++++++++++++++
 .../devicetree/bindings/timer/nxp,sysctr-timer.txt | 25 -------
 .../bindings/timer/nxp,sysctr-timer.yaml           | 54 +++++++++++++++
 .../devicetree/bindings/timer/nxp,tpm-timer.txt    | 28 --------
 .../devicetree/bindings/timer/nxp,tpm-timer.yaml   | 61 +++++++++++++++++
 6 files changed, 195 insertions(+), 98 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml

-- 
2.7.4

