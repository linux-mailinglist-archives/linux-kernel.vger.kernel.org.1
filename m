Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C052FB3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbhASIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:13:58 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:64290 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731579AbhASIMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:12:15 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnv9kQlAZgemqZAA--.29288S4;
        Tue, 19 Jan 2021 16:10:59 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: Fix error handling in extcon_dev_register
Date:   Tue, 19 Jan 2021 16:10:55 +0800
Message-Id: <20210119081055.13207-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnv9kQlAZgemqZAA--.29288S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1fJrWDtFyfGr4ftw4DXFb_yoW3JFgEk3
        y8ZrWfZan7Kry7Krn0kr4avr1FkFs8Wr1fXw1qyFn3Wa45Xr42gFWkZF1DAr47ZwsruFnI
        yrWqgr1fAr93WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcKBlZdtSCuZQACse
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When devm_kcalloc() fails, we should execute device_unregister()
to unregister edev->dev from system.

Fixes: 046050f6e623e ("extcon: Update the prototype of extcon_register_notifier() with enum extcon")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/extcon/extcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 0a6438cbb3f3..e7a9561a826d 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1241,6 +1241,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 				sizeof(*edev->nh), GFP_KERNEL);
 	if (!edev->nh) {
 		ret = -ENOMEM;
+		device_unregister(&edev->dev);
 		goto err_dev;
 	}
 
-- 
2.17.1

