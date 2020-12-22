Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029FC2E0C86
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgLVPOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:14:42 -0500
Received: from comms.puri.sm ([159.203.221.185]:54784 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgLVPOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:14:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 44D3EE01EC;
        Tue, 22 Dec 2020 07:14:01 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cFOKc_XSqCjf; Tue, 22 Dec 2020 07:14:00 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 0/4] small Librem 5 phone dts updates
Date:   Tue, 22 Dec 2020 16:13:43 +0100
Message-Id: <20201222151347.7886-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

revision history
----------------
v2: (thanks Krzysztof)
 add Fixes tags and improve commit messages
v1:
 https://lore.kernel.org/linux-arm-kernel/20201218103131.22013-1-martin.kepplinger@puri.sm/

Martin Kepplinger (4):
  arm64: dts: imx8mq-librem5: add vin-supply to VDD_1V8
  arm64: dts: imx8mq-librem5: add pinctrl for the touchscreen
    description
  arm64: dts: imx8mq-librem5: Move usdhc clocks assignment to board DT
  arm64: dts: imx8mq-librem5-r3: workaround i2c1 issue with 1GHz cpu
    voltage

 .../boot/dts/freescale/imx8mq-librem5-r3.dts  |  6 ++++
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 28 ++++++++++++++-----
 2 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.20.1

