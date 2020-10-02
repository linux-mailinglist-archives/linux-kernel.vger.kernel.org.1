Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999EE2811DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbgJBL6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:58:05 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:31314 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBL6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:58:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601639884; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qDQzbm47CYdBUkE20350VaDtfWjfmMFoiz8B19hWedA=; b=q4rbO/n+W25/Ne4h5oh3vVmZdm/aHjp+0kwTKpqKA5aNTN9/dW7W/3figVSUzuzWhmJ089EX
 WbTz7FSz7XHqTQfWlMtnXt1BcXqbbGEhfv6K+EhZvErktRIfxVGhe6/xOJlbIz3hEMi1J+k8
 7FP60TaB9wCWKzaDBo4BuTolUmw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f7715cb8246bdcb55a3c554 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Oct 2020 11:58:03
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01B28C433C8; Fri,  2 Oct 2020 11:58:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-498.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBCB8C433FE;
        Fri,  2 Oct 2020 11:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBCB8C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pintu@codeaurora.org
From:   Pintu Kumar <pintu@codeaurora.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     pintu@codeaurora.org, pintu.ping@gmail.com
Subject: [PATCH] mm/util.c: Add error logs for commitment overflow
Date:   Fri,  2 Oct 2020 17:27:41 +0530
Message-Id: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headless embedded devices often come with very limited amount
of RAM such as: 256MB or even lesser.
These types of system often rely on command line interface which can
execute system commands in the background using the fork/exec combination.
There could be even many child tasks invoked internally to handle multiple
requests.
In this scenario, if the parent task keeps committing large amount of
memory, there are chances that this commitment can easily overflow the
total RAM available in the system. Now if the parent process invokes fork
or system commands (using system() call) and the commitment ratio is at
50%, the request fails with the following, even though there are large
amount of free memory available in the system:
fork failed: Cannot allocate memory

If there are too many 3rd party tasks calling fork, it becomes difficult to
identify exactly which parent process is overcommitting memory.
Since, free memory is also available, this "Cannot allocate memory" from
fork creates confusion to application developer.

Thus, I found that this simple print message (even once) is helping in
quickly identifying the culprit.

This is the output we can see on a 256MB system and with a simple malloc
and fork program.

[root@ ~]# cat /proc/meminfo
MemTotal:         249520 kB   ==> 243MB
MemFree:          179100 kB

PPID	PID	USER	RSS	VSZ	STAT	ARGS
 150	164	root	1440	250580	S	./consume-and-fork.out 243

__vm_enough_memory: commitment overflow: ppid:150, pid:164, pages:62451
fork failed[count:0]: Cannot allocate memory

Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
---
 mm/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index 5ef378a..9431ce7a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -895,6 +895,9 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 error:
 	vm_unacct_memory(pages);
 
+	pr_err_once("%s: commitment overflow: ppid:%d, pid:%d, pages:%ld\n",
+			__func__, current->parent->pid, current->pid, pages);
+
 	return -ENOMEM;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

