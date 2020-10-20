Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B795A292E07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgJSTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgJSTCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:02:51 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71540C0613CE;
        Mon, 19 Oct 2020 12:02:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z2so1320811ilh.11;
        Mon, 19 Oct 2020 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+Mo5PZTRY/ozgpRWhfvSGxQiQnu+hbGGj5HeK4zgq8=;
        b=mFRleDFchkeO4f0xX8MFjz0vzkuHh5EPh7Szo80XEN0beecJ50arjVv71+wSsfl7QS
         wWQmI3RqM+HEYdgfxo96HyDKUG3m8Z0Tj5kCva/7K5tlRhgcPO4SDUMFuzwRACNel8qw
         GF6iSqOFxCDnLBQF5Uk0odQ1zWsMFnh6b+ICCSgjq/grXVT5h+edgiXJhd+7OgTdWQ2J
         D37tfoVNFUreE7lRs+4HHDrd85FNKDkWDiluRNPlsPIbj87fcVb7KoRHxJTSAA7WRVFl
         anD2fjeGAPe5lgZ8cbdNQ1zx0dwKELmP3qSbw/esTZgthfjJDD47z0+ua9ndd3kTwXES
         +4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+Mo5PZTRY/ozgpRWhfvSGxQiQnu+hbGGj5HeK4zgq8=;
        b=uOdY43wdF661899CVtiF7PNO1TwQOwjhHxOQQkrW/9bGVcRS5zQIpz7JEwXy9RT5xF
         +zeKa2AW+ShxoHlmBZZohGXUzxU7baFl7PH1JBUVditjEOBPuUA1T5H00WKKGeBMSIsn
         SWSQGDFzZ+xmPw3/bCeBouQy3HwFBdKXD290upLRO01A7O/ivHnEvxFvPTW1ij1SdHlV
         Wf/fb9y5X2EaiWkC1PSfb3azmEs87M9UZxUP6hB/ak12tR7o72kVT4s8Tchi3u5LIQva
         rTeIQdOCB37FMb/83AOLv/Ljx1tgNYki+GOu1gHUXQttgEwzi80OxlyL4Ml50iCztY+l
         HqIQ==
X-Gm-Message-State: AOAM533NjzIEdtc6fidLMvvUKYw+sIG75tFrtnFXbLyqXYOwSQ/QtJ9W
        CV2kTcBJF++9szBDaMM3ITK9aMqncg==
X-Google-Smtp-Source: ABdhPJwgnkotyfm0gh/sV+3SG10fcVmkTIJjkm+n5DvPoQ80/3CawuKrGmSPDcGkZ+Jt95p2xAknvw==
X-Received: by 2002:a92:844b:: with SMTP id l72mr427557ild.244.1603134169726;
        Mon, 19 Oct 2020 12:02:49 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id q16sm580359ilj.22.2020.10.19.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:02:49 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/2] block: Add some exports for bcachefs
Date:   Mon, 19 Oct 2020 15:02:40 -0400
Message-Id: <20201019190241.2910492-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcachefs has its own direct IO code.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index e865ea55b9..72a65c4113 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1320,6 +1320,7 @@ void bio_set_pages_dirty(struct bio *bio)
 			set_page_dirty_lock(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
@@ -1379,6 +1380,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
+EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 static inline bool bio_remaining_done(struct bio *bio)
 {
-- 
2.28.0

