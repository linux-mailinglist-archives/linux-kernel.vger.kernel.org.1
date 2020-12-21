Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EF2DFE01
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLUQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgLUQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608567824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uiRubI3oETCvVOh+zg0XhoDMdq17a8X4QGnnA5oDaZk=;
        b=T5S9282iw6tqzDFjQw55dGbVg8UIJTZj5hGJq9eqaqJgZ+qhwB5Sf+9l9TKrbtKnSyWrOd
        fvjUtw+2xiZBvngvVjpJcrRnn+c/6PYdolIrO4oXSzywRCKFshrKG+ltPQRsN86HUwqKlA
        GRupgqPfD9KHEv9tSC9nPkPcO8nY23k=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-iB7rBKO1OpymxxbQpG6a8Q-1; Mon, 21 Dec 2020 11:23:41 -0500
X-MC-Unique: iB7rBKO1OpymxxbQpG6a8Q-1
Received: by mail-ot1-f70.google.com with SMTP id n11so5279502otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiRubI3oETCvVOh+zg0XhoDMdq17a8X4QGnnA5oDaZk=;
        b=sw+l7WoWwa9EviQi+gtINPdtshf+HcpIkUmZXGFf1iArXgeVnqZohbsoXj39D9S/UD
         urR0ekOj4Bz1dE1+KgwdtFSLOylAr4X6eLEgzoh67Z4CDBDbZ8hJcI1reLANMzK5GS5c
         TPOARlnCoQ3eKX80J8fFqZDqNU1K3T8udJhKLzlpLXq9OdcNF3BEpIp4H0SfMvj79ncL
         bHjeieZlEU973uUnrEZptqpOIrfQzC1tlVa5e3/bU4dxD01azk5vvyT3cwrWP5AWIN2X
         CUHdxB9Z3NgnPOZPfaCgafkxUO2VkKqrHl7FERwoVMJtlxHOk9YhBsDQxx6xkZRQxp2x
         41VA==
X-Gm-Message-State: AOAM530+PDhj4yboKBcwN43V4/LJjrt7cEbfIEGtVjRVDcaLz5xhz+VV
        RfumM8HHdgTvpXEm+ZGmSQoz7l6KE9myDMB6QdNgCGbrgts5QO0BbYIAfrzH3LBcWTuBLa8oMq0
        gBJACD/hSNMfK6d2qXorJrAwv
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr12898932otq.296.1608567820965;
        Mon, 21 Dec 2020 08:23:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj7yy05ARrHiu7d6hk216DQqhec4uZlxDRe8wh6EiwRslymmkvnn13c/nidGQr11Cuecka6g==
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr12898916otq.296.1608567820808;
        Mon, 21 Dec 2020 08:23:40 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r13sm3977307oti.49.2020.12.21.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:23:40 -0800 (PST)
From:   trix@redhat.com
To:     njavali@marvell.com, mrangankar@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: qedi: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:23:35 -0800
Message-Id: <20201221162335.3756353-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Attributing the function allows the compiler to more thoroughly
check the use of the function with -Wformat and similar flags.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/qedi/qedi_dbg.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index 37d084086fd4..b2c9b0a2db6a 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -78,13 +78,16 @@ struct qedi_dbg_ctx {
 #define QEDI_INFO(pdev, level, fmt, ...)	\
 		qedi_dbg_info(pdev, __func__, __LINE__, level, fmt,	\
 			      ## __VA_ARGS__)
-
+__printf(4, 5)
 void qedi_dbg_err(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		  const char *fmt, ...);
+__printf(4, 5)
 void qedi_dbg_warn(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		   const char *fmt, ...);
+__printf(4, 5)
 void qedi_dbg_notice(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		     const char *fmt, ...);
+__printf(5, 6)
 void qedi_dbg_info(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		   u32 info, const char *fmt, ...);
 
-- 
2.27.0

