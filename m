Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3C2020BE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 05:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbgFTDch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 23:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733096AbgFTDbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:31:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD54EC0610DF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b201so5397253pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ExlyNd4C6Vtqo5InL4xGzXnaPAWUSdxdUBoxlRz8EM=;
        b=NXIjEZzmAlY5fdC/DwXct9GYDHogfeUCrjSkTO4JXjF9UTv+cR2dEUWt3FWlTNaAHp
         ArVHLS7GaAaX0GRdppC6MVL4iulBAnXl0RDRkmjEpohR99AIp9TcfcZKNXy8KweQ5j+M
         qKbddjlMm6r/UiOtSlPQhvc966Inhn9BIPgP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ExlyNd4C6Vtqo5InL4xGzXnaPAWUSdxdUBoxlRz8EM=;
        b=ceAOZdJqirijeFgyuquu1wNkD10MxyPMZfRMUsb6AOXy2+y95mP3h0ksrJSe2nADid
         pz36g0TG4hBcyp8LDFuX5se3ce/rSYfxsLGkKnn8Ip3PyMs/5tejdhbBGMKUJMdbxBF/
         TYzAjW3cXtASoFRBhLqQ7612FeFhRcy4O1T8l7y1BEv0iiHsZB8BL9GmWTESkkYD7DBD
         1Oav8D+NFkI6RjhXSKRtpDI9tDJYKzQ4xlTcTdYx2boSlGbptJAmaZ2b6pAIZw8qtq2S
         YJT6SItcnCHmQGZq1ECxPCq3D96IKUkXzqsZ2p5IhZZ+ej46cw5TplajuQmhyha8Ao10
         dpzA==
X-Gm-Message-State: AOAM531J+SrL5LpaK14mH8Ta1zYRYLnTyqs99X9y36ylrK59oc33WD4m
        i131Jt6pN17+QAwuBqxp3KOIvA==
X-Google-Smtp-Source: ABdhPJyAJ8Da6kpj1cpdp7acRpdjHPEasdxnBrzutMhIZjw6K4AKJtCbSzx12+H3IHWiTttzpZGpTg==
X-Received: by 2002:a63:dd42:: with SMTP id g2mr5615212pgj.442.1592623825373;
        Fri, 19 Jun 2020 20:30:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n69sm7060385pjc.25.2020.06.19.20.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 11/16] media: sur40: Remove uninitialized_var() usage
Date:   Fri, 19 Jun 2020 20:30:02 -0700
Message-Id: <20200620033007.1444705-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just remove this variable since it was
actually unused:

drivers/input/touchscreen/sur40.c:459:6: warning: variable 'packet_id' set but not used [-Wunused-but-set-variable]
  459 |  u32 packet_id;
      |      ^~~~~~~~~

However, in keeping with the documentation desires outlined in commit
335abaea7a27 ("Input: sur40 - silence unnecessary noisy debug output"),
comment out the assignment instead of removing it.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Fixes: 335abaea7a27 ("Input: sur40 - silence unnecessary noisy debug output")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/input/touchscreen/sur40.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 34d31c7ec8ba..620cdd7d214a 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -456,8 +456,6 @@ static void sur40_poll(struct input_dev *input)
 {
 	struct sur40_state *sur40 = input_get_drvdata(input);
 	int result, bulk_read, need_blobs, packet_blobs, i;
-	u32 uninitialized_var(packet_id);
-
 	struct sur40_header *header = &sur40->bulk_in_buffer->header;
 	struct sur40_blob *inblob = &sur40->bulk_in_buffer->blobs[0];
 
@@ -491,7 +489,7 @@ static void sur40_poll(struct input_dev *input)
 		if (need_blobs == -1) {
 			need_blobs = le16_to_cpu(header->count);
 			dev_dbg(sur40->dev, "need %d blobs\n", need_blobs);
-			packet_id = le32_to_cpu(header->packet_id);
+			/* packet_id = le32_to_cpu(header->packet_id); */
 		}
 
 		/*
-- 
2.25.1

