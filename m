Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E892885EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgJIJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgJIJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:25:55 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6567C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:25:54 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 16so9509823oix.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEY5igIwIVqg7iSnPtH8wWYjqyD7WfVBwRYRioZpnzY=;
        b=RwZHD2nmYM0CAkHF6aaqK82Wk3veVjLE0WevppIlF/xWTlco3XXncKPu8yAtNSJ6rB
         KBIHPQlHgmefF4fdVcIoZwOshqgr24kGX97wboLn9M6MYyOuH92xuVZq8V3lHR2k9HF8
         NQLWQSCgTfYMDPnjsxpPOQLWvt41b8VTHoF3LDlN5pwwpazYBb6j21YawhWPSTXMEj7e
         rvvP4u+ZlUZSH08j3txOZBvHNmiGFrrKMODNwOZVcQaGIPXd5Fu8CNai2XlwnN1va9Pu
         CYPvkpU6sG3qXPIVriayAEJb2/KRs69qyXT4wBitdJ+i3Q0twy4LMhaHv98UnzVHdGIM
         ioFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEY5igIwIVqg7iSnPtH8wWYjqyD7WfVBwRYRioZpnzY=;
        b=hHl0NkoUh/OGfIR8L6xvHAfrADRwvc9FhC/eLCeQ/Qfi/y9R2sDFr2ThxkhY7fQkaK
         B2bih5VwDpGgeKUSA4Gd44jsFGRW7DqlCm5eMGdC5pB0QS45eQGMrHmlp81gtnR8eSO5
         9/gZ8sMVmoSaCWp3Pud3iXg4ZLiQ3vnvWL53IflWtYFg6JrTIIduy73QAFnWSAxUPJzl
         KGrAVtOQImphd2dBTHUeBf0Mi9Qf6h4OCTxdlhHEj5EdA7Fltp1xl9T+hdX9tZ547AnD
         PmhhrjASItNOhfLz0JhwBDsFK5DVrjbge7myOIZ6XjlyQRGp+bPBFyVav4VD0YBh6P/O
         ypVQ==
X-Gm-Message-State: AOAM533TqkIMozC9MW1cQJWMwpOoauOrnqh5KQsInWq10FGyz2OL+TA3
        TaVBlXyLmEp4D7HTRfcd+rgQWtUsYs8DbN8Y
X-Google-Smtp-Source: ABdhPJyUPOj6EuUGjmiLEXYAr6nTISGruC/rg8r01eyiHtG3MpflzIeCa/jOCUpN/xycGnfFC02aTA==
X-Received: by 2002:aca:c586:: with SMTP id v128mr1899090oif.115.1602235554201;
        Fri, 09 Oct 2020 02:25:54 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id g124sm7026337oia.58.2020.10.09.02.25.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 02:25:53 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, jun qian <qianjun.kernel@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/1] Sched/fair: Improve the accuracy of sched_stat_wait statistics
Date:   Fri,  9 Oct 2020 17:25:30 +0800
Message-Id: <20201009092530.223-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

When the sched_schedstat changes from 0 to 1, some sched se maybe
already in the runqueue, the se->statistics.wait_start will be 0.
So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
wrong. We need to avoid this scenario.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..6f8ca0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -906,6 +906,15 @@ static void update_curr_fair(struct rq *rq)
 	if (!schedstat_enabled())
 		return;
 
+	/*
+	 * When the sched_schedstat changes from 0 to 1, some sched se
+	 * maybe already in the runqueue, the se->statistics.wait_start
+	 * will be 0.So it will let the delta wrong. We need to avoid this
+	 * scenario.
+	 */
+	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+		return;
+
 	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
 
 	if (entity_is_task(se)) {
-- 
1.8.3.1

