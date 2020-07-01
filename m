Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7C210634
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgGAIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgGAIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0492C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so22891786wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHtif/VrKAdzD8tANDBuK+rW4l81OqvLbxPsir5m1XU=;
        b=vJqpzOS1A0c6oMtc0af+fRpBSXMwQoovcCXupfRxb7znpgIWRRczksYghPdPHEFmCE
         oyqJqkM9FZEEW90HdE3Hc4+B+6qORH9GgQUdG0GiFQHHdRN0ejsTRhCcL9Pf6KBeOZmW
         JxGoHEijNGJg4n6/AhXAn/Blhna/ebAtbSRq+k5bEbSVoo9zP9zLNNGm8pe8UaU7uemz
         7xH08zTwvFOt1kdNJ5Pz/ekoGZGlrHfVcQKquuKPV8n70A8sSl5yYkkNzeeIxrDRz9Sb
         O15dlK1sR/LQp2FAv7D3h9EYGaq+35CGm9FNckky+DWXrZR3qzKPcegMugxfu6arbmdG
         J2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHtif/VrKAdzD8tANDBuK+rW4l81OqvLbxPsir5m1XU=;
        b=H6WYvTmYgijrAXDyTsbk5GkI85a5KPTWdsH62D2ic+B5uVt2LdgCx/5fXEQkYt8CPv
         mC4f8Iwf28UfWCJpgiDEaMt5hPAKquZP0m3lwfsFsodTdmcz7Xpvv8B4z1qBmbW/rR5g
         ncuiqVAmxZVVurtDRkzgwVBMazozcIV4PBUtqFdzhnaFQpgagV3ky5fykAwsmNPv3lk4
         EQAMjMMv01Jr/Xus9FYpGNeNeR6TYE+lBO5bGaGC8JH9ImOfkwPGAUrtIZ1Wg+hpEMvB
         lpP+88qHSNSUUziceIwhllJD+l9xK8UScc3c0ZZu/qCQ8EKXQKzoshX2yT67+cP9mQhP
         SlQg==
X-Gm-Message-State: AOAM531jSznD3zzRH2XwyFA8qQtfa5FoFwKKxnWh/D+25EfbI6DkmEd0
        6DQxyYv67K7Cqd4+F7ZKzOC06A==
X-Google-Smtp-Source: ABdhPJy9LlWpECdpu7YJ+PT2kLRmfK8C5xHkyZ1UgHCWtZBDrFONd8eLqdWjzuc43U9jIpJoouc7Bw==
X-Received: by 2002:adf:f445:: with SMTP id f5mr26159848wrp.339.1593592303535;
        Wed, 01 Jul 2020 01:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 17/30] misc: mic: cosm: cosm_debugfs: Demote function headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:31:05 +0100
Message-Id: <20200701083118.45744-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/mic/cosm/cosm_debugfs.c:25: warning: Function parameter or member 's' not described in 'log_buf_show'
 drivers/misc/mic/cosm/cosm_debugfs.c:25: warning: Function parameter or member 'unused' not described in 'log_buf_show'
 drivers/misc/mic/cosm/cosm_debugfs.c:78: warning: Function parameter or member 's' not described in 'force_reset_show'
 drivers/misc/mic/cosm/cosm_debugfs.c:78: warning: Function parameter or member 'pos' not described in 'force_reset_show'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/cosm/cosm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/cosm/cosm_debugfs.c b/drivers/misc/mic/cosm/cosm_debugfs.c
index 68a731fd86dee..cb55653cf1f92 100644
--- a/drivers/misc/mic/cosm/cosm_debugfs.c
+++ b/drivers/misc/mic/cosm/cosm_debugfs.c
@@ -15,7 +15,7 @@
 /* Debugfs parent dir */
 static struct dentry *cosm_dbg;
 
-/**
+/*
  * log_buf_show - Display MIC kernel log buffer
  *
  * log_buf addr/len is read from System.map by user space
@@ -68,7 +68,7 @@ static int log_buf_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(log_buf);
 
-/**
+/*
  * force_reset_show - Force MIC reset
  *
  * Invokes the force_reset COSM bus op instead of the standard reset
-- 
2.25.1

