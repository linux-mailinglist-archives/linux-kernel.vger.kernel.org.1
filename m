Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF2E297450
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbgJWQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751855AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D5B246C1;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=J7G13+aNnMy7mzwjj7Q8DL+RJxJZp8RG7EudgPBJ24s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4wu7n60GcgT4RSJWOAmn32w4yvcDUMC9Gq+sO5boca3EDDCS9BSq26wyefmBcxpG
         SHkwx39qeGaoAJXVwRd/15hNjEL7H55jJyERrYkWGVyIwFB0D2/9vTO0gmwn1Smq34
         U8Vn0LIkHuiZ+O5Fp7y5z/mIGWW2dvqo+5VqFIvY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002AxJ-EX; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 43/56] hrtimer: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:30 +0200
Message-Id: <117905e796d1dd4920ecd7f9f917f95e15784c2f.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hrtimer_get_remaining() markup is documenting, instead,
__hrtimer_get_remaining(), as it is placed at the C file.

In order to properly document it, a kernel-doc markup is
needed together with the function prototype. So, add a
new one, while preserving the existing one, just fixing
the function name.

The hrtimer_is_queued prototype has a typo: it is using
'=' character instead of '-' to split:
	        identifier - description

as required by kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/hrtimer.h | 6 +++++-
 kernel/time/hrtimer.c   | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 107cedd7019a..bb5e7b0a4274 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -447,6 +447,10 @@ static inline void hrtimer_restart(struct hrtimer *timer)
 /* Query timers: */
 extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
 
+/**
+ * hrtimer_get_remaining - get remaining time for the timer
+ * @timer:	the timer to read
+ */
 static inline ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
 {
 	return __hrtimer_get_remaining(timer, false);
@@ -458,7 +462,7 @@ extern u64 hrtimer_next_event_without(const struct hrtimer *exclude);
 extern bool hrtimer_active(const struct hrtimer *timer);
 
 /**
- * hrtimer_is_queued = check, whether the timer is on one of the queues
+ * hrtimer_is_queued - check, whether the timer is on one of the queues
  * @timer:	Timer to check
  *
  * Returns: True if the timer is queued, false otherwise
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3624b9b5835d..61c39ff68439 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1289,7 +1289,7 @@ int hrtimer_cancel(struct hrtimer *timer)
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
 /**
- * hrtimer_get_remaining - get remaining time for the timer
+ * __hrtimer_get_remaining - get remaining time for the timer
  * @timer:	the timer to read
  * @adjust:	adjust relative timers when CONFIG_TIME_LOW_RES=y
  */
-- 
2.26.2

