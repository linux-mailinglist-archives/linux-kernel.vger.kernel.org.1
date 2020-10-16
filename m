Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B122907B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407149AbgJPOvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:51:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405198AbgJPOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:51:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GEWUvB186445;
        Fri, 16 Oct 2020 10:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=c1NhbOHEDhzcxLPA1GOILYdrnACyWXlyvDOPA70TcX8=;
 b=kIVFjsE9ZGRXvlRSsPWsZwoSD6TdLz7XszoejJxHz9M+HGmy6tu3oyikjQt2U7qLgTe+
 HyPJ1TQsdgccOgKl7T+rOVTLIb2ddfZ6kse8T54Am6NoVZltNGmIqEUUOydpbsa5buN3
 koxM2MWdP7q6qa7PFj8JHRoQmXY4mIMbRH0qrxm9Y1buIOhcByU9hQjsw7ipjubjlgg/
 od5zPTKJEOB8iN3w01fQP7akAKSW/JhLzrhdw31Gz83q2VX8qejTaVrjfEbXMbfShXk8
 U6GX9PvOmWjGdRIdCe6dCwe6Zwrnhhz4QxMpLD0SeWoDHYceafPkgewSS9Eu/l/uHu6m 1w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347da78tca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 10:51:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09GEmXnW010896;
        Fri, 16 Oct 2020 14:51:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3434k86ddg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 14:51:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09GEp0mE30867760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 14:51:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB480AE04D;
        Fri, 16 Oct 2020 14:51:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48053AE056;
        Fri, 16 Oct 2020 14:51:00 +0000 (GMT)
Received: from localhost (unknown [9.145.150.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 16 Oct 2020 14:51:00 +0000 (GMT)
Date:   Fri, 16 Oct 2020 16:50:58 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/crc32test: remove extra local_irq_disable/enable
Message-ID: <patch.git-4369da00c06e.your-ad-here.call-01602859837-ext-1679@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_07:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=734
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4d004099a668 ("lockdep: Fix lockdep recursion") uncovered the
following issue in lib/crc32test reported on s390:

BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
caller is lockdep_hardirqs_on_prepare+0x48/0x270
CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.9.0-next-20201015-15164-g03d992bd2de6 #19
Hardware name: IBM 3906 M04 704 (LPAR)
Call Trace:
 [<0000000000d54870>] show_stack+0x90/0xf8
 [<0000000000d675d2>] dump_stack+0xa2/0xd8
 [<0000000000d6c9ac>] check_preemption_disabled+0xe4/0xe8
 [<00000000001d6098>] lockdep_hardirqs_on_prepare+0x48/0x270
 [<00000000002ac274>] trace_hardirqs_on+0x9c/0x1b8
 [<0000000001441430>] crc32_test.isra.0+0x170/0x1c0
 [<0000000001441764>] crc32test_init+0x1c/0x40
 [<0000000000100cd0>] do_one_initcall+0x40/0x130
 [<0000000001411586>] do_initcalls+0x126/0x150
 [<0000000001411826>] kernel_init_freeable+0x1f6/0x230
 [<0000000000d6cc92>] kernel_init+0x22/0x150
 [<0000000000d7bcc4>] ret_from_fork+0x24/0x2c
no locks held by swapper/0/1.

Remove extra local_irq_disable/local_irq_enable helpers calls.

Fixes: 5fb7f87408f1 ("lib: add module support to crc32 tests")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 lib/crc32test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/crc32test.c b/lib/crc32test.c
index 97d6a57cefcc..61ddce2cff77 100644
--- a/lib/crc32test.c
+++ b/lib/crc32test.c
@@ -683,7 +683,6 @@ static int __init crc32c_test(void)
 
 	/* reduce OS noise */
 	local_irq_save(flags);
-	local_irq_disable();
 
 	nsec = ktime_get_ns();
 	for (i = 0; i < 100; i++) {
@@ -694,7 +693,6 @@ static int __init crc32c_test(void)
 	nsec = ktime_get_ns() - nsec;
 
 	local_irq_restore(flags);
-	local_irq_enable();
 
 	pr_info("crc32c: CRC_LE_BITS = %d\n", CRC_LE_BITS);
 
@@ -768,7 +766,6 @@ static int __init crc32_test(void)
 
 	/* reduce OS noise */
 	local_irq_save(flags);
-	local_irq_disable();
 
 	nsec = ktime_get_ns();
 	for (i = 0; i < 100; i++) {
@@ -783,7 +780,6 @@ static int __init crc32_test(void)
 	nsec = ktime_get_ns() - nsec;
 
 	local_irq_restore(flags);
-	local_irq_enable();
 
 	pr_info("crc32: CRC_LE_BITS = %d, CRC_BE BITS = %d\n",
 		 CRC_LE_BITS, CRC_BE_BITS);
-- 
2.25.4
