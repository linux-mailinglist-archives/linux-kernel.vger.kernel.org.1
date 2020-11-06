Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7876A2A91D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgKFIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:52:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:52:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A68n23R059812;
        Fri, 6 Nov 2020 08:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=hdn3S6G4CZ9K6laz9yIdjncIsG6hx8UfoRsDLSDj7Cc=;
 b=r3MCFurXvxw6VH30+BpBL/iLkG9zfbW90V0aivuUIG37aBoX6BdCRhYrYHqo3bSCcrZP
 q4jcrELDM51Erem499ec0SOlvwNU4ibutEKmmJ+R6Gh8ZarvtI/TAD5F3eDTNXmGDtY+
 JOOK9ONDKTUvu+6B4+3ktfZk+aax0Wk5ShmzSUiepAoOZWdc5/9rrxmDLgA/6SAWv8ZG
 M+jyY5FVqKGAYr0ONxXKjweKE6VofLKEJJ4/CqeMFXnO4aYpKmdM9Lt4ikua+/k7iwLD
 ubZOfjZ6xWNkH5vaESacio1+wtbq2DSVtRrOpzFHAPIdzg9QnH9lvARO3ddoyyu0xXB0 wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34hhw2yvgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 08:52:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A68oo64166690;
        Fri, 6 Nov 2020 08:52:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34hw0jwc5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 08:52:18 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A68qC36031674;
        Fri, 6 Nov 2020 08:52:17 GMT
Received: from mwanda (/10.175.216.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 00:52:11 -0800
Date:   Fri, 6 Nov 2020 11:52:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] futex: Don't enable IRQs unconditionally in put_pi_state()
Message-ID: <20201106085205.GA1159983@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exit_pi_state_list() function calls put_pi_state() with IRQs
disabled and is not expecting that IRQs will be enabled inside the
function.  Use the _irqsave() so that IRQs are restored to the original
state instead of enabled unconditionally.

Fixes: 153fbd1226fb ("futex: Fix more put_pi_state() vs. exit_pi_state_list() races")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is from static analysis and not tested.  I am not very familiar
with futex code.

 kernel/futex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index f8614ef4ff31..ca84745713bc 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -788,8 +788,9 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 	 */
 	if (pi_state->owner) {
 		struct task_struct *owner;
+		unsigned long flags;
 
-		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_lock_irqsave(&pi_state->pi_mutex.wait_lock, flags);
 		owner = pi_state->owner;
 		if (owner) {
 			raw_spin_lock(&owner->pi_lock);
@@ -797,7 +798,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 			raw_spin_unlock(&owner->pi_lock);
 		}
 		rt_mutex_proxy_unlock(&pi_state->pi_mutex, owner);
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock, flags);
 	}
 
 	if (current->pi_state_cache) {
-- 
2.28.0

