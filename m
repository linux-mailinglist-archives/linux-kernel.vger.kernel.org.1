Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC902C8F84
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgK3U4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:56:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730142AbgK3U4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606769719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/ZAwvZtDYmNBQEeHwjGA++LouPQPRyxXm/Ha/6ZWHhA=;
        b=JBVBbM3TuLeuX80rBUB9ZCybIVpl7mlUdYbyqTonwELF3CP9svFGprTPtvCq970XiHiXj0
        8xEFmIEVM9+2FjhHOqElM4MnDTCDDBWfzbqldST0MzG1JZ16dvhpDNQjwi9Yfwy+NDWPiv
        x5OMO+qyiFO330xC3ra1Wx+uTsicTkk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-9LYgIOd-MCekWE_-RkBBCg-1; Mon, 30 Nov 2020 15:55:16 -0500
X-MC-Unique: 9LYgIOd-MCekWE_-RkBBCg-1
Received: by mail-qv1-f71.google.com with SMTP id f2so5395165qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ZAwvZtDYmNBQEeHwjGA++LouPQPRyxXm/Ha/6ZWHhA=;
        b=g6drm0HkpBybVRHXY0X5oyxrZVAXE8bELpXrgvesG/nUbbhfv5kiM27w4IzXJP29Oe
         NHxZYIVCkeECjGC0XLZoG3lYj+CXPKtc7BneiLdCFQ/cfG5W8y9OZ2Ks7DuhHq1ZnP/o
         h+wajgum/72sXED9wVGJiYBM1vheNDgFEx4nY44pmBhwPnmrwdTN2x3hd6iddGGTm3Kc
         hmhJ9WqH8a/KpSmKApB+S4llxSNgE7PqFEn3iH6cDfOPD+pAuV4Xyti2usPrQwSuZmAs
         O0xNsnqz83mmBcqse5lUs+SMpVXuUCZ8vOKgobMAEI7DO5hkXO7h+t9UrkYB70UBKpbV
         Iq3w==
X-Gm-Message-State: AOAM531qwelpecS6uUt02MbvE0b0k+Pik08An5oKWBYUTWnWKDGh+TIO
        4Phs+DV67cpFBXbRnj+8+tbtSKOKioJaYVteiigDIuB3FMu5EJ+ikzp8vBnFwuvO351nL62qPRY
        isGyUlT7x4dAYPLsw0fB2tGo4
X-Received: by 2002:a05:620a:16cd:: with SMTP id a13mr7120033qkn.11.1606769716068;
        Mon, 30 Nov 2020 12:55:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/UdhwRv7V20I5LgOaUh7kjrCLd1h/h9sMAUjhfrnNHqyBTazMGwFil5wCxl6j8kugPGe+hw==
X-Received: by 2002:a05:620a:16cd:: with SMTP id a13mr7120016qkn.11.1606769715886;
        Mon, 30 Nov 2020 12:55:15 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p48sm18251568qtp.67.2020.11.30.12.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 12:55:15 -0800 (PST)
From:   trix@redhat.com
To:     njavali@marvell.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] scsi: qla2xxx: remove trailing semicolon in macro definition
Date:   Mon, 30 Nov 2020 12:55:09 -0800
Message-Id: <20201130205509.3447316-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.
Remove unneeded escaped newline.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: remove unneeded escaped newline
---
 drivers/scsi/qla2xxx/qla_def.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index ed9b10f8537d..6248e528efe5 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4970,8 +4970,7 @@ struct secure_flash_update_block_pk {
 } while (0)
 
 #define QLA_QPAIR_MARK_NOT_BUSY(__qpair)		\
-	atomic_dec(&__qpair->ref_count);		\
-
+	atomic_dec(&__qpair->ref_count)
 
 #define QLA_ENA_CONF(_ha) {\
     int i;\
-- 
2.18.4

