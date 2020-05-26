Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFED1C80D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 06:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEGEX3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 May 2020 00:23:29 -0400
Received: from smtp.h3c.com ([221.12.31.13]:35769 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEGEX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 00:23:28 -0400
X-Greylist: delayed 3576 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 00:23:27 EDT
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 0473Nop1042756
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 11:23:50 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 0473NcBg042361
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 May 2020 11:23:38 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 11:23:39 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <yubin@h3c.com>,
        <tian.xianting@h3c.com>
Subject: [PATCH] sched/fair: Fix typo in comment
Date:   Thu, 7 May 2020 11:18:53 +0800
Message-ID: <20200507031853.35994-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0473NcBg042361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_prempt_curr() -> check_preempt_curr()

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85..458ab5521 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6858,7 +6858,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_

        /*
         * This is possible from callers such as attach_tasks(), in which we
-        * unconditionally check_prempt_curr() after an enqueue (which may have
+        * unconditionally check_preempt_curr() after an enqueue (which may have
         * lead to a throttle).  This both saves work and prevents false
         * next-buddy nomination below.
         */
--
2.17.1

-------------------------------------------------------------------------------------------------------------------------------------
���ʼ����丽�������»������ŵı�����Ϣ�������ڷ��͸������ַ���г�
�ĸ��˻�Ⱥ�顣��ֹ�κ����������κ���ʽʹ�ã�������������ȫ���򲿷ֵ�й¶�����ơ�
��ɢ�������ʼ��е���Ϣ������������˱��ʼ������������绰���ʼ�֪ͨ�����˲�ɾ����
�ʼ���
This e-mail and its attachments contain confidential information from New H3C, which is
intended only for the person or entity whose address is listed above. Any use of the
information contained herein in any way (including, but not limited to, total or partial
disclosure, reproduction, or dissemination) by persons other than the intended
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
by phone or email immediately and delete it!
