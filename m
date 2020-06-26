Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1120B215
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgFZNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgFZNFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664FBC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so9483649wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNnA3JIm/nNhrY/m6pTfGCbKyGY/Dou+IuOqoFoMcwU=;
        b=B+LncNESHZGTDdwm7FjaILQLgKfvB6QamNreWe/XQU8xhaEyEgsb4U4qxv08+ixDQ/
         FnFt+RwqGrfUKnvBlql07hsVBCzE8UfjCT3v5eVekh5N4t1Bwgj3t+2SxxxU7SRQMXB0
         iTIJMUDsufjuawLt1gCRmBs/5pxHL5XViTLUT+Uo07Yz19ugnCvaoVfcFUnnLjCb4OjZ
         APmtU1Hf+9fSpX5lG6GEsXO6xskSzVK/ym1JiQDWWG5muto8+vU7oP854PneFglhTygr
         IQp8m8nacqffpUHGayeWyU3H9dsP1a2WI5Ubcvp56QpipsQYivh3t90zZIS4lEEMDq1c
         Bd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNnA3JIm/nNhrY/m6pTfGCbKyGY/Dou+IuOqoFoMcwU=;
        b=Z1kwYg6B+OiTaU3ES7yn1TWhg1tcbbW5+5Q9dioKZn+GL2GD4fkXpEmwrwG5sSt32t
         DGPB1Uun2J2FgReXIH82/aTPB4uTzJSBvNLrj+/e6NuK08TI9XUeYWnOwdYEZhSTUL0V
         inqH418weaPhnhq6DynJrvUTPmf4rZnjk1vXqLwY2GDI+kolKeMCy7Z59U48HWr/WzAY
         IWbHpfiGDOfXSr2CvLwO3ChG8rN+Svy/QyFifZ839wLQizlhczWsiiPhyHwiSSsUCAOH
         TbHt+PXef38oatzAlElHT5csF3cok0xp4jARMujmSI5Pch/CJ3bv0mGXEwejMR/e7W68
         ncSg==
X-Gm-Message-State: AOAM5329z115pNhrxB9GudrGsD5j4iJJrZpBk3ZKLWLNaDBbatMXKG/a
        xyy3VAeKGNcsQLQpgk4KUvdfzg==
X-Google-Smtp-Source: ABdhPJxBW4IPbPO5eoGMHxlvutWDO9MyQLFBGRb78I8VQ4Bim4qrRNtJrdF1lbgIHvXTS+XFhHn/sA==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr3677374wrp.412.1593176735173;
        Fri, 26 Jun 2020 06:05:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 05/10] misc: lkdtm: Always provide prototype for lkdtm_DOUBLE_FAULT()
Date:   Fri, 26 Jun 2020 14:05:20 +0100
Message-Id: <20200626130525.389469-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lkdtm_DOUBLE_FAULT() already has internal logic to handle
!CONFIG_X86_32.  Compiling out the prototype actually prevents
that logic from being useful.

Fixes the following W=1 warning:

 drivers/misc/lkdtm/bugs.c: At top level:
 drivers/misc/lkdtm/bugs.c:420:6: warning: no previous prototype for ‘lkdtm_DOUBLE_FAULT’ [-Wmissing-prototypes]
 420 | void lkdtm_DOUBLE_FAULT(void)
 | ^~~~~~~~~~~~~~~~~~

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/lkdtm/lkdtm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 601a2156a0d48..8878538b2c132 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -31,9 +31,7 @@ void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
-#ifdef CONFIG_X86_32
 void lkdtm_DOUBLE_FAULT(void);
-#endif
 void lkdtm_CORRUPT_PAC(void);
 
 /* lkdtm_heap.c */
-- 
2.25.1

