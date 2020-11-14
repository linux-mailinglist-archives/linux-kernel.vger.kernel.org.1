Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9A2B2D38
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgKNMyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:54:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgKNMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:53:58 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AECWP8P084243;
        Sat, 14 Nov 2020 07:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+GFf5HLFwaNORiZdhbLtPgFiP1jvubuOoIqJBQqz6Cw=;
 b=lhwhQyYFs5y6YOmilCIz02cFWnCV/2zrsd5RZgkp84qtvM9TG0Zr5z66S+SA8q+6zBxR
 4SVQComWP0pK42UzLXOFnOgaOXYdr58PEdXHBXgLD8mp1OrCddESU+nImemWy9UetsgZ
 b88vWQVOHHsmPfRtSjJqowT0Y+xWGyu39hgiBvxDFIL0VyHxynlVwhT1yfbHF44EIxTJ
 4VuHJpJPSJV+KrJP7ViwOVGL/VY0h+k4+fQMK6qiw7GciMMetkjWWp5b6pq+hAJGSwEW
 tKT+T/DRdULpHCUhwFmYVyfUqDzlJu59TV2mowEThfN0TbzX0X+S/bdhDObAIbR8q+mj RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34tdft1xf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Nov 2020 07:53:17 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AECcv1J103682;
        Sat, 14 Nov 2020 07:53:17 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34tdft1xev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Nov 2020 07:53:17 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AECph6L009545;
        Sat, 14 Nov 2020 12:53:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 34t6gh85gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Nov 2020 12:53:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AECrC7p60424516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Nov 2020 12:53:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD546A4040;
        Sat, 14 Nov 2020 12:53:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F647A4051;
        Sat, 14 Nov 2020 12:53:12 +0000 (GMT)
Received: from localhost (unknown [9.171.68.134])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 14 Nov 2020 12:53:12 +0000 (GMT)
Date:   Sat, 14 Nov 2020 13:53:10 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/sorttable: Fix ORC unwind table sorting on big endian
Message-ID: <patch.git-45d71f2e4f14.your-ad-here.call-01605357883-ext-1218@work.hours>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-14_04:2020-11-13,2020-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=2 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when x86_64 kernel is cross compiled on big endian hardware
ORC unwind table is not sorted correctly. Due to missing byte swaps and
treating size as 4-byte value ORC sections sizes end up as 0 and the
problem is silently ignored.

Make ORC unwind table sorting endianness aware.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 This goes on top of the patch series:
 http://lkml.kernel.org/r/cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours

 scripts/sorttable.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..99f3fa1767d1 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -59,6 +59,8 @@
 # define uint_t			uint64_t
 # define _r			r8
 # define _w			w8
+# define _r4			r
+# define _w4			w
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -80,6 +82,8 @@
 # define uint_t			uint32_t
 # define _r			r
 # define _w			w
+# define _r4			r
+# define _w4			w
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -98,7 +102,7 @@ pthread_t orc_sort_thread;
 
 static inline unsigned long orc_ip(const int *ip)
 {
-	return (unsigned long)ip + *ip;
+	return (unsigned long)ip + (int)_r4((uint32_t *)ip);
 }
 
 static int orc_sort_cmp(const void *_a, const void *_b)
@@ -158,7 +162,7 @@ static void *sort_orctable(void *arg)
 	/* initialize indices array, convert ip_table to absolute address */
 	for (i = 0; i < num_entries; i++) {
 		idxs[i] = i;
-		tmp_orc_ip_table[i] = g_orc_ip_table[i] + i * sizeof(int);
+		tmp_orc_ip_table[i] = (int)_r4((uint32_t *)&g_orc_ip_table[i]) + i * sizeof(int);
 	}
 	memcpy(tmp_orc_table, g_orc_table, orc_size);
 
@@ -169,7 +173,7 @@ static void *sort_orctable(void *arg)
 			continue;
 
 		/* convert back to relative address */
-		g_orc_ip_table[i] = tmp_orc_ip_table[idxs[i]] - i * sizeof(int);
+		_w4(tmp_orc_ip_table[idxs[i]] - i * sizeof(int), (uint32_t *)&g_orc_ip_table[i]);
 		g_orc_table[i] = tmp_orc_table[idxs[i]];
 	}
 
@@ -256,14 +260,12 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = s->sh_size;
-			g_orc_ip_table = (int *)((void *)ehdr +
-						   s->sh_offset);
+			orc_ip_size = _r(&s->sh_size);
+			g_orc_ip_table = (int *)((void *)ehdr + _r(&s->sh_offset));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = s->sh_size;
-			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     s->sh_offset);
+			orc_size = _r(&s->sh_size);
+			g_orc_table = (struct orc_entry *)((void *)ehdr + _r(&s->sh_offset));
 		}
 #endif
 	} /* for loop */
-- 
2.25.4
