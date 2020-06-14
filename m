Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D462C1F894A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgFNOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 10:34:18 -0400
Received: from mail-m965.mail.126.com ([123.126.96.5]:58134 "EHLO
        mail-m965.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 10:34:17 -0400
X-Greylist: delayed 1838 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jun 2020 10:34:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=lsbRBE5rJ6r7F+hR4L
        UAghXlgSQa25BI4H503EvZ2m0=; b=bpU9clATCOiwWUDZ5kwlipVICcIKF1cblZ
        Ye0xZZ2rjeeJmQDr8b4Iyyo9At44Op1ynKhPpr0ymA/XoT+ar/yanwGx2ARbjT9+
        XjTeghWIecPKFiGzQd/VBduqCwxR9Oxjju4AqxqJ5BHRQxTXa0XbATv420kpN2F3
        okFlBuX8I=
Received: from zhixu-home.lan (unknown [114.249.235.144])
        by smtp10 (Coremail) with SMTP id NuRpCgBnbyMaLuZeZ7olRw--.5682S2;
        Sun, 14 Jun 2020 22:03:08 +0800 (CST)
From:   Zhixu Zhao <zhixu001@126.com>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Zhixu Zhao <zhixu001@126.com>
Subject: [PATCH] staging: gasket: core: Fix a coding style issue in gasket_core.c
Date:   Sun, 14 Jun 2020 21:51:31 +0800
Message-Id: <20200614135131.11282-1-zhixu001@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: NuRpCgBnbyMaLuZeZ7olRw--.5682S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1DAry5Jw48trWxuF15urg_yoWfAFcEkr
        4Iy34xX3Z5Kas7GF15Gr9rGFy5twnrXrWvgFW2q3yUW3yqvF4UWrW8Ar1kuF4Dur47uFy8
        C3yUCrn0qw1ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjwZ2PUUUUU==
X-Originating-IP: [114.249.235.144]
X-CM-SenderInfo: x2kl53qqqrqiyswou0bp/1tbiDxxDfFpEAyneeQAAs-
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a coding alignment issue found by checkpatch.pl.

Signed-off-by: Zhixu Zhao <zhixu001@126.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 67325fbaf760..357063ad5c33 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -304,7 +304,7 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 
 	gasket_dev->bar_data[bar_num].virt_base =
 		ioremap(gasket_dev->bar_data[bar_num].phys_base,
-				gasket_dev->bar_data[bar_num].length_bytes);
+			gasket_dev->bar_data[bar_num].length_bytes);
 	if (!gasket_dev->bar_data[bar_num].virt_base) {
 		dev_err(gasket_dev->dev,
 			"Cannot remap BAR %d memory region %p\n",
-- 
2.17.1

