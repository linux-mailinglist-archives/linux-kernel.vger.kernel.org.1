Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073B82A7D75
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgKELrp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Nov 2020 06:47:45 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:51831 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbgKELrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:47:45 -0500
X-Greylist: delayed 1581 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 06:47:39 EST
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id 0A5BLH7F087659
        for <linux-kernel@vger.kernel.org>; Thu, 5 Nov 2020 19:21:17 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id 0A5BL4cB087198
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 5 Nov 2020 19:21:04 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from localhost (10.0.74.33) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 5 Nov 2020 19:21:05
 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, <xuewen.yan94@gmail.com>
Subject: [PATCH v2] sched: revise the initial value of the util_avg.
Date:   Thu, 5 Nov 2020 19:20:53 +0800
Message-ID: <1604575253-2386-1-git-send-email-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.0.74.33]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com 0A5BL4cB087198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the original code logic:
                cfs_rq->avg.util_avg
sa->util_avg  = -------------------- * se->load.weight
                cfs_rq->avg.load_avg
but for fair_sched_class:
se->load.weight = 1024 * sched_prio_to_weight[prio];
        cfs_rq->avg.util_avg
so the  -------------------- must be extremely small, the
        cfs_rq->avg.load_avg
judgment condition "sa->util_avg < cap" could be established.
It's not fair for those tasks who has smaller nice value.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e3..079760b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -794,7 +794,11 @@ void post_init_entity_util_avg(struct task_struct *p)

        if (cap > 0) {
                if (cfs_rq->avg.util_avg != 0) {
-                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+                       if (p->sched_class == &fair_sched_class)
+                               sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
+                       else
+                               sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+
                        sa->util_avg /= (cfs_rq->avg.load_avg + 1);

                        if (sa->util_avg > cap)
--
1.9.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
