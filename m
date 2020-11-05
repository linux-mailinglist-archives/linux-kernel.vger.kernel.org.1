Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E132A7944
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgKEI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:29:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:27512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgKEI3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:29:01 -0500
IronPort-SDR: Tzg6rNHMPvE8s3uQs/2RMtgl6l1pGgEl/nFoEn3Fm9x962so/lkI3JmBmu2KpaDoq5WMuwwbAe
 avjvlbyVsGnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="169490978"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="169490978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 00:28:59 -0800
IronPort-SDR: nUp/+X//aM/SYwFrMlZRSVMFyjVB+CltZDanTK50mC5M7+c7kJSW+CJpNolPwd/GVCX9TvTc6J
 c0NRomAH2n7g==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="539293116"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 00:28:57 -0800
Subject: Re: [LKP] Re: [mm/gup] a308c71bf1: stress-ng.vm-splice.ops_per_sec
 -95.6% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Jann Horn <jannh@google.com>
Cc:     Peter Xu <peterx@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>,
        zhengjun.xing@intel.com
References: <20201102091428.GK31092@shao2-debian>
 <CAHk-=wiRnRsS4CqLypK533G2Ho=NVTt_s-e9KXZ=b0ptOSB15A@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <dd22f78e-764b-4896-e2d0-5f4e4cf178af@linux.intel.com>
Date:   Thu, 5 Nov 2020 16:28:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiRnRsS4CqLypK533G2Ho=NVTt_s-e9KXZ=b0ptOSB15A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2020 2:29 AM, Linus Torvalds wrote:
> On Mon, Nov 2, 2020 at 1:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
>>
>> Greeting,
>>
>> FYI, we noticed a -95.6% regression of stress-ng.vm-splice.ops_per_sec due to commit:
>>
>> commit: a308c71bf1e6e19cc2e4ced31853ee0fc7cb439a ("mm/gup: Remove enfornced COW mechanism")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Note that this is just the reverse of the previous 2000% improvement
> reported by the test robot here:
> 
>      https://lore.kernel.org/lkml/20200611040453.GK12456@shao2-debian/
> 
> and the explanation seems to remain the same:
> 
>      https://lore.kernel.org/lkml/CAG48ez1v1b4X5LgFya6nvi33-TWwqna_dc5jGFVosqQhdn_Nkg@mail.gmail.com/
> 
> IOW, this is testing a special case (zero page lookup) that the "force
> COW" patches happened to turn into a regular case (COW creating a
> regular page from the zero page).
> 
> The question is whether we should care about the zero page for gup_fast lookup.
> 
> If we do care, then the proper fix is likely simply to allow the zero
> page in fast-gup, the same way we already do in slow-gup.
> 
> ENTIRELY UNTESTED PATCH ATTACHED.
> 
> Rong - mind testing this? I don't think the zero-page _should_ be
> something that real loads care about, but hey, maybe people do want to
> do things like splice zeroes very efficiently..

I test the patch, the regression still existed.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/testtime/class/cpufreq_governor/ucode:
 
lkp-csl-2sp5/stress-ng/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/100%/1HDD/30s/pipe/performance/0x5002f01

commit:
   1a0cf26323c80e2f1c58fc04f15686de61bfab0c
   a308c71bf1e6e19cc2e4ced31853ee0fc7cb439a
   da5ba9980aa2211c1e2a89fc814abab2fea6f69d (debug patch)

1a0cf26323c80e2f a308c71bf1e6e19cc2e4ced3185 da5ba9980aa2211c1e2a89fc814
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
  3.406e+09           -95.6%   1.49e+08           -96.4%  1.213e+08 
    stress-ng.vm-splice.ops
  1.135e+08           -95.6%    4965911           -96.4%    4041777 
    stress-ng.vm-splice.ops_per_sec

> 
> And note the "untested" part of the patch. It _looks_ fairly obvious,
> but maybe I'm missing something.
> 
>              Linus
> 
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
