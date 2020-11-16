Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A92B3D66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKPGzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:55:55 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:23363 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgKPGzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:55:55 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 01:55:54 EST
X-AuditID: 0a650161-e51ff70000001043-d6-5fb21ef0d29c
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 5F.16.04163.0FE12BF5; Mon, 16 Nov 2020 14:40:48 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1605508848; h=from:subject:to:date:message-id;
        bh=Gns6O61I8csSWjaxeroBzq6nv9TvlYGgYZ38uFYueFc=;
        b=Gt+xbH09jXy8ekUu13rUIJbW2Z+UnapYzqwYms44r+WJqLDbfnJOQpEHpW7Ag/unmL/XvQM6Rk3
        uhNpuuwL/JJ1wFdMNEyZY9idsPTnsnUYHEo4xF95Ww1EjVejZGhIEvFHSPe9xk2AGkMITqJrz0Ecn
        o7BZCgNOf157cKOL42Q=
Received: from hsj-OptiPlex-5060.iluvatar.local (10.101.199.252) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 16 Nov 2020 14:40:48 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <peterz@infradead.org>
CC:     <herbert@gondor.apana.org.au>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <linux-kernel@vger.kernel.org>,
        <shijie8@gmail.com>, Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] lockdep: fix the typo
Date:   Mon, 16 Nov 2020 14:40:39 +0800
Message-ID: <20201116064039.7549-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.252]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the 'signle' to 'single".

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 include/linux/lockdep_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9a1fd49df17f..1989017d663f 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -46,7 +46,7 @@ enum lockdep_wait_type {
  * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
  * cached in the instance of lockdep_map
  *
- * Currently main class (subclass == 0) and signle depth subclass
+ * Currently main class (subclass == 0) and single depth subclass
  * are cached in lockdep_map. This optimization is mainly targeting
  * on rq->lock. double_rq_lock() acquires this highly competitive with
  * single depth.
-- 
2.17.1

