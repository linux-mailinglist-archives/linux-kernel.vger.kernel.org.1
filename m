Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1750287B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgJHSI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:08:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:48099 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbgJHSIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:08:55 -0400
IronPort-SDR: 1Z22Zurtp3NRFSs5zyEmiQW2hfV0d16EzvhdK9x7SK2RskYl2zQEgKJPS4N+s9Z8WF9OILDGE+
 LMe1Sw9wwQOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="161920551"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="161920551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 11:08:55 -0700
IronPort-SDR: xbCRTsvaiMr5rQyo9afK5ie/+xVIveyihJxPUReSGOnEVE9oM/Wp7VnVigXxB3epR9OOiRp80e
 rIBlyvGY+ttg==
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="328648505"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.20.171]) ([10.209.20.171])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 11:08:54 -0700
Subject: Re: How should we handle illegal task FPU state?
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
 <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com>
 <20201001205857.GH7474@linux.intel.com>
 <f1835c1f-31bc-16a9-ffa5-896b1aeb895a@intel.com>
 <CALCETrWswWdgXO2J6nRjXW_4JRsK1TzzVZ62EDsF+d_79O+6Sw@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <8e23f875-3c3c-957d-84db-530d2ece432e@intel.com>
Date:   Thu, 8 Oct 2020 11:08:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWswWdgXO2J6nRjXW_4JRsK1TzzVZ62EDsF+d_79O+6Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/2020 3:04 PM, Andy Lutomirski wrote:
> On Thu, Oct 1, 2020 at 2:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 10/1/20 1:58 PM, Sean Christopherson wrote:
>>> One thought for a lowish effort approach to pave the way for CET would be to
>>> try XRSTORS multiple times in switch_fpu_return().  If the first try fails,
>>> then WARN, init non-supervisor state and try a second time, and if _that_ fails
>>> then kill the task.  I.e. do the minimum effort to play nice with bad FPU
>>> state, but don't let anything "accidentally" turn off CET.
>>
>> I'm not sure we should ever keep running userspace after an XRSTOR*
>> failure.  For MPX, this might have provided a nice, additional vector
>> for an attacker to turn off MPX.  Same for pkeys if we didn't correctly
>> differentiate between the hardware init state versus the "software init"
>> state that we keep in init_task.
>>
>> What's the advantage of letting userspace keep running after we init its
>> state?  That it _might_ be able to recover?
> 
> I suppose we can kill userspace and change that behavior only if
> someone complains.  I still think it would be polite to try to dump
> core, but that could be tricky with the current code structure.  I'll
> try to whip up a patch.  Maybe I'll add a debugfs file to trash MXCSR
> for testing.
> 

One complication of letting XRSTORS fail is exit_to_user_mode_prepare() 
will need to go back to exit_to_user_mode_loop() again (or repeat some 
parts of it).

Currently, when exit_to_user_mode_loop() exits, xstates should have been 
validated earlier and to be restored shortly.  At this stage, XRSTORS 
should not fault.  If we need to kill the task, we should have done that 
earlier.

There are only two sources of invalid xstates: PTRACE and sigreturn. 
For user-mode data, both sources have been taken care of. 
Supervisor-mode data can be checked/reviewed easily.  There are only CET 
and PASID supervisor states.

Yu-cheng
