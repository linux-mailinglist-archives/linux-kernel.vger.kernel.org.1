Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8D301881
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 22:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAWVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 16:20:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13456 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbhAWVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 16:20:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10NL16Yr051574;
        Sat, 23 Jan 2021 16:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=V/uZh7grFtRpvKoy4oKbOWx5irOBO5xdSuC7+n4228Q=;
 b=d/xw0qkSfvjT/edXqoxnZ2oEz+G+yyR89qFgZnbOZSJjRZl5akbP30xfUR1XonrZOsOZ
 WZCV39j60Rp8W/k6Djn5GmsQkE3FQKJ3CKtaXLeAwheacQP7JzQeX4cTV20ShJjUZMRd
 C1/Tqv2aodhLy0ITk4/WJPFYKN3qDegGNOAqms6AM24hUWjkEMEdvckXPoYnZhgA3MHS
 qsMKj/5tHZnr5OorOEuRB3kLggQl2lGgEMmmFpzPfUqzeJdn16YvnIeQNKhBDkfmIMQv
 a8xAQrDMxTpY49OiwrRg9C7+igLeOkbMjrg3WqJpX/pLscTg/RQZhqY/iXPZ7iPwS+95 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 368seva0t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 16:18:42 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10NL17Nd051686;
        Sat, 23 Jan 2021 16:18:42 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 368seva0sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 16:18:41 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10NLH7FP029153;
        Sat, 23 Jan 2021 21:18:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 368b2h0h40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 21:18:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10NLIVJo36176194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jan 2021 21:18:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A3C9A4051;
        Sat, 23 Jan 2021 21:18:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3F42A404D;
        Sat, 23 Jan 2021 21:18:37 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 23 Jan 2021 21:18:37 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
References: <20210114170412.4819-1-john.ogness@linutronix.de>
        <yt9dk0s48y70.fsf@linux.ibm.com>
        <87v9bomtd0.fsf@jogness.linutronix.de>
Date:   Sat, 23 Jan 2021 22:18:37 +0100
In-Reply-To: <87v9bomtd0.fsf@jogness.linutronix.de> (John Ogness's message of
        "Sat, 23 Jan 2021 00:48:19 +0106")
Message-ID: <yt9deeibe4ia.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-23_12:2021-01-22,2021-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101230119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness <john.ogness@linutronix.de> writes:

> On 2021-01-22, Sven Schnelle <svens@linux.ibm.com> wrote:
>>
>> So somehow the pointer for console_drivers changes.
>>
>> I can't provide the normal kernel crash output as printk is no longer
>> working,
>
> I don't understand what you mean here. The crash tool can dump the
> printk buffer.
>
> I would be curious to see what the messages look like. It would also be
> helpful to know the last message you saw on the console.
>

The last message is:

[ 1845.640466] User process fault: interruption code 0007 ilc:2 in libm.so[7d78c000+a3000]
[ 1845.640474] CPU: 9 PID: 859915 Comm: ld.so.1 Not tainted 5.11.0-20210122.rc4.git0.9f29bd8b2e71.300.fc33.s390x+git #1
[ 1845.640476] Hardware name: IBM 8561 T01 703 (LPAR)
[ 1845.640478] User PSW : 0705300080000000 000000007d7983b2
[ 1845.640480]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:3 PM:0 RI:0 EA:1
[ 1845.640483] User GPRS: 0000000000000000 000000007d798360 0000000000000010 000003ff00000004
[ 1845.640485]            000000007f854dd0 000000007d7e9788 000003ff00401b30 000000007f854ff8
[ 1845.640487]            000003ff00000000 000003ff7d5b4da0 000003ff00000000 000003ff00000010
[ 1845.640489]            000003ff004022c6 000003ff004024b0 0000000080401796 000000007f854de8

That's also what's written to the console. Please note the the output
above is expected. It's only reporting that a user space program
performed an invalid FPU operation. The kernel crash is neither written
to the console nor the dmesg buffer.

>> kmsg_dump_rewind+290 is:
>>
>>               if (!(con->flags & CON_ENABLED))
>>                         continue;
>>
>> in kernel/printk/printk.c:1845
>>
>> I haven't dived into whether our show_code() is doing something wrong
>> which was covered in the past or whether that's because of the patch
>> above but wanted to make you aware of that in case you have an idea.
>> Otherwise i have to dig into the code.
>
> Unless we are dealing with very long printk messages that normally get
> truncated (800+ characters) this patch simply adds a string
> terminator. I do not see how that could possibly cause this kind of
> damage.
>
> When this triggers, there is nothing happening with consoles registering
> or deregistering, right?

That's correct. No registering/unregistering taking place.

> The string terminator (kernel/printk/printk.c:1402) is only added for
> paranoia. If you comment that out, this patch will have no effect (for
> "normal" length lines). I would be curious if that somehow makes a
> difference for you.

I was able to reproduce it in a virtual machine where i have a few more
ways to debug. What i got was:

01:  -> 00000000001B8814"  MVI     92001000 >> 000000000163F1CD     CC 2

That's a watchpoint telling me that the code at 0x1b8814 wants to store
one byte to 0x163f1cd, which is the second byte of console_drivers.

gdb tells me about 0x1b8814:

(gdb) list *(0x1b8814)
0x1b8814 is in record_print_text (/home/svens/ibmgit/linux/kernel/printk/printk.c:1402).
1397		 * If a buffer was provided, it will be terminated. Space for the
1398		 * string terminator is guaranteed to be available. The terminator is
1399		 * not counted in the return value.
1400		 */
1401		if (buf_size > 0)
1402			text[len] = 0;
1403	
1404		return len;
1405	}
1406

In s390 assembly, this is the store:

   0x00000000001b8810 <+0x130>:	la	%r1,0(%r7,%r9)
   0x00000000001b8814 <+0x134>:	mvi	0(%r1),0

The cpu registers at the time of write:

01: GRG  0 =  0000000000000020  000000000163F1CD
01: GRG  2 =  0000000000000042  000003E000623A98
01: GRG  4 =  000000000000000E  000000000087BB70
01: GRG  6 =  0000000000000400  *0000000000000224*
01: GRG  8 =  000000000000000F  *000000000163EFA9*
01: GRG 10 =  0000000000000033  0000000000000000
01: GRG 12 =  00000000809AE000  000003E000623A98
01: GRG 14 =  00000000001B884C  000003E0006239E8

So r9 is 000000000163EFA9 - seems to be the start of the current message:

0163EFA9:  *[   24.069514]            000000007d7af3c2: b30d0002..debr.%f0,%f2.debr.%f0,%f2

while r7 is the offset, and that one is way to big:

0000000000000224

If you add that to 0163EFA9, you'll see that we're outside of the buffer
and overwriting space after, which is console_drivers.

The message it's trying to print is rather long, so the 0x224 could be
the size of the whole line:

This is not from the same crash, but this is how the message looks like
it's trying to print:

[   23.960773] User Code: 000000007d7af3ba: 78005000            le      %f0,0(%r5) 
[   23.960773]            000000007d7af3be: 78205004            le      %f2,4(%r5) 
[   23.960773]           #000000007d7af3c2: b30d0002            debr    %f0,%f2 
[   23.960773]           >000000007d7af3c6: a7280000            lhi     %r2,0 
[   23.960773]            000000007d7af3ca: 07fe                bcr     15,%r14 
[   23.960773]            000000007d7af3cc: 0707                bcr     0,%r7 
[   23.960773]            000000007d7af3ce: 0707                bcr     0,%r7 
[   23.960773]            000000007d7af3d0: c050000289ec        larl    %r5,000000007d8007a8 

I'm pretty sure it's related to the way how the s390 disassembler
prints the buffer, it uses several pr_cont() calls, and it's crashing in the
last pr_cont("\n") (in arch/s390/kernel/dis.c - show_code());

I'm trying to get the content of the log buffer and other state, if
there's anything else i can provide let me know.

