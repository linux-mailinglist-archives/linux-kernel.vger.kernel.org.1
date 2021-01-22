Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE4300ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbhAVVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:24:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728447AbhAVVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:23:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10ML3dWI122496;
        Fri, 22 Jan 2021 16:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=S5rl+RAwXzFz1RjASTeFHDc25EU36YcXkFw6cL1UDFU=;
 b=iQZfXinqAmZClMHbrCe+XdvDJcnMh2dSxJlgK27gxKo51KiX3lERJZFUvbeL9v3DKYRl
 Vi90yG86IBHD9jl3ChntQ1u6z2XqBx+IWzaAszH0Z1WUn2X9ruKy7zffzM+dk4AICIei
 wB7mUKtI3Tyvo5quYwAgsZRY4Cn06bGT5f6kNYo6qic/Jafu7hrdojRrnok+/B/mrCR5
 Ydj5gBBayH/SijQHEtYGm6So4ph1H10orWnb52by6cxB3WklSlrSZBgHSeo3suJ13nKh
 T+lryWHzRs+PLWd3y6FYM2svOhOEL69nBBPZBpNOX7CY9u0yrNHWbBAE0yA4lhsicq6J VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36856n22tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 16:21:45 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10ML5Zc8132007;
        Fri, 22 Jan 2021 16:21:45 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36856n22t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 16:21:44 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10MLH2BC003632;
        Fri, 22 Jan 2021 21:21:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 367k0s8y0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 21:21:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10MLLXMh23855480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 21:21:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C1FBAE053;
        Fri, 22 Jan 2021 21:21:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8CD2AE051;
        Fri, 22 Jan 2021 21:21:39 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Jan 2021 21:21:39 +0000 (GMT)
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
Date:   Fri, 22 Jan 2021 22:21:39 +0100
In-Reply-To: <20210114170412.4819-1-john.ogness@linutronix.de> (John Ogness's
        message of "Thu, 14 Jan 2021 18:10:12 +0106")
Message-ID: <yt9dk0s48y70.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_15:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 mlxscore=0 mlxlogscore=764
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness <john.ogness@linutronix.de> writes:

> Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
> msg_print_text() would only write up to size-1 bytes into the
> provided buffer. Some callers expect this behavior and append
> a terminator to returned string. In particular:
>
> arch/powerpc/xmon/xmon.c:dump_log_buf()
> arch/um/kernel/kmsg_dump.c:kmsg_dumper_stdout()
>
> msg_print_text() has been replaced by record_print_text(), which
> currently fills the full size of the buffer. This causes a
> buffer overflow for the above callers.
>
> Change record_print_text() so that it will only use size-1 bytes
> for text data. Also, for paranoia sakes, add a terminator after
> the text data.
>
> And finally, document this behavior so that it is clear that only
> size-1 bytes are used and a terminator is added.
>
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
> [..]

I'm seeing crashes on s390x with this patch while running the glibc
testsuite. The glibc test suite triggers a few FPU exceptions which
are printed to the kernel log by default. Looking at the crash dump,
i see that the console_drivers pointer seems to be overwritten while
printing that (user space) warning:

crash> print *console_drivers
$1 = {
  name = "\247\071\377\373\354!\004\214\000\331\300\345\000\033\353_", 
  write = 0xa7190001eb119078, 
  read = 0xe6e320b0050090, 
  device = 0xa51e0010a7210001, 
  unblank = 0xa7291000b9e28012, 
  setup = 0xe320f0a00004e320, 
  exit = 0x208e0094eb112000, 
  match = 0xcec1c006e017f, 
  flags = -4984, 
  index = 133, 
  cflag = 8143136, 
  data = 0x800458108004ec12, 
  next = 0x5007eaf000000
}

crash> x/16i console_drivers
   0x79009700:  lghi    %r3,-5
   0x79009704:  aghik   %r2,%r1,1164
   0x7900970a:  brasl   %r14,0x79386dc8
   0x79009710:  lghi    %r1,1
   0x79009714:  laog    %r1,%r1,120(%r9)
   0x7900971a:  llgc    %r2,5(%r11)
   0x79009720:  llilh   %r1,16
   0x79009724:  tmll    %r2,1
   0x79009728:  lghi    %r2,4096
   0x7900972c:  locgre  %r1,%r2
   0x79009730:  lg      %r2,160(%r15)
   0x79009736:  llc     %r2,142(%r2)
   0x7900973c:  srlg    %r1,%r1,0(%r2)
   0x79009742:  clij    %r1,1,12,0x7900981e
   0x79009748:  cgij    %r8,0,8,0x79009852
   0x7900974e:  la      %r2,4(%r8)

crash> sym 0x79009700
79009700 (t) iomap_finish_ioend+192
/usr/src/debug/kernel-5.10.fc33/linux-5.11.0-20210122.rc4.git0.9f29bd8b2e71.300.fc33.s390x/./include/linux/pagemap.h:
59

So somehow the pointer for console_drivers changes.

I can't provide the normal kernel crash output as printk is no longer
working, but in crash the backtrace looks like this:
crash> bt
PID: 859915  TASK: dad24000          CPU: 9   COMMAND: "ld.so.1"
 LOWCORE INFO:
  -psw      : 0x0002000180000000 0x0000000078c8400e
  -function : stop_run at 78c8400e
  -prefix   : 0x0041e000
  -cpu timer: 0x7ffff953a957e166
  -clock cmp: 0xd92876863ac66b00
  -general registers:
     0xf0f0f0f000000000 0x0000000078c8400e
     0x0000000079984830 0x0000000079984830
     0x0000000079ac62c0 0x0000000000000002
     0x0000000000000038 000000000000000000
     0x000000007a19157e 000000000000000000
     0x00000000fffffffa 000000000000000000
     0x00000000dad24000 000000000000000000
     0x0000000078c8416e 0x00000380033136f0
  -access registers:
     0x7d5b4da0 0xa2a795c0 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
  -control registers:
     0x00a0000014966a10 0x000000007a15c007
     0x000000000001d0a0 000000000000000000
     0x000000000000ffff 0x000000000001d080
     0x000000003b000000 0x00000001f29b81c7
     0x0000000000008000 000000000000000000
     000000000000000000 000000000000000000
     000000000000000000 0x000000007a15c007
     0x00000000db000000 0x000000000001d0c0
  -floating point registers:
     0x5faaaaabeb67f92f 0x0007fffffffffff8
     0x40400000eb67f000 000000000000000000
     0x0000000000000007 0x0000006400000000
     0x000002aa2a63f028 0x000000000963cf85
     0x000000002a642c60 000000000000000000
     0x7f85516ceb67f222 0x000003ffeb67f528
     0x000003ffeb67f230 0x0000000100000000
     0x000003ffeb67f21d 0x000002aa28d2d970

 #0 [38003313710] stop_run at 78c8400e
 #1 [38003313728] atomic_notifier_call_chain at 78ced536
 #2 [38003313778] panic at 7974aeca
 #3 [38003313818] die at 78c897ea
 #4 [38003313880] do_no_context at 78c9b230
 #5 [380033138b8] pgm_check_handler at 7976438c
 PSW:  0404c00180000000 0000000078d304ba (kmsg_dump_rewind+290)
 GPRS: 0000000000000020 0000000000000000 0000000000000000 00000000ffffec88 
       000000000000000e 00000000793f4800 0000000000000224 0000000000000000 
       0000000000000000 0000000000000000 0000000000000224 0005007eaf000000 
       00000000dad24000 0000000000000000 0000038003313a68 0000038003313a18 
 #0 [38003313a68] console_unlock at 78d3158e
 #1 [38003313b48] vprintk_emit at 78d32f50
 #2 [38003313ba8] vprintk_default at 78d32f9e
 #3 [38003313c00] printk at 7974bfae
 #4 [38003313c90] show_code at 78c8588e
 #5 [38003313de0] show_registers at 7974a26e
 #6 [38003313e70] show_regs at 78c8961e
 #7 [38003313ea0] pgm_check_handler at 7976438c
 PSW:  0705300080000000 000000007d7983b2 (user space)
 GPRS: 0000000000000000 000000007d798360 0000000000000010 000003ff00000004 
       000000007f854dd0 000000007d7e9788 000003ff00401b30 000000007f854ff8 
       000003ff00000000 000003ff7d5b4da0 000003ff00000000 000003ff00000010 
       000003ff004022c6 000003ff004024b0 0000000080401796 000000007f854de8

kmsg_dump_rewind+290 is:

              if (!(con->flags & CON_ENABLED))
                        continue;

in kernel/printk/printk.c:1845

I haven't dived into whether our show_code() is doing something wrong
which was covered in the past or whether that's because of the patch
above but wanted to make you aware of that in case you have an idea.
Otherwise i have to dig into the code.

Thanks
Sven
