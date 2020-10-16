Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526FB2907C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409205AbgJPOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:51:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:28909 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409071AbgJPOvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:51:35 -0400
IronPort-SDR: 2daS5uibJmiAUNHDk1JuG8ZkHLZ+JXyRWr6+B2bjUQixlAQ35fNfphL+DiO5k3DyKBwawlwTQp
 YItzByGcVb3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="145931156"
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; 
   d="scan'208";a="145931156"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 07:51:34 -0700
IronPort-SDR: W2gGSueEDce8Ckr4AlvPLkcTKsRAk8PchgmOKN5iW9AbLevJM5B/X9cShyyuB1ykN4sMC3536H
 ztgaihoVXfcg==
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; 
   d="scan'208";a="464702829"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.186]) ([10.249.172.186])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 07:51:29 -0700
Subject: Re: [mm/writeback] 8d92890bd6: will-it-scale.per_process_ops -15.3%
 regression
To:     Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
References: <20201014084706.GB11647@shao2-debian>
 <20201014101904.GA11144@quack2.suse.cz>
 <87pn5kfply.fsf@notabene.neil.brown.name>
 <20201015090843.GA7037@quack2.suse.cz> <20201015091254.GB7037@quack2.suse.cz>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <08f0ec04-ab69-84ab-eadb-89f67c453b6b@intel.com>
Date:   Fri, 16 Oct 2020 22:51:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015091254.GB7037@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2020 5:12 PM, Jan Kara wrote:
> On Thu 15-10-20 11:08:43, Jan Kara wrote:
>> On Thu 15-10-20 08:46:01, NeilBrown wrote:
>>> On Wed, Oct 14 2020, Jan Kara wrote:
>>>
>>>> On Wed 14-10-20 16:47:06, kernel test robot wrote:
>>>>> Greeting,
>>>>>
>>>>> FYI, we noticed a -15.3% regression of will-it-scale.per_process_ops due
>>>>> to commit:
>>>>>
>>>>> commit: 8d92890bd6b8502d6aee4b37430ae6444ade7a8c ("mm/writeback: discard
>>>>> NR_UNSTABLE_NFS, use NR_WRITEBACK instead")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>
>>>> Thanks for report but it doesn't quite make sense to me. If we omit
>>>> reporting & NFS changes in that commit (which is code not excercised by
>>>> this benchmark), what remains are changes like:
>>>>
>>>>          nr_pages += node_page_state(pgdat, NR_FILE_DIRTY);
>>>> -       nr_pages += node_page_state(pgdat, NR_UNSTABLE_NFS);
>>>>          nr_pages += node_page_state(pgdat, NR_WRITEBACK);
>>>> ...
>>>> -               nr_reclaimable = global_node_page_state(NR_FILE_DIRTY) +
>>>> -                                       global_node_page_state(NR_UNSTABLE_NFS);
>>>> +               nr_reclaimable = global_node_page_state(NR_FILE_DIRTY);
>>>> ...
>>>> -       gdtc->dirty = global_node_page_state(NR_FILE_DIRTY) +
>>>> -                     global_node_page_state(NR_UNSTABLE_NFS);
>>>> +       gdtc->dirty = global_node_page_state(NR_FILE_DIRTY);
>>>>
>>>> So if there's any negative performance impact of these changes, they're
>>>> likely due to code alignment changes or something like that... So I don't
>>>> think there's much to do here since optimal code alignment is highly specific
>>>> to a particular CPU etc.
>>>
>>> I agree, it seems odd.
>>>
>>> Removing NR_UNSTABLE_NFS from enum node_stat_item would renumber all the
>>> following value and would, I think, change NR_DIRTIED from 32 to 31.
>>> Might that move something to a different cache line and change some
>>> contention?
>>
>> Interesting theory, it could be possible.
>>
>>> That would be easy enough to test: just re-add NR_UNSTABLE_NFS.
>>
>> Yeah, easy enough to test. Patch for this is attached. 0-day people, can
>> you check whether applying this patch changes anything in your perf
>> numbers?
> 
> Forgot the patch. Attached now.
> 
> 								Honza
> 

Hi,

We tested the patch and the regression became worse, but as you said the
problem seems odd, so we tested v5.9 and regression already disappeared.

a37b0715ddf30077 8d92890bd6b8502d6aee4b37430                        v5.9
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
     341015 ±  9%     -18.4%     278292           +32.4%     451473 
   will-it-scale.per_process_ops
   65475001 ±  9%     -18.4%   53432256           +32.4%   86682938 
   will-it-scale.workload

Best Regards,
Rong Chen

