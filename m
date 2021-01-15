Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F12F89A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbhAOX4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbhAOX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610754879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xawz1GzWGC1J4p8x9iOjgOkyB6zixvv0cO2ZY7wH17o=;
        b=XKn7T2AmvziQQegeYwlYov1HuzDiyPIfygoIHOTULc/1TVYWuOW7m7M2/tuywfQD1t+cZI
        uoebMJxtmig2soOXI1iUZvZ7Dc4dqw9+f30EoVKHWN05XGU8ufRjz5YNTD7BQQQo4km+Xx
        rhDGLpW/i5zOcxBsqDK2XxsexK8hiTw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-OL3HAvJ5P5y0trOReUlcnw-1; Fri, 15 Jan 2021 18:54:36 -0500
X-MC-Unique: OL3HAvJ5P5y0trOReUlcnw-1
Received: by mail-qt1-f198.google.com with SMTP id h7so8762239qtn.21
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xawz1GzWGC1J4p8x9iOjgOkyB6zixvv0cO2ZY7wH17o=;
        b=t2N5RgEwRu6rxG4u8oZL46XvOzc/Ngjx3GKTN77TcVOk8nQeHXhHK0rAzyqS1ihsxT
         BcWHrUxqz/Fi/qs5/kwa3CRAhH5tclnP/3/Vq/S1qalsJD4JpGLkMJA6B+gI/vspzZPb
         lvOvSmBYz4NYXAMN4tyTesEnnszAhgezrjlBROCxKeDgtrSw/YGdfTgDtfFYJlkDaB5h
         5TrvnhRUv9+Ybef0gImRk+1nL7AdixBduAaKOQCrNU+Yyp84wePQxQQYSHOp+9ETsruZ
         3dteZC8wRbc6eLufsanty3GEFWgM0FwgYtyxTKS3kHYsvCPtYYirMqw1oiYPynDIkvtZ
         eY8A==
X-Gm-Message-State: AOAM533/DNbpTpn9lQcVWQ/BvLNCpv2dBZYA8dEmpYSiTplXPd7rd6rZ
        gO+2fYTCi8Iz6SdvgZOgAm0WkzPhTxlwqE8yWNMyZpThtykyJ6/IIUpWik+PGTicIEOT8ApFbE3
        sqDL/D+oCvF/z/UwpsQLUKBiP
X-Received: by 2002:a05:620a:909:: with SMTP id v9mr14767206qkv.435.1610754875422;
        Fri, 15 Jan 2021 15:54:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL7HYfnpoQgMUFZrafizcBstrGYOj0LBXF3RrdaUC8jM693qzhueNKRgKGV+rcmkOvoMB3YQ==
X-Received: by 2002:a05:620a:909:: with SMTP id v9mr14767193qkv.435.1610754875276;
        Fri, 15 Jan 2021 15:54:35 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p15sm6111790qke.11.2021.01.15.15.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 15:54:34 -0800 (PST)
From:   trix@redhat.com
To:     a.hajda@samsung.com, mchehab@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] [media] s5p-mfc: remove definition of DEBUG
Date:   Fri, 15 Jan 2021 15:54:26 -0800
Message-Id: <20210115235426.290001-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_debug.h b/drivers/media/platform/s5p-mfc/s5p_mfc_debug.h
index 752bbe4fe48e..e7e696c08081 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_debug.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_debug.h
@@ -12,8 +12,6 @@
 #ifndef S5P_MFC_DEBUG_H_
 #define S5P_MFC_DEBUG_H_
 
-#define DEBUG
-
 #ifdef DEBUG
 extern int mfc_debug_level;
 
-- 
2.27.0

