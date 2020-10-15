Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6E28FAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgJOVrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbgJOVqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:46:48 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9041FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:46:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d124so174425qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jJ0XSGNBD3tY7euVB543fHYlpP3eBszAe3/uk5F5Rds=;
        b=vC3eeJ6AWKOK6CgMzXd0FxGlRUk8myAzlN+70++340FYOMYD15ktWn91DBrYrWR47c
         jFA+Mx2y1wdC7z7njaKJYotyVpJFBfEi+nhsDxqAmfSduj1NT0+zRFdNwy9e9toc+a53
         NJf02KjD+XK/Y9RUvU4YlofHQOHM7sjLb/D2JZOAeMyZCfBgMo4PBB923Ff+cqQ5QNlH
         sfa5nZTJBkXVAyFUF484hZemQyPmym8Cd7g4aDAnTqA10dEpyLim6nt2Z6wcu2sjtTXE
         ccSjY2r4S+2LUylMM+L5ZFdT1Qpar5gD1MraOicAQkB6m/eRUxx33mnCLx+qOq4uCB5v
         CAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jJ0XSGNBD3tY7euVB543fHYlpP3eBszAe3/uk5F5Rds=;
        b=QyrOADeFNHXSXfKzDutO9CB9rH19n3RsXq3czd5PS+CFna67+JsHDJeYGOPkLLH5o3
         fZ7vJVlAiMHln96LfdiZ6ORM97sl6NcF2UuTBBpEL9UnvC2UgqBBOPpkIO8GeBpX16u/
         OERl7IfbAHgo3lZCVLWi5eFOjo6tQsQQAjlXA6IExyiuwBWLzSlz6bGtjc1vtRP/9ALD
         94MC/Y0za+MHjMifoOa7WnsDhOERavZ/L2mMqi5OsXCnLXJ0Yl9+ECSgh2fCxRdkvKIL
         BYTsAQ6xogDHAIkpe9EqQuQpyY/dkImIBz/FLVmYfygBgXMh5H+vyc/bM5BfG3JIrPKT
         chOw==
X-Gm-Message-State: AOAM530befO0amAeXfgxgBSpbwYPcN/2H17FBOo2aQjiUqJySYK5Yg6G
        P3b8V1Dom58I53EdzarewRuG8KNo+oQ=
X-Google-Smtp-Source: ABdhPJy/gKbvbPaKedo5PE3S0DBqu189VWoYKJIviBQq1cp6yrPskRaTZNVZkmirHKdPnYKENw3tPx1dOJs=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:14b4:: with SMTP id
 bo20mr957599qvb.24.1602798405757; Thu, 15 Oct 2020 14:46:45 -0700 (PDT)
Date:   Thu, 15 Oct 2020 21:46:32 +0000
In-Reply-To: <20201015214632.41951-1-satyat@google.com>
Message-Id: <20201015214632.41951-5-satyat@google.com>
Mime-Version: 1.0
References: <20201015214632.41951-1-satyat@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 4/4] dm: enable may_passthrough_inline_crypto on some targets
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm-linear and dm-flakey obviously can pass through inline crypto support.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-flakey.c | 1 +
 drivers/md/dm-linear.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a2cc9e45cbba..655286dacc35 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -253,6 +253,7 @@ static int flakey_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->per_io_data_size = sizeof(struct per_bio_data);
 	ti->private = fc;
+	ti->may_passthrough_inline_crypto = true;
 	return 0;
 
 bad:
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..345e22b9be5d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_same_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->may_passthrough_inline_crypto = true;
 	ti->private = lc;
 	return 0;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

