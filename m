Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FB28DBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgJNIfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:35:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39392 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgJNIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:35:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8YRqa186243;
        Wed, 14 Oct 2020 08:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=T3PCr19DmirvMKsRm0x8g9OFkz0Tyylo49u+1BOAFHo=;
 b=St0ZITX9FhrksKfVT/FbxvtQeoLPaGoWi67xN00KCBxtVbBPOmHSPzKa8JljTBrLk02q
 kG9OQDHz5NqBB+ulZZuT39/ApUGjpag9g2YPoLlp7ONfE++y4550mD75c3xDRtDRIZ3k
 XimNsbHvQDYOSk40LN87kwohPcuZ5liQ/FLyzSJYIeHn3irPuULlNBM3F9RRVd+dMdSl
 9shj9ykx/EDGODiPYD9HCOqB2+0tQplAhJtzRds1ME/Ql3dr8KfFZAnAiUb2l8KWEBeB
 Ds/QJcFpy2s2ufD2ZJUn7KiZ6j/xl+T8+hYPxMQ2+LyjeTMlmrGBIbV/47IkW63xC4Bm 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3434wkp6h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:35:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8ZF86154891;
        Wed, 14 Oct 2020 08:35:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 343pv00cgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:35:30 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09E8ZT6X022446;
        Wed, 14 Oct 2020 08:35:29 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:35:29 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Huang <wei.huang2@amd.com>
Subject: [PATCH 8/8] x86/cpu/amd: enable X86_FEATURE_NT_GOOD on AMD Zen
Date:   Wed, 14 Oct 2020 01:32:59 -0700
Message-Id: <20201014083300.19077-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014083300.19077-1-ankur.a.arora@oracle.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System:           Oracle E2-2C
CPU:              2 nodes * 64 cores/node * 2 threads/core
                  AMD EPYC 7742 (Rome, 23:49:0)
Memory:           2048 GB evenly split between nodes
Microcode:        0x8301038
scaling_governor: performance
L3 size:          16 * 16MB
cpufreq/boost:    0

Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosq
(X86_FEATURE_REP_GOOD) and x86-64-movnt (X86_FEATURE_NT_GOOD):

              x86-64-stosq (5 runs)     x86-64-movnt (5 runs)      speedup
              -----------------------   -----------------------    -------
     size       BW        (   pstdev)          BW   (   pstdev)

     16MB      15.39 GB/s ( +- 9.14%)    14.56 GB/s ( +-19.43%)     -5.39%
    128MB      11.04 GB/s ( +- 4.87%)    14.49 GB/s ( +-13.22%)    +31.25%
   1024MB      11.86 GB/s ( +- 0.83%)    16.54 GB/s ( +- 0.04%)    +39.46%
   4096MB      11.89 GB/s ( +- 0.61%)    16.49 GB/s ( +- 0.28%)    +38.68%

The next workload exercises the page-clearing path directly by faulting over
an anonymous mmap region backed by 1GB pages. This workload is similar to the
creation phase of pinned guests in QEMU.

$ cat pf-test.c
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <linux/mman.h>

 #define HPAGE_BITS 30

 int main(int argc, char **argv) {
	int i;
	unsigned long len = atoi(argv[1]); /* In GB */
	unsigned long offset = 0;
	unsigned long numpages;
	char *base;

	len *= 1UL << 30;
	numpages = len >> HPAGE_BITS;

	base = mmap(NULL, len, PROT_READ|PROT_WRITE,
	            MAP_PRIVATE | MAP_ANONYMOUS |
		    MAP_HUGETLB | MAP_HUGE_1GB, 0, 0);

	for (i = 0; i < numpages; i++) {
	        *((volatile char *)base + offset) = *(base + offset);
	        offset += 1UL << HPAGE_BITS;
	}

	return 0;
 }

The specific test is for a 128GB region but this is a single-threaded
O(n) workload so the exact region size is not material.

Page-clearing throughput for clear_page_rep(): 11.33 GBps
$ perf stat -r 5 --all-kernel -e ... bin/pf-test 128

 Performance counter stats for 'bin/pf-test 128' (5 runs):

    25,130,082,910      cpu-cycles                #    2.226 GHz                      ( +-  0.44% )  (54.54%)
     1,368,762,311      instructions              #    0.05  insn per cycle           ( +-  0.02% )  (54.54%)
     4,265,726,534      cache-references          #  377.794 M/sec                    ( +-  0.02% )  (54.54%)
       119,021,793      cache-misses              #    2.790 % of all cache refs      ( +-  3.90% )  (54.55%)
       413,825,787      branch-instructions       #   36.650 M/sec                    ( +-  0.01% )  (54.55%)
           236,847      branch-misses             #    0.06% of all branches          ( +- 18.80% )  (54.56%)
     2,152,320,887      L1-dcache-load-misses     #   40.40% of all L1-dcache accesses  ( +-  0.01% )  (54.55%)
     5,326,873,560      L1-dcache-loads           #  471.775 M/sec                    ( +-  0.20% )  (54.55%)
       828,943,234      L1-dcache-prefetches      #   73.415 M/sec                    ( +-  0.55% )  (54.54%)
            18,914      dTLB-loads                #    0.002 M/sec                    ( +- 47.23% )  (54.54%)
             4,423      dTLB-load-misses          #   23.38% of all dTLB cache accesses  ( +- 27.75% )  (54.54%)

           11.2917 +- 0.0499 seconds time elapsed  ( +-  0.44% )

Page-clearing throughput for clear_page_nt(): 16.29 GBps
$ perf stat -r 5 --all-kernel -e ... bin/pf-test 128

 Performance counter stats for 'bin/pf-test 128' (5 runs):

    17,523,166,924      cpu-cycles                #    2.230 GHz                      ( +-  0.03% )  (45.43%)
    24,801,270,826      instructions              #    1.42  insn per cycle           ( +-  0.01% )  (45.45%)
     2,151,391,033      cache-references          #  273.845 M/sec                    ( +-  0.01% )  (45.46%)
           168,555      cache-misses              #    0.008 % of all cache refs      ( +-  4.87% )  (45.47%)
     2,490,226,446      branch-instructions       #  316.974 M/sec                    ( +-  0.01% )  (45.48%)
           117,604      branch-misses             #    0.00% of all branches          ( +-  1.56% )  (45.48%)
           273,492      L1-dcache-load-misses     #    0.06% of all L1-dcache accesses  ( +-  2.14% )  (45.47%)
       490,340,458      L1-dcache-loads           #   62.414 M/sec                    ( +-  0.02% )  (45.45%)
            20,517      L1-dcache-prefetches      #    0.003 M/sec                    ( +-  9.61% )  (45.44%)
             7,413      dTLB-loads                #    0.944 K/sec                    ( +-  8.37% )  (45.44%)
             2,031      dTLB-load-misses          #   27.40% of all dTLB cache accesses  ( +-  8.30% )  (45.43%)

           7.85674 +- 0.00270 seconds time elapsed  ( +-  0.03% )

The L1-dcache-load-misses (L2$ access from DC Miss) count is
substantially lower which suggests we aren't doing write-allocate or
RFO. The L1-dcache-prefetches are also substantially lower.

Note that the IPC and instruction counts etc are quite different, but
that's just an artifact of switching from a single 'REP; STOSQ' per
PAGE_SIZE region to a MOVNTI loop.

The page-clearing BW shows a ~40% improvement. Additionally, a quick
'perf bench memset' comparison on AMD Naples (AMD EPYC 7551) shows
similar performance gains. So, enable X86_FEATURE_NT_GOOD for
AMD Zen.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/cpu/amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dcc3d943c68f..c57eb6c28aa1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -918,6 +918,9 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
 
+	if (c->x86 == 0x17)
+		set_cpu_cap(c, X86_FEATURE_NT_GOOD);
+
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
 #endif
-- 
2.9.3

