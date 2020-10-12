Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872A528B147
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgJLJRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:17:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:22215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgJLJRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:17:39 -0400
IronPort-SDR: a1bEGxFMLHZgGtPA4K/tGVYQnE8Vvn/lleeEGfJtxJvR2gst8IapsQAYEbRCHwAeW7UoPws7o/
 rdHhn6Q9uFaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="162245844"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="162245844"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:17:38 -0700
IronPort-SDR: q1CsRV+tsmPS5LvW9aSOh9xTX1XeVVMPrWpSgz3qvtemLO3s9+BXcvJRdcO7HQlyVxNMuKyFRw
 qjSQaOpcIoGw==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="529886002"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:17:36 -0700
Subject: Re: [tip:x86/pti] BUILD SUCCESS WITH WARNING
 767d46ab566dd489733666efe48732d523c8c332
To:     Philip Li <philip.li@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
References: <5f62b7f2.Q9ixRaxJwQpWTURd%lkp@intel.com>
 <20200917061220.GB31960@zn.tnic> <20200917073620.GA4946@intel.com>
 <20200917080044.GD31960@zn.tnic> <20200917133722.GA21986@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <c06bc69c-e3f6-2902-5df7-15cf2c9ea9d7@intel.com>
Date:   Mon, 12 Oct 2020 17:16:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200917133722.GA21986@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 9/17/20 9:37 PM, Philip Li wrote:
> On Thu, Sep 17, 2020 at 10:00:44AM +0200, Borislav Petkov wrote:
>> On Thu, Sep 17, 2020 at 03:36:20PM +0800, Philip Li wrote:
>>> The 2nd type is this one, which is a summarized report of head
>>> to provide an overview. Most of time, repo owner can receive the
>>> bisected mail. For this time, the issue is reported against peterz-queue
>>> repo which has this 767d46ab56 head firstly. Since the head later appears
>>> in tip, we just gather all issues and send the summary to tip related
>>> recipients. But no more bisected mail.
>> Yeah, but that second report is not very helpful because nowhere it says
>> it is a summary and nowhere it has that link you pasted above so that
>> some other maintainer can go look.
>>
>> Always put yourself in the recipient's shoes and ask yourself: "what can
>> the recipient do with this report and does it have everything in there
>> required to be able to reproduce the issue?"
>>
>> If not, then it needs changing.
> thanks for the advice. We will provide update in 1-2 weeks for the progress
> to make the report more informative and useful.

We have added the reported links in the report, you can find it in the 
latest tip report:

[tip:master] BUILD REGRESSION 820e6f502f021417140bc8ee11f9c7be148ea844

tree/branch:https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git   master
branch HEAD: 820e6f502f021417140bc8ee11f9c7be148ea844  Merge branch 'efi/core'

Error/Warning reports:

https://lore.kernel.org/lkml/202010112007.JDl1BSci-lkp@intel.com

Error/Warning in current branch:

tools/include/linux/types.h:30:18: error: typedef redefinition with different types ('uint64_t' (aka 'unsigned long') vs '__u64' (aka 'unsigned long long'))
tools/include/linux/types.h:31:17: error: typedef redefinition with different types ('int64_t' (aka 'long') vs '__s64' (aka 'long long'))

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-a016-20201011
     |-- tools-include-linux-types.h:error:typedef-redefinition-with-different-types-(-int64_t-(aka-long-)-vs-__s64-(aka-long-long-))
     `-- tools-include-linux-types.h:error:typedef-redefinition-with-different-types-(-uint64_t-(aka-unsigned-long-)-vs-__u64-(aka-unsigned-long-long-))

Best Regards,
Rong Chen

>
>>> We will consider how to show useful produce info in summary report as
>>> the feedback here, which is quite useful, such like pointing to the
>>> bisected mail. This would take some time, and we will add to our TODO
>>> as high priority.
>> Yes, that would be much appreciated. You can also tag your reports with
>> a unique hash which is then in an URL so that one can go and download the
>> .config and what else is needed. For example...
>>
>> Thx.
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette

