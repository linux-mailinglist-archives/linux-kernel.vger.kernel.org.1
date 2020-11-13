Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2562B13AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgKMBJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:09:33 -0500
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74]:55144 "EHLO
        mx0b-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbgKMBJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:09:33 -0500
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0AgIx026053
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 19:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=date : from : to :
 cc : subject : message-id : mime-version : content-type; s=pps01;
 bh=6GHSVFv6nLZcPp7xHyy6h6ys4E8ZCnHV183m9AtQ+oU=;
 b=ktxBKmVuOYse6zqM90EhXhc+/cHukuYUxYKvZD9y1L9831rWtqFrwcj5jMuBl5W9I+F5
 SFiaaXxDE/faw0wdVsf2ShYgqhle+bj1afx+qmx5aBxjfNRVHHPO9saX1YiEm3HdcVN+
 dBXEtQRO6NaBOBLekoyfy6uhhYytX0aDxwmPSKwco4j7ge0Mhs3AcA1p0UTafOFor7+d
 lQV56a6xXoLKTUq/mJYLhJlhxIpCTQhQBA33TcnkEdRoyRUF18obnIdaFgM3FYG+fVv0
 9Ly9oRCaK+y7xyzmcNZk+9RPx681c3yNttisxesvTyE5+a5ZV/pSlkMhqZNNgUJcggFg cg== 
Received: from sendprdmail22.cc.columbia.edu (sendprdmail22.cc.columbia.edu [128.59.72.24])
        by mx0b-00364e01.pphosted.com with ESMTP id 34nretn9xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 19:38:13 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by sendprdmail22.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 0AD0cCFf035701
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 19:38:12 -0500
Received: by mail-qv1-f71.google.com with SMTP id w6so4994325qvr.15
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6GHSVFv6nLZcPp7xHyy6h6ys4E8ZCnHV183m9AtQ+oU=;
        b=mvtqv8B8QOOdKdsGnoPdPjH9H3WlcxG2MQs2l34JfOeTCoq9jQmiKEGfU8YnsI+LBL
         HYzndMxk2AXajStnXBZn44AFaXMdx+G3ki0artsqiqFiooMMB3FxCCcAgUHZ1ayOwkcH
         Ig6hx8ytNzcN9rnsl//kn0LA3AHQZlMvuBYEOMEy5fhH7GKW62SyZAY1w1lQjqRbxnLL
         bpqK58X9lk86wop8ZNE7U3lnkbbNiLq51SrbPq/n1fDvBSvjoCM1sYG4bFAbzTqkvidX
         l8Vx9M+qfjYIz4eShjkq/UlP0LtNbiO2vPI08JrUoY5ql57ezDArGO9b4rEXv8n4AxmI
         9esQ==
X-Gm-Message-State: AOAM532xc9o6G4APgmM+Ts5wd/BBxdmeI5hWfkbAuCkrOkXubTWqGIr1
        UK08RNhPiMLN0fzZL+XtCjkuSAECtF/4//pU/62WbMU5imI9/1eeg6JDXaYhdwYv3bAoSr1bcp8
        AFI6wfLG3IZd+BsI9B/oyzY2TG6vKCkSC
X-Received: by 2002:ac8:5b94:: with SMTP id a20mr1911810qta.223.1605227891815;
        Thu, 12 Nov 2020 16:38:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBzEHRTJRu5aGYZiB78oPhguCzcqO8415TjaRayvNVRls5a2aCXvKAnOdg5JbUu7OMvrvH0w==
X-Received: by 2002:ac8:5b94:: with SMTP id a20mr1911790qta.223.1605227891513;
        Thu, 12 Nov 2020 16:38:11 -0800 (PST)
Received: from charmander (dyn-160-39-33-233.dyn.columbia.edu. [160.39.33.233])
        by smtp.gmail.com with ESMTPSA id i64sm6128558qtb.43.2020.11.12.16.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:38:11 -0800 (PST)
Date:   Thu, 12 Nov 2020 19:38:09 -0500
From:   Tal Zussman <tz2294@columbia.edu>
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org
Subject: [PATCH] kernel/sys.c: trivial: Fix typos and formatting in comments
Message-ID: <20201113003809.GA7686@charmander>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_16:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=10 mlxlogscore=953 clxscore=1015
 suspectscore=1 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=10
 impostorscore=10 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 kernel/sys.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..399ef8d8cb61 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1584,7 +1584,7 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 
 	/*
 	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not
-	 * infite. In case of RLIM_INFINITY the posix CPU timer code
+	 * infinite. In case of RLIM_INFINITY the posix CPU timer code
 	 * ignores the rlimit.
 	 */
 	 if (!retval && new_rlim && resource == RLIMIT_CPU &&
@@ -1692,18 +1692,18 @@ SYSCALL_DEFINE2(setrlimit, unsigned int, resource, struct rlimit __user *, rlim)
  * given child after it's reaped, or none so this sample is before reaping.
  *
  * Locking:
- * We need to take the siglock for CHILDEREN, SELF and BOTH
- * for  the cases current multithreaded, non-current single threaded
- * non-current multithreaded.  Thread traversal is now safe with
+ * We need to take the siglock for CHILDREN, SELF and BOTH
+ * for the cases current multithreaded, non-current single threaded
+ * non-current multithreaded. Thread traversal is now safe with
  * the siglock held.
- * Strictly speaking, we donot need to take the siglock if we are current and
- * single threaded,  as no one else can take our signal_struct away, no one
- * else can  reap the  children to update signal->c* counters, and no one else
+ * Strictly speaking, we do not need to take the siglock if we are current and
+ * single threaded, as no one else can take our signal_struct away, no one
+ * else can reap the children to update signal->c* counters, and no one else
  * can race with the signal-> fields. If we do not take any lock, the
  * signal-> fields could be read out of order while another thread was just
- * exiting. So we should  place a read memory barrier when we avoid the lock.
- * On the writer side,  write memory barrier is implied in  __exit_signal
- * as __exit_signal releases  the siglock spinlock after updating the signal->
+ * exiting. So we should place a read memory barrier when we avoid the lock.
+ * On the writer side, write memory barrier is implied in  __exit_signal
+ * as __exit_signal releases the siglock spinlock after updating the signal->
  * fields. But we don't do this yet to keep things simple.
  *
  */
@@ -2204,7 +2204,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
 	 * If command line arguments and environment
 	 * are placed somewhere else on stack, we can
 	 * set them up here, ARG_START/END to setup
-	 * command line argumets and ENV_START/END
+	 * command line arguments and ENV_START/END
 	 * for environment.
 	 */
 	case PR_SET_MM_START_STACK:
@@ -2252,12 +2252,12 @@ static int prctl_get_tid_address(struct task_struct *me, int __user * __user *ti
 static int propagate_has_child_subreaper(struct task_struct *p, void *data)
 {
 	/*
-	 * If task has has_child_subreaper - all its decendants
-	 * already have these flag too and new decendants will
+	 * If task has has_child_subreaper - all its descendants
+	 * already have these flag too and new descendants will
 	 * inherit it on fork, skip them.
 	 *
 	 * If we've found child_reaper - skip descendants in
-	 * it's subtree as they will never get out pidns.
+	 * its subtree as they will never get out pidns.
 	 */
 	if (p->signal->has_child_subreaper ||
 	    is_child_reaper(task_pid(p)))
-- 
2.20.1

