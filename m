Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B972B84F1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKRTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:33:09 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18725 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKRTdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:33:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb576fe0007>; Wed, 18 Nov 2020 11:33:18 -0800
Received: from [10.2.62.4] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 19:32:58 +0000
Subject: Re: [mm/gup] 47e29d32af: phoronix-test-suite.npb.FT.A.total_mop_s
 -45.0% regression
To:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>
CC:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Dave Chinner" <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Jonathan Corbet" <corbet@lwn.net>, Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kbuild test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        feng tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@intel.com>,
        <guobing.chen@intel.com>, <ming.a.chen@intel.com>,
        <frank.du@intel.com>, <Shuhua.Fan@intel.com>,
        <wangyang.guo@intel.com>, <Wenhuan.Huang@intel.com>,
        <jessica.ji@intel.com>, <shan.kang@intel.com>,
        <guangli.li@intel.com>, <tiejun.li@intel.com>, <yu.ma@intel.com>,
        <dapeng1.mi@intel.com>, <jiebin.sun@intel.com>,
        <gengxin.xie@intel.com>, <fan.zhao@intel.com>
References: <20201117024825.GA8169@xsang-OptiPlex-9020>
 <24d9d093-5b7a-9aee-8d61-59c0007a9269@nvidia.com>
 <20201118134952.GE1981@quack2.suse.cz>
 <CAPcyv4g=MFAojCeCST+sF22A+2cetVMFmQuDtu7arEM+0a+Ebw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f297fa64-3833-b361-0175-d769ce4ad31d@nvidia.com>
Date:   Wed, 18 Nov 2020 11:32:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g=MFAojCeCST+sF22A+2cetVMFmQuDtu7arEM+0a+Ebw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605727998; bh=/zzto4qjui2QjTRLRNXiDcYtzpUx5bkuyHBccy5FEXc=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=oJrQCeqSFU8BNSDtz4THhkYXIqCYe7H0T5GmvybJtxVSbs2ad2JqRtEc9hgt5IU2t
         GrM6lYjdbXaj0rOM0i1Efmi8+kcAjyEORoPxo8VXw6OvfoOlIa/1uCwuiFyFwG9pQZ
         suZyFoe4RYVtjavFdS6NUY6zgEzBPMaC5XHcCRl90VFxqyWtBUA+snciB2AewyHsg/
         AqtPm9SG+08yAvieBfUXe+kgMmCtTwxbWtk2oMx7am0BFSi6ClYACYFK00afHGDjnT
         4A9jtApbrrvkVNWZlCgeK8Zb7dFTe12+62GzmWiImWMDtMAXtY2M2AuEliJ0Egv9CH
         CaFnaWpQWtf1g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 10:17 AM, Dan Williams wrote:
> On Wed, Nov 18, 2020 at 5:51 AM Jan Kara <jack@suse.cz> wrote:
>>
>> On Mon 16-11-20 19:35:31, John Hubbard wrote:
>>>
>>> On 11/16/20 6:48 PM, kernel test robot wrote:
>>>>
>>>> Greeting,
>>>>
>>>> FYI, we noticed a -45.0% regression of phoronix-test-suite.npb.FT.A.total_mop_s due to commit:
>>>>
>>>
>>> That's a huge slowdown...
>>>
>>>>
>>>> commit: 47e29d32afba11b13efb51f03154a8cf22fb4360 ("mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> ...but that commit happened in April, 2020. Surely if this were a serious
>>> issue we would have some other indication...is this worth following up
>>> on?? I'm inclined to ignore it, honestly.
>>
>> Why this was detected so late is a fair question although it doesn't quite
>> invalidate the report...
> 
> I don't know what specifically happened in this case, perhaps someone
> from the lkp team can comment? However, the myth / contention that
> "surely someone else would have noticed by now" is why the lkp project
> was launched. Kernels regressed without much complaint and it wasn't
> until much later in the process, around the time enterprise distros
> rebased to new kernels, did end users start filing performance loss
> regression reports. Given -stable kernel releases, 6-7 months is still
> faster than many end user upgrade cycles to new kernel baselines.
> 

I see, thanks for explaining. I'll take a peek, then.

thanks,
-- 
John Hubbard
NVIDIA
