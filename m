Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519A32A1E96
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKAOk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 09:40:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbgKAOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604241624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WUL64u8dGf0LoKnUz7lF+D+J0ocjCbe9Ay8eU/rDBJ4=;
        b=MUYiCNWVPtAryyGmrLctOHyTrWEyRdr8tRX7qtaMRkiEEVjf5CIwdCXI3Va+eWVyVIC2YA
        joiyIiVEjGxukAPboFAT1YH2J4MKf96KtBlHQpN31l+33Sh05HYWJMoMiEnSzPspUmh99v
        XiL43rOFUlHOHdN99GoKKRnczhNu4Ec=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-gbBN15EzODOLgGOR5zAjHw-1; Sun, 01 Nov 2020 09:40:22 -0500
X-MC-Unique: gbBN15EzODOLgGOR5zAjHw-1
Received: by mail-ot1-f69.google.com with SMTP id e31so26664ote.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 06:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WUL64u8dGf0LoKnUz7lF+D+J0ocjCbe9Ay8eU/rDBJ4=;
        b=fR/IWipwNc33CtCIIUbrI2YdwWIi5I6BC4+MO53GOuJqiQCmpZgnVximpWFugLUFFJ
         wqZq8hHCnhM1fUpCmouJ9pSainDmb6+GJ+CBsaxLEpnJFq0J7uuQhLmBtolPi2x9A4UI
         ub7wsA+P1yGe4ym2weq6ep6BuSVPGW18G+AOZhNv6kD1Rx5N8Up4TGzCaBw611LK+tcF
         kheYtRgSUXhTjvmN0jDqKr/aSEf9p5IwEFdd7OAM5FVKrfz96hxK9x9k1DXuEKOnllKo
         QayCBTKMJGc5SHVlGNHPK8TQc82MM1gkQFeBX2mGRVdtFg7OtV5e/yeNvsGf/RNEiENZ
         l3Gg==
X-Gm-Message-State: AOAM530ug/MgiET2WdyIU2ktrEHwGc7ZyNaD3Op5CTO7NaeWloHd91Tx
        FhpYezcWJzbIZEMdwDXZwbeQFTtP14acHfN17+xRwalvZd1tnW/ByGtFsbOa0f/fk/5Bk+42APw
        v36soCgrq7648+LWiCZQPcmFt
X-Received: by 2002:aca:ab50:: with SMTP id u77mr3838866oie.111.1604241621988;
        Sun, 01 Nov 2020 06:40:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCMM4TlP5Yz7zso7HiOmxshFFIZRjvHbAQQc7PaS/R66+AJ3PeA5xHwhc2C7I73PxclekXbQ==
X-Received: by 2002:aca:ab50:: with SMTP id u77mr3838855oie.111.1604241621808;
        Sun, 01 Nov 2020 06:40:21 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f18sm2931296otp.10.2020.11.01.06.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:40:21 -0800 (PST)
From:   trix@redhat.com
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: fcoe: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 06:40:17 -0800
Message-Id: <20201101144017.2284047-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/fcoe/fcoe.c       | 2 +-
 drivers/scsi/fcoe/fcoe_sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index a4be6f439c47..03bf49adaafe 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -2023,7 +2023,7 @@ static int fcoe_ctlr_enabled(struct fcoe_ctlr_device *cdev)
 	case FCOE_CTLR_UNUSED:
 	default:
 		return -ENOTSUPP;
-	};
+	}
 }
 
 /**
diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index ffef2c8eddc6..af658aa38fed 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -312,7 +312,7 @@ static ssize_t store_ctlr_mode(struct device *dev,
 	default:
 		LIBFCOE_SYSFS_DBG(ctlr, "Mode change not supported.\n");
 		return -ENOTSUPP;
-	};
+	}
 }
 
 static FCOE_DEVICE_ATTR(ctlr, mode, S_IRUGO | S_IWUSR,
@@ -346,7 +346,7 @@ static ssize_t store_ctlr_enabled(struct device *dev,
 		break;
 	case FCOE_CTLR_UNUSED:
 		return -ENOTSUPP;
-	};
+	}
 
 	rc = ctlr->f->set_fcoe_ctlr_enabled(ctlr);
 	if (rc)
-- 
2.18.1

