Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058581CD70D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgEKLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:03:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKLC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:02:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C2713ACC2;
        Mon, 11 May 2020 11:03:00 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] MAINTAINERS: Update Raspberry Pi development repository
Date:   Mon, 11 May 2020 13:02:50 +0200
Message-Id: <20200511110250.23869-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Anholt's repo isn't used anymore. List current one.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 091ec22c1a23..60908ace8d31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3320,7 +3320,7 @@ L:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/anholt/linux
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
-- 
2.26.2

