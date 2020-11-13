Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB242B23C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKMS1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKMS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:27:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10031C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:27:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w4so11665027ybq.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=xdF5VExq/IBWGsj2OEHUNluwUzzlJmZ8MV9WRDo+8nE=;
        b=vFIPLkCaqwKSBguafVn6m1/I+5QrOZPDGtj/UkUiZfs3xbc1XEp8UDUFXRqeTwf7ia
         C0LHCIOHkJZ5k0yCyanXd0vKgH/fPGcoYAnvm7jv/6PIyL1FgjZ8X3jLzvNOX3+PEvuw
         5LC8TKb5yf59dIDK+1uDBdYENHicNa3zw6L+DzDJQLY/P7B3QcQTxyf3lNEGiUqg7kn0
         vksgztLnnFSDwCEW3vvyPPL0Hi5NdIxoiozPUeCuaU5avftQywTt+PCxSsXQPafiAQrH
         RHrH3Ay2PKHKDkPr3xqdUg4UgiKhwoDKeWKkvVP+YwZRNk0ygyho+ZHA0DDPe9eN/3Xs
         KOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=xdF5VExq/IBWGsj2OEHUNluwUzzlJmZ8MV9WRDo+8nE=;
        b=FG2MJNp8czBMWvBoHZU62USBkT25Mp+pTuP1Zu7ChxTW+7YTu4nMJiR6kt4Y6VNxfq
         j24pWo5p5106qlBCPijPxZyYMufhwFY1OxkWPeWPyrMp5MWJSXr8I2lzql7M/3mJDxrL
         6+c94nqVq2o6pzMrFcQ3S9EY5il0TJXWO483eYWHFUlyBnw9qSRn3tTK8kKFU70cRmrK
         ibCsd+gdEiEux+bIfroe/fm6BBOr2w/Zqd9PzV9dQeqEv77NHbgOi1j5yrjLjULmOr6H
         W39ZgBCdROkYZ0LPD/VJWHgWofcsdDBtZlis/TEXZZoBoCW+sicihOQU6gONatsYIcUF
         c3CA==
X-Gm-Message-State: AOAM533wtA0eMOLce+m1zY2ij+Oha/K/d1+tIjdkW8a7oOprceJ+jd2n
        O9fQ4GOIWpTPrc3Bf0MtwiVUQU6oS80WdnuHFXc=
X-Google-Smtp-Source: ABdhPJwWoewcmHHjSS240pc3RuOvn1E8zFNJX/2yJW4FRrHjCDV3yYzamaoh0ImL6L1+JS7BgYSrnVtws1rUUKKTPF8=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:6903:: with SMTP id
 e3mr4860426ybc.295.1605292025213; Fri, 13 Nov 2020 10:27:05 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:26:54 -0800
Message-Id: <20201113182654.967462-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] x86/e820: fix the function type for e820__mapped_all
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e820__mapped_all is passed as a callback to is_mmconf_reserved, which
expects a function of type:

  typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);

This trips indirect call checking with Clang's Control-Flow Integrity
(CFI). Change the last argument from enum e820_type to unsigned to fix
the type mismatch.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/e820/api.h | 2 +-
 arch/x86/kernel/e820.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..e872a796619d 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -12,7 +12,7 @@ extern unsigned long pci_mem_start;
 
 extern bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type);
 extern bool e820__mapped_any(u64 start, u64 end, enum e820_type type);
-extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
+extern bool e820__mapped_all(u64 start, u64 end, unsigned type);
 
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 22aad412f965..9f6a4e9bca4c 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -145,7 +145,7 @@ static struct e820_entry *__e820__mapped_all(u64 start, u64 end,
 /*
  * This function checks if the entire range <start,end> is mapped with type.
  */
-bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
+bool __init e820__mapped_all(u64 start, u64 end, unsigned type)
 {
 	return __e820__mapped_all(start, end, type);
 }

base-commit: 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
-- 
2.29.2.299.gdc1121823c-goog

