Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E63295820
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507977AbgJVF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409018AbgJVF42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:56:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC8C0613CE;
        Wed, 21 Oct 2020 22:56:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so451977pfa.10;
        Wed, 21 Oct 2020 22:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VbYIO501n+ry6CYxaNF6frK+9j27vTWjQbIgJfLCePo=;
        b=p9nYY5al2feQVwPlO8KHIt/K9KZsjgKnKlcUMTQNdc346LAS84fKrjgEo0EodZdBOU
         JpEc7AKOM/ZGYxzbEE3dqjfK9NHVnYq62t6ceYwDVNmrU41whTFaIioO4YBM+DpOub3h
         Ms7BNkMbNF6Su66K30v+s0yFs3kc/7ahYHrOWVsqxDF+IifLsWhxrFeJZxE6s07q9czI
         U3KojYr8m/UMKgnyJBG1Jx3t/LFfr5zvjA/+FA0Xg3in6stAFgNvL1VWfGY1ydgR8ZEW
         +Q7fz45onuRXCkfGzTao2c1nC4kmMQD86On7gw0tYkwq09ekkiYBfDT6I5TtnnFw/+jk
         em9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VbYIO501n+ry6CYxaNF6frK+9j27vTWjQbIgJfLCePo=;
        b=hPMDdDUb/Iy4GBYyHX8drzRBwfqNLjdKiiKld+Um5RW/AH5JT9++/kJgPOqZKJF4Xq
         24zCYhf8lPeDGpGMnHT4dMqtsgd2CYpwD7uGD7sCfXrquho3aLx/0UYvuzhEtNdqzbwt
         /ILRJko172ySuUrA99CD2g3NtDvuJkBLyIaT+FXwDh2QojaJ5Ye8fpw76XDDsBy2MNAM
         r1m4WI+DGjirgETd9frSLnaRHEOk2GiaqFpR+KAHcfr5Q9y0lgMqsy3t7cXkFakI5xAO
         kLQGan98Db5Do+rgRUzE/NrQQHYBqGmHABZmcftKPu4gzomGmdmoDRDSfBp1LoLqshW2
         ALew==
X-Gm-Message-State: AOAM533Pz48LXR1MVhd7FZb0hiJtzNlVk+rfqMG5UWsbfx7QJo+lA0Rs
        krI6SY3o0mu9FP0ZyYwNaw3ol7np+Q==
X-Google-Smtp-Source: ABdhPJzXqtxh/omVyEX1StbzywyHIVA6EtEaYtkcN3JQEmR5cuCzjpXHPPzBBdl2AvlBgjC6Q6t86w==
X-Received: by 2002:aa7:83c9:0:b029:158:11ce:4672 with SMTP id j9-20020aa783c90000b029015811ce4672mr911009pfn.23.1603346187972;
        Wed, 21 Oct 2020 22:56:27 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12sm830995pgi.14.2020.10.21.22.56.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 22:56:27 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH 0/3] warn and suppress irqflood
Date:   Thu, 22 Oct 2020 13:56:00 +0800
Message-Id: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
When the bug happens, the kernel is totally occupies by irq.  Currently, there
may be nothing or just soft lockup warning showed in console. It is better
to warn users with irq flood info.

In the kdump case, the kernel can move on by suppressing the irq flood.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: afzal mohammed <afzal.mohd.ma@gmail.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oliver Neukum <oneukum@suse.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: kexec@lists.infradead.org

Pingfan Liu (3):
  kernel/watchdog: show irq percentage if irq floods
  kernel/watchdog: suppress max irq when irq floods
  Documentation: introduce a param "irqflood_suppress"

 Documentation/admin-guide/kernel-parameters.txt |  3 ++
 include/linux/irq.h                             |  2 ++
 kernel/irq/spurious.c                           | 32 +++++++++++++++++
 kernel/watchdog.c                               | 48 +++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

-- 
2.7.5

