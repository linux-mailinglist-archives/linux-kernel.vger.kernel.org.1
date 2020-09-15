Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6926A4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIOMNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIOMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:07:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDFFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:03 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a3so3539584oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46qkXYBzzl32SKFnSZdE3/cfCOxFi6epSy1AcDD8C7A=;
        b=an9h8NlrVyDqw3/Nelwhy+HmK4AMivI+ZRQgtHQ7JEEq4KjMFJvZ0nimyvI7R2raEj
         6b2j+DPibko2NVqJ0/RGMbk9RKXPuoEIhWMgDC8sWyp1aV74YCaIEbaDrUAkB0oHIBuq
         IYqNLRiuRb8AXV/e/ZFsApEb26WRuW7OQsOLFa5D7w33veZJuJkLUcTvKHAaG448DZeK
         2W8XckP+r8UpgkMb5iGUmzoGkyo58c/OcW8xmUQFDFQKoXj4eKQEr+Le/WVM16HpB906
         oEVdTVxdKiYP4ZZieDI1bID5TbsuJTwePI42VzUBTgOWT7UvMHSzDo4APGnkJJUxJwHK
         y6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46qkXYBzzl32SKFnSZdE3/cfCOxFi6epSy1AcDD8C7A=;
        b=fc4/XlLOx7/By3Hfz48y1vn7j3Pzb4DATehHC26bVMudD8P/PqDjm4hMup4OJE7j3x
         DG34OEm9bLrwBZLHAc3BY228qRSBWFAA/zl1x4Vi+zTarJ8JVlBtFJFYJ3ilhLvKS8M5
         E8aUhOkoak17kyHykkB6bfD68E2oi0iOz3rPn571dG3Sr+s5eGDIrSbEIReFr5FTRFDW
         u2eg4P3FXa8h9cjVRV2/clltn9cvG5nZlhhYFLfSNAcpZfG5P1DRljLNSgzyKrKILbGL
         4d3GI82O1UUfyUb1Zn4OQdq00bssA3VFwMASa98UwlyA9GFOX/n75wiJSemcM1JhF86K
         vHyg==
X-Gm-Message-State: AOAM530xtM9153KIBj0oX0No0VxJgqg2Myldu6dCSBiVh4/G2jAChk/w
        vOcm2rcgEAhB8YW45AiGP68=
X-Google-Smtp-Source: ABdhPJz3YkvBDEkifdJwBiU3B4cARIjXtHukT5iJNFhnN3Slf0WcynE9ibgqbHm3UzfZr8UacJr8jg==
X-Received: by 2002:aca:568d:: with SMTP id k135mr3160462oib.136.1600171022594;
        Tue, 15 Sep 2020 04:57:02 -0700 (PDT)
Received: from localhost.localdomain ([111.205.198.3])
        by smtp.gmail.com with ESMTPSA id y17sm5373055otq.68.2020.09.15.04.56.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:57:02 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V7 0/4] Softirq:avoid large sched delay from the pending softirqs
Date:   Tue, 15 Sep 2020 19:56:05 +0800
Message-Id: <20200915115609.85106-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

When get the pending softirqs, it need to process all the pending
softirqs in the while loop. If the processing time of each pending
softirq is need more than 2 msec in this loop, or one of the softirq
will running a long time, according to the original code logic, it
will process all the pending softirqs without wakeuping ksoftirqd,
which will cause a relatively large scheduling delay on the
corresponding CPU, which we do not wish to see. The patch will check
the total time to process pending softirq, if the time exceeds 2 ms
we need to wakeup the ksofirqd to aviod large sched delay.

jun qian (4):
  softirq: Use sched_clock() based timeout
  softirq: Factor loop termination condition
  softirq: Rewrite softirq processing loop
  softirq: Allow early break the softirq processing loop

 kernel/softirq.c | 168 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 120 insertions(+), 48 deletions(-)

-- 
1.8.3.1

