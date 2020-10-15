Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02D928F7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgJORqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:46:19 -0400
Received: from m12-12.163.com ([220.181.12.12]:55526 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgJORqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=XN9H2
        NxW6U+e1Qg/wOmyXlcxurDEZ/tcQC1sO6RyP+k=; b=mT98cD3/kTxfYXfjTD9J2
        6kKF9FWRalRzyDAgJezJoix2UPMoGiF7G/H7okemV6TFSgOwOpe1qCcoTLOlp9Ay
        VtxInKaN9UMa4BgtXXa8m3hFFUBPYAB1yWtqmg9JUhgRB4OFyYqlvGt8PixaQepr
        01AIWU4HzE3PoIAVw+JRvw=
Received: from localhost (unknown [101.228.30.83])
        by smtp8 (Coremail) with SMTP id DMCowAB3nwS4ZYhfVlTERw--.36972S2;
        Thu, 15 Oct 2020 23:07:36 +0800 (CST)
Date:   Thu, 15 Oct 2020 23:07:36 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        walken@google.com, vbabka@suse.cz, ldufour@linux.ibm.com,
        arnd@arndb.de, sh_def@163.com, linux-kernel@vger.kernel.org
Subject: [PATCH] acct.c: use #elif instead of #end and #elif
Message-ID: <20201015150736.GA91603@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowAB3nwS4ZYhfVlTERw--.36972S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFy3KryUGw4UGw1UJF1fWFg_yoW3ZFg_ua
        1Fqr18CF15Ar1rAr929ws5ArWfW3y8XF4v9w17Kay7Za1DAwn5Xw1DArn293sa9397GFy3
        urn8CFnxGrn2yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRi1CJJUUUUU==
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIBi+X10TBw9RrAAAsi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use #elif instead of #end and #elif.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/acct.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index b0c5b3a9f5af..24681372af07 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -381,9 +381,7 @@ static comp2_t encode_comp2_t(u64 value)
 		return (value & (MAXFRACT2>>1)) | (exp << (MANTSIZE2-1));
 	}
 }
-#endif
-
-#if ACCT_VERSION == 3
+#elif ACCT_VERSION == 3
 /*
  * encode an u64 into a 32 bit IEEE float
  */
@@ -500,8 +498,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	/* backward-compatible 16 bit fields */
 	ac.ac_uid16 = ac.ac_uid;
 	ac.ac_gid16 = ac.ac_gid;
-#endif
-#if ACCT_VERSION == 3
+#elif ACCT_VERSION == 3
 	{
 		struct pid_namespace *ns = acct->ns;
 
-- 
2.25.1


