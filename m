Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A42B1230
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKLWvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:51:41 -0500
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74]:4080 "EHLO
        mx0a-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgKLWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:51:41 -0500
X-Greylist: delayed 3278 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2020 17:51:40 EST
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACLiV9H008257
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=date : from : to :
 subject : message-id : mime-version : content-type; s=pps01;
 bh=X34LAhEQrojm/xQlKaNpACIV1qmJ4JMAKxNy22ZzzLI=;
 b=Z5ZTdByMr589ndIQKvHDTd0RI/qIFZOSt1zcEL8++FtRaHH20XL7d9FNbxfNozeVlWZi
 nlXuTplnoqKbbydnkwdaukgDtrOOKgX+ArsPXFagaZ95qGXzzpckhVR/kgWO9URdM9gK
 sKunCB0YmbKm+zsbMK1p3bDIlYapFtKNsVpvxSUrRxGWEbi6Vgq/0ZePAZkG9CiT1PLl
 jWxz6LkWCEpiZ7rD7KBccHBLeC8qpE7hgq6y/fX0E1c/q0mrvxTnYA+J0/efDedKPEXM
 wU42+10chwIjLcgVphZ3TOdH04iWVlAGAfae1pJV/TrQi+5Vl+O/F7DtcTVg2DuI8S8j Bg== 
Received: from sendprdmail22.cc.columbia.edu (sendprdmail22.cc.columbia.edu [128.59.72.24])
        by mx0a-00364e01.pphosted.com with ESMTP id 34q7sm2d5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:57:01 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by sendprdmail22.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 0ACLv0Yt057992
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:57:00 -0500
Received: by mail-qt1-f200.google.com with SMTP id u28so4451228qtv.20
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=X34LAhEQrojm/xQlKaNpACIV1qmJ4JMAKxNy22ZzzLI=;
        b=TzCHJ6JqPr5f/+gQPmbu4mzpWF3Y72CMWzGHaWp3/lL21Yqs6O4k1TVO1ka2E9S4eD
         +cQoMRoJfjgRo6wOPEqXiTxUrPliw5tytui3D8B2n478jEURpKb4nl4M2aAxUQieo4iE
         eO216sWiBcczqxHw6PztNN0YLwRzuQZmcQJsnkC1jmhEYhQ4dgJaS/2xd+3EmcSOqMEz
         S2XuqsZmzNBZip+ZxSuypw9sBVTqIEwdVNActmn1v/XHvyuz9FXae5ZUi3StFcz9vQP/
         zMSAeyMZJNsvo+kRNDvapcI8sy4yPf+nVfNsEGHrM5eAM9PA05U2eM0Tpz/HPCr6Wq41
         qE4Q==
X-Gm-Message-State: AOAM533hisRzyZFMpszHKnMGm44DECrIQgui7+t7wiWTO/OleOrglhQ5
        xg+aXOag/72JDeA3qr0ybnH2GUK9vmWErHAsoxKthKWBHr/zC21o10gI2XKDyIfp92T294hQXV1
        c88lwF56yfY8f1P9gFlfSMoAItTR+Xy94
X-Received: by 2002:ac8:36bc:: with SMTP id a57mr1325106qtc.193.1605218219728;
        Thu, 12 Nov 2020 13:56:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/xqMVxvHiYraEYm6ElJbbYn7oRVQWMCPzyObG3eHL2S1E6CRBzWsYExrGdymXMxZBAeSsmw==
X-Received: by 2002:ac8:36bc:: with SMTP id a57mr1325081qtc.193.1605218219440;
        Thu, 12 Nov 2020 13:56:59 -0800 (PST)
Received: from charmander (dyn-160-39-33-233.dyn.columbia.edu. [160.39.33.233])
        by smtp.gmail.com with ESMTPSA id w45sm6070084qtw.96.2020.11.12.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:56:59 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:56:57 -0500
From:   Tal Zussman <tz2294@columbia.edu>
To:     Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] syscalls: Fix file comments for syscalls implemented in
 kernel/sys.c
Message-ID: <20201112215657.GA4539@charmander>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_13:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0 bulkscore=10 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=10
 lowpriorityscore=10 mlxlogscore=999 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relevant syscalls were previously moved from kernel/timer.c to kernel/sys.c,
but the comments weren't updated to reflect this change.

Fixing these comments messes up the alphabetical ordering of syscalls by
filename. This could be fixed by merging the two groups of kernel/sys.c syscalls,
but that would require reordering the syscalls and renumbering them to maintain
the numerical order in unistd.h.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/syscalls.h          | 2 +-
 include/uapi/asm-generic/unistd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 37bea07c12f2..629870fbb2c9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -744,7 +744,7 @@ asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
 asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
 
-/* kernel/timer.c */
+/* kernel/sys.c */
 asmlinkage long sys_getpid(void);
 asmlinkage long sys_getppid(void);
 asmlinkage long sys_getuid(void);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2056318988f7..fc48c64700eb 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -517,7 +517,7 @@ __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 __SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
 #endif
 
-/* kernel/timer.c */
+/* kernel/sys.c */
 #define __NR_getpid 172
 __SYSCALL(__NR_getpid, sys_getpid)
 #define __NR_getppid 173
-- 
2.20.1

