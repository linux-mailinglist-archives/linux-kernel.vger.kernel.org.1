Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9C32DE11D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbgLRKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:33:42 -0500
Received: from comms.puri.sm ([159.203.221.185]:50100 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389154AbgLRKdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:33:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CA33BE00A1;
        Fri, 18 Dec 2020 02:32:31 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EaD2XY5oh-Vx; Fri, 18 Dec 2020 02:32:30 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 0/4] small Librem 5 phone dts updates
Date:   Fri, 18 Dec 2020 11:31:27 +0100
Message-Id: <20201218103131.22013-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor updates for the current hardware descriptions:

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

