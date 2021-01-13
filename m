Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7D42F581C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbhANCOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:14:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38644 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbhAMVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:31:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9F71B1F45140
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: pm-domains: Don't print an error if child domain is deferred
Date:   Wed, 13 Jan 2021 22:30:12 +0100
Message-Id: <20210113213012.67643-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Child domains can be deferred by the core because one of its resources
is not available yet, in such case, it will print an error, but
later it will succeed to probe. Fix that using the dev_err_probe()
function so it only prints an error on a real error.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-pm-domains.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index ae255aa7b1a9..8055fb019ba6 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -480,8 +480,8 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
 
 		child_pd = scpsys_add_one_domain(scpsys, child);
 		if (IS_ERR(child_pd)) {
-			ret = PTR_ERR(child_pd);
-			dev_err(scpsys->dev, "%pOF: failed to get child domain id\n", child);
+			dev_err_probe(scpsys->dev, PTR_ERR(child_pd),
+				      "%pOF: failed to get child domain id\n", child);
 			goto err_put_node;
 		}
 
-- 
2.29.2

