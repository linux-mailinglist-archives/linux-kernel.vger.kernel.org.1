Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1328DBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgJNIeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:34:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37972 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgJNIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:34:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8Ua63182186;
        Wed, 14 Oct 2020 08:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=RJVK+CzUyTBfDw8obQvm5ubHP60lgkWKdRwFkICT7nw=;
 b=waB2eQIrwmiMTY3v0fBxN+93kgkczxJ4quJYyja93bd6i5Dm8tsjGIB7W2Js086WpoVB
 4enKt3KAE78OZNY+6kIBzbWDQ3YC20h4JXcNjE5i9/HzvUMLKMsCdhblh/AnGtei7iix
 Vo+T+hmgGh73p7YHMb7LlNntZJxaaQNLIBr7reXMxvpbUffuCKjZtDt+VrGr3jtMM8aJ
 e/FqGOoZ0S6J+nW4W2DRpzaL4m/I05aHv9uAZODqoLDYnBVmLgNMHRnCc0ELj4kBOrfI
 TSVIU5vxg3KXD2eTH1VmHEpGbb5iwDjT/ksM0rdp8AlrvS5/pIM+9zqTU87kKTLHpzZ7 jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3434wkp60x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:33:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8TYC9005668;
        Wed, 14 Oct 2020 08:33:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 344by3a4y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:33:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09E8XeAc021661;
        Wed, 14 Oct 2020 08:33:40 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:33:40 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 7/8] x86/cpu/intel: enable X86_FEATURE_NT_GOOD on Intel Broadwellx
Date:   Wed, 14 Oct 2020 01:32:58 -0700
Message-Id: <20201014083300.19077-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014083300.19077-1-ankur.a.arora@oracle.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System:           Oracle X6-2
CPU:              2 nodes * 10 cores/node * 2 threads/core
		  Intel Xeon E5-2630 v4 (Broadwellx, 6:79:1)
Memory:           256 GB evenly split between nodes
Microcode:        0xb00002e
scaling_governor: performance
L3 size:          25MB
intel_pstate/no_turbo: 1

Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
(X86_FEATURE_ERMS) and x86-64-movnt (X86_FEATURE_NT_GOOD):

              x86-64-stosb (5 runs)     x86-64-movnt (5 runs)       speedup
              -----------------------   -----------------------     -------
     size       BW        (   pstdev)          BW   (   pstdev)

     16MB      17.35 GB/s ( +- 9.27%)    11.83 GB/s ( +- 0.19%)     -31.81%
    128MB       5.31 GB/s ( +- 0.13%)    11.72 GB/s ( +- 0.44%)    +121.84%
   1024MB       5.42 GB/s ( +- 0.13%)    11.78 GB/s ( +- 0.03%)    +117.34%
   4096MB       5.41 GB/s ( +- 0.41%)    11.76 GB/s ( +- 0.07%)    +117.37%

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

Page-clearing throughput for clear_page_erms(): 3.72 GBps
$ perf stat -r 5 --all-kernel -e ... bin/pf-test 128

 Performance counter stats for 'bin/pf-test 128' (5 runs):

    74,799,496,556      cpu-cycles                #    2.176 GHz                      ( +-  2.22% )  (29.41%)
     1,474,615,023      instructions              #    0.02  insn per cycle           ( +-  0.23% )  (35.29%)
     2,148,580,131      cache-references          #   62.502 M/sec                    ( +-  0.02% )  (35.29%)
        71,736,985      cache-misses              #    3.339 % of all cache refs      ( +-  0.94% )  (35.29%)
       433,713,165      branch-instructions       #   12.617 M/sec                    ( +-  0.15% )  (35.30%)
         1,008,251      branch-misses             #    0.23% of all branches          ( +-  1.88% )  (35.30%)
     3,406,821,966      bus-cycles                #   99.104 M/sec                    ( +-  2.22% )  (23.53%)
     2,156,059,110      L1-dcache-load-misses     #  445.35% of all L1-dcache accesses  ( +-  0.01% )  (23.53%)
       484,128,243      L1-dcache-loads           #   14.083 M/sec                    ( +-  0.22% )  (23.53%)
           944,216      LLC-loads                 #    0.027 M/sec                    ( +-  7.41% )  (23.53%)
           537,989      LLC-load-misses           #   56.98% of all LL-cache accesses  ( +- 13.64% )  (23.53%)
     2,150,138,476      LLC-stores                #   62.547 M/sec                    ( +-  0.01% )  (11.76%)
        69,598,760      LLC-store-misses          #    2.025 M/sec                    ( +-  0.47% )  (11.76%)
       483,923,875      dTLB-loads                #   14.077 M/sec                    ( +-  0.21% )  (17.64%)
             1,892      dTLB-load-misses          #    0.00% of all dTLB cache accesses  ( +- 30.63% )  (23.53%)
     4,799,154,980      dTLB-stores               #  139.606 M/sec                    ( +-  0.03% )  (23.53%)
                90      dTLB-store-misses         #    0.003 K/sec                    ( +- 35.92% )  (23.53%)

            34.377 +- 0.760 seconds time elapsed  ( +-  2.21% )

Page-clearing throughput with clear_page_nt(): 11.78GBps
$ perf stat -r 5 --all-kernel -e ... bin/pf-test 128

 Performance counter stats for 'bin/pf-test 128' (5 runs):

    23,699,446,603      cpu-cycles                #    2.182 GHz                      ( +-  0.01% )  (23.53%)
    24,794,548,512      instructions              #    1.05  insn per cycle           ( +-  0.00% )  (29.41%)
           432,775      cache-references          #    0.040 M/sec                    ( +-  3.96% )  (29.41%)
            75,580      cache-misses              #   17.464 % of all cache refs      ( +- 51.42% )  (29.41%)
     2,492,858,290      branch-instructions       #  229.475 M/sec                    ( +-  0.00% )  (29.42%)
        34,016,826      branch-misses             #    1.36% of all branches          ( +-  0.04% )  (29.42%)
     1,078,468,643      bus-cycles                #   99.276 M/sec                    ( +-  0.01% )  (23.53%)
           717,228      L1-dcache-load-misses     #    0.20% of all L1-dcache accesses  ( +-  3.77% )  (23.53%)
       351,999,535      L1-dcache-loads           #   32.403 M/sec                    ( +-  0.04% )  (23.53%)
            75,988      LLC-loads                 #    0.007 M/sec                    ( +-  4.20% )  (23.53%)
            24,503      LLC-load-misses           #   32.25% of all LL-cache accesses  ( +- 53.30% )  (23.53%)
            57,283      LLC-stores                #    0.005 M/sec                    ( +-  2.15% )  (11.76%)
            19,738      LLC-store-misses          #    0.002 M/sec                    ( +- 46.55% )  (11.76%)
       351,836,498      dTLB-loads                #   32.388 M/sec                    ( +-  0.04% )  (17.65%)
             1,171      dTLB-load-misses          #    0.00% of all dTLB cache accesses  ( +- 42.68% )  (23.53%)
    17,385,579,725      dTLB-stores               # 1600.392 M/sec                    ( +-  0.00% )  (23.53%)
               200      dTLB-store-misses         #    0.018 K/sec                    ( +- 10.63% )  (23.53%)

         10.863678 +- 0.000804 seconds time elapsed  ( +-  0.01% )

L1-dcache-load-misses (L1D.REPLACEMENT) is substantially lower which
suggests that, as expected, we aren't doing write-allocate or RFO.

Note that the IPC and instruction counts etc are quite different, but
that's just an artifact of switching from a single 'REP; STOSB' per
PAGE_SIZE region to a MOVNTI loop.

The page-clearing BW is substantially higher (~100% or more), so enable
X86_FEATURE_NT_GOOD for Intel Broadwellx.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/cpu/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 59a1e3ce3f14..161028c1dee0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -662,6 +662,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 	if (c->x86 == 6)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+	if (c->x86 == 6 && c->x86_model == INTEL_FAM6_BROADWELL_X)
+		set_cpu_cap(c, X86_FEATURE_NT_GOOD);
 #else
 	/*
 	 * Names for the Pentium II/Celeron processors
-- 
2.9.3

