Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C644E19D081
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbgDCGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 02:53:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:36967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgDCGxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:53:23 -0400
IronPort-SDR: pkfLmWpzZubv+DHa8fiJAyu7bJwuIO/XCyMy5rPySuD4tcYd27exZU7XlcCsZITG71e2Vc3aag
 yzROJfHYaVbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 23:53:22 -0700
IronPort-SDR: SYWvhQZyVHVpX4T8X0mwVSyHpqrQLoipgtu+F7FP2HWJYz+ETML7SiQEeGyQnC63G4SX1xnMaq
 d+R0X+4p/0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200"; 
   d="scan'208";a="451200393"
Received: from unknown (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2020 23:53:20 -0700
Subject: Re: [LKP] Re: de8f5e4f2d ("lockdep: Introduce wait-type checks"): [
 17.344674] EIP: default_idle
To:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        LKP <lkp@lists.01.org>
References: <20200402081732.GM8179@shao2-debian>
 <87h7y2ns2j.fsf@nanos.tec.linutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <75dd6e6b-745d-23be-6d3d-1984b1f7f47d@intel.com>
Date:   Fri, 3 Apr 2020 14:52:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87h7y2ns2j.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 5:40 PM, Thomas Gleixner wrote:
> kernel test robot <lkp@intel.com> writes:
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> commit de8f5e4f2dc1f032b46afda0a78cab5456974f89
>> Author:     Peter Zijlstra <peterz@infradead.org>
>> AuthorDate: Sat Mar 21 12:26:01 2020 +0100
>> Commit:     Peter Zijlstra <peterz@infradead.org>
>> CommitDate: Sat Mar 21 16:00:24 2020 +0100
>>
>>      lockdep: Introduce wait-type checks
> Can you please avoid enabling
>
>> CONFIG_PROVE_RAW_LOCK_NESTING=y
> for now?
>
> As the changelog states, there are known issues and that's why the
> config is default=n.

Hi Thomas,

Thanks for the advice, we have disabled CONFIG_PROVE_RAW_LOCK_NESTING.

Best Regards,
Rong Chen
