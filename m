Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1478C2CB5D4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgLBHig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLBHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:38:35 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2736C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6xnHv3rphSgn53P0PGZrL9LpkhU6UXxRnGNCvw7gTzk=; b=idFCyg6LfMt3hn5VKrEXtVVzpd
        Yvi3O7UHlH7ExZqzoT7ZQh67Gq0orMtwktcKRmDAHSr3d749P/Y/moGSBrr7Zq41/GUSestGTPujr
        2Brq8TOqtesfnpzuc4k/aBFqx+XT03oRHyA1lIiJsztVWTytVWcsSzKwEI9xidNAEkng=;
Received: from p200300ccff0883001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:8300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kkMhv-0000qo-RF; Wed, 02 Dec 2020 08:37:48 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kkMhv-0002Vv-Ig; Wed, 02 Dec 2020 08:37:47 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable power driver of RN5T618 PMIC family
Date:   Wed,  2 Dec 2020 08:37:39 +0100
Message-Id: <20201202073739.9619-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a driver now for the power supply and fuel gauge functionality
of that chip family, so enable them, since they are used by various
i.MX6 boards, especially ebook-readers.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 221f5c340c86..70928cc48939 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -222,6 +222,7 @@ CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_RESET_SYSCON_POWEROFF=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
-- 
2.20.1

