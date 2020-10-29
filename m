Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5343129E287
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbgJ2CUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgJ2CUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:20:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w1so1114696wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4CRNeSmy3FyXnZUZ7tr/IZ8afmWOf8D3YAtE6xTyoQ8=;
        b=J3ivwzlrNciTCwZENDbWE0z1n/3i+5lZw18x1iYXBeSCz2F8eIz/4qFipUshIv319g
         oSIFRy+vgpsMRdsxP3tZVL0T3b18ssVrwdKDtFcMD+6FApIY/HOfAKvpvmf61JagBg/p
         SIfHlnfRr30DSFFexRa/kAKONER2oKHRDr4P08jjxtQBSHDlyiP8FbaWZvIFlYNs8oF8
         tbswwNAuxNMTfcDi0PdRzxVgVe8zqU6/h8S3aWN37qy/d+wSNOj/4/Tg+LIDwWwwghSM
         +DGIcic41+Hmh9ldTpILRm7MJI0dx3HgwjPk3SCPs2XnL+Rx4TRy6GQUKH8u8Ov1+zal
         PARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4CRNeSmy3FyXnZUZ7tr/IZ8afmWOf8D3YAtE6xTyoQ8=;
        b=QnqEmTLADauPclYyPKQzsqTxcCr5sDjTznrRHPCMozWXibfk4ORLBfvRLga0dXYVHW
         K0wiCsmza07hRt/vaASWgfBOgpzHaBYWOQ3xoIsLhRsleC9+Rp39BLWOB77MtgWMM3nV
         bpsGz3tbwnDy8+Db49ddoBIikdmn1dKC6n8JB2sZjf+cetLEQR8H2LyC1eq66115+nyF
         6joTAOrVQrvtm6WpljU06OGOvvhJY8AWKE0IEKpIp/42xIoB56V03TiiwoS6l06CXwUr
         rMsK3H1kNK+vjJD/ZQrt8blzcKtxmIZt17vckmXU0/M6YbyIgqxXmYwWKenU26yKtmFu
         SRew==
X-Gm-Message-State: AOAM5310doRRlbIgW91R2jJFekLPh72bFjWesmkY1QJp6puv4CnJdo7Z
        fQV6CluSekoPRmpAKciofVA=
X-Google-Smtp-Source: ABdhPJyL3wZjHtHwbC9OxI2ZqQd0fuz0L8atdGBacs5m3tXlvzfN6uhMkFj6F9Xn7PLSbycVrBl7dA==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr2475908wru.355.1603938028192;
        Wed, 28 Oct 2020 19:20:28 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id m4sm2138937wrr.47.2020.10.28.19.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:20:27 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH 0/5] Elimo Impetus and Initium support
Date:   Thu, 29 Oct 2020 02:19:55 +0000
Message-Id: <20201029022000.601913-1-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elimo Impetus is an Open Source Hardware System-on-Module based on the 
SoChip S3 SoC.
It is meant for integration into carrier boards or, more generally, larger 
designs, and uses an M2 connector to facilitate that.
The Elimo Initium is a carrier board for the Impetus, together they provide a 
fully open source SBC.

This patch set adds support for both. It it based off the sunxi/dt-for-5.11
branch of the https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
tree.

Matteo Scordino (5):
  dt-bindings: vendors: add Elimo Engineering vendor prefix
  ARM: dts: sun8i: V3/S3: Add UART1 pin definitions to the V3/S3 dtsi
  ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
  dt-bindings: arm: sunxi: add Elimo bindings
  ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC

 .../devicetree/bindings/arm/sunxi.yaml        | 10 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 51 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts  | 27 ++++++++++
 arch/arm/boot/dts/sun8i-v3.dtsi               |  5 ++
 6 files changed, 96 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts

-- 
2.20.1

