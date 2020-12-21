Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1662DFB64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgLULJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgLULJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:09:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6033C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:08:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 23so22632082lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CpcodZ8L++OLa4XZKDyL2SJ3Ju3Gnu3WQYgmvkwp61k=;
        b=OLYKshbIiObgr9DOfOUDpwHDFKi0ppoZiua60CqF2+vHEKlcilasECSDHd2CuGrXk7
         tUfNWA3CXO5hGFPupZh7ygrvtJF9gxZ4XRkccBOTG5RlBhb7R3RxK9v0Hv9afSp4ra7o
         CcO3riImK6ZCXdOsLRojpPjrBOm7JOcbaePm40B2632Y8XfWSi5+hYHiEtOxbZUlnkf5
         bg+uqF0kIus8CbnTZQDRXl+NCLmwC+a0MdZ0/WlQpRHcrWAX/SVd1R7IdGKHelO75b/C
         LF14ocyml2QjoajPsyZCIhLVXJmzCT5cN0dqnqMLE30u/8b9c+cENPIfJeYGwq6rJvkI
         uy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CpcodZ8L++OLa4XZKDyL2SJ3Ju3Gnu3WQYgmvkwp61k=;
        b=j6KW03wkKSJ6xSSKoM+827YaYmspnF6cloC7Xp7qbRoULNuYjH1sGbrCAI/6IvtHWT
         a4FKmoVwHLeINaPYaHP7C5QRkEPFH/hiLEyzeFThsKjblm74N3NPMb0N2j9MO6x6Dxoo
         vx6fdQPz2Bjz3bn3n/jvEMBTMbCXr5n9bqfT/sUMN566fY3JSWbpBuMxDaj7MwXCxY5k
         VVY0XKuxv7qC5YX5C1gEQNTriBfRfwxUuFrDYiJHfYw4tVStXVdZKvqYs0FcPpqtMPwt
         MjDBy7OHt2Fthk6GeXKoHNGtZX6BWWByA9pPjA6vbMEaGbcYWdes9160wEf53ezxC/Vk
         y/0g==
X-Gm-Message-State: AOAM532nxrm3vCilohKNIEikCiAEElc5w0t9i8kk2Q3h9gd0fxrKPa5/
        20nGsr67yfUvtfF3LRgLQZEY4uPuBK3gu810cHxFl0NavrM=
X-Google-Smtp-Source: ABdhPJxHZ0CzZtLX0yxYAp4dIhBRV4HADDUYwApAv5DU5Upq1MPompLd4oBVdoBUXF0G1XZEHZwnQ7P0B6S6JMTl9Yo=
X-Received: by 2002:a19:6b19:: with SMTP id d25mr6315441lfa.282.1608548929299;
 Mon, 21 Dec 2020 03:08:49 -0800 (PST)
MIME-Version: 1.0
From:   seiya seiya <seiyaquestions@gmail.com>
Date:   Mon, 21 Dec 2020 19:08:38 +0800
Message-ID: <CAAEMCNB-jrEcCZ98QK_i5z_4u8S6RSuK708Vzk13oi2Z4mgbpQ@mail.gmail.com>
Subject: =?UTF-8?Q?Did_the_=22TASK=5FWAKING=22_condition_really_need_to_be_ex?=
        =?UTF-8?Q?amine_in_=22=5F=5Fset=5Fcpus=5Fallowed=5Fptr=E2=80=9C_function=3F?=
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks:

        I use linux kernel v5.3.1 version, i think all recent version
may be same  on the spot i methion below,
In function "__set_cpus_allowed_ptr".
file:linux-stable/kernel/sched/core.c
function: __set_cpus_allowed_ptr
1562         if (task_running(rq, p) || p->state =3D=3D TASK_WAKING) {
1563                 struct migration_arg arg =3D { p, dest_cpu };
1564                 /* Need help from migration thread: drop lock and wait=
. */
1565                 task_rq_unlock(rq, p, &rf);
1566                 stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
1567                 return 0;
1568          }

you see here are examining the "p->state" equals " TASK_WAKING ", but
from the whole kernel code, i found  only one place set the "p->state"
to " TASK_WAKING ", which is in the same file function,
the function is  try_to_wake_up, below is that:
file:linux-stable/kernel/sched/core.c
function: try_to_wake_up
2506         p->sched_contributes_to_load =3D !!task_contributes_to_load(p)=
;
2507         p->state =3D TASK_WAKING;
2508
2509         if (p->in_iowait) {
2510                 delayacct_blkio_end(p);
2511                 atomic_dec(&task_rq(p)->nr_iowait);
2512         }

so, this is the single place that set the p ->state =3D TASK_WAKING, and
 with the procedure going on in "try_to_wake_up", the p->state would
be set to  "TASK_RUNNING" in "ttwu_do_wakeup".
file : linux-stable/kernel/sched/core.c
function:ttwu_do_wakeup
2100         check_preempt_curr(rq, p, wake_flags);
2101         p->state =3D TASK_RUNNING;
2102         trace_sched_wakeup(p);

so,   TASK_WAKING is an intermediate state for the task to be woken.
but, which strange to me, both the sequence of   p->state =3D
TASK_WAKING; and   p->state =3D TASK_RUNNING; are protected by
"p->pi_lock"
it seems like that:
try_to_wake_up( ... )
    raw_spin_lock_irqsave(&p->pi_lock, flags);
   =E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=
=E3=80=82=E3=80=82
     p->state =3D TASK_WAKING;
    =E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82
   p->state =3D TASK_RUNNING;
  =E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=
=E3=80=82
 raw_spin_unlock_irqrestore(&p->pi_lock, flags);

and, also, the "p->state =3D=3D TASK_WAKING" check  in function
__set_cpus_allowed_ptr protected by the same "p->pi_lock" in
"task_rq_lock".

so it seems like that:

 __set_cpus_allowed_ptr(...)
{
   raw_spin_lock_irqsave(&p->pi_lock, flags);
   =E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=
=E3=80=82=E3=80=82=E3=80=82
   if (task_running(rq, p) || p->state =3D=3D TASK_WAKING) {

=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=
=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82=E3=80=82
   raw_spin_unlock_irqrestore(&p->pi_lock, flags);
}

so, my puzzle is: how did the core see the intermediate state of "
p->state =3D=3D TASK_WAKING" at runtime? because the two places are all
protected by the same spinlock (p->pi_lock). and there only one place
to set the p->state to TASK_WAKEING?

In which scenario the  "p->state =3D=3D TASK_WAKING" of function
__set_cpus_allowed_ptr success?

thank you!
