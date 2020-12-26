Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E4A2E2DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 09:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgLZIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 03:04:10 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:61510 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgLZIEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 03:04:09 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app3 (Coremail) with SMTP id cC_KCgDX32sy7uZf2rYQAA--.27169S4;
        Sat, 26 Dec 2020 16:03:02 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: Add null check in rtl8192_usb_initendpoints
Date:   Sat, 26 Dec 2020 16:02:56 +0800
Message-Id: <20201226080258.6576-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgDX32sy7uZf2rYQAA--.27169S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy5Kw15uFyrurWfGFWfZrb_yoW3trb_Kr
        1xJa97Zr1UCrnYywnFkF4UJry7tF1fZFsYyFnaqrWfW3yFyFZ8t3srZr1DGa47XFZ3uFZ5
        uFWxGry5Jw18GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgYEBlZdtRrnPgAPs0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an allocation for priv->rx_urb[16] has no null check,
which may lead to a null pointer dereference.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 93676af98629..9fc4adc83d77 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1608,6 +1608,8 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 		void *oldaddr, *newaddr;
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!priv->rx_urb[16])
+			return -ENOMEM;
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
 		if (!priv->oldaddr)
 			return -ENOMEM;
-- 
2.17.1

