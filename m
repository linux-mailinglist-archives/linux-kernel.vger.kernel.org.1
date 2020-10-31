Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A07E2A182E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 15:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgJaOcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 10:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727867AbgJaOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 10:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604154755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kXhWCs+9zTxQOtjMQhFpoy8/ajJEfbXQIJVQiZvQ8/I=;
        b=Tx8b+5pQhfMc1HBWyg5+N/LLY7EXbzs5+ikqrgHB8P1eoK1qejlml0HV7rL6dk/Wnz1a9a
        KsM2AY9N6+Gf1jw3zjHyhQWvWR4l0J1wM4o0p3Y88Fb+zepeVPh55nlhLFmWGI5/Cq06QS
        hvLiAvFD4Sq0VnvdSq76pxHgNZiXT9M=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-VTTfGXKmOgeyL94r1668mA-1; Sat, 31 Oct 2020 10:32:33 -0400
X-MC-Unique: VTTfGXKmOgeyL94r1668mA-1
Received: by mail-ot1-f71.google.com with SMTP id t19so3833548otc.17
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kXhWCs+9zTxQOtjMQhFpoy8/ajJEfbXQIJVQiZvQ8/I=;
        b=az3xgL7Sbl9rWzgcrDlpHFNs4OqZq5thfr/tKsVQZcSN0OPmR3Rq7vaqtyrsnCW9mR
         qeGBQXlUvOxVR61uyzE+xvJXE5dhOwi55GzrcLiLx4voO04tfHYoUwRg0KBHnH34Us+B
         Z1wOQYBTCbBXsPlIuaxJJ8ImoEoEnpa8EcNu8BbPGfuhTBZYsbL+agXrW82C3f0THShf
         eSHn4kzmR3YPT8Kwcqtx/IxD2UB84fFd9lAmRf5IlXCeIvuW5BP8lv9u0vR1Yj0YkoM/
         ldL1I+/0IzyPLfWwvT72DkUtmjlUrA4MLbG3sFQsSbvrf1FduYzJH+habbsDe83RTmtk
         +rFw==
X-Gm-Message-State: AOAM532qwf0eS2emKforqqvO2N4Ejvqglt88h4wjMUHnFVmKkb0/29vh
        +OWahppxtfiqddE+qgHr/DHcl9hIXcjp005HK2/wj6bYxVMgKjkJ1GBtJQljcdUCjCosqUqsGX9
        /NkueClvK3C5V6c56GoEOZi1/
X-Received: by 2002:a05:6830:1aec:: with SMTP id c12mr667576otd.227.1604154752578;
        Sat, 31 Oct 2020 07:32:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKiIuRbRN83Tb6qDHPgyWarXgxFwjkCtR5kHtfbTSGqRlv64HJXLQdCfxXXgNaW5jzglE5kg==
X-Received: by 2002:a05:6830:1aec:: with SMTP id c12mr667559otd.227.1604154752425;
        Sat, 31 Oct 2020 07:32:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a23sm2107606oot.33.2020.10.31.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 07:32:31 -0700 (PDT)
From:   trix@redhat.com
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: mic: cosm: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 07:32:15 -0700
Message-Id: <20201031143215.2140843-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/mic/cosm/cosm_scif_server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/cosm/cosm_scif_server.c b/drivers/misc/mic/cosm/cosm_scif_server.c
index 7baec9fd8756..d6e43d42f3d1 100644
--- a/drivers/misc/mic/cosm/cosm_scif_server.c
+++ b/drivers/misc/mic/cosm/cosm_scif_server.c
@@ -114,7 +114,7 @@ static void cosm_shutdown_status_int(struct cosm_device *cdev,
 		dev_err(&cdev->dev, "%s %d Unexpected shutdown_status %d\n",
 			__func__, __LINE__, shutdown_status);
 		return;
-	};
+	}
 	cdev->shutdown_status_int = shutdown_status;
 	cdev->heartbeat_watchdog_enable = false;
 
-- 
2.18.1

