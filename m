Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA92CA595
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgLAO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:28:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729282AbgLAO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:28:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1E7kQn082413;
        Tue, 1 Dec 2020 09:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=kLvSKLNA6e03F2kdSXRnZvayoAHvFAN2lZQbmygpHEQ=;
 b=iJyA173nJgfS1aAWfPjSoMjOOFR+ZvHMldApKDGaTiGGtLNAs94HpaTRkjxJf7NuyXsU
 y/Ux1Qw21I/aKUa9dUGS9pKJLz1NxbkzUXAgROQJUce1KbkjAnTwc+Nmk9tFgk1EpChM
 pllxNhTYzt3stQ5cyavkoq/bWvgNoQQM2RYXubG4D4gSyTDHhlksvd4/fcFW/W1KyDGS
 Dc4MDhOVHjq0hqxDqoF6zS7yHCkHYy35EF/68s1U9vBCgnXnKesa2fhQNce/TxZdI6MC
 fnuvbFqYASwCXqDkW/ae94PgLufxibmjSEpDpSLea3tr7Zs+oh0w8IM6NYCmxT3yqCns Sw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jab24sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 09:28:07 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1ENJ5q016964;
        Tue, 1 Dec 2020 14:28:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 353e689p0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:28:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1ES3XF6685260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 14:28:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F148252050;
        Tue,  1 Dec 2020 14:28:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E00E95204E;
        Tue,  1 Dec 2020 14:28:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 880D7E0161; Tue,  1 Dec 2020 15:28:02 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] split up lockdep and syscall related functionality in generic entry code
Date:   Tue,  1 Dec 2020 15:27:50 +0100
Message-Id: <20201201142755.31931-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_05:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=848 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is v2 of the patch. I've split it up the to multiple ones,
and added documentation. The first patch was basically a hack to demonstrate
what i need, sorry for not sending a more cleaned up version.

As additional explanation here's the content of the v1 cover letter:

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
	syscall_exit_to_user_mode_work(regs);
}


