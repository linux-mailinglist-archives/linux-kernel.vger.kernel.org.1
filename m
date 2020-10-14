Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3728728DBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgJNIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:34:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42762 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgJNIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:34:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8SVvl079244;
        Wed, 14 Oct 2020 08:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ft6BxI93bWXpv5KvcECBv+9LJ7SCRti4HHPnJOWKA5I=;
 b=Czn2jonC75aPpOWTRBGtuTqOGY4H6TXn6TUbRZ5mRdbo4BOgCgnz/GMijDJWZvVhm8Vn
 n25yZEqwzTTBwu4KXzAqYfqAuK3Jce8tU/ydy9cRWLUS6R5L37ZgXRQrwLFebCS6Tk1P
 JbbVYWy2CYn7EeB8tDg1zbafT9+0bUZCorMQiVXY7RtHcVsC7j99wJJMWiFVtXsOBC6n
 7hH+jj5WeJwfG1bjvZ3dX93/ria/3rD8QGahF5qTeTq/9y6gmdokx63RmbI9GrhZqvlj
 iWM29v//dmbItItKrUUe//B68OVFHAgJOFWypC0zGTJWhRBQBUflDkSCyGqDu/4aRhgs Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 343pajvt4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:33:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8UYa3111523;
        Wed, 14 Oct 2020 08:33:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 343pvxfstq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:33:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09E8X6iQ021466;
        Wed, 14 Oct 2020 08:33:06 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:33:05 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4/8] x86/asm: add clear_page_nt()
Date:   Wed, 14 Oct 2020 01:32:55 -0700
Message-Id: <20201014083300.19077-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014083300.19077-1-ankur.a.arora@oracle.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clear_page_nt() which is essentially an unrolled MOVNTI loop. The
unrolling keeps the inner loop similar to memset_movnti() which can be
exercised via perf bench mem memset.

The caller needs to execute an SFENCE when done.

MOVNTI, from the Intel SDM, Volume 2B, 4-101:
 "The non-temporal hint is implemented by using a write combining (WC)
  memory type protocol when writing the data to memory. Using this
  protocol, the processor does not write the data into the cache hierarchy,
  nor does it fetch the corresponding cache line from memory into the
  cache hierarchy."

The AMD Arch Manual has something similar to say as well.

This can potentially improve page-clearing bandwidth (see below for
performance numbers for two microarchitectures where it helps and one
where it doesn't) and can help indirectly by consuming less cache
resources.

Any performance benefits are expected for extents larger than LLC-sized
or more -- when we are DRAM-BW constrained rather than cache-BW
constrained.

 # Intel Broadwellx
 # Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
 # (X86_FEATURE_ERMS) and x86-64-movnt:

 System:           Oracle X6-2
 CPU:              2 nodes * 10 cores/node * 2 threads/core
                  Intel Xeon E5-2630 v4 (Broadwellx, 6:79:1)
 Memory:           256G evenly split between nodes
 Microcode:        0xb00002e
 scaling_governor: performance
 L3 size:           25MB
 intel_pstate/no_turbo: 1

              x86-64-stosb (5 runs)     x86-64-movnt (5 runs)       speedup
              -----------------------   -----------------------     -------
     size            BW   (   pstdev)          BW   (   pstdev)

     16MB      17.35 GB/s ( +- 9.27%)    11.83 GB/s ( +- 0.19%)     -31.81%
    128MB       5.31 GB/s ( +- 0.13%)    11.72 GB/s ( +- 0.44%)    +121.84%
   1024MB       5.42 GB/s ( +- 0.13%)    11.78 GB/s ( +- 0.03%)    +117.34%
   4096MB       5.41 GB/s ( +- 0.41%)    11.76 GB/s ( +- 0.07%)    +117.37%

Comparing perf stats for size=4096MB:

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-stosb
 # Running 'mem/memset' benchmark:
 # function 'x86-64-stosb' (movsb-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...

       5.405362 GB/sec
       5.444229 GB/sec
       5.397943 GB/sec
       5.401012 GB/sec
       5.439320 GB/sec

  Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-stosb' (5 runs):

     2,064,476,092      cpu-cycles                #    1.087 GHz                      ( +-  0.17% )  (22.19%)
         8,578,591      instructions              #    0.00  insn per cycle           ( +- 12.01% )  (27.79%)
       132,481,645      cache-references          #   69.730 M/sec                    ( +-  0.20% )  (27.83%)
           157,710      cache-misses              #    0.119 % of all cache refs      ( +-  5.80% )  (27.84%)
         2,879,628      branch-instructions       #    1.516 M/sec                    ( +-  0.21% )  (27.86%)
            80,581      branch-misses             #    2.80% of all branches          ( +- 13.15% )  (27.84%)
        94,401,869      bus-cycles                #   49.687 M/sec                    ( +-  0.25% )  (22.21%)
       133,947,283      L1-dcache-load-misses     # 139717.91% of all L1-dcache accesses  ( +-  0.26% )  (22.21%)
            95,870      L1-dcache-loads           #    0.050 M/sec                    ( +-  9.95% )  (22.21%)
             1,700      LLC-loads                 #    0.895 K/sec                    ( +-  6.50% )  (22.21%)
             1,410      LLC-load-misses           #   82.95% of all LL-cache accesses  ( +- 19.42% )  (22.21%)
       132,526,771      LLC-stores                #   69.754 M/sec                    ( +-  0.65% )  (11.10%)
           101,145      LLC-store-misses          #    0.053 M/sec                    ( +- 11.19% )  (11.10%)

           1.90238 +- 0.00358 seconds time elapsed  ( +-  0.19% )

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt
 # Running 'mem/memset' benchmark:
 # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...

      11.774264 GB/sec
      11.758826 GB/sec
      11.774368 GB/sec
      11.758239 GB/sec
      11.760348 GB/sec

  Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt' (5 runs):

     1,619,807,936      cpu-cycles                #    0.971 GHz                      ( +-  0.24% )  (22.14%)
     1,481,306,856      instructions              #    0.91  insn per cycle           ( +-  0.33% )  (27.75%)
           163,086      cache-references          #    0.098 M/sec                    ( +- 11.68% )  (27.79%)
            39,913      cache-misses              #   24.474 % of all cache refs      ( +- 26.45% )  (27.84%)
       135,741,931      branch-instructions       #   81.353 M/sec                    ( +-  0.33% )  (27.89%)
            82,647      branch-misses             #    0.06% of all branches          ( +-  6.29% )  (27.90%)
        73,575,446      bus-cycles                #   44.095 M/sec                    ( +-  0.28% )  (22.28%)
            27,834      L1-dcache-load-misses     #   68.42% of all L1-dcache accesses  ( +- 65.93% )  (22.28%)
            40,683      L1-dcache-loads           #    0.024 M/sec                    ( +- 42.62% )  (22.27%)
             2,598      LLC-loads                 #    0.002 M/sec                    ( +- 22.66% )  (22.25%)
             1,523      LLC-load-misses           #   58.60% of all LL-cache accesses  ( +- 39.64% )  (22.22%)
                 2      LLC-stores                #    0.001 K/sec                    ( +-100.00% )  (11.08%)
                 0      LLC-store-misses          #    0.000 K/sec                    (11.07%)

           1.67003 +- 0.00169 seconds time elapsed  ( +-  0.10% )

The L1-dcache-load-miss (L1D.REPLACEMENT) counts are significantly down,
which does confirm that unlike "REP; STOSB", MOVNTI does not result in a
write-allocate.

 # AMD Rome
 # Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosq
 # (X86_FEATURE_REP_GOOD) and x86-64-movnt:

 System:           Oracle E2-2c
 CPU:              2 nodes * 64 cores/node * 2 threads/core
                   AMD EPYC 7742 (Rome, 23:49:0)
 Memory:           2048 GB evenly split between nodes
 Microcode:        0x8301038
 scaling_governor: performance
 L3 size:          16 * 16MB
 cpufreq/boost:    0

              x86-64-stosq (5 runs)     x86-64-movnt (5 runs)      speedup
              -----------------------   -----------------------    -------
     size       BW        (   pstdev)          BW   (   pstdev)

     16MB      15.39 GB/s ( +- 9.14%)    14.56 GB/s ( +-19.43%)     -5.39%
    128MB      11.04 GB/s ( +- 4.87%)    14.49 GB/s ( +-13.22%)    +31.25%
   1024MB      11.86 GB/s ( +- 0.83%)    16.54 GB/s ( +- 0.04%)    +39.46%
   4096MB      11.89 GB/s ( +- 0.61%)    16.49 GB/s ( +- 0.28%)    +38.68%

Comparing perf stats for size=4096MB:

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-stosq
 # Running 'mem/memset' benchmark:
 # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...

      11.785122 GB/sec
      11.970851 GB/sec
      11.916821 GB/sec
      11.861517 GB/sec
      11.941867 GB/sec

  Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-stosq' (5 runs):

     1,014,645,096      cpu-cycles                #    1.264 GHz                      ( +-  0.18% )  (45.28%)
         4,620,983      instructions              #    0.00  insn per cycle           ( +-  1.86% )  (45.37%)
       262,988,622      cache-references          #  327.723 M/sec                    ( +-  0.21% )  (45.51%)
         6,312,740      cache-misses              #    2.400 % of all cache refs      ( +-  1.12% )  (45.56%)
         1,792,517      branch-instructions       #    2.234 M/sec                    ( +-  0.20% )  (45.60%)
            54,095      branch-misses             #    3.02% of all branches          ( +-  2.99% )  (45.64%)
       133,710,131      L1-dcache-load-misses     #  363.51% of all L1-dcache accesses  ( +-  0.12% )  (45.55%)
        36,783,396      L1-dcache-loads           #   45.838 M/sec                    ( +-  0.79% )  (45.46%)
        53,411,709      L1-dcache-prefetches      #   66.559 M/sec                    ( +-  0.28% )  (45.39%)

           0.80303 +- 0.00117 seconds time elapsed  ( +-  0.15% )

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt
 # Running 'mem/memset' benchmark:
 # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...

      16.533230 GB/sec
      16.496138 GB/sec
      16.480302 GB/sec
      16.478333 GB/sec
      16.474600 GB/sec

  Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt' (5 runs):

     1,091,352,779      cpu-cycles                #    1.292 GHz                      ( +-  0.32% )  (45.25%)
     1,483,248,390      instructions              #    1.36  insn per cycle           ( +-  0.14% )  (45.38%)
       134,114,985      cache-references          #  158.723 M/sec                    ( +-  0.17% )  (45.51%)
           117,682      cache-misses              #    0.088 % of all cache refs      ( +-  0.99% )  (45.59%)
       135,009,275      branch-instructions       #  159.781 M/sec                    ( +-  0.18% )  (45.68%)
            50,659      branch-misses             #    0.04% of all branches          ( +-  7.50% )  (45.66%)
            58,569      L1-dcache-load-misses     #    5.84% of all L1-dcache accesses  ( +-  6.04% )  (45.57%)
         1,002,657      L1-dcache-loads           #    1.187 M/sec                    ( +- 15.40% )  (45.45%)
             3,111      L1-dcache-prefetches      #    0.004 M/sec                    ( +- 31.21% )  (45.38%)

           0.84554 +- 0.00289 seconds time elapsed  ( +-  0.34% )

Similar to Intel Broadwellx, the L1-dcache-load-misses (L2$ access from
DC Miss) counts are significantly lower. The L1 prefetcher is also
fairly quiet.

 # Intel Skylakex
 # Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
 # (X86_FEATURE_ERMS) and x86-64-movnt:

 System:           Oracle X8-2
 CPU:              2 nodes * 26 cores/node * 2 threads/core
                  Intel Xeon Platinum 8270CL (Skylakex, 6:85:7)
 Memory:           3TB evenly split between nodes
 Microcode:        0x5002f01
 scaling_governor: performance
 L3 size:          36MB
 intel_pstate/no_turbo: 1

              x86-64-stosb (5 runs)     x86-64-movnt (5 runs)      speedup
              -----------------------   -----------------------    -------
     size            BW   (   pstdev)          BW   (   pstdev)

     16MB      20.38 GB/s ( +- 2.58%)     6.25 GB/s ( +- 0.41%)   -69.28%
    128MB       6.52 GB/s ( +- 0.14%)     6.31 GB/s ( +- 0.47%)    -3.22%
   1024MB       6.48 GB/s ( +- 0.31%)     6.24 GB/s ( +- 0.00%)    -3.70%
   4096MB       6.51 GB/s ( +- 0.01%)     6.27 GB/s ( +- 0.42%)    -3.68%

Comparing perf stats for size=4096MB:

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-stosb
 # Running 'mem/memset' benchmark:
 # function 'x86-64-stosb' (movsb-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...
       6.516972 GB/sec
       6.518756 GB/sec
       6.517620 GB/sec
       6.517598 GB/sec
       6.518799 GB/sec

 Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-stosb' (5 runs):

     3,357,373,317      cpu-cycles                #    1.133 GHz                      ( +-  0.01% )  (29.38%)
       165,063,710      instructions              #    0.05  insn per cycle           ( +-  1.54% )  (35.29%)
           358,997      cache-references          #    0.121 M/sec                    ( +-  0.89% )  (35.32%)
           205,420      cache-misses              #   57.221 % of all cache refs      ( +-  3.61% )  (35.36%)
         6,117,673      branch-instructions       #    2.065 M/sec                    ( +-  1.48% )  (35.38%)
            58,309      branch-misses             #    0.95% of all branches          ( +-  1.30% )  (35.39%)
        31,329,466      bus-cycles                #   10.575 M/sec                    ( +-  0.03% )  (23.56%)
        68,543,766      L1-dcache-load-misses     #  157.03% of all L1-dcache accesses  ( +-  0.02% )  (23.53%)
        43,648,909      L1-dcache-loads           #   14.734 M/sec                    ( +-  0.50% )  (23.50%)
           137,498      LLC-loads                 #    0.046 M/sec                    ( +-  0.21% )  (23.49%)
            12,308      LLC-load-misses           #    8.95% of all LL-cache accesses  ( +-  2.52% )  (23.49%)
            26,335      LLC-stores                #    0.009 M/sec                    ( +-  5.65% )  (11.75%)
            25,008      LLC-store-misses          #    0.008 M/sec                    ( +-  3.42% )  (11.75%)

          2.962842 +- 0.000162 seconds time elapsed  ( +-  0.01% )

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt
 # Running 'mem/memset' benchmark:
 # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...
       6.283420 GB/sec
       6.222843 GB/sec
       6.282976 GB/sec
       6.282828 GB/sec
       6.283173 GB/sec

 Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt' (5 runs):

     4,462,272,094      cpu-cycles                #    1.322 GHz                      ( +-  0.30% )  (29.38%)
     1,633,675,881      instructions              #    0.37  insn per cycle           ( +-  0.21% )  (35.28%)
           283,627      cache-references          #    0.084 M/sec                    ( +-  0.58% )  (35.31%)
            28,824      cache-misses              #   10.163 % of all cache refs      ( +- 20.67% )  (35.34%)
       139,719,697      branch-instructions       #   41.407 M/sec                    ( +-  0.16% )  (35.35%)
            58,062      branch-misses             #    0.04% of all branches          ( +-  1.49% )  (35.36%)
        41,760,350      bus-cycles                #   12.376 M/sec                    ( +-  0.05% )  (23.55%)
           303,300      L1-dcache-load-misses     #    0.69% of all L1-dcache accesses  ( +-  2.08% )  (23.53%)
        43,769,498      L1-dcache-loads           #   12.972 M/sec                    ( +-  0.54% )  (23.52%)
            99,570      LLC-loads                 #    0.030 M/sec                    ( +-  1.06% )  (23.52%)
             1,966      LLC-load-misses           #    1.97% of all LL-cache accesses  ( +-  6.17% )  (23.52%)
               129      LLC-stores                #    0.038 K/sec                    ( +- 27.85% )  (11.75%)
                 7      LLC-store-misses          #    0.002 K/sec                    ( +- 47.82% )  (11.75%)

           3.37465 +- 0.00474 seconds time elapsed  ( +-  0.14% )

The L1-dcache-load-misses (L1D.REPLACEMENT) count is much lower just
like the previous two cases. No performance improvement for Skylakex
though.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_64.h |  1 +
 arch/x86/lib/clear_page_64.S   | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..bde3c2785ec4 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -43,6 +43,7 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
+void clear_page_nt(void *page);
 
 static inline void clear_page(void *page)
 {
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index c4c7dd115953..f16bb753b236 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -50,3 +50,29 @@ SYM_FUNC_START(clear_page_erms)
 	ret
 SYM_FUNC_END(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
+
+/*
+ * Zero a page.
+ * %rdi - page
+ *
+ * Caller needs to issue a fence at the end.
+ */
+SYM_FUNC_START(clear_page_nt)
+	xorl	%eax,%eax
+	movl	$4096,%ecx
+
+	.p2align 4
+.Lstart:
+        movnti  %rax, 0x00(%rdi)
+        movnti  %rax, 0x08(%rdi)
+        movnti  %rax, 0x10(%rdi)
+        movnti  %rax, 0x18(%rdi)
+        movnti  %rax, 0x20(%rdi)
+        movnti  %rax, 0x28(%rdi)
+        movnti  %rax, 0x30(%rdi)
+        movnti  %rax, 0x38(%rdi)
+        addq    $0x40, %rdi
+        subl    $0x40, %ecx
+        ja      .Lstart
+	ret
+SYM_FUNC_END(clear_page_nt)
-- 
2.9.3

