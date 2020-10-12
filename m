Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BD28BF26
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404107AbgJLRoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:44:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56230 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403994AbgJLRoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:44:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CHXmIV090586;
        Mon, 12 Oct 2020 17:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HxRv3Dnw2IAVYw6cW4Yey20sM14OKFhTKaxaAYHS+eU=;
 b=IwIM2O39+FMP9Gq07P/h7h6dDkk0m71A6MfqoFem1PNDJbUyX/8+goNFyRqRDFmOzhe2
 n8lkKks/FpuzbzJewOmwJOB/3YjVWmwm+Y7pPtNO8EWfcbr3SRZQhNh2RYFO8mXCfiN2
 gAXt7kVAVdhkItIqaos6n0PGQ2DQsf4aL4QVl9i/s2feo062VKuP5Pb1wNlAq77jV2cy
 4oqnf8Ea407RDsm7SgL3Y4Gv3ztFLhKzBv8uxV3a6ycrX50+FchYFe5Xq5S69g37WDxj
 1MyHyGgwz1WsrGCFvgEruxlaaGotu18JCckIp6x7ISdpJVk+vl6jGhG1CG2x2nCDb/WG gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 343vae4q62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 17:42:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CHV9jA022013;
        Mon, 12 Oct 2020 17:40:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 343puwvasd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 17:40:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09CHegFt031643;
        Mon, 12 Oct 2020 17:40:43 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Oct 2020 10:40:42 -0700
Subject: Re: [LKP] Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput
 -33.4% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200622005551.GK5535@shao2-debian>
 <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
 <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
 <d945497d-0edb-f540-33e1-8b1ba1e20f62@linux.intel.com>
 <691152ef-6787-9598-4445-fd2a0164f70f@oracle.com>
 <1f6d321e-96b4-18c3-2991-d6a2e94c9e60@oracle.com>
 <68992a81-a1b9-467b-59c4-48ab65c601c5@linux.intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7540556c-1e07-51b2-d903-829a887ef5b6@oracle.com>
Date:   Mon, 12 Oct 2020 10:40:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <68992a81-a1b9-467b-59c4-48ab65c601c5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/20 10:29 PM, Xing Zhengjun wrote:
> Hi Mike,
> 
>    I re-test it in v5.9-rc8, the regression still existed. It is almost the same as 34ae204f1851. Do you have time to look at it? Thanks.
> 

Thank you for testing.

Just curious, did you apply the series in this thread or just test v5.9-rc8?
If just testing v5.9-rc8, no changes to this code were added after 34ae204f1851,
so results being the same are expected.

There are some functional issues with this new hugetlb locking model that
are currently being worked.  It is likely to result in significantly different
code.  The performance issues discovered here will be taken into account with
the new code.  However, as previously mentioned additional synchronization
is required for functional correctness.  As a result, there will be some
regression in this code.

-- 
Mike Kravetz

> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/size/test/cpufreq_governor/ucode:
> 
> lkp-knm01/vm-scalability/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/8T/anon-cow-seq-hugetlb/performance/0x11
> 
> commit:
>   49aef7175cc6eb703a9280a7b830e675fe8f2704
>   c0d0381ade79885c04a04c303284b040616b116e
>   v5.8
>   34ae204f18519f0920bd50a644abd6fefc8dbfcf
>   v5.9-rc1
>   v5.9-rc8
> 
> 49aef7175cc6eb70 c0d0381ade79885c04a04c30328                        v5.8 34ae204f18519f0920bd50a644a                    v5.9-rc1   v5.9-rc8
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change %stddev     %change         %stddev     %change         %stddev %change         %stddev
>              \          |                \          |                \         |                \          |                \          |          \
>      38043 ±  3%     -30.2%      26560 ±  4%     -29.5%      26815 ± 6%      -7.4%      35209 ±  2%      -7.4%      35244            -8.8%   34704        vm-scalability.median
>       7.86 ± 19%      +9.7       17.54 ± 21%     +10.4       18.23 ± 34%      -3.1        4.75 ±  7%      -4.5        3.36 ±  7%      -4.0     3.82 ± 15%  vm-scalability.median_stddev%
>   12822071 ±  3%     -34.1%    8450822 ±  4%     -33.6%    8517252 ± 6%     -10.7%   11453675 ±  2%     -10.2%   11513595 ±  2%     -11.6% 11331657        vm-scalability.throughput
>  2.523e+09 ±  3%     -20.7%  2.001e+09 ±  5%     -19.9%  2.021e+09 ± 7%      +6.8%  2.694e+09 ±  2%      +7.3%  2.707e+09 ±  2%      +5.4% 2.661e+09        vm-scalability.workload
> 
> 
> On 8/22/2020 7:36 AM, Mike Kravetz wrote:
>> On 8/21/20 2:02 PM, Mike Kravetz wrote:
>>> Would you be willing to test this series on top of 34ae204f1851?  I will need
>>> to rebase the series to take the changes made by 34ae204f1851 into account.
>>
>> Actually, the series in this thread will apply/run cleanly on top of
>> 34ae204f1851.  No need to rebase or port.  If we decide to move forward more
>> work is required.  See a few FIXME's in the patches.
>>
