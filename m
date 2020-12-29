Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C32E7110
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgL2Nu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:50:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9944 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgL2Nu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:50:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D4wkP565vzhyxw;
        Tue, 29 Dec 2020 21:49:01 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:49:33 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        "Zheng Yongjun" <zhengyongjun3@huawei.com>
Subject: [PATCH -next] soundwire: intel: Use kzalloc for allocating only one thing
Date:   Tue, 29 Dec 2020 21:50:12 +0800
Message-ID: <20201229135012.23472-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/soundwire/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6a1e862b16c3..5cef271079be 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -967,7 +967,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Port configuration */
-	pconfig = kcalloc(1, sizeof(*pconfig), GFP_KERNEL);
+	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
 	if (!pconfig) {
 		ret =  -ENOMEM;
 		goto error;
-- 
2.22.0

