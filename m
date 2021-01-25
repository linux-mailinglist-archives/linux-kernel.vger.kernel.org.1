Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7508302D79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbhAYVVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:21:06 -0500
Received: from simcoe207srvr.owm.bell.net ([184.150.200.207]:60413 "EHLO
        torfep02.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732590AbhAYVSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:18:34 -0500
Received: from bell.net torfep02 184.150.200.158 by torfep02.bell.net
          with ESMTP
          id <20210125211750.MJQD17235.torfep02.bell.net@torspm01.bell.net>;
          Mon, 25 Jan 2021 16:17:50 -0500
Received: from [192.168.2.49] (really [70.50.109.22]) by torspm01.bell.net
          with ESMTP
          id <20210125211750.SKIW29322.torspm01.bell.net@[192.168.2.49]>;
          Mon, 25 Jan 2021 16:17:50 -0500
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
To:     Helge Deller <deller@gmx.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
 <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
 <20210125204720.GA28462@ls3530.fritz.box>
 <4bdf35de-f804-4e9d-cde9-cc6785840a60@gmx.de>
 <627d4b69-79cf-371b-9aa7-d87f26e4f088@bell.net>
 <3564bcea-5781-123f-564e-53289967e9e4@gmx.de>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <428d571c-1f68-7a59-3232-9bb362b51a5b@bell.net>
Date:   Mon, 25 Jan 2021 16:17:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3564bcea-5781-123f-564e-53289967e9e4@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-Analysis: v=2.4 cv=e5fD9Yl/ c=1 sm=1 tr=0 ts=600f357e a=S6gQgrXzeH76ECG4GouVuA==:117 a=S6gQgrXzeH76ECG4GouVuA==:17 a=IkcTkHD0fZMA:10 a=EmqxpYm9HcoA:10 a=FBHGMhGWAAAA:8 a=zXK1geL4ILfIpM-3CFcA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4xfBJ+nOCswV9EIfbwbiJwU5NBjGo/X2rv0RR/muTRuEIiZnsH6/jK6wVAle4uMiT4wA1rHgj7zf/T9AwKXN21RmMW1ahuBtc8P2x3hgeLmZXx0z3Mhy0v ejjWRaXIQmbByIoAotE2QJdySpf+29XRNFHrshUmlYI//TxJjf89DVslQq16U97M35lX5zXnYP3UWTG6LAqaJ9Z562Vsd/mfX0LJYQ9cP3YtN4GD3+/yQWC0 bHONEGIwelrfwJZXw0+yDQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-25 4:13 p.m., Helge Deller wrote:
> On 1/25/21 10:08 PM, John David Anglin wrote:
>> I would suggest the following for this hunk:
>>
>> +    ldil    L%intr_restore, %r2
>> +    BL    preempt_schedule_irq
>> +    ldo     R%intr_restore(%r2), %r2
>>
>>     ldil    L%intr_restore, %r1
>>     b,l    preempt_schedule_irq,%r2
>>     ldo     R%intr_restore(%r1), %r2
>>
>> On PA 2.0 hardware that gives a 22-bit call.
> "BL" is already using "b,l", see #define in arch/parisc/include/asm/assembly.h
>
> The 22-bit weren't sufficient, that's why I changed it too.
Okay but "b,l" only provides a 22-bit branch with %r2 as link register.  You also need to use %r1 in the ldil and ldo instructions.

Dave

-- 
John David Anglin  dave.anglin@bell.net

