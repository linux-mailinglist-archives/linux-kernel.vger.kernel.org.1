Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B3C2F5AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbhANG06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbhANG0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:26:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13DDC23976;
        Thu, 14 Jan 2021 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610605568;
        bh=BiN2Dsvpeojkkw97MJouJxauaNi6M6gNDGNje1e+PM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9Dubl2+wHr4IzrQ+8CrbEtbxYT5TuXipZqQ6q9Y+b1bxn9yucdX3DgFol8mWrXfC
         jd1p5z6DF0D2c+OrFs2I50CwS4jXwKueQDbTplOhtbYYyawQSGw/bQWhPOYCrShUOX
         k0S6Yt5LzcjUrlO3SZVFN1Pk/htVhUgzat5NlCmATYDRnhSOtuFB7f+Yj0U6riFasa
         hbqvEL2NjD1QKbwfFDhWUDIwEXfUOdDLRkekau1vsEKGaZs5hFWKbdrQ7sHm10Jc1p
         EDShcropGEkvuXiCY/gu6mkiE9kE4lKGUCSPsluokxStDO5MYjPRRasFKNscwY9OAR
         mGNGv+eySAVzA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzw56-00EJ7I-J0; Thu, 14 Jan 2021 07:26:04 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] MAINTAINERS: update mediatek,ufs-phy.yaml reference
Date:   Thu, 14 Jan 2021 07:26:00 +0100
Message-Id: <d452a50ec87a662f3e816a25a4bff4ea7bb4ac23.1610605373.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610605373.git.mchehab+huawei@kernel.org>
References: <cover.1610605373.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 67038ec1bdfb ("dt-bindings: phy: convert phy-mtk-ufs.txt to YAML schema")
renamed: Documentation/devicetree/bindings/phy/phy-mtk-*
to: Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b15037d9b01d..6cf24e7fc569 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,7 +2093,7 @@ M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/phy/phy-mtk-*
+F:	Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml*
 F:	drivers/phy/mediatek/
 
 ARM/Microchip (AT91) SoC support
-- 
2.29.2

