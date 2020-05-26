Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039761D5F61
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgEPHWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 03:22:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbgEPHWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 03:22:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6D372E8431338979092;
        Sat, 16 May 2020 15:22:01 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 May 2020
 15:21:51 +0800
To:     <haren@us.ibm.com>, <linux-kernel@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH 1/2] lib: 842 - Remove useless checking in add_template()
Message-ID: <e46137c5-6bdd-59bd-1a20-59752f2bb8c2@huawei.com>
Date:   Sat, 16 May 2020 15:21:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning was found by smatch tool:
  "add_template() error: testing array offset 'c' after use."

Fix it by removing the useless checking in add_template().

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 lib/842/842_compress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4168e1..18255d25781b 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -225,9 +225,6 @@ static int add_template(struct sw842_param *p, u8 c)
 	u8 *t = comp_ops[c];
 	bool inv = false;

-	if (c >= OPS_MAX)
-		return -EINVAL;
-
 	pr_debug("template %x\n", t[4]);

 	ret = add_bits(p, t[4], OP_BITS);
-- 
1.8.3.1

