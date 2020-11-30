Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB12C8E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgK3Tcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:32:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgK3Tcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:32:52 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUJVw6t161547;
        Mon, 30 Nov 2020 14:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/+cFMQeSfYg4ZvEvs3fk4BNFd+iDHP8uRlJGhoKYdKQ=;
 b=f8p4Wy+HctXSLgbmusLjKY04Oz+Rxu+lzL4o6XuS4GW4apbkCcS2qSI4BWg8R7OpfNah
 XcQWym8Ek9n4cYvYEXhxnk/ZXkOdG5Jn8YX16mzGqnU7GXrDgZE/kBBMDC6Brw1U61J5
 B1ihQ0+GIP/5ERWAf2hqliNji/+jZXgOsEsLCrTokpo5udBtcCsJCZouRxRG3QHQ+Brp
 i1FI2H07oX/UGBcBsxFbJfMcoc8vC9rf+6Pt1MTMDn20Qaj7Ly+PiJqav534l1xWQ7oj
 08GSuh/9VU5QhTuVf7vcrXNfFBvvROvpL56ZbluHkoVk/1Wwu79OD38sgB6NMo4i3rOB jw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3552dca4jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 14:32:01 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AUJM4T9008399;
        Mon, 30 Nov 2020 19:31:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 353e682brd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 19:31:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AUJVXu847841718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 19:31:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 527184C044;
        Mon, 30 Nov 2020 19:31:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F295B4C04A;
        Mon, 30 Nov 2020 19:31:32 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.84.77])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Nov 2020 19:31:32 +0000 (GMT)
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com> <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
Date:   Mon, 30 Nov 2020 20:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_08:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=838
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.20 19:04, Linus Torvalds wrote:
> On Mon, Nov 30, 2020 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> But but but...
>>>
>>>   do_idle()                   # IRQs on
>>>     local_irq_disable();      # IRQs off
>>>     defaul_idle_call()        # IRQs off
>>         lockdep_hardirqs_on();  # IRQs off, but lockdep things they're on
>>>       arch_cpu_idle()         # IRQs off
>>>         enabled_wait()        # IRQs off
>>>         raw_local_save()      # still off
>>>         psw_idle()            # very much off
>>>           ext_int_handler     # get an interrupt ?!?!
>>               rcu_irq_enter()   # lockdep thinks IRQs are on <- FAIL
>>
>> I can't much read s390 assembler, but ext_int_handler() has a
>> TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
>> with the actual state, but there's some condition before it, what's that
>> test and is that right?
> 
> I think that "psw_idle()" enables interrupts, exactly like x86 does.

Yes, by definition.  Otherwise it would be an software error state.
The interesting part is the lpswe instruction at the end (load PSW) 
which loads the full PSW, which contains interrupt enablement, wait bit,
condition code, paging enablement, machine check enablement the address
and others. The idle psw is enabled for interrupts and has the wait bit
set. If the wait bit is set and interrupts are off this is called "disabled
wait" and is used for panic, shutdown etc. 

> See my previous email.
> 
> But no, I can't read s390 asm either. IBM is notorious for making up
> odd IBM-only incomprehensible names. When "oi" means "or immediate", I
> personally start suspecting that there were some "happy drugs"
> involved
> 
> To make matters worse, some of the assembly code in psw_idle isn't
> even assembly code, it's machine code, with "BPON" being an
> alternative instruction definition with just the hex encoding for the
> machine code instruction rather than any actual human-legible
> instruction encoding.
> 
> Of course, when the "human-legible" instructions are "oi", I guess hex
> codes aren't all that much less legible..
> 
> s390 programmers must be some super-human breed. Or, alternatively,
> they are munching happy pills by the truck-load to get over the pain
> ;)


For something that was defined in 1964 it is certainly not too bad.
And for the oddities, you simply get used to it.

In the end the scheme is actually relatively straightforward. 
The first character defines what it is:
o: or
a: add
n: and
l: load	
i: insert (kind of a load to parts, e.g. only one byte)
st: store
b: branch
j: jump
and some more but those should cover 80% of what you need.
and the following characters then tell if 32 or 64 bit (g), 
immediate (i) value or memory, type of register (float, general purpose).
so lg for a 64 bit load, l for a 32bit load. 
ld for a load into a floating point register (double)
