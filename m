Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2EC2AB237
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKIIKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:10:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:62846 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKIIKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:10:51 -0500
IronPort-SDR: gxmLwP1JQiZOrd8No5teYkSKrcfEpscRAhI19esOpjcCPY2duv/pGtEBDerRYDMSmeF0AE2+Qc
 oTUjbhM+I3nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="156773775"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="156773775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:10:50 -0800
IronPort-SDR: JPGF7s/1+WRJKXVbEL29DP0pLeCBpfrt+lfR0OiQwW6ObwwjiEahRYKJrjzq8LZRfOQ9lF8lVh
 e8vRu1O0yugA==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="540740423"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:10:47 -0800
Subject: Re: [LKP] Re: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7%
 regression
To:     Matthew Wilcox <willy@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, zhengjun.xing@intel.com
References: <20201030071715.GV31092@shao2-debian>
 <20201030131711.GJ27442@casper.infradead.org>
 <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
 <20201030145835.GL27442@casper.infradead.org>
 <d57f327c-a22e-1fb0-26fe-68b4964e75dc@intel.com>
 <20201106205536.GS17076@casper.infradead.org>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <363450b6-0e99-6916-d296-bec81978a78b@linux.intel.com>
Date:   Mon, 9 Nov 2020 16:10:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106205536.GS17076@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2020 4:55 AM, Matthew Wilcox wrote:
> On Mon, Nov 02, 2020 at 01:21:39PM +0800, Rong Chen wrote:
>> we compared the tmpfs.ops_per_sec: (363 / 103.02) between this commit and
>> parent commit.
> 
> Thanks!  I see about a 50% hit on my system, and this patch restores the
> performance.  Can you verify this works for you?
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 9b065d412e5f..e602333f8c0d 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -225,7 +225,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
>   		struct address_space *mapping)
>   {
>   	XA_STATE(xas, &mapping->i_pages, linear_page_index(vma, start));
> -	pgoff_t end_index = end / PAGE_SIZE;
> +	pgoff_t end_index = linear_page_index(vma, end + PAGE_SIZE - 1);
>   	struct page *page;
>   
>   	rcu_read_lock();
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 
I test the patch, the regression is disappeared.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/testtime/class/cpufreq_governor/ucode:
 
lkp-csl-2sp3/stress-ng/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/100%/1HDD/100s/memory/performance/0x400002c

commit:
   f5df8635c5a3c912919c91be64aa198554b0f9ed
   e6e88712e43b7942df451508aafc2f083266f56b
   6bc25f0c5e0d55145f7ef087adea2693802a80f3 (this test patch)

f5df8635c5a3c912 e6e88712e43b7942df451508aaf 6bc25f0c5e0d55145f7ef087ade
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
       1198 ±  4%     -69.7%     362.67            +3.3%       1238 ± 
3%  stress-ng.tmpfs.ops
      11.62 ±  4%     -69.7%       3.52            +3.4%      12.02 ± 
3%  stress-ng.tmpfs.ops_per_sec



-- 
Zhengjun Xing
