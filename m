Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7392A17F9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgJaNs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727633AbgJaNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604152106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=koqxXVI3CHRUKXsDex4SfEdQYS8NkBCLBnUpSAjG+sY=;
        b=KqYy1OUihDfcytXJQbwS3mCiCPUfF9PdC+sZZVUINdyEZBRWJcYdbQS6vgIJs7oH0IsH2/
        CMk4sizaKIDhE1NASy6vvNIoOClB3faX99DW48M5CcWu/78wyWnwgaCS0WFGDTY3q9lgbw
        eD8IIuw5XEY08Yirol3glQvlfGpx8cA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-oe1sa5svMlaGNK4zs2Bx_g-1; Sat, 31 Oct 2020 09:48:24 -0400
X-MC-Unique: oe1sa5svMlaGNK4zs2Bx_g-1
Received: by mail-oi1-f198.google.com with SMTP id w192so3778007oie.20
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 06:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=koqxXVI3CHRUKXsDex4SfEdQYS8NkBCLBnUpSAjG+sY=;
        b=argTFSdvVp41w1sBKqaDcSw8P3QLCpzKxUzLO4enp83PhojLca0/0tNl3Fi3p2D6X5
         Kl8vSDkalSRiqtAwrOuNMkepCEqWAoSZButrxfmTKaaCyxPVtORk7bPnMgYnDILPJehN
         GkY18X3YB57Jp5t+zTtoTdMJLzS0netTVgYuqh27owKOxWk3BoXGMtEksgLiucyoTyVS
         aZpWzB4KVCaLKMSdiWD5GHtW7GIzZxTYb/7c2FE3IJMWu3Ncywf8NxsU8MfDGiUfN0KG
         y3R8gzQrdjmwJNBU41Gx8D2vd06oXiy00gbfOJTTWW3P4ncsS9b8ZBK5oHttR6vN25Ba
         WNsA==
X-Gm-Message-State: AOAM533U5pSPfvfYLaqP8HRYS+CsG9QUbhzUdpsIPbF1faw4SR4r58Z8
        9iczrWubsbAMZ64F+j0jKNwd137fLG4RyVM/nU/eoUSH3QPZVzoSwOAg3qfwET284xjMwxf0jpo
        7G0DEFsLPXnZ3e/xacplqo2u6
X-Received: by 2002:aca:ef06:: with SMTP id n6mr3963810oih.173.1604152103470;
        Sat, 31 Oct 2020 06:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjCMbRXrdCYsKD15lUL6wntOAje2yEwKUXm9Q2bku2WeEsh3eA9hPN7AjaxlYjNcTZpy6TuQ==
X-Received: by 2002:aca:ef06:: with SMTP id n6mr3963801oih.173.1604152103349;
        Sat, 31 Oct 2020 06:48:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d22sm2094299oij.53.2020.10.31.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:48:22 -0700 (PDT)
From:   trix@redhat.com
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] memstick: mspro_block: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:48:18 -0700
Message-Id: <20201031134818.2135446-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/memstick/core/mspro_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index cd6b8d4f2335..afb892e7ffc6 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
 		return "attr_devinfo";
 	default:
 		return NULL;
-	};
+	}
 }
 
 typedef ssize_t (*sysfs_show_t)(struct device *dev,
-- 
2.18.1

