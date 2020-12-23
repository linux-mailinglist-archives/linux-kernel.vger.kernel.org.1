Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6520A2E20E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 20:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgLWTbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 14:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728395AbgLWTbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608751780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xTTbekLN43CvnFCG6plT22h7BWmUKb8wS413UYgxl6o=;
        b=dNFAjN1e0CpkqB3mc7/hKiJ54sBQaI/LtaJaRV0tpEYVmbeB0S+ZKvAAvcM2gtwcM11QEJ
        ZWipewgrKdQo8DxID3V7FqnP+y3atNU+am/n3dI8ztyFXjgqOhwedfYxV4/PBXWYTy8Q7R
        vva994csvUPP0e2yd/UGdGr5om5zhZg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-jUQfFtysOHuvsF2AAzlN6A-1; Wed, 23 Dec 2020 14:29:38 -0500
X-MC-Unique: jUQfFtysOHuvsF2AAzlN6A-1
Received: by mail-qk1-f198.google.com with SMTP id 188so49986qkh.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 11:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTTbekLN43CvnFCG6plT22h7BWmUKb8wS413UYgxl6o=;
        b=kFkIzjKUYDZn/i3iSybAHsYfcqd8cMh7wekH6WGMPpbTNGkRnruZnejQe1PJJnBWwO
         Dkq+Wn0SfqlF0ewRICUuVhJfCzLx5j1RONh8goTtVVZcGbH9Yfc9odVwDe7XAZg92BoY
         I6MtCd4IAgTSeo5eWz+3d7G89YWox62xGRnBMMhny9JF9CN3ZMLrEajN4OleMjAIzIga
         1vIlP68eqUr9St51f7sqxXxfaX7oOl6Sv2kKVrzF/nkovc+ezig7SNj2jxFUqWBPRo0p
         VLBPplFs/+dViJa4usolyaoddY3L/x8+vwcYbJZ06WFIhnD5wZGhaWVtkKIDMyAD7uYD
         xiDA==
X-Gm-Message-State: AOAM533l8SUUe7KKB4VhosV6ZF8slNH95PEZ1L2nZF3d6LSnm/cq+l8Q
        0iZk8Fer2APZeg7nXlCEodn2j0/bwryWXK7Zh6yxh1rub1SqDPbcFAbs1BOb7S4EdPPfGXrZIZ7
        XetKoyf4VAcMmv8oTRp5sE135
X-Received: by 2002:ae9:ef12:: with SMTP id d18mr28621410qkg.473.1608751778122;
        Wed, 23 Dec 2020 11:29:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCjxF568qOP1Tpkyc6qjgmXjcXnP0DqGEG1lwU+eDQXT9IQQVeZD9PTcl5sEtpqni/aPJymg==
X-Received: by 2002:ae9:ef12:: with SMTP id d18mr28621392qkg.473.1608751777904;
        Wed, 23 Dec 2020 11:29:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a11sm15407136qtd.19.2020.12.23.11.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:29:37 -0800 (PST)
From:   trix@redhat.com
To:     jonathan.derrick@intel.com, revanth.rajashekar@intel.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] block: sed-opal: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 11:29:31 -0800
Message-Id: <20201223192931.122370-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index daafadbb88ca..9be24559ee9a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2540,7 +2540,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 
 		ret = __opal_lock_unlock(dev, &suspend->unlk);
 		if (ret) {
-			pr_debug("Failed to unlock LR %hhu with sum %d\n",
+			pr_debug("Failed to unlock LR %u with sum %d\n",
 				 suspend->unlk.session.opal_key.lr,
 				 suspend->unlk.session.sum);
 			was_failure = true;
-- 
2.27.0

