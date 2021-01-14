Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019B52F651B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbhANPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbhANPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:24 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECCC061796
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:36 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 139so4047374pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=33jUdHhsrV2CapOFoRvS5dOYYlCXOaJVM4qnyxmNbLU=;
        b=apKtoFYknu3DIcXShFWPosdE+beqxNL3vnxUidGPnAu4PB+7WBe23CsevJNH8B3nzC
         YeS2VuQUPAqWD+CAbk1eZ91bQ79KccJuqim4mCQfmOlUOqnaeiYbOe7XzjaHBPE8VehE
         HcMYkND85iXYvGQdWN/rM6gAG9jW+Zn2gXwASSuE/bPBBgDSL0pEm9cH8za/aw0/IY3P
         pDo++HqA3k0shLmHIO8lFLb4Q4rfwMAchSbZjbksJe7/9mwTnMS5PG6XCZgeNvno1tKj
         zRvQSJJdOh/c341ec5fFf6wd4tAP50OKMskZzM6zhRQfeKD1jb9g3r/gZLNiedP2ynZ8
         Kk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=33jUdHhsrV2CapOFoRvS5dOYYlCXOaJVM4qnyxmNbLU=;
        b=PkfncUgs/pJWzm7k1Tr+/wl/arKQS/6tF7dKndswZd4lQSP7Sxu3f8UO8znAAebt55
         U2RjW2boaU1OVFYftaMUt1HXgg69HzNUV2UGX1evcTcP0/nzDWxg8N08EPgjH9/DvHqq
         5eexk8rfj+N+wt71NR8OazhNT7s5dvxj8HYiFKf0LHCslw1uDByC+wQVxHYDD1lfaavi
         GgLWFGhbqH8rabGWBECOQPnnqvvURC+Vnv0dYvW8r6is4Qsrarh49lq33u+uppAsy0lK
         jTnzPwaJdvuzqr7KfZ6sCC1HangodVdIHx+qUt4IkL/razgazUJ76FXFdH6ou8aVi65v
         fREg==
X-Gm-Message-State: AOAM531Wld+QPdn0f/1jYEyFpDDJTV8ePh1ZZi+wH5KiWG/y8CctfN/H
        O3WoA55QKVmdslO6k+cUQpbkJ5LfinI=
X-Google-Smtp-Source: ABdhPJyg3FWwzuF2MutPmTEmq0PgduUD2kKumkbOPbt3K4Us/J6vOeb3DnbLSRWjxovCLHKsVQ7RE4hvH+A=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:903:2292:b029:de:45c0:7005 with SMTP id
 b18-20020a1709032292b02900de45c07005mr5349837plh.75.1610639255488; Thu, 14
 Jan 2021 07:47:35 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:19 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-4-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 3/7] block: respect blk_crypto_bio_sectors_alignment() in bounce.c
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __blk_queue_bounce respect blk_crypto_bio_sectors_alignment()
when calling bio_split().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bounce.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bounce.c b/block/bounce.c
index d3f51acd6e3b..7800e2a5a0f8 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -305,6 +305,9 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	if (!bounce)
 		return;
 
+	sectors = round_down(sectors,
+			     blk_crypto_bio_sectors_alignment(*bio_orig));
+
 	if (!passthrough && sectors < bio_sectors(*bio_orig)) {
 		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
 		bio_chain(bio, *bio_orig);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

