Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A894B28DB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgJNIcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:32:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgJNIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:32:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8UFhm024666;
        Wed, 14 Oct 2020 08:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=5ydYQ8dUv8oDnJfhefOP0BYEmkkh15qRgIuEKlO1PAw=;
 b=yVNe2hDRabx4RAaaeUm/8qY9djxmpKGaHDadxGZSwTLRQyuDeELzW5JRFJsWuD9BQgRl
 F+Cqi86cVHP1hyBVywRqWN5wIBT9mo50vNKB7Ku/NzsbFP9exFMzYarBaW++jjIuB0Xg
 ZjZClpVngPPleKFNoN1Maa9B9l2iLoT2K/cze8al3ys+wADE6kGL6SRNxqGz7I+RHqWM
 amF4f4v3hy7OC6AWtZugZ8xzrbMtTKzOzgkE470kdOzR3qBxwFEJksDGJ21Wh7kUkHGU
 02mYR+8NmG97H+hzBtFzfgM/Y69yC9kAE3fyK6w+L/CrM0MHR9Huw100F37f1DdfeEKo mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 343vaecfmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:32:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8TguL125847;
        Wed, 14 Oct 2020 08:32:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 343php84ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:32:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09E8WfCe028920;
        Wed, 14 Oct 2020 08:32:41 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:32:40 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 0/8] Use uncached writes while clearing gigantic pages
Date:   Wed, 14 Oct 2020 01:32:51 -0700
Message-Id: <20201014083300.19077-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds clear_page_nt(), a non-temporal MOV (MOVNTI) based
clear_page().

The immediate use case is to speedup creation of large (~2TB) guests
VMs. Memory for these guests is allocated via huge/gigantic pages which
are faulted in early.

The intent behind using non-temporal writes is to minimize allocation of
unnecessary cachelines. This helps in minimizing cache pollution, and
potentially also speeds up zeroing of large extents.

That said there are, uncached writes are not always great, as can be seen
in these 'perf bench mem memset' numbers comparing clear_page_erms() and
clear_page_nt():

Intel Broadwellx:
              x86-64-stosb (5 runs)     x86-64-movnt (5 runs)       speedup
              -----------------------   -----------------------     -------
     size            BW   (   pstdev)          BW   (   pstdev)
     16MB      17.35 GB/s ( +- 9.27%)    11.83 GB/s ( +- 0.19%)     -31.81%
    128MB       5.31 GB/s ( +- 0.13%)    11.72 GB/s ( +- 0.44%)    +121.84%

AMD Rome:
              x86-64-stosq (5 runs)     x86-64-movnt (5 runs)      speedup
              -----------------------   -----------------------     -------
     size            BW   (   pstdev)          BW   (   pstdev)
     16MB      15.39 GB/s ( +- 9.14%)    14.56 GB/s ( +-19.43%)     -5.39%
    128MB      11.04 GB/s ( +- 4.87%)    14.49 GB/s ( +-13.22%)    +31.25%

Intel Skylakex:
              x86-64-stosb (5 runs)     x86-64-movnt (5 runs)      speedup
              -----------------------   -----------------------    -------
     size            BW   (   pstdev)          BW   (   pstdev)
     16MB      20.38 GB/s ( +- 2.58%)     6.25 GB/s ( +- 0.41%)   -69.28%
    128MB       6.52 GB/s ( +- 0.14%)     6.31 GB/s ( +- 0.47%)    -3.22%

(All of the machines in these tests had a minimum of 25MB L3 cache per
socket.)

There are two performance issues:
 - uncached writes typically perform better only for region sizes
   sizes around or larger than ~LLC-size.
 - MOVNTI does not always perform well on all microarchitectures.

We handle the first issue by only using clear_page_nt() for GB pages.

That leaves out page zeroing for 2MB pages, which is a size that's large
enough that uncached writes might have meaningful cache benefits but at
the same time is small enough that uncached writes would end up being
slower.

We can handle a subset of the 2MB case -- mmaps with MAP_POPULATE -- by
means of a uncached-or-cached hint decided based on a threshold size. This
would apply to maps backed by any page-size.
This case is not handled in this series -- I wanted to sanity check the
high level approach before attempting that.

Handle the second issue by adding a synthetic cpu-feature,
X86_FEATURE_NT_GOOD which is only enabled for architectures where MOVNTI
performs well.
(Relatedly, I thought I had independently decided to use ALTERNATIVES
to deal with this, but more likely I had just internalized it from this 
discussion:
https://lore.kernel.org/linux-mm/20200316101856.GH11482@dhcp22.suse.cz/#t)

Accordingly this series enables X86_FEATURE_NT_GOOD for Intel Broadwellx
and AMD Rome. (In my testing, the performance was also good for some
pre-production models but this series leaves them out.)

Please review.

Thanks
Ankur

Ankur Arora (8):
  x86/cpuid: add X86_FEATURE_NT_GOOD
  x86/asm: add memset_movnti()
  perf bench: add memset_movnti()
  x86/asm: add clear_page_nt()
  x86/clear_page: add clear_page_uncached()
  mm, clear_huge_page: use clear_page_uncached() for gigantic pages
  x86/cpu/intel: enable X86_FEATURE_NT_GOOD on Intel Broadwellx
  x86/cpu/amd: enable X86_FEATURE_NT_GOOD on AMD Zen

 arch/x86/include/asm/cpufeatures.h           |  1 +
 arch/x86/include/asm/page.h                  |  6 +++
 arch/x86/include/asm/page_32.h               |  9 ++++
 arch/x86/include/asm/page_64.h               | 15 ++++++
 arch/x86/kernel/cpu/amd.c                    |  3 ++
 arch/x86/kernel/cpu/intel.c                  |  2 +
 arch/x86/lib/clear_page_64.S                 | 26 +++++++++++
 arch/x86/lib/memset_64.S                     | 68 ++++++++++++++++------------
 include/asm-generic/page.h                   |  3 ++
 include/linux/highmem.h                      | 10 ++++
 mm/memory.c                                  |  3 +-
 tools/arch/x86/lib/memset_64.S               | 68 ++++++++++++++++------------
 tools/perf/bench/mem-memset-x86-64-asm-def.h |  6 ++-
 13 files changed, 158 insertions(+), 62 deletions(-)

-- 
2.9.3

