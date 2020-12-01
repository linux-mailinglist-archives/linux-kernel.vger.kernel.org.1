Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24D92CA5F5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbgLAOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:41:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53006 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387462AbgLAOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:41:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1EXdJK095532;
        Tue, 1 Dec 2020 09:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=uGCqCp10+oaj15yPZPEOOY2cYafooLAxWSolNIH6rz0=;
 b=Kx0HDkmbDJBzFFJnGWaLnA7iTJv6FmYaHaWMIRUUcqwE0TJzu5OJ+14lr6/MFK7ERvpn
 I8Abx0kk0g+PZHydS5WuH4C2uvC8mcJpA/s3KCDiVbx0QVrX1yDH6ZJqsMk8Cmv0gQJn
 rJEtjjh4SofO+1HfxvAzmF5iTqP1eAiShJNGDhGY/F15MFJYyyrEE+HL21U7h2v6ANGC
 uQ9eilDlL+m8hFdwNRxJlZysik9EodXvmjIUJDCczLgnhr/2iDg20uOd509DPGc6Qc1i
 zLgCTWzIoOly7YYoxelIgE0gCAeUeL3gnmzPfY34jvpBJ98kad0nkJiNGH7ObmkEwvwy qw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355ghqxe4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 09:41:14 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1Ebr2b026714;
        Tue, 1 Dec 2020 14:41:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpda04p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:41:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1EfA7F65077508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 14:41:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20EABA405E;
        Tue,  1 Dec 2020 14:41:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B3A8A404D;
        Tue,  1 Dec 2020 14:41:10 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 14:41:09 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] entry: rename exit_from_user_mode()
References: <20201201142755.31931-1-svens@linux.ibm.com>
        <20201201142755.31931-3-svens@linux.ibm.com>
Date:   Tue, 01 Dec 2020 15:41:09 +0100
In-Reply-To: <20201201142755.31931-3-svens@linux.ibm.com> (Sven Schnelle's
        message of "Tue, 1 Dec 2020 15:27:52 +0100")
Message-ID: <yt9dft4pwpve.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_07:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> In order to make this function publicly available rename
> it so it can still be inlined. An additional exit_from_user_mode()
> function will be added with a later commit.

That should of course be exit_to_user_mode() in the commit
description...

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/entry/common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 683a8e1b5388..076ee1cde67f 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -111,7 +111,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
>  }
>  
>  /**
> - * exit_to_user_mode - Fixup state when exiting to user mode
> + * __exit_to_user_mode - Fixup state when exiting to user mode
>   *
>   * Syscall/interupt exit enables interrupts, but the kernel state is
>   * interrupts disabled when this is invoked. Also tell RCU about it.
> @@ -122,7 +122,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
>   *    mitigations, etc.
>   * 4) Tell lockdep that interrupts are enabled
>   */
> -static __always_inline void exit_to_user_mode(void)
> +static __always_inline void __exit_to_user_mode(void)
>  {
>  	instrumentation_begin();
>  	trace_hardirqs_on_prepare();
> @@ -265,7 +265,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
>  	local_irq_disable_exit_to_user();
>  	exit_to_user_mode_prepare(regs);
>  	instrumentation_end();
> -	exit_to_user_mode();
> +	__exit_to_user_mode();
>  }
>  
>  noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
> @@ -278,7 +278,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
>  	instrumentation_begin();
>  	exit_to_user_mode_prepare(regs);
>  	instrumentation_end();
> -	exit_to_user_mode();
> +	__exit_to_user_mode();
>  }
>  
>  noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
