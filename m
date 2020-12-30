Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08402E7889
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgL3Mam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3Mal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:30:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A2C061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 04:30:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q4so8612561plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 04:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jsnnBXg6lelG7+XbLzabCq81Yh3z5bgKCoZFhfqiXuk=;
        b=qzHL+/lyx4Z6vY0q7IBxdflaOVzCtE3H1kivEQqxY2XsAqLXkZ5QRGilN6YfRcdgFG
         pzTFetxmUlviYA5oD/7XFHv9mQ0XoFjjg+G90XV16DMZ+c8TtwQpoexiuPI3Xm5SIpm+
         tgft9G4J1xj+GdKnmfn0l2pfFCNA9hVTgLVpL6XYYaEpattoM1/ke4Ha2LCGHMzJMD3O
         DvZMO9HvkHbnLxA5NxhKP0a8c5uBbR8J69RZh8L5dtVNS9vrexzgoqwapmCYplSDDXAy
         xOti2zA2dzn+D9gSMu9UIytaGkjxXitM5LJGdLav668j6RKyPX3a8KGI9hABMMtWNuZf
         BJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jsnnBXg6lelG7+XbLzabCq81Yh3z5bgKCoZFhfqiXuk=;
        b=iqDIibVrFkmYz5h7TERyHvnKOvuhztvXn28j4V5N5Qm/1LsciA3Racz039F9mwCaGu
         lCivnjqBCYZsZOJqD4Y9LHmZo4y7g7sjaWmoL9rsqu6KvRkAiETSEw12f/5j9IqL+sBY
         oHJ7h+6ZOQ4zPGSppJpkMBDJBnYm4GSQcz+idzKcgKmJKPKTBW08X+Mj0E777PibPgoO
         y0/sajhL2prQziz2gGmbk2QycRJ2l2OY0LPd0WiCZ0UOv9q56zn4ELKJvolI+qPkg2/g
         7Dh7V21kxOG6QiWyDs1q24cBtM0FE9ARk5c05lnEb1dsGepvPxnue1OrNNHhn7E21mBr
         BbWQ==
X-Gm-Message-State: AOAM530auDz12LbFwfSIXYXv1ygG/RiAd0KR1DFWWYjoavZdnrbh5r2d
        JG1gTa97Ou4J/5zBsCHPHnQ=
X-Google-Smtp-Source: ABdhPJx5pK/afO+mden2HHnNspr12+kTHCCUKgXvg8378jzEZPxheBb9IUGg0eHedqB5Ocn7P95IrA==
X-Received: by 2002:a17:902:bd09:b029:dc:3399:219c with SMTP id p9-20020a170902bd09b02900dc3399219cmr30620250pls.55.1609331401095;
        Wed, 30 Dec 2020 04:30:01 -0800 (PST)
Received: from localhost.localdomain ([222.99.248.130])
        by smtp.googlemail.com with ESMTPSA id d20sm8318207pjz.3.2020.12.30.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 04:30:00 -0800 (PST)
From:   6812skiii@gmail.com
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Jangwoong Kim <6812skiii@gmail.com>
Subject: [PATCH] futex: Remove unneeded gotos
Date:   Wed, 30 Dec 2020 21:29:53 +0900
Message-Id: <20201230122953.10473-1-6812skiii@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jangwoong Kim <6812skiii@gmail.com>

Get rid of gotos that do not contain any cleanup.

According to coding style documentation: "If there is no
cleanup needed then just return directly"

Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
---
 kernel/futex.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index c47d1015d759..0490d7e7fe7f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3024,7 +3024,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * Success, we're done! No tricky corner cases.
 		 */
 		if (!ret)
-			goto out_putkey;
+			return ret;
 		/*
 		 * The atomic access to the futex value generated a
 		 * pagefault, so retry the user-access and the wakeup:
@@ -3041,7 +3041,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * wake_futex_pi has detected invalid state. Tell user
 		 * space.
 		 */
-		goto out_putkey;
+		return ret;
 	}
 
 	/*
@@ -3062,7 +3062,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 
 		default:
 			WARN_ON_ONCE(1);
-			goto out_putkey;
+			return ret;
 		}
 	}
 
@@ -3073,7 +3073,6 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 
 out_unlock:
 	spin_unlock(&hb->lock);
-out_putkey:
 	return ret;
 
 pi_retry:
-- 
2.17.1

