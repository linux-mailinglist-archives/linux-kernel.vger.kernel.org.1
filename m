Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF40C2DE80E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgLRRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:32:56 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:49060 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731972AbgLRRcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:32:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3B9A7FB03;
        Fri, 18 Dec 2020 18:32:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3i-ldZmZMy2L; Fri, 18 Dec 2020 18:32:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 008E143FE1; Fri, 18 Dec 2020 18:32:08 +0100 (CET)
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
Subject: [PATCH v1 3/3] arm64: defconfig: Enable more DM/MD targets as modules
Date:   Fri, 18 Dec 2020 18:32:08 +0100
Message-Id: <199c0c18dbb2b1fed98f2c99ed74c4b794dcd79e.1608312654.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608312654.git.agx@sigxcpu.org>
References: <cover.1608312654.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most notably DM_CRYPT for disk encryption but things like snapshot, etc.
are useful on embedded as well and the others make sense on arm64
servers.

CONFIG_BLK_DEV_MD gets dropped because other config options like
CONFIG_MD_RAID0 depend on it.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/configs/defconfig | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6f5f03237db6..060bebe0d35d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -296,10 +296,27 @@ CONFIG_SATA_RCAR=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_PATA_OF_PLATFORM=y
 CONFIG_MD=y
-CONFIG_BLK_DEV_MD=m
 CONFIG_BLK_DEV_DM=m
+CONFIG_DM_CRYPT=m
+CONFIG_DM_SNAPSHOT=m
+CONFIG_DM_THIN_PROVISIONING=m
+CONFIG_DM_WRITECACHE=m
 CONFIG_DM_MIRROR=m
+CONFIG_DM_LOG_USERSPACE=m
+CONFIG_DM_RAID=m
 CONFIG_DM_ZERO=m
+CONFIG_DM_MULTIPATH=m
+CONFIG_DM_MULTIPATH_QL=m
+CONFIG_DM_MULTIPATH_ST=m
+CONFIG_DM_MULTIPATH_HST=m
+CONFIG_DM_MULTIPATH_IOA=m
+CONFIG_DM_DELAY=m
+CONFIG_DM_DUST=m
+CONFIG_DM_UEVENT=y
+CONFIG_DM_FLAKEY=m
+CONFIG_DM_VERITY=m
+CONFIG_DM_LOG_WRITES=m
+CONFIG_DM_INTEGRITY=m
 CONFIG_NETDEVICES=y
 CONFIG_MACVLAN=m
 CONFIG_MACVTAP=m
-- 
2.29.2

