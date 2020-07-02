Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B632128C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgGBP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 11:56:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbgGBP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593705365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ZXfUlrODmksHX6ewH8QfKHuA1CKjkhdObLb5yxv2YrM=;
        b=ck5VSCWrrXjcMXrSdBRLBxGuFWaBtft/TLljjOgAticpSAWKWuMoBQdj2tSOfK+Fu5SzPB
        c2JSM1MhWCaKVUAiXYet+/rdP5vGhTGt8M5CmZgU0fFyjzfp7AlEADRJMdPZBegcRfd2ye
        I89GI/eaiZwfVdi7yS85Tt1biIEbY2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-pbQFvTWOMvaPEmiPd0J84Q-1; Thu, 02 Jul 2020 11:56:03 -0400
X-MC-Unique: pbQFvTWOMvaPEmiPd0J84Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58427107ACF2;
        Thu,  2 Jul 2020 15:56:02 +0000 (UTC)
Received: from npache.remote.csb (ovpn-117-192.rdu2.redhat.com [10.10.117.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7920973FD3;
        Thu,  2 Jul 2020 15:56:01 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, steffen.klassert@secunet.com,
        daniel.m.jordan@oracle.com, npache@redhat.com
Subject: [PATCH v2] Remove __init from padata_do_multithreaded and padata_mt_helper.
Date:   Thu,  2 Jul 2020 11:55:48 -0400
Message-Id: <20200702155548.14690-1-npache@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow padata_do_multithreaded function to be called after bootstrap.

v2: removed __init from padata_work_alloc_mt and padata_works_free

Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/padata.h |  2 +-
 kernel/padata.c        | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 7302efff5..2e7d92e80 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -201,7 +201,7 @@ extern void padata_free_shell(struct padata_shell *ps);
 extern int padata_do_parallel(struct padata_shell *ps,
 			      struct padata_priv *padata, int *cb_cpu);
 extern void padata_do_serial(struct padata_priv *padata);
-extern void __init padata_do_multithreaded(struct padata_mt_job *job);
+extern void padata_do_multithreaded(struct padata_mt_job *job);
 extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 			      cpumask_var_t cpumask);
 extern int padata_start(struct padata_instance *pinst);
diff --git a/kernel/padata.c b/kernel/padata.c
index 4373f7ada..c067b1339 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -58,7 +58,7 @@ struct padata_mt_job_state {
 };
 
 static void padata_free_pd(struct parallel_data *pd);
-static void __init padata_mt_helper(struct work_struct *work);
+static void padata_mt_helper(struct work_struct *work);
 
 static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
 {
@@ -106,7 +106,7 @@ static void padata_work_init(struct padata_work *pw, work_func_t work_fn,
 	pw->pw_data = data;
 }
 
-static int __init padata_work_alloc_mt(int nworks, void *data,
+static int padata_work_alloc_mt(int nworks, void *data,
 				       struct list_head *head)
 {
 	int i;
@@ -132,7 +132,7 @@ static void padata_work_free(struct padata_work *pw)
 	list_add(&pw->pw_list, &padata_free_works);
 }
 
-static void __init padata_works_free(struct list_head *works)
+static void padata_works_free(struct list_head *works)
 {
 	struct padata_work *cur, *next;
 
@@ -463,7 +463,7 @@ static int pd_setup_cpumasks(struct parallel_data *pd,
 	return err;
 }
 
-static void __init padata_mt_helper(struct work_struct *w)
+static void padata_mt_helper(struct work_struct *w)
 {
 	struct padata_work *pw = container_of(w, struct padata_work, pw_work);
 	struct padata_mt_job_state *ps = pw->pw_data;
@@ -503,7 +503,7 @@ static void __init padata_mt_helper(struct work_struct *w)
  *
  * See the definition of struct padata_mt_job for more details.
  */
-void __init padata_do_multithreaded(struct padata_mt_job *job)
+void padata_do_multithreaded(struct padata_mt_job *job)
 {
 	/* In case threads finish at different times. */
 	static const unsigned long load_balance_factor = 4;
-- 
2.18.1

