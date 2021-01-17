Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A342FB158
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbhASGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:24:50 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33815 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733126AbhASFlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:41:53 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2D333580631;
        Tue, 19 Jan 2021 00:41:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 19 Jan 2021 00:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=VDehzgrOpYq7V
        MUDV2d7bJb4x3mmDXyU96lOh2LDL/M=; b=XL+z1xpR7gTTu1KUUctv2/53pVJSL
        fUoIQ/9kzovPw1DZ7Ql+kFlacL1/0kgZs0PoSIB1KcYgNoRcGEVhCpZUhojh+JSe
        1hcjP1CofmrTfhE6+8lCNi4XL8cUrjbwoZoDKM+P7w4OY5n8LqU9N5GH+kGs5ERb
        J8HnZ+GRqEor1XFwagGrelxlugTjcyNbJfucOaFooQGldfTGMJk8sLau1wYpv9dJ
        jp04Ms8zzDs6zQ2hwgOyYx6czgqlxqWgJEQGgzNM6rQ+IyhdvfipbN9LwHRq/Dqs
        fwr7AibMqJntiDwgaDdKys0743at0BCN4q4LO/GAHR+Qomj9scjY6SBgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VDehzgrOpYq7VMUDV2d7bJb4x3mmDXyU96lOh2LDL/M=; b=MIUvvIjF
        FFc0w0SY64Jv6PqYQRdM8GwMsOwtByf+hdHnwMUELkH50lBIoPExXN+RxA+Qr9/H
        zWMh3aWf6L5LIezahj/6vvjH/lY5XlquGXhNbWYcz3KGi+uJhTrShCCMmwlHZgwD
        ss6PVhOV9CYNrHNlmv86cZtC9m+3yN+uTycbt0GtVz3r18vm+wPNdJCMM18LfTgy
        Ou51bS/Cq9kd0QIJFAmtX2SUX2bRaC9g3OJZ3voYK4q32Qr9U9uhnQ316LQ8dx6C
        KGkVgPyuTsOSf6P78+TgJ4Fo/NgS2+rSlfQmRJJki5qFzQU2IWwUhpd5SEEQkz2F
        MOZxGBlq9lWWpA==
X-ME-Sender: <xms:8nAGYC-pxeI5yD1S4_8vIdLZ1wk1dyj6TtH-ld8lWuop1a9V7Xhs_Q>
    <xme:8nAGYCtfcyWjkS3SR1QtIueFQxDPQbIUvxWA1U9YNdr9FqVYTn7EinEBHSzJJ5bAo
    7c39XE2zF3NvwV4feE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecukfhppeejfedrleef
    rdekgedrvddtkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:8nAGYIB_pJZKZb0_myJIVD09OTI_J6wMisb5tvv9ekLV7vOWfiafVA>
    <xmx:8nAGYKe1er0eS7IKYdCiAQ3RYozmZ7elAB9U3QtAezUwQsFZawk1uQ>
    <xmx:8nAGYHMmq3CKeNmhJdO2Vr2zYpdwvMXGlWO1xyWwPonrOqnj0Yse3A>
    <xmx:8nAGYCqOVB6EfUXNWjYjWMrVsqH0frcsXv431oL2HDDlfXsUt2xtkA>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD0A9240057;
        Tue, 19 Jan 2021 00:41:04 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 3/3] arch/arm/configs: Enable VMSPLIT_2G in imx_v6_v7_defconfig
Date:   Sun, 17 Jan 2021 10:03:01 -0800
Message-Id: <20210117180301.1956-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210117180301.1956-1-alistair@alistair23.me>
References: <20210117180301.1956-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reMarkable2 requires VMSPLIT_2G, so lets set this in the
imx_v6_v7_defconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 55674cb1ffce..fa9229616106 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -29,6 +29,7 @@ CONFIG_SOC_IMX7D=y
 CONFIG_SOC_IMX7ULP=y
 CONFIG_SOC_VF610=y
 CONFIG_SMP=y
+CONFIG_VMSPLIT_2G=y
 CONFIG_ARM_PSCI=y
 CONFIG_HIGHMEM=y
 CONFIG_FORCE_MAX_ZONEORDER=14
-- 
2.29.2

