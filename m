Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665762C6E2D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgK1B2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 20:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730301AbgK0UA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606507201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=YX3PDhvRE+VeqHxgvNMZolM1FSVvjpNDz5RKUJDXUSA=;
        b=LlZqlmABA1q82dCq/khbm37uWlCtUOmt3ARIWTMsLjoOIYZL7kWiCxYsD/ZQ6yWsBvbqBV
        6blz9K8RTvp0/0yZaSrg9qaWHIRraHlwnSR32DdyFbaYxPoTZrFfeWThiYjOLJxlVU8MMR
        4JkivsBcyV/UCpTrmVGKM9dbP3tvCck=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552--1wYClAVNuaVf5Ur1Ii2Vg-1; Fri, 27 Nov 2020 14:21:56 -0500
X-MC-Unique: -1wYClAVNuaVf5Ur1Ii2Vg-1
Received: by mail-qv1-f72.google.com with SMTP id e13so3559449qvl.19
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YX3PDhvRE+VeqHxgvNMZolM1FSVvjpNDz5RKUJDXUSA=;
        b=kaeUV+zGUHSw5Q7pDqg6o0KuoeBL7nx61vU4sS+1eCNtXqFvEPvdf/HB1Zn0R+8NNR
         NBH9fOtllUP76UqzC+3tiPmp+Fj1xQ08ha4X4GWdvE3WM9kxVqBdfksBDP9rQeKGFMk/
         awHvAW+M6HmuLOrBWcJ/6OHt4hTmEcLKvVRVx+Rv4nzhbT/JOt40V9apR0XEBepaj9KW
         uec0W6T8zBgJNygRvwZRAabfTrh4aB/WjRz8guu79YDA6yjpPMxFnCac+XmMP/rwvhUi
         ILnhZO5FxeTT/al8n+NQSA4yafZMPRK7d6BCYhjrIoGDchuqaP6W7oNnM40mXYVCsVAi
         3+WQ==
X-Gm-Message-State: AOAM531+SrPusBaPvU8umraMZSOGubedYcgqymrgRJAeL4dJj01cpXhP
        PSS+r6j1lo0U+5OZsCBRQzz1/TJXwUZUXtmshKsssVZsTXpHsdPkTd8QsN4CEAI4yNr5Ts8tn7o
        XHpY0bBuL1HkfkDJDLMZ3spBL
X-Received: by 2002:a05:622a:291:: with SMTP id z17mr9764528qtw.180.1606504915965;
        Fri, 27 Nov 2020 11:21:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTjd3+sc/rOOK9IGazo/f+VSMO0SUNnoM4vNPL9Qx06yg0Cqm4w4a1MKDCHKvLsCni1m5cUA==
X-Received: by 2002:a05:622a:291:: with SMTP id z17mr9764514qtw.180.1606504915784;
        Fri, 27 Nov 2020 11:21:55 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z19sm6946111qtu.51.2020.11.27.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:21:55 -0800 (PST)
From:   trix@redhat.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:21:49 -0800
Message-Id: <20201127192149.2859789-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/scsi/scsi_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 6dffa8555a39..f6221c006aa7 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -25,7 +25,7 @@ struct scsi_driver {
 
 extern int scsi_register_driver(struct device_driver *);
 #define scsi_unregister_driver(drv) \
-	driver_unregister(drv);
+	driver_unregister(drv)
 
 extern int scsi_register_interface(struct class_interface *);
 #define scsi_unregister_interface(intf) \
-- 
2.18.4

