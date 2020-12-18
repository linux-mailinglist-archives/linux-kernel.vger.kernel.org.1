Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0F2DE80D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgLRRcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:32:55 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:49046 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgLRRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:32:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C40CAFB04;
        Fri, 18 Dec 2020 18:32:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VZuO-4deToAD; Fri, 18 Dec 2020 18:32:09 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EAEAC43FDF; Fri, 18 Dec 2020 18:32:08 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Max Krummenacher <max.oss.09@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] arm64: defconfig: Enable more filesystems
Date:   Fri, 18 Dec 2020 18:32:07 +0100
Message-Id: <e7813d825691aa00e7e47ec98b4ba64ddc739435.1608312654.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608312654.git.agx@sigxcpu.org>
References: <cover.1608312654.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs, f2fs and iso are common enough to have them everywhere.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e42ba0c8f302..6f5f03237db6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1092,8 +1092,10 @@ CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_XFS_FS=m
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
+CONFIG_F2FS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
@@ -1101,6 +1103,9 @@ CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
 CONFIG_OVERLAY_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_UDF_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=y
-- 
2.29.2

