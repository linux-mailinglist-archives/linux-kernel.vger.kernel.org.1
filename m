Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2BB254F67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 21:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgH0Tww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 15:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgH0Twu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:52:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF51C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:52:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w20so7168860iom.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fIqWlMBbgKgUZW+HB8etDtKQeLffAbAjf8iY4VxAZag=;
        b=EuPx8TyBG4bYxErvqUCUVFJiqwUgxZcKPXyVPxd+CyMWl5ib4E3/0iaYIcXGzsArGn
         iBfFSwOhaynbxXystbjE2m0IAfzR649Pv8j45rW3aJg8v3/yaktcZZPEFw8FPTI5nTIr
         c1w4dCCG4sOKT8nsTS8Gihdn4e+9klHeiSkXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fIqWlMBbgKgUZW+HB8etDtKQeLffAbAjf8iY4VxAZag=;
        b=ZtWZvYw7Qzr1f5546ugDs8NVyVE/yhVro8aXG8PXPMwzR8xt3ovKJxMXJkGOpmvPnk
         IXbs4Wn9jREpilobx1nN3pPoDySZYIzwS3T8OYguwXUacdQb1w/8hgk4w/s4tbCfDYgT
         xDPjpzmSYIYBk0OAsnl6xPaj2zczFiZ4BrS2sT9u3XPJVI0tMqm2hqjxaDNvg7ytSQIO
         47Nyv5n+8NL9LcTf2u91lj7GWgnMogzd1xonhxUQiy4JoEtvFeHaKOBPvHYVZJD8LrQS
         KUin/ksq6n58vkvL+A2KlZKPUdUi9E3H6OKBou8uw7l+QtQOxZCnvx+wW1nXBdRUM8Dx
         V6cQ==
X-Gm-Message-State: AOAM531otPogPZ2VsFZbc9QHl2WfNSXiXCbnWtJTMcCRLl/1Dr/FZzbH
        cgZgWgB9L94/p/d5GsLjMS2WBg==
X-Google-Smtp-Source: ABdhPJzhubCDa6AAuurccePp5pH9tvFbrx+5wirCv5ldX4LxqAbDK+mm9OfqtnsZKuE4ZQuYfZWnuw==
X-Received: by 2002:a5d:80cb:: with SMTP id h11mr18210363ior.189.1598557969816;
        Thu, 27 Aug 2020 12:52:49 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id t90sm1664808ill.50.2020.08.27.12.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:52:49 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, Shirish.S@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: i8042 - Lock i8042_mutex before flushing
Date:   Thu, 27 Aug 2020 13:52:23 -0600
Message-Id: <20200827135205.2.I1417edfd3526143f14fea2546787ba4bb6f32ae8@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200827135205.1.I6981f9a9f0c12e60f8038f3b574184f8ffc1b9b5@changeid>
References: <20200827135205.1.I6981f9a9f0c12e60f8038f3b574184f8ffc1b9b5@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make i8042_flush lock the i8042_mutex before flushing the buffer. This
will prevent i8042_flush from clearing the buffer while a PS/2 command is
in progress. I'm not sure if this is really possible. We already
hold the lock when calling i8042_command, so this makes i8042_flush have
the same behavior.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/input/serio/i8042.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 8590e51bcc087..b693154641500 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -254,6 +254,8 @@ static int i8042_flush(void)
 	int count = 0;
 	int retval = 0;
 
+	mutex_lock(&i8042_mutex);
+
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	while ((str = i8042_read_status()) & I8042_STR_OBF) {
@@ -270,6 +272,8 @@ static int i8042_flush(void)
 
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
+	mutex_unlock(&i8042_mutex);
+
 	return retval;
 }
 
-- 
2.28.0.297.g1956fa8f8d-goog

