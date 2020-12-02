Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D698C2CC035
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgLBO7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgLBO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:59:43 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:59:03 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t18so1275000plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJyif+Bhzhm3rCNjSKwcnr5pgcagU8QYIZ7kRlFomoM=;
        b=uNz5bhrh9TL9RatCAg+C3+U+3GjVC7cEzhkjwu0cBL0X7lWAm+cgUxErfz12sk64YX
         NOnCFKB7OVPH3tK53koTlzcVTrVgs3jy6xSvnEZaiQkOe5YJFaJx/lALCG3Q+Ozc2fp+
         2B5hcpVFeKzYvriQ3rRjdeibTZevpW/EdFXr+Tyz9Q94VQfTa+zvQwlx0PrY4cQJD/Ew
         kVXZv+QFA+DSwENod3dg5y+zc0o5aqb2t5OUrwZVrLSLRDLk7WuIhk0hyusBxJIh9WF1
         DF0wIxGulUmRjzXPvUg5Jggzw5Ek3oEjB2tLvbHMwK2/42K+NN5oELdh1rpKmy8jnEOM
         XKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJyif+Bhzhm3rCNjSKwcnr5pgcagU8QYIZ7kRlFomoM=;
        b=HTzqOL24RX8RAY+CZ00b9NDEsjReWloMOc8pJia83sgwfjKLMPS2NU98tQcAOhsXtc
         ZrnoagsJ6PBMuG6N9ghosnmjtodheUUV+MRrPtH5+7yAJN3qCQYBxnDsI6zUtEDubfgj
         4El+pOyYXbCLGPC0z1+wQXxQrJo2Ds7vQI3/i4bPBIZh/qgWhD6kNHvMmUgWWJRoe406
         rILCQrI8dG1r0oTgIUEPbVsMwKRx0FD988el2Ug2cm8UrAir+eZmg2rQj5Lq83rQ2qE3
         eGNraPOJuNAFL4ilJqVaNCWkLXExxIOGCaQTBigePYtCVzvukIfOeocSCH2D/Fuj34rF
         Dg3w==
X-Gm-Message-State: AOAM533kuddjW/IICggkhoAvK2TIxLHDGH66oYoviUtOMRc9rjUd9LNf
        a1y00C8cNpVufSWxi4JwRZM=
X-Google-Smtp-Source: ABdhPJxbtWXApVfjSXKsTo1dXrpDPM7sLJvnadw56FjyXem/+Qr6ScSqQizpAZQAl3E1Yo+a/csbFw==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr239952pjg.65.1606921142741;
        Wed, 02 Dec 2020 06:59:02 -0800 (PST)
Received: from localhost.localdomain (cl-ubuntu-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fee1:602f])
        by smtp.gmail.com with ESMTPSA id j11sm146826pfe.26.2020.12.02.06.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:59:01 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kernfs: speed up concurrency performance
Date:   Wed,  2 Dec 2020 22:58:35 +0800
Message-Id: <20201202145837.48040-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

kernfs is an important facillity to support pseudo file systems and cgroup. 
Currently, with a global mutex, reading files concurrently from kernfs (e.g. /sys) 
is very slow.

This problem is reported by Brice Goglin on thread:
Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
https://lore.kernel.org/lkml/X60dvJoT4fURcnsF@kroah.com/

I independently comfirmed this on a 96-core AWS c5.metal server.
Do open+read+write on /sys/devices/system/cpu/cpu15/topology/core_id 1000 times.
With a single thread it takes ~2.5 us for each open+read+close.
With one thread per core, 96 threads running simultaneously takes 540 us 
for each of the same operation (without much variation) -- 200x slower than the 
single thread one. 

The problem can only be observed in large machines (>=16 cores).
The more cores you have the slower it can be.

Perf shows that CPUs spend most of the time (>80%) waiting on mutex locks in 
kernfs_iop_permission and kernfs_dop_revalidate.

This patchset contains the following 2 patches:
0001-kernfs-replace-the-mutex-in-kernfs_iop_permission-wi.patch
0002-kernfs-remove-mutex-in-kernfs_dop_revalidate.patch

0001 replace the mutex lock in kernfs_iop_permission with a new rwlock and 
0002 removes the mutex lock in kernfs_dop_revalidate.

After applying this patchset, the multi-thread performance becomes linear with 
the fastest one at ~30 us to the worst at ~150 us, very similar as I tested it
on a normal ext4 file system with fastest one at ~20 us to slowest at ~100 us. 
And I believe that is largely due to spin_locks in filesystems which are normal.

Although it's still slower than single thread, users can benefit from this 
patchset, especially ones working on HPC realm with lots of cpu cores and want to
fetch system information from sysfs.

I tried my best to solve this problem. If there is stupid mistake, please kindly
point out. I would appreciate it greatly.

Fox

 fs/kernfs/dir.c        |  9 +++------
 fs/kernfs/inode.c      | 16 ++++++++--------
 include/linux/kernfs.h |  1 +
 3 files changed, 12 insertions(+), 14 deletions(-)

-- 
2.29.2

