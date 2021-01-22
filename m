Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8142FF9B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbhAVA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:59:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:2345 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbhAVA7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:59:20 -0500
IronPort-SDR: LVrGrXEFpynTWRyOkwfKhzlI+A+MUHIkN4/1ekifFNfvtlG5O40iiP3LnwIcEarvkLWJupr7ih
 m3JUBn1jfqcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="198116163"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="198116163"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:58:03 -0800
IronPort-SDR: AomqZirfBYVX2dVA+TNPs283Zma2HyLlHIIDH5aGMH8DRj3N5ZLC8croTmaYD2XAlL90zvzOOO
 5c0JzNFGWyyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="385547697"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.145])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2021 16:58:01 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     "Alejandro Colomar \(man-pages\)" <alx.manpages@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -V9 2/3] NOT kernel/man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
References: <20210120061235.148637-1-ying.huang@intel.com>
        <20210120061235.148637-3-ying.huang@intel.com>
        <99b71573-714f-5ec6-37e5-3e6e080432fc@gmail.com>
Date:   Fri, 22 Jan 2021 08:58:00 +0800
In-Reply-To: <99b71573-714f-5ec6-37e5-3e6e080432fc@gmail.com> (Alejandro
        Colomar's message of "Thu, 21 Jan 2021 21:39:40 +0100")
Message-ID: <87lfclss87.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Alejandro Colomar (man-pages)" <alx.manpages@gmail.com> writes:

> Hi Huang Ying,
>
> On 1/20/21 7:12 AM, Huang Ying wrote:
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: "Alejandro Colomar" <alx.mailinglists@gmail.com>
>
> Sorry, for the confusion.
> I have a different email for reading lists.
> I use alx.manpages@ for everything,
> and alx.mailinglists@ just for reading lists, but sometimes,
> when I answer emails not sent to me,
> I forget to change the reply address,
> and you see that address (which I intended to be readonly).
>
> Please, use alx.manpages@gmail.com,
> or your mail might get lost between many list emails ;)

Got it!

>> ---
>>  man2/set_mempolicy.2 | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> 
>> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
>> index 68011eecb..fa64a1820 100644
>> --- a/man2/set_mempolicy.2
>> +++ b/man2/set_mempolicy.2
>> @@ -113,6 +113,22 @@ A nonempty
>>  .I nodemask
>>  specifies node IDs that are relative to the set of
>>  node IDs allowed by the process's current cpuset.
>> +.TP
>> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.12)"
>> +When
>> +.I mode
>> +is
>> +.BR MPOL_BIND ,
>> +enable the kernel NUMA balancing for the task if it is supported by
>> +the kernel.
>> +If the flag isn't supported by the kernel, or is used with
>> +.I mode
>> +other than
>> +.BR MPOL_BIND ,
>> +return \-1 and
>> +.I errno
>> +is set to
>> +.BR EINVAL .
>
> The wording here is a bit weird:
> [return // is set].  It would be better as
> [return // set] or [returns // sets] or [is returned // is set].
>
> The same page, has:
>
> [
> RETURN VALUE
>        On success, set_mempolicy() returns 0; on error, -1 is  re‐
>        turned and errno is set to indicate the error.
> ]
>
> so I'd use the latter for consistency.

Sure.  Will change this.  Thanks for comments!

Best Regards,
Huang, Ying

>>  .PP
>>  .I nodemask
>>  points to a bit mask of node IDs that contains up to
>> @@ -293,6 +309,12 @@ argument specified both
>>  .B MPOL_F_STATIC_NODES
>>  and
>>  .BR MPOL_F_RELATIVE_NODES .
>> +Or, the
>> +.B MPOL_F_NUMA_BALANCING
>> +isn't supported by the kernel, or is used with
>> +.I mode
>> +other than
>> +.BR MPOL_BIND .
>>  .TP
>>  .B ENOMEM
>>  Insufficient kernel memory was available.
>> 
>
> Other than that, it's good for me.
>
> Thanks,
>
> Alex
>
> Just a reminder for myself (please ignore it):
> - Break EINVAL into multiple paragraphs.
> - (Maybe) reorder lists to be in alphabetical order.
