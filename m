Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F82DB3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgLOSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:34:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730744AbgLOSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608057165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V0mOKUC1c9jIdmBHrE2UTrYyCPIaALN4ciYRI/jsXN4=;
        b=TzvsO85l2m6SITXAHqTbsA3sztrVTZwuA6QSLnc4s9otpnNjt5wRzGffGm9S96Na1ey/1h
        FQkcYKmJ1Q9KLfGftUazgYlq17BbiWsxZIK32dfw0fTqXsEo6fmtMLIJm6H0Ze1sKFIHhd
        RDy4CofcaWX0nNvH1u3tUvd0tJTURSw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-KXc-RTjhNiWG-vCXrRlMqg-1; Tue, 15 Dec 2020 13:32:44 -0500
X-MC-Unique: KXc-RTjhNiWG-vCXrRlMqg-1
Received: by mail-qv1-f72.google.com with SMTP id b9so14825919qvj.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0mOKUC1c9jIdmBHrE2UTrYyCPIaALN4ciYRI/jsXN4=;
        b=o4LOsXE9sCjztnymiKsrDyxX//6O94cMuAbw34b6bhogoFylvEiXE++uTCSaOcsQn/
         EnrHxo6Ico9j8AMrbOPdZamkzeSAffpON/Fqy1+Cw7IsPPE77J29GkYKFXVg1NFgtX+s
         UdXLvP7ygkBwA3bBaUbowTbHvfBRWr610wklCfEwEh26N45RlvBkwTYfCqM9SqtJl4ro
         O8oLSFIFhXY1QuQYVRGyNnFH2ZQOMXRpop/alhEZHKMqVVB2l2kFkxgP9pHtRQDv27wb
         G4gi32M9HpUxNIGwSurXSFWSZroBnY9C8ChRaG3yeiiSyfb7iBglUsRxJLYsgGodG9bI
         wlWQ==
X-Gm-Message-State: AOAM530cp/Vd0feBEGPrcDgW1uK92wQhGsTpMrDw79j0HMf+EBwQtTxQ
        PPV83CupTjNyczRUCLGpSrjHUagoKe7eX16UIbWzgNtLH9PExB6rDhzuMY6aLEiY+yMWvDz0Tma
        fXEPA4fhWOija2meHh1s+3Y9Y
X-Received: by 2002:a37:a309:: with SMTP id m9mr39408170qke.477.1608057163625;
        Tue, 15 Dec 2020 10:32:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc5XN+2gohiXP7OSbNvjdyFmfV9/NJ44oCCK6YQmcFB2K7lGIoz9MSF/0FEVZdBB17AZAOCQ==
X-Received: by 2002:a37:a309:: with SMTP id m9mr39408149qke.477.1608057163421;
        Tue, 15 Dec 2020 10:32:43 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 6sm17779099qko.3.2020.12.15.10.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:32:42 -0800 (PST)
From:   trix@redhat.com
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] hwmon: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 10:32:37 -0800
Message-Id: <20201215183237.2071770-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/hwmon/smsc47m1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index b637836b58a1..37531b5c8254 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -682,7 +682,7 @@ static int __init smsc47m1_handle_resources(unsigned short address,
 			/* Request the resources */
 			if (!devm_request_region(dev, start, len, DRVNAME)) {
 				dev_err(dev,
-					"Region 0x%hx-0x%hx already in use!\n",
+					"Region 0x%x-0x%x already in use!\n",
 					start, start + len);
 				return -EBUSY;
 			}
-- 
2.27.0

