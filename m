Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86656215B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgGFPxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 11:53:40 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:31114 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729364AbgGFPxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:53:40 -0400
Received: from home.intra.ispras.ru (unknown [10.10.165.12])
        by smtp.ispras.ru (Postfix) with ESMTP id 90086203BF;
        Mon,  6 Jul 2020 18:53:36 +0300 (MSK)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] fbdev: sm712fb: set error code in probe
Date:   Mon,  6 Jul 2020 18:53:28 +0300
Message-Id: <20200706155328.8396-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If smtcfb_pci_probe() does not detect a valid chip it cleans up
everything and returns 0. This can result in various bad things later.
The patch sets the error code on the corresponding path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/sm712fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a1b4a853d9e..fbe97340b8e0 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1614,7 +1614,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	default:
 		dev_err(&pdev->dev,
 			"No valid Silicon Motion display chip was detected!\n");
-
+		err = -ENODEV;
 		goto failed_fb;
 	}
 
-- 
2.16.4

