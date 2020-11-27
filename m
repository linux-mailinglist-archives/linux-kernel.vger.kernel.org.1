Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCC2C6B95
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgK0S1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgK0S1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606501668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ivVfcziFHnEvcS5Bte7luvrxRDQJe1ZJdM0WYQjDTTA=;
        b=NM9igEviGoRRu/M5b2Z16gStmwis1XI83RiAKNV+GakK8JgnjuiS++rXvSgQVtF8kvKkvu
        YqX33Uq2fdFqBRVF2IaHuNs1xcYoIvDeeVJkMQtR0pC/HmahOT/fpd6ZRek5ByU7nmUlk4
        HgpMiwZtXCqJeHWr9YtHRIicP9tWJGw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-Q0EETJuXOSC5Dok5ys8luw-1; Fri, 27 Nov 2020 13:27:47 -0500
X-MC-Unique: Q0EETJuXOSC5Dok5ys8luw-1
Received: by mail-qv1-f72.google.com with SMTP id m45so3488385qvg.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ivVfcziFHnEvcS5Bte7luvrxRDQJe1ZJdM0WYQjDTTA=;
        b=gP0L81UN4Bz3pmDtNjiK1/teWm6LWVkTujRRwgPeF9gP0xxBa3wjgKIwdMu4futJYu
         ND54OMhrABVS8In/JzKJpSCBXIKjiTgrrG9b/b8YZL7hzUv5Kww/Vs+7J5UkJB9Sdxpn
         D/QZgqyx4EElGLO7bAxU7Od8YhPQzxlWAfG4i4xHeMK7DAqxPSHvU6SxZQ05zei+/8tp
         YyPM3y+Nb+GdunDtqKQ+tSWfmwMuXj6ofZrD6JcxGhPZStr7Nk32zb9eLeq642ybeEKv
         sSHgBdyJeuagGVG9nwV2afJwKfEXyIdgxdFa1j9bVmWui7d7YhTNxzPThXhXgIxMUwSC
         uYcA==
X-Gm-Message-State: AOAM5323btAZKq7C+FEn2scVXYp457bdNf7bg616IPPZCfFTks+9Qz3i
        U1B9XNxFul4sG8nfphMn43DUWzFPJ+QEP68NCyu6KqPdYHBejxrLC0gSZgcrLTSmLj327luSEqc
        JOEgoEPiWqDoAGwZjKEX57ZYe
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr9236311qvt.46.1606501666756;
        Fri, 27 Nov 2020 10:27:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5LBFW1XYMsGNH49WE9w7zTVsK3Xp4ZMYlvm2rn00CcrHZZTtmkUgDFpLEqHTZigDkV/pjzA==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr9236303qvt.46.1606501666568;
        Fri, 27 Nov 2020 10:27:46 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p73sm6497879qka.79.2020.11.27.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:27:45 -0800 (PST)
From:   trix@redhat.com
To:     njavali@marvell.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: qla2xxx: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 10:27:41 -0800
Message-Id: <20201127182741.2801597-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/qla2xxx/qla_def.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index ed9b10f8537d..86d249551b2d 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4970,7 +4970,7 @@ struct secure_flash_update_block_pk {
 } while (0)
 
 #define QLA_QPAIR_MARK_NOT_BUSY(__qpair)		\
-	atomic_dec(&__qpair->ref_count);		\
+	atomic_dec(&__qpair->ref_count)		\
 
 
 #define QLA_ENA_CONF(_ha) {\
-- 
2.18.4

