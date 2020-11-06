Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C61B2A8EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKFFMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:12:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:17048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKFFMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:12:48 -0500
IronPort-SDR: 5RuQghmxkUbCQufSltVoHT3YV2o9VfN9rPwUeKrrPwlc7nmeOFjZDjwbGzhqJYmPzA5GTfAwIK
 fRfIgazoislQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="165993855"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="165993855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 21:12:48 -0800
IronPort-SDR: uL2Gu9JVs2uTujiqJ7nu/ZBkr1Z8DNpVd64OioM2dclx+WwE13Ud6tMbkyg6qViMUYqVZONLvt
 nK6JY8UY4EPA==
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="471933236"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 21:12:45 -0800
Subject: Re: [LKP] Re: [mm/gup] a308c71bf1: stress-ng.vm-splice.ops_per_sec
 -95.6% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, zhengjun.xing@intel.com
References: <20201102091428.GK31092@shao2-debian>
 <CAHk-=wiRnRsS4CqLypK533G2Ho=NVTt_s-e9KXZ=b0ptOSB15A@mail.gmail.com>
 <dd22f78e-764b-4896-e2d0-5f4e4cf178af@linux.intel.com>
 <CAHk-=wjMgTdpsXeuBfRBz23mTSD67V_BB_aV2bCzDHF2-k0WBg@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <be48a131-882a-1cfe-99b7-6cb497eab20c@linux.intel.com>
Date:   Fri, 6 Nov 2020 13:12:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjMgTdpsXeuBfRBz23mTSD67V_BB_aV2bCzDHF2-k0WBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2020 2:37 AM, Linus Torvalds wrote:
> On Thu, Nov 5, 2020 at 12:29 AM Xing Zhengjun
> <zhengjun.xing@linux.intel.com> wrote:
>>
>>> Rong - mind testing this? I don't think the zero-page _should_ be
>>> something that real loads care about, but hey, maybe people do want to
>>> do things like splice zeroes very efficiently..
>>
>> I test the patch, the regression still existed.
> 
> Thanks.
> 
> So Jann's suspicion seems interesting but apparently not the reason
> for this particular case.
> 
> For being such a _huge_ difference (20x improvement followed by a 20x
> regression), it's surprising how little the numbers give a clue. The
> big changes are things like
> "interrupts.CPU19.CAL:Function_call_interrupts", but while those
> change by hundreds of percent, most of the changes seem to just be
> about them moving to different CPU's. IOW, we have things like
> 
>        5652 ± 59%    +387.9%      27579 ± 96%
> interrupts.CPU13.CAL:Function_call_interrupts
>       28249 ± 32%     -69.3%       8675 ± 50%
> interrupts.CPU28.CAL:Function_call_interrupts
> 
> which isn't really much of a change at all despite the changes looking
> very big - it's just the stats jumping from one CPU to another.
> 
> Maybe there's some actual change in there, but it's very well hidden if so.
> 
> Yes, some of the numbers get worse:
> 
>      868396 ±  3%     +20.9%    1050234 ± 14%
> interrupts.RES:Rescheduling_interrupts
> 
> so that's a 20% increase in rescheduling interrupts,  But it's a 20%
> increase, not a 500% one. So the fact that performance changes by 20x
> is still very unclear to me.
> 
> We do have a lot of those numa-meminfo changes, but they could just
> come from allocation patterns.
> 
> That said - another difference between the fast-cup code and the
> regular gup code is that the fast-gup code does
> 
>                  if (pte_protnone(pte))
>                          goto pte_unmap;
> 
> and the regular slow case does
> 
>          if ((flags & FOLL_NUMA) && pte_protnone(pte))
>                  goto no_page;
> 
> now, FOLL_NUMA is always set in the slow case if we don't have
> FOLL_FORCE set, so this difference isn't "real", but it's one of those
> cases where the zero-page might be marked for NUMA faulting, and doing
> the forced COW might then cause it to be accessible.
> 
> Just out of curiosity, do the numbers change enormously if you just remove that
> 
>                  if (pte_protnone(pte))
>                          goto pte_unmap;
> 
> test from the fast-cup case (top of the loop in gup_pte_range()) -
> effectively making fast-gup basically act like FOLL_FORCE wrt numa
> placement..

Based on the last debug patch, I removed the two lines code at the top 
of the loop in gup_pte_range() as you mentioned, the regression still 
existed.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/testtime/class/cpufreq_governor/ucode:
 
lkp-csl-2sp5/stress-ng/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/100%/1HDD/30s/pipe/performance/0x5002f01

commit:
   1a0cf26323c80e2f1c58fc04f15686de61bfab0c
   a308c71bf1e6e19cc2e4ced31853ee0fc7cb439a
   da5ba9980aa2211c1e2a89fc814abab2fea6f69d (last debug patch)
   8803d304738b52f66f6b683be38c4f8b9cf4bff5 (to debug the odd 
performance numbers)

1a0cf26323c80e2f a308c71bf1e6e19cc2e4ced3185 da5ba9980aa2211c1e2a89fc814 
8803d304738b52f66f6b683be38
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
          |                \
  3.406e+09           -95.6%   1.49e+08           -96.4%  1.213e+08 
       -96.5%  1.201e+08        stress-ng.vm-splice.ops
  1.135e+08           -95.6%    4965911           -96.4%    4041777 
       -96.5%    4002572        stress-ng.vm-splice.ops_per_sec


> 
> I'm not convinced that's a valid change in general, so this is just a
> "to debug the odd performance numbers" issue.
> 
> Also out of curiosity: is the performance profile limited to just the
> load, or is it a system profile (ie do you have "-a" on the perf
> record line or not).
> 

In our test , "-a" is enabled on the perf record line.

>                 Linus
> 

-- 
Zhengjun Xing
