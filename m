Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB22C99A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgLAIgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:36:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbgLAIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:36:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B182pox055406;
        Tue, 1 Dec 2020 03:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=VyPdlnJoO0c9Ribr/dt1Rk75ubOoNxfX/Qj0qOLpu1o=;
 b=o0d7iJjZ+fRxkxSN63IHpBN5NpB2yexK9j7YYsFlVIPrpDCI4XTVo4ON8OtWteH0eJI9
 PZJxxOepv4pjri43sUxxMVLvkAWqAprT38hwEp8ZpIU4zeCX3fl4e5e4qbnw6QkpezA6
 zC3wic2oYkDk7BEXW5US1wht/nD4/A3s0/LobOZ3b1x5MNS9qR6VnUv5njQmTXWkoXdc
 qO3C8vz3AkuLctTCUO2qntRqw7mPO/wZWIztSmRiAoB5GDmNjyvzRJ7EucRNgB2CYOc+
 fWaQwJQgdCRU7kQQFB4pZoEgoDZEcLrcnkCDHSqXQmQ3Csmos7qMAAtLrU3Vit2wHYGU 4w== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355gtbavdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 03:36:04 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B18ZFcl006358;
        Tue, 1 Dec 2020 08:36:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 353e689gs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 08:36:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B18Zwjo41288030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 08:35:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 740AE4C044;
        Tue,  1 Dec 2020 08:35:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 631174C040;
        Tue,  1 Dec 2020 08:35:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 08:35:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id F3B09E24F9; Tue,  1 Dec 2020 09:35:57 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, hca@linux.ibm.com
Subject: split up lockdep and syscall related functionailty in generic entry code
Date:   Tue,  1 Dec 2020 09:35:52 +0100
Message-Id: <20201201083553.50996-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_01:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=353
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i'm currently working on converting s390 to use the generic entry
functionality. So far things are straigt-forward, there's only one
slight problem. There is a syscall_enter_from_user_mode() which sets
lockdep state and other initial stuff + does the entry work at the same
time. This is a problem on s390 because the way we restart syscalls isn't
as easy as on x86.

My understanding on x86 is that syscalls are restarted there by just rewinding
the program counter and return to user space, so the instruction causing
the syscall gets executed again.

On s390 this doesn't work, because the syscall number might be hard coded
into the 'svc' instruction, so when the syscall number has to be changed we
would repeat the wrong (old) syscall.

So we would need functions that only do the stuff that is required when switching
from user space to kernel and back, and functions which do the system call tracing
and work which might be called repeatedly.

With the attached patch, the s390 code now looks like this:

(i removed some s390 specific stuff here to make the function easier
to read)

__do_syscall is the function which gets called by low level entry.S code:

void noinstr __do_syscall(struct pt_regs *regs)
{
	enter_from_user_mode(regs);	/* sets lockdep state, and other initial stuff */

	/*
	 * functions that need to run with irqs disabled,
	 * but lockdep state and other stuff set up
	 */
	memcpy(&regs->gprs[8], S390_lowcore.save_area_sync, 8 * sizeof(unsigned long));
	memcpy(&regs->int_code, &S390_lowcore.svc_ilc, sizeof(regs->int_code));
	regs->psw = S390_lowcore.svc_old_psw;

	update_timer_sys();

	local_irq_enable();

	regs->orig_gpr2 = regs->gprs[2];

	do {
		regs->flags = _PIF_SYSCALL;
		do_syscall(regs);
	} while (test_pt_regs_flag(regs, PIF_SYSCALL_RESTART));

	exit_to_user_mode();
}

__do_syscall calls do_syscall which does all the syscall work, and this might
be called more than once if PIF_SYSCALL_RESTART is set:

void do_syscall(struct pt_regs *regs)
{
	unsigned long nr = regs->int_code & 0xffff;

	nr = syscall_enter_from_user_mode_work(regs, nr);
	regs->gprs[2] = -ENOSYS;
	if (likely(nr < NR_syscalls)) {
		regs->gprs[2] = current->thread.sys_call_table[nr](
				regs->orig_gpr2, regs->gprs[3],
				regs->gprs[4], regs->gprs[5],
				regs->gprs[6], regs->gprs[7]);
	}
	syscall_exit_to_user_mode1(regs);
}

What do you think about the attach patch? I'm also open for a proper name
for syscall_exit_to_user_mode1() ;-)


