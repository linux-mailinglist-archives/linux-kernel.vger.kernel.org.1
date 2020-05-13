Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCA1D175D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 16:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbgEMOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 10:19:10 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:19215 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgEMOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:19:10 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 070EB109068;
        Wed, 13 May 2020 22:19:03 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] cpufreq: fix a minor typo for cpufreq_driver doc
Date:   Wed, 13 May 2020 07:18:54 -0700
Message-Id: <20200513141854.18451-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VDTUNCQkJCTkNLSENISFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6Dyo5TDgwLzEYQz4KGEI#
        Py5PFDJVSlVKTkNCSExCTk9NSElCVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUpNTks3Bg++
X-HM-Tid: 0a720e6734a79374kuws070eb109068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the duplicate "to" possibly double-typed.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index f7240251a949..67d5950bd878 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -330,7 +330,7 @@ struct cpufreq_driver {
 	 *
 	 * get_intermediate should return a stable intermediate frequency
 	 * platform wants to switch to and target_intermediate() should set CPU
-	 * to to that frequency, before jumping to the frequency corresponding
+	 * to that frequency, before jumping to the frequency corresponding
 	 * to 'index'. Core will take care of sending notifications and driver
 	 * doesn't have to handle them in target_intermediate() or
 	 * target_index().
-- 
2.17.1

