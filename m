Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF42FAC87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394614AbhARVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:22:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394599AbhARVVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 16:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611004804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dnnhtVflN2ojM9kAenMCIB7Y4XJh/WZ4WZYOBwFIU+E=;
        b=TciDN/WU63V6D9qku56XA+SkStAOD7+UF2Zn2+Jw34FhsCRWns4+WGGbC26FF5LV1HOKvt
        L0pe1F8ZFV7whnycnQaV8q0+jrNvrCaKyo1FgBD77GPgw+h0G3dHr9vVO9PUaSKMMn5x3s
        ADgi2qVQrleGzu8/iIL3G5EbStD5Yf8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-xkwzEDOYOSOtPr23A6VGdw-1; Mon, 18 Jan 2021 16:20:02 -0500
X-MC-Unique: xkwzEDOYOSOtPr23A6VGdw-1
Received: by mail-qv1-f69.google.com with SMTP id h1so17617336qvr.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnnhtVflN2ojM9kAenMCIB7Y4XJh/WZ4WZYOBwFIU+E=;
        b=ZbNvaQry4feadVDl1EkXArGXq0z2k+r2wli/wBxfaAsEcANrd9zSTM9XS9UzK4Yg2H
         +SJm/kTimMwo4Yo8E0201Da0Y5AzihYJnSKiIK1PzUwQ4GQkZVo6g+HyqY23L+pGGSS+
         2SulprINSBi42ceAKj6FYPH+gbvTaHcKK8wirpVBwzcPerHwNok7sEGVaI9ViyDc8qBu
         OejGwefHekzb3C7kmHH+cOd6VB4j/vGs80AORzW9xWjnZZjwTULfm1LMh0AGdYBB33H4
         VPUUCwlNGM135NW10MxA74+zX+Pp+vTxEVWpo5ziBOlVFkAvBO4QfyqP4DStxnnXtmqU
         CjKQ==
X-Gm-Message-State: AOAM5314rmZkKiztWCf4RZbV/Z2ZswdD94cwMDGmJiyfUGAEqJk5+QDK
        9g64JmdiiP4Ibtxw1qJ/VVRX+hunu5HBFK7XmWNMJd6J4qJT4l6ND7NVgSFhnCZSzh4esF5xXsd
        4C1yUkph6BuTQRGfP81X16r8J
X-Received: by 2002:a37:c49:: with SMTP id 70mr1486842qkm.365.1611004802174;
        Mon, 18 Jan 2021 13:20:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzte4H9mRqboR6tvo97B8zSYHvEzDIzcKIOMw+wkTZvDCOqn4qqBKdtPpcbud8KDlh6nVhWJg==
X-Received: by 2002:a37:c49:: with SMTP id 70mr1486822qkm.365.1611004801903;
        Mon, 18 Jan 2021 13:20:01 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q20sm11484209qkj.49.2021.01.18.13.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 13:20:01 -0800 (PST)
From:   trix@redhat.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] clocksource: mxs_timer: add missing semicolon when DEBUG is defined
Date:   Mon, 18 Jan 2021 13:19:55 -0800
Message-Id: <20210118211955.763609-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When DEBUG is defined this error occurs

drivers/clocksource/mxs_timer.c:138:1: error:
  expected ‘;’ before ‘}’ token

The preceding statement needs a semicolon.
Replace pr_info() with pr_debug() and remove the unneeded ifdef.

Fixes: eb8703e2ef7c ("clockevents/drivers/mxs: Migrate to new 'set-state' interface")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v1: replace pr_info() with pr_debug()
---
 drivers/clocksource/mxs_timer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index bc96a4cbf26c..e52e12d27d2a 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -131,10 +131,7 @@ static void mxs_irq_clear(char *state)
 
 	/* Clear pending interrupt */
 	timrot_irq_acknowledge();
-
-#ifdef DEBUG
-	pr_info("%s: changing mode to %s\n", __func__, state)
-#endif /* DEBUG */
+	pr_debug("%s: changing mode to %s\n", __func__, state);
 }
 
 static int mxs_shutdown(struct clock_event_device *evt)
-- 
2.27.0

