Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC12F6521
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbhANPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbhANPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:36 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05079C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:42 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id 32so3441878plf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/1PpEbZ5u6Fy77mPqfkLa/nkoU52/tGMEHsbdtWepW4=;
        b=K1hogn8H0AcWLbJ1RB0i9mk+1WZxhfVKnMp1bl0mzoSc3owq6JLTq4RswfCdqIijZ7
         JOzl88lRYNXKHVEqn4ckkcT00dOCrFa1oaYNf6+uk5mksiFgViBomI+LuT7trMVxIKL3
         lA678wJO8a0w1YSBmHzgp35CrsaWRmz6iMZi/86cpDalD7nwnhvoGZa1RXWpkXylT0p8
         W8jajLGIfymIxuhZGGvlyB1V/J7d8pb1EchKb+Sgioprp+tRoh1SoBzMGGCYc+ln3yGx
         C0Ld5Xjh/k9F/QNGfldfQiivtqAjGp3Rkr/xLdXihH7H0MAa2Oa5GnvdC7RFwVZyt+Wh
         yeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/1PpEbZ5u6Fy77mPqfkLa/nkoU52/tGMEHsbdtWepW4=;
        b=PO5F8X31PIRjKlnPUg1sY0qP2suzUj8JrVbaIixFPcejdwdaaWZSV9t8A89G0OMqKB
         T9A3tLq/JeuO18S8vCL8ThNhas/+REVw5wKKh9LfSU7V1rh75Memmi549eWNuiP701pA
         HitL70ZkW+7Ch0YRwiAYAK9t1qG8oL5nMta/32ck29mCTRiq269k0tipgJNNUl3AV0zc
         N9F0RalHB10SgEXfrrmlEop8uKat4AQnKTiH6AbTUiTKmkx4G29CJrLnwSf0+V0bUJD2
         X7QylCkRbqD9801wJNtjIRjfp0YTvLl2xGSiaDWf+aEevb+FrM5OzW8/mWSM5FwPvzry
         fk+g==
X-Gm-Message-State: AOAM531/FWcovNGnRvNGEJY+XyGf8BLQdldahBUwQBk4JP40g3VUNvsb
        y9oj7xz70bkEkG1WizI7gxtA06F6QVc=
X-Google-Smtp-Source: ABdhPJxvZfMl2YEge75XAxbNvz3zndXJD7I49Liu1RV4ESXrtxeeROuRAuEe7qcF1uQihpPtTzG7Lg/KyvY=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:90b:ec2:: with SMTP id
 gz2mr5519727pjb.143.1610639261504; Thu, 14 Jan 2021 07:47:41 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:22 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-7-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 6/7] block: add WARN() in bio_split() for sector alignment
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of sectors passed to bio_split() should be aligned to
blk_crypto_bio_sectors_alignment(). All callers have been updated to ensure
this, so add a WARN() if the number of sectors is not aligned.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..c5f577ee6b8d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1472,6 +1472,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
+	WARN_ON(!IS_ALIGNED(sectors, blk_crypto_bio_sectors_alignment(bio)));
 
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-- 
2.30.0.284.gd98b1dd5eaa7-goog

