Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E69F28C6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 03:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgJMB7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 21:59:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:10723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgJMB7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:59:15 -0400
IronPort-SDR: 4G1W6WE3qItNGE/IxMjrG/QfiDTUFUYJmv541J+kd0vYEPAe1okK41/HaZexCqLWikgMWRXj+G
 J6fIV3Q4llUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="183300758"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="183300758"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:59:14 -0700
IronPort-SDR: k5qJWCDafxOsmny4KINhBVye9sXkMA4nlpSsL10KeG4562wqGdyozBqEjpdhUOVgSCoPGwQEeQ
 Lm5st2HI7A+w==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="530195278"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:59:10 -0700
Subject: Re: [LKP] Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput
 -33.4% regression
To:     Mike Kravetz <mike.kravetz@oracle.com>,
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
 <7540556c-1e07-51b2-d903-829a887ef5b6@oracle.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <4c95b307-90b5-798f-34c1-000ea5331ebb@linux.intel.com>
Date:   Tue, 13 Oct 2020 09:59:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <7540556c-1e07-51b2-d903-829a887ef5b6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2020 1:40 AM, Mike Kravetz wrote:
> On 10/11/20 10:29 PM, Xing Zhengjun wrote:
>> Hi Mike,
>>
>>     I re-test it in v5.9-rc8, the regression still existed. It is almost the same as 34ae204f1851. Do you have time to look at it? Thanks.
>>
> 
> Thank you for testing.
> 
> Just curious, did you apply the series in this thread or just test v5.9-rc8?
> If just testing v5.9-rc8, no changes to this code were added after 34ae204f1851,
> so results being the same are expected.
> 

I just test v5.9-rc8. Where can I find the series patches you mentioned 
here? Or just wait for the next mainline release?


> There are some functional issues with this new hugetlb locking model that
> are currently being worked.  It is likely to result in significantly different
> code.  The performance issues discovered here will be taken into account with
> the new code.  However, as previously mentioned additional synchronization
> is required for functional correctness.  As a result, there will be some
> regression in this code.
> 

-- 
Zhengjun Xing
