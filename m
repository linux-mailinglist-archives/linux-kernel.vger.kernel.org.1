Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F3293F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgJTP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731360AbgJTP0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:26:47 -0400
Received: from ziggy.com (unknown [213.195.119.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA1921D6C;
        Tue, 20 Oct 2020 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603207607;
        bh=4xGtl3FRFn5GI0tSM6nai/BhPtfdAZaAQ5vlpNpkEA4=;
        h=From:To:Cc:Subject:Date:From;
        b=lX/Hn/gpTiWi7/UgZrrIiV4GA4emxvWNP8W1/QOmrch04ZEcpItogKd1IvPZYxa9Z
         LMd+wjo6pauov3cISElVJ3p8bHTVeL7EDv/zPo5c7kKCLlXETNs3Dk7LPYbACnxZx5
         tpB/0yAr2SnQzH/PqKLbov43RN+0oSe5m1DHn91I=
From:   matthias.bgg@kernel.org
To:     matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yh.chen@mediatek.com,
        Miles.Chen@mediatek.com, Yingjoe.Chen@mediatek.com,
        kuohong.wang@mediatek.com
Subject: [PATCH] MAINTAINERS: change mediatek wiki page
Date:   Tue, 20 Oct 2020 17:26:39 +0200
Message-Id: <20201020152639.21950-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The old wiki page unfortunately got lost by server crash.
The new wiki can be found on the kernel.org infrastructure

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14b8ec0bb58b..7d0088782a9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2067,7 +2067,7 @@ M:	Matthias Brugger <matthias.bgg@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	https://mtk.bcnfs.org/
+W:	https://mtk.wiki.kernel.org/
 C:	irc://chat.freenode.net/linux-mediatek
 F:	arch/arm/boot/dts/mt6*
 F:	arch/arm/boot/dts/mt7*
-- 
2.28.0

