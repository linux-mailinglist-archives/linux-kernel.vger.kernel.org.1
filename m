Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83A2F4016
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbhALXQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbhALXQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:16:43 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7FC061786;
        Tue, 12 Jan 2021 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CpIpjamshJ3uHwSrCn2sDnuXqrCaKswn7NSyruUIWa0=; b=ay/4TZMW5tWopuYrhaI3ykYQn/
        A0lGf4PdfUC84f9Cw/nB3eGQNNeerTnfNjMDmlVS4RY6CW/RmcWDur8vFM2X46AlDKtLOZWuPh82+
        u11eyt6gFo4uKswgV0m/TMTEZ/3PtVPIU07bFbWVJZrneU6CyQepSnxH5fz1faMX9PYw=;
Received: from p200300ccff1586001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff15:8600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kzStK-0005SE-7q; Wed, 13 Jan 2021 00:15:58 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kzStJ-0007o0-Ul; Wed, 13 Jan 2021 00:15:57 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/4] ARM: dts: imx: uart improvements for ebookreaders
Date:   Wed, 13 Jan 2021 00:15:44 +0100
Message-Id: <20210112231549.29957-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add second uart
- correct pinmux for console uart (it was working before because of
  setup by uboot)
- document locations on board

Andreas Kemnade (4):
  ARM: dts: imx6sl-tolino-shine2hd: correct console uart pinmux
  ARM: dts: imx6sl-tolino-shine2hd: add second uart
  ARM: dts: imx6sl-tolino-shine3: correct console uart pinmux
  ARM: dts: imx: e60k02: add second uart

 arch/arm/boot/dts/e60k02.dtsi                |  6 ++++++
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 18 ++++++++++++++++--
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts   | 15 +++++++++++++--
 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts   | 13 ++++++++++++-
 4 files changed, 47 insertions(+), 5 deletions(-)

-- 
2.20.1

