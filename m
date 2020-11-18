Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC392B74E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKRDgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgKRDgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:36:42 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FEDC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:42 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so548252pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HRxrxj4kkq5sIvpeS6bsCaGOBWTxfHUm6EpLOfHBfZs=;
        b=YkYNCy7T+gpfFeZZJU4Xf5wdAOlzCUKmt66RWiEdAHwSWlCKmb9oilvlX+Rrosefmg
         bnrJS4mYh3g41wPTxof5aIEbnLahWNJOscf7ziq3NAQqYESCaw6iGhnJ+7Rk8lvI+ndh
         mXe6W3HWQd2ScnbK5Egzy5r1tOGFSz8Ac+tqPy45cTutxtji7LfZXNzxao9KKFV849IU
         XfOWzTEHLXpr/QzCBbZTcEu7HphBcfIzLOHx6p/IEND5C/FUzC8jB7k6pfuUCNi0Acdf
         xEI4E3cyc86f2r4oBR5emNBVuW5y13lWdr8flsy9t2pKNffIgf3oQIa3HBN4aZxJgxgn
         0wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HRxrxj4kkq5sIvpeS6bsCaGOBWTxfHUm6EpLOfHBfZs=;
        b=Evx8xtqGEFVVurM46s2XmPFmC9rLBDayIHj6KNeEmSzqeAVYmbS1jEIkWVvCrsNcnr
         9VXhyKNdjckYC719y8OSAhjkopUCA5B7SlmlcHE0PvCHwftSMH+SVTTZNI5IBEyPrdJm
         iz9nWFRZyfP33uqDM19g0t0WW7o+tRptJlED+b+QIKt9oW0Lc7QzxL80vImIr3KQXtqe
         RCth98AGl+4Ma2wGOiB0xC+/GV59rL+q83smyHE5r/9uBpfjiE3FzmuZ4/JNaro+Tr8G
         nb81zaXWZdoUIqcSkhURBQQDTWqV7SP9SOtNNoLnmQdkl7bdkGL4k8uoo1rJ1+GgwNcB
         25Hg==
X-Gm-Message-State: AOAM533nphwWGOLK2GxiUprwhVuUw10ZgrriREdgfToYgBI+HMJCOdM4
        Qb4iiVReKexbaQARqpMVsiMJgxx7EA==
X-Google-Smtp-Source: ABdhPJx9l+/BBdKgXfmlYE/AggdUie30cqGFIRiau2jQFcjyhoxGpLAmgVLQrjN7aAxfO3hr33yqzQ==
X-Received: by 2002:a63:cd0f:: with SMTP id i15mr6441551pgg.46.1605670601357;
        Tue, 17 Nov 2020 19:36:41 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s21sm8915450pgm.65.2020.11.17.19.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 19:36:40 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org
Subject: [PATCH 0/3] use soft lockup to detect irq flood
Date:   Wed, 18 Nov 2020 11:36:15 +0800
Message-Id: <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <87tuueftou.fsf@nanos.tec.linutronix.de>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chipset's pins are often multi-used because greedy usage compares to a
finite pin number. This requests a carefully configuration in firmware or OS.
If not, it may contribute to most of irq flood cases, which appears as a soft
lockup issue on Linux. 
 
Strictly speaking, soft lockup and irq flood are different things to overcome.
And it is helpful to make users aware of that situation for prime time.

This series shows the irq statistics when soft lockup. The statistics can be
used to evaluate the possibility of irq flood and as a rough evaluated input to
the kernel parameter "irqstorm_limit" in [1].
 
It is not easy to find a common way to work around irq flood, which may be
raised by different root cause. To now, it is still a open question.
Thomas and Guilherme suggested patches to suppress the odd irq in different
situation. [1].[2]

[1]: https://lore.kernel.org/lkml/87tuueftou.fsf@nanos.tec.linutronix.de/
[2]: https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com/


Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org


Pingfan Liu (3):
  x86/irq: account the unused irq
  kernel/watchdog: make watchdog_touch_ts more accurate by using
    nanosecond
  kernel/watchdog: use soft lockup to detect irq flood

 arch/x86/kernel/irq.c       |  1 +
 include/linux/kernel_stat.h |  1 +
 kernel/watchdog.c           | 37 ++++++++++++++++++++++++++-----------
 3 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.7.5

