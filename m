Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C02AA608
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgKGOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgKGOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:48:31 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41511C0613CF;
        Sat,  7 Nov 2020 06:48:31 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id s24so5086460ioj.13;
        Sat, 07 Nov 2020 06:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mP3gJ5lTnK5UZP2K6I08cK9nCarVRdZx+jxqMPg3oHk=;
        b=AUeg2/u1YyqUy73HNL3HLVBW4mlSf+phDxaBDz8AkRD7skqcE1OcmXYyjm43waXkWD
         2ds+dSonjx7Dhje63NvRplzxhHrnk9kFvYNZuM4EkA1mGaL9uJLmDlvy+XWna7eucTkj
         9lUvyNYbZETAeg55IWzihbKrplhV+r7G79uM+nLL7ZsnWMPNL0oHTEpF+T2hU1zr59Dr
         LRpkyWBQedN/PFum7eyA7VL0LEGTQK2Ii6Uq7NUYsphuQ8L8BvN3umgZ7mnP2TN3EeSL
         cgQUXXLqGb96rqtbhV7BpmSRF3g4eirQFxhTz4ZErsX6JnpdzBZh4NunEjjfI+CwTtHz
         Joaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mP3gJ5lTnK5UZP2K6I08cK9nCarVRdZx+jxqMPg3oHk=;
        b=fW7nQ28y2kJRS6FJHJJzL/FLJb0n1oIGuWqs0ozgXyWzD6cGx3SnqOslHCJJvd4QD8
         3z1lrkGTPGElrCBgGHyK0/nVzDOeTgfhgraqSYdKPxWN9U9UDOLjMV7LaA9MKMqGhlhu
         Qf7vFoXlSnZ88wf2f7l/uITr7hqqZwkGkCfpsQ7fLCrhMNY9ZaCOblqVcrbvNTuCAZRA
         19/bK6Sh1efpi8Ybz8AvZXdqQcsr4q+/sI5Pk6GIAz571QpzehLexk7CShpcY85vfebb
         rQD/4T+oTn1LX15AHq7wsxDkUG//o+hNSgqD9xO/e7UNxKA4S4xbLm1Ucvx8pBp5f3cs
         S1dA==
X-Gm-Message-State: AOAM530tbOa/DCKaSxGOAFN6bk/TOeEZBOUl9Lmacvhqag1i8dQA5CRW
        cyLIKRqzVgJX+jvyr2zRe6w=
X-Google-Smtp-Source: ABdhPJycI0bAZ9BC+zEAyRh1oOUOFuHJto28gP0HZpdS45Mh3hM4vkGptTRykHvoNksIyA8OQohIXA==
X-Received: by 2002:a5e:dc48:: with SMTP id s8mr2950247iop.198.1604760510533;
        Sat, 07 Nov 2020 06:48:30 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id t2sm2737892iob.5.2020.11.07.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 06:48:29 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/3] arm64: defconfig: Enable WM8962
Date:   Sat,  7 Nov 2020 08:48:10 -0600
Message-Id: <20201107144811.1977108-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107144811.1977108-1-aford173@gmail.com>
References: <20201107144811.1977108-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beacon EmbeddedWorks development kits supporting i.MX8M Mini
and Nano have an WM8962 audio CODEC installed.  Add modules for both
CONFIG_SND_SOC_WM8962 and CONFIG_SND_SOC_FSL_ASOC_CARD to enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  No Change
V3:  No Change
V2:  New to series

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 821b21a56ad7..00357f5c6fa5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -701,6 +701,7 @@ CONFIG_SND_SOC_FSL_EASRC=m
 CONFIG_SND_IMX_SOC=m
 CONFIG_SND_SOC_IMX_SPDIF=m
 CONFIG_SND_SOC_IMX_AUDMIX=m
+CONFIG_SND_SOC_FSL_ASOC_CARD=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
@@ -728,6 +729,7 @@ CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8904=m
+CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
-- 
2.25.1

