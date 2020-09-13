Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8C2680E8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 21:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIMTCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 15:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbgIMTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 15:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600023731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=F8whIUgMp1lvGf/GWEweUfRdukW6LYYiX1ca+Djnia4=;
        b=Chlw4glww2F4QoIPR1LPFfxOi61YBDYtpg4L/Ny1+dUgf5mPJky+bb/ZmjufGF0tweO+NS
        rO8fdPDitjnQL//zxE37vSF2yydFAoPU3tGk1CuvlYyLaQKlrrQXnZGfjojxubmEN0eiJE
        Ub3xhlQhRr4KoeHl0QPfXb9+g/0grNc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-_GvuoGE6O5aq6ri0mzRM3A-1; Sun, 13 Sep 2020 15:02:09 -0400
X-MC-Unique: _GvuoGE6O5aq6ri0mzRM3A-1
Received: by mail-qv1-f71.google.com with SMTP id w32so3686425qvw.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 12:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F8whIUgMp1lvGf/GWEweUfRdukW6LYYiX1ca+Djnia4=;
        b=SJW3YGIvSJIj6c0ZB7L454KY2YRyisqwVh/CFALkYPTON/NsVjgM1dHczSBPecoqA4
         yrbYugLoUcsQ3PUeKY5ZX81QtQeaehL1XZh9Q42jvXg1DBkd355QC5NDIrCgAAkIF1yY
         kT8R2r2mUT16EPo6SF0DfHgVp8tl/jGp0n5Dk+EZOSfqrTfLugiIFcGLzbEcp8LbizRs
         VdKJ7NIExSt6RCnFPRYUJizwdvhVAuYJWM/CljuY4WSvhGbeJFTK0a1fKuF9wrBaGeq1
         OHByCeKorIUw8WgBG6dQYUjkBZPPof2N9yuMqnPSkJ4ohAdCO5e+DUrF2LBUB0dQM0HO
         nD5A==
X-Gm-Message-State: AOAM533iFDJsLBzKXS3CGChwM9u3tj6CZrOTbGX2H8rJtwIue2FI/M4P
        HqPmpX0q9ym2qNJVwq1yYXBOJuyO5r8Y8DPNng28XYfSS0FkTO8rAIburbRyyBflJyBHN76Sviy
        6Uh3WIk4H6hg82+hFJMq/OkL3
X-Received: by 2002:a37:a712:: with SMTP id q18mr9291037qke.428.1600023729000;
        Sun, 13 Sep 2020 12:02:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl3SCpA4CYaZI45tebrp4s5fvkg4CmyqPUIZ9fKX8iY36eLoGjn6Cbp912F6ErRHj9/xwbEA==
X-Received: by 2002:a37:a712:: with SMTP id q18mr9291014qke.428.1600023728751;
        Sun, 13 Sep 2020 12:02:08 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g19sm11583013qka.84.2020.09.13.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 12:02:08 -0700 (PDT)
From:   trix@redhat.com
To:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        len.brown@intel.com
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: initialize tp_nvram_state variable
Date:   Sun, 13 Sep 2020 12:02:03 -0700
Message-Id: <20200913190203.22238-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this represenative problem
thinkpad_acpi.c:2523:7: warning: Branch condition evaluates
  to a garbage value
                if (!oldn->mute ||
                    ^~~~~~~~~~~

In hotkey_kthread() mute is conditionally set by hotkey_read_nvram()
but unconditionally checked by hotkey_compare_and_issue_event().
So the tp_nvram_state variable s[2] needs to be initialized.

Fixes: 01e88f25985d ("ACPI: thinkpad-acpi: add CMOS NVRAM polling for hot keys (v9)")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 47925c319d7b..24da8b6872f2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2573,7 +2573,7 @@ static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
  */
 static int hotkey_kthread(void *data)
 {
-	struct tp_nvram_state s[2];
+	struct tp_nvram_state s[2] = { 0 };
 	u32 poll_mask, event_mask;
 	unsigned int si, so;
 	unsigned long t;
-- 
2.18.1

