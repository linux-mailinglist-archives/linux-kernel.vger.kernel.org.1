Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1B62A1798
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgJaNXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgJaNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:23:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9257C0617A6;
        Sat, 31 Oct 2020 06:23:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id n5so8953797ile.7;
        Sat, 31 Oct 2020 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C5TY9Wkz59ytckWXNebEjmACP7EGIzlB4+x6CMVE9U=;
        b=diHccTdJcNstLlNOgFczpRf4ITQOs2IrhKYxsL67SFx04Mg7E+KOXIisoZIMWDk+6v
         0V1kQ0boiM/2VGjIe1cKwVdTrM2dsC1BoMcnf9FsiZbNuskfrZrOdNrMbH6qR+uOqzdS
         4u6i8nO1PnzIMfpF7LULTPt1W+Kh0eaGXqbaTUAobfVaVTSD01GOSIPTyrXnpqVd5j0o
         7hH6aNKoIgSsf9ftouhujaHgNPhbKrsAyjbXY147ZDrdGbUiIDyKVn0AMYyBkWoQTmJu
         5pZXXgU6wGodrIlNo+DxT3fjeOu94RHmqMwbxJyAElyDwstyGgqKuW6ljzur2i1rrJmd
         xkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C5TY9Wkz59ytckWXNebEjmACP7EGIzlB4+x6CMVE9U=;
        b=qX2wiUA//GYLqMVnOeqyaDFQhf3p30mGIe3eAFeRf2e1Fjn6w/eYsB9ZoFZSqjH+g6
         sEoHlwntEtUZTax2uGMVcYK/uP+81No3Da1JJi8/LE3agkCjKR0/sXtVuUCfNQSJN66e
         rMNb1OwE55vEpqlK8wTIUTyHq2CWXc04liaJh7Mn+vyiucI3qDOoLl2W+JmGc7Zgo7/u
         llnAZ6jMCGcANwrv9EaztZwMO2eA4FjhSrDDPLfOYSFp/XnLHwEXk1MqJ+bTfzZDplh/
         RlT5sgX/UBX3yhkzkRrIKWqXNwRYO5RHi0dpPekr91Bp367l68hjv5ZGgkL2nTYFRMyw
         +5JA==
X-Gm-Message-State: AOAM533NhiVY43UOBqiDy8VF6We/8+pi8MnU29tX8OBsuMit9/0RVENx
        jipQm7f4dPLR+ATuRgTy298=
X-Google-Smtp-Source: ABdhPJwACz3FXFq9vkpBMb/wu64FdpKHhdZ75PaRS/usZRTwDfvWL1jieazow192LaCvHG7e+tMw3A==
X-Received: by 2002:a92:cc92:: with SMTP id x18mr4743034ilo.63.1604150619031;
        Sat, 31 Oct 2020 06:23:39 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id y3sm6804655ilc.49.2020.10.31.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:23:38 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, marex@denx.de,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] Enable Audio functions on i.MX8M Nano
Date:   Sat, 31 Oct 2020 08:23:23 -0500
Message-Id: <20201031132328.712525-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano uses similar blocks of audio IP as the iMX8M Mini
This series adds those functions.

V2:  Mostly corrects some minor typos and rebased on Shawn Guo's 
branch imx/dt64.  The added cover letter with stats was per request
to show what's changed at a high level.

Adam Ford (5):
  arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter
  arm64: defconfig: Enable ASRC and EASRC
  arm64: dts: imx8mn: Add SAI nodes
  arm64: dts: imx8mn: Add support for micfil
  arm64: dts: imx8mn: Add node for SPDIF

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 143 ++++++++++++++++++++++
 arch/arm64/configs/defconfig              |   2 +
 2 files changed, 145 insertions(+)

-- 
2.25.1

