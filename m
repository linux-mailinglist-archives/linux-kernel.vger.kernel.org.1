Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA852BBC24
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKUCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:13:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgKUCNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:13:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AL25Z7i173836;
        Sat, 21 Nov 2020 02:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=KUG4PDvOwngs6N6BX25iUqg/rAZPMRJUAGALjtlZ0Nw=;
 b=wX+nJA70fy5YbuJCM1hDMto3f+HxdUPPHJXemASyGjx+eIT8mQKWiQL/OViFCQwUoEVn
 p3wDKAsLGhzc6udwGImj3+UNOHnNhoFksRAWteNe2+j0K9i9A8uYocBagF6EAmgsLPmA
 dcb75v5eq6uqdlDc0zIcVg0Dqm0ZduIXrjGm+Hmj90i1c7UPfobR+qB4iV8nS5Ht+g73
 9GfpVkJ11GtuVHFDWjXUhQ/SklkJMEAspGJYbEaVe0zwx2QiKm3Xj5IWpuxc8yhYjh5d
 csVMLuvSG896ZUCkkj6tdhdtaz1zPyf7jKRfv/e4A0VlDtZDG7me/xC8JdLkefFV4Job FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vnn654-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 21 Nov 2020 02:13:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AL2BST8113030;
        Sat, 21 Nov 2020 02:12:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34umd47aff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Nov 2020 02:12:59 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AL2CwfW009301;
        Sat, 21 Nov 2020 02:12:58 GMT
Received: from instance-20201020-2045-libo.osdevelopmeniad.oraclevcn.com (/100.100.230.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Nov 2020 18:12:57 -0800
From:   Libo Chen <libo.chen@oracle.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
Cc:     m.mizuma@jp.fujitsu.com
Subject: [PATCH 1/1] ktest.pl: Fix incorrect reboot for grub2bls
Date:   Fri, 20 Nov 2020 18:12:43 -0800
Message-Id: <20201121021243.1532477-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue was first noticed when I was testing different kernels on
Oracle Linux 8 which as Fedora 30+ adopts BLS as default. Even though a
kernel entry was added successfully and the index of that kernel entry was
retrieved correctly, ktest still wouldn't reboot the system into
user-specified kernel.

The bug was spotted in subroutine reboot_to where the if-statement never
checks for REBOOT_TYPE "grub2bls", therefore the desired entry will not be
set for the next boot.

Add a check for "grub2bls" so that $grub_reboot $grub_number can
be run before a reboot if REBOOT_TYPE is "grub2bls" then we can boot to
the correct kernel.

Fixes: ac2466456eaa ("ktest: introduce grub2bls REBOOT_TYPE option")

Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index cb16d2aac51c..54188ee16c48 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2040,7 +2040,7 @@ sub reboot_to {
 
     if ($reboot_type eq "grub") {
 	run_ssh "'(echo \"savedefault --default=$grub_number --once\" | grub --batch)'";
-    } elsif ($reboot_type eq "grub2") {
+    } elsif (($reboot_type eq "grub2") or ($reboot_type eq "grub2bls")) {
 	run_ssh "$grub_reboot $grub_number";
     } elsif ($reboot_type eq "syslinux") {
 	run_ssh "$syslinux --once \\\"$syslinux_label\\\" $syslinux_path";
-- 
2.27.0

