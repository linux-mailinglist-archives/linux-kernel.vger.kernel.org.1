Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF12C4F93
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbgKZHdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbgKZHdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:33:46 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241EA21D81;
        Thu, 26 Nov 2020 07:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606376026;
        bh=AyBcETcUXHxQfpaJ1Qc1wfZW0HDdZWtar/7MThviV7k=;
        h=From:To:Cc:Subject:Date:From;
        b=BXS34bF3soW3uEkltzK98lPgXOPl1h80ch3LmkzhJ4p7AccviksHpaQb7ITQoeuOy
         NapmNuXxiUKjdq0SafsBpl/M6STWrm0SqiTxXrD0xgcMkVeWMejBTFEcV+8BpheuXj
         XOTxbxULc74AnZta05Rm5s50ckOLD7WOq8EeA+M0=
Received: by wens.tw (Postfix, from userid 1000)
        id C389E5F806; Thu, 26 Nov 2020 15:33:42 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: rockchip: rk3328-roc-cc: Misc improvements
Date:   Thu, 26 Nov 2020 15:33:33 +0800
Message-Id: <20201126073336.30794-1-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi,

Here are some improvements for the ROC-RK3328-CC.

Patch 1 sets dr_mode to "host" for OTG. Since the board has a type A
host port wired to the OTG controller, setting this is appropriate.

Patch 2 enables HDMI audio.

Patch 3 enables analog audio.

I opted to use one simple-card for each audio interface since a) the
definitions are already in the .dtsi file and b) having one card per
interface with proper names makes them easier to identify.

The changes are quite trivial. Hope they can be merged for the next
release.


Regards
ChenYu

Chen-Yu Tsai (3):
  arm64: dts: rockchip: rk3328-roc-cc: Set dr_mode to "host" for OTG
  arm64: dts: rockchip: rk3328-roc-cc: Enable HDMI audio
  arm64: dts: rockchip: rk3328-roc-cc: Enable analog audio

 .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.29.2

