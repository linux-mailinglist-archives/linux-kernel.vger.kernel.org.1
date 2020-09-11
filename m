Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C3265F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgIKMUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 08:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgIKMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:16:50 -0400
Received: from mail.kernel.org (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FDE22207;
        Fri, 11 Sep 2020 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826608;
        bh=hRvZkeA5envDy3jhEryZBWbNL0TKkQVW9LyxnaBNgqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOnLxkIZSbj3z0FDLvaw1/7hm2GKZUM7rCnmALOdyRnjVrL/N8HlwqMpL0EDu6f+W
         xVkJ97yZymr3BSzlaUfa1tf0afl+9nTsGNOShQEi1fYFeO/YzdbjmCst9+2RlVvpIc
         H9A7tRUt7H6adXKWj/jeBNkXN0VwIzDIDE+WB1BU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGhyv-0006WH-W5; Fri, 11 Sep 2020 14:16:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND 4/8] dts: phy: phy-hi3670-usb3.txt: use a consistent namespace
Date:   Fri, 11 Sep 2020 14:16:40 +0200
Message-Id: <f7832a577fc4b7d2f8459c1023f9782e43a9efb2.1599826421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599826421.git.mchehab+huawei@kernel.org>
References: <cover.1599826421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this driver is not used yet, use a more consistent namespace,
similar to the PHY layer for Kirin 960 (hi3660).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
index 4cb02612ff23..2fb27cb8beaf 100644
--- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
@@ -2,7 +2,7 @@ Hisilicon Kirin970 usb PHY
 -----------------------
 
 Required properties:
-- compatible: should be "hisilicon,kirin970-usb-phy"
+- compatible: should be "hisilicon,hi3670-usb-phy"
 - #phy-cells: must be 0
 - hisilicon,pericrg-syscon: phandle of syscon used to control phy.
 - hisilicon,pctrl-syscon: phandle of syscon used to control phy.
@@ -14,7 +14,7 @@ Refer to phy/phy-bindings.txt for the generic PHY binding properties
 
 Example:
 	usb_phy: usbphy {
-		compatible = "hisilicon,kirin970-usb-phy";
+		compatible = "hisilicon,hi3670-usb-phy";
 		#phy-cells = <0>;
 		hisilicon,pericrg-syscon = <&crg_ctrl>;
 		hisilicon,pctrl-syscon = <&pctrl>;
-- 
2.26.2

