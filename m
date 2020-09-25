Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0931627953D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgIYXzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:55:43 -0400
Received: from agrajag.zerfleddert.de ([88.198.237.222]:39618 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIYXzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:55:42 -0400
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id BAA945B2057C; Sat, 26 Sep 2020 01:55:41 +0200 (CEST)
Date:   Sat, 26 Sep 2020 01:55:41 +0200
From:   Tobias Jordan <kernel@cdqe.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: arm: integrator: fix device node iterator leak
Message-ID: <20200925235541.GA28030@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the for_each_available_child_of_node loop of integrator_lm_populate,
add a call to of_node_put to avoid leaking the iterator if we bail out.

Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
 drivers/bus/arm-integrator-lm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index 845b6c43fef8..cb6da80d1c7d 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -53,6 +53,7 @@ static int integrator_lm_populate(int num, struct device *dev)
 				 base);
 			ret = of_platform_default_populate(child, NULL, dev);
 			if (ret) {
+				of_node_put(child);
 				dev_err(dev, "failed to populate module\n");
 				return ret;
 			}
-- 
2.20.1

