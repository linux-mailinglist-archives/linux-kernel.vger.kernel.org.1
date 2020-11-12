Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1012B0AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgKLRJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:09:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgKLRJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:09:43 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACH3chf128614;
        Thu, 12 Nov 2020 12:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=6Xe2ZA+A+QG08tFZ8cZQnIaJG0VIfWSK/S1ydOEKqq4=;
 b=qD0iTdaOSN863L5JiNc8jumhXM6XyBx3M8Wnu0QfnPP2ZOyRmHRhPGnJa05u++q4J0Kr
 qRSnyXPihR7qPfZshy0BPe8ffJqFUi3rKIw3ei7Fzf/U8zMslRZ3Z48Rih+OSy/kMcai
 6QsGnN2JoHQhuqa5QygjzVNBwFCs2LmKeobKWARoTwiPlSa/Xdigw41ouY0SGuSB9Y5D
 9Y4/JcWkIDsGxPSJ/Uu8NIlLB5GMgm8cDFJA0gMY9HfOGqkJzYRAImB2ZOx+9/Ej4xz3
 rmAcSyoLa2gpHn/kbgVz5zw1PpHLRzL1Grmo7QrbbDbmDY+SFEWCqnndPO3VK6Q0ilOz ww== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34s7m3kw69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 12:09:00 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACGrKcM026795;
        Thu, 12 Nov 2020 17:08:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 34nk78b0wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 17:08:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACH8uOV61604130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 17:08:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02B27AE055;
        Thu, 12 Nov 2020 17:08:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48DAEAE045;
        Thu, 12 Nov 2020 17:08:55 +0000 (GMT)
Received: from localhost (unknown [9.85.93.203])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 17:08:55 +0000 (GMT)
Date:   Thu, 12 Nov 2020 22:38:53 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 1/3 v5] ftrace: Have the callbacks receive a struct
 ftrace_regs instead of pt_regs
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201112011516.589846126@goodmis.org>
        <20201112011815.466562067@goodmis.org>
In-Reply-To: <20201112011815.466562067@goodmis.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1605200348.x55f7x9h4h.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_07:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=779 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>=20
> In preparation to have arguments of a function passed to callbacks attach=
ed
> to functions as default, change the default callback prototype to receive=
 a
> struct ftrace_regs as the forth parameter instead of a pt_regs.
>=20
> For callbacks that set the FL_SAVE_REGS flag in their ftrace_ops flags, t=
hey
> will now need to get the pt_regs via a ftrace_get_regs() helper call. If
> this is called by a callback that their ftrace_ops did not have a
> FL_SAVE_REGS flag set, it that helper function will return NULL.
>=20
> This will allow the ftrace_regs to hold enough just to get the parameters
> and stack pointer, but without the worry that callbacks may have a pt_reg=
s
> that is not completely filled.
>=20
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/x86/kernel/kprobes/ftrace.c  |  3 ++-
>  fs/pstore/ftrace.c                |  2 +-
>  include/linux/ftrace.h            | 16 ++++++++++++++--
>  include/linux/kprobes.h           |  2 +-
>  kernel/livepatch/patch.c          |  3 ++-
>  kernel/trace/ftrace.c             | 27 +++++++++++++++------------
>  kernel/trace/trace_event_perf.c   |  2 +-
>  kernel/trace/trace_events.c       |  2 +-
>  kernel/trace/trace_functions.c    |  9 ++++-----
>  kernel/trace/trace_irqsoff.c      |  2 +-
>  kernel/trace/trace_sched_wakeup.c |  2 +-
>  kernel/trace/trace_selftest.c     | 20 +++++++++++---------
>  kernel/trace/trace_stack.c        |  2 +-
>  13 files changed, 55 insertions(+), 37 deletions(-)
>=20

<snip>

> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 629abaf25681..be73350955e4 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -345,7 +345,7 @@ static inline void wait_for_kprobe_optimizer(void)=20
> { }
>  #endif /* CONFIG_OPTPROBES */
>  #ifdef CONFIG_KPROBES_ON_FTRACE
>  extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent=
_ip,
> -				  struct ftrace_ops *ops, struct pt_regs *regs);
> +				  struct ftrace_ops *ops, struct ftrace_regs *fregs);

This breaks the build on non-x86 architectures that support=20
KPROBES_ON_FTRACE.

- Naveen
