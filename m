Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3486298D18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775459AbgJZMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:49:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54348 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1768773AbgJZMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:49:18 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QCVx1j170062;
        Mon, 26 Oct 2020 08:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2yx1YdhlwJAg3/Nd0uG6Y3uzIjyLxLnTpiyheWl/qvs=;
 b=J3MHI0HACEDx2n7Zj80yVnpt6LIw3PYcW0rnbNu9jqwzZH1fMlwC6o7TWWhW6pFLmVu3
 j0p/99U2GLMhs1n6SNzzlRN+PpcGw1LQjd7UK6dU3OuJynwbeTgLHoOqyaOwqGknBDvz
 AlkJTgoK1OpHA/W7wMSlfXmq4EEt4Sl+rfiz+JaTNqh5vYuKj30XpB612BIjr5YvEAOS
 izjihdJMewrR6oHKrTIF7aymxC1jfooUfOAdCt80l2vw9Ysf0DRElfs0u/K2VpBVxZJ+
 s6Ye1yb6iYPwCV+gpz9gQ3m1SNWUjg0A8fmExscw3YAh1jpTOoWyDQGk0GhR842aKiIB 5Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34d97fheur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 08:49:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QCkoon011630;
        Mon, 26 Oct 2020 12:49:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 34cbhh27tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 12:49:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09QCnARb26018224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 12:49:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24F9D4C046;
        Mon, 26 Oct 2020 12:49:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B42C14C052;
        Mon, 26 Oct 2020 12:49:09 +0000 (GMT)
Received: from localhost (unknown [9.145.93.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Oct 2020 12:49:09 +0000 (GMT)
Date:   Mon, 26 Oct 2020 13:49:08 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] s390: correct __bootdata / __bootdata_preserved macros
Message-ID: <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
References: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
 <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_06:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=2 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=775
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010260088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently s390 build is broken.

  SECTCMP .boot.data
error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
make[2]: *** [arch/s390/boot/section_cmp.boot.data] Error 1
  SECTCMP .boot.preserved.data
error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
make[2]: *** [arch/s390/boot/section_cmp.boot.preserved.data] Error 1
make[1]: *** [bzImage] Error 2

Commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
to __section("foo")") converted all __section(foo) to __section("foo").
This is wrong for __bootdata / __bootdata_preserved macros which want
variable names to be a part of intermediate section names .boot.data.<var
name> and .boot.preserved.data.<var name>. Those sections are later
sorted by alignment + name and merged together into final .boot.data
/ .boot.preserved.data sections. Those sections must be identical in
the decompressor and the decompressed kernel (that is checked during
the build).

Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/include/asm/sections.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/sections.h b/arch/s390/include/asm/sections.h
index a996d3990a02..0c2151451ba5 100644
--- a/arch/s390/include/asm/sections.h
+++ b/arch/s390/include/asm/sections.h
@@ -26,14 +26,14 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
  * final .boot.data section, which should be identical in the decompressor and
  * the decompressed kernel (that is checked during the build).
  */
-#define __bootdata(var) __section(".boot.data.var") var
+#define __bootdata(var) __section(".boot.data." #var) var
 
 /*
  * .boot.preserved.data is similar to .boot.data, but it is not part of the
  * .init section and thus will be preserved for later use in the decompressed
  * kernel.
  */
-#define __bootdata_preserved(var) __section(".boot.preserved.data.var") var
+#define __bootdata_preserved(var) __section(".boot.preserved.data." #var) var
 
 extern unsigned long __sdma, __edma;
 extern unsigned long __stext_dma, __etext_dma;
-- 
2.25.4
