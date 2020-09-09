Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49061262775
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIG4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 02:56:25 -0400
Received: from smtp.h3c.com ([60.191.123.56]:26358 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgIIG4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:56:24 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 0896u51D043736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Sep 2020 14:56:05 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Sep 2020 14:56:07 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <andriin@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] block: remove redundant empty check of mq_list
Date:   Wed, 9 Sep 2020 14:48:14 +0800
Message-ID: <20200909064814.5704-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0896u51D043736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_flush_plug_list() itself will do the empty check of mq_list,
so remove such check in blk_flush_plug_list().
Actually normally mq_list is not empty when blk_flush_plug_list is
called.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50..dda301610 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1864,8 +1864,7 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	flush_plug_callbacks(plug, from_schedule);
 
-	if (!list_empty(&plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
+	blk_mq_flush_plug_list(plug, from_schedule);
 }
 
 /**
-- 
2.17.1

