Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9639292E44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgJSTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730464AbgJSTQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603134997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=dzHVJ8vOAW33NYg2J2jFUIdaBUTLIuMa9pZOA05Ophk=;
        b=E88nDpWPJMBKRgEcbidGWsU9wiLRvOoCqHKUkX8xfgZlyEcunULiKGkEiHwX88vOlyKC/y
        09HipevfQiPNIEyLBthae5LdbUg9gaHTA7kcwPbV+H5j/rlGs9P5QX7lC3Sm+NvNR6DC1n
        +LbykSYuOzFvENSYU0eimm1XFy6HT3E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-knO-4CtWP0WBtqTR4b4aUQ-1; Mon, 19 Oct 2020 15:16:36 -0400
X-MC-Unique: knO-4CtWP0WBtqTR4b4aUQ-1
Received: by mail-qv1-f71.google.com with SMTP id eh4so569109qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dzHVJ8vOAW33NYg2J2jFUIdaBUTLIuMa9pZOA05Ophk=;
        b=WpVDI/rTDx/BPyTcqAtBhw5ilYEcnOSO2oQm7Q2nG58PBMr90RSxA7liPaSeAJigM/
         W7SkkhuzhGBx7DUI6Sv2diNUG+ZmDZak+xhBcSmxkl9rtpgYu2VnGhH9cMp/NQBPjcJe
         mf11Mwrt3YPkBXRTHdsPZ/vOp+hwgGPNXdXVzE+gAgfr0xW403CQiFC51zwukrOibI9C
         2ky5VDa6oBFCDVqOnqaFEaHmVz1LhWwB5dPWuKsjdeOaslEiw7ljxaJVPkidD/3b1VoH
         04Ftei1UuuZEz9CAETK0WwKNpIZcCpn2y7/4XNKSITo7wPbkNCe1yzCEJrYdx28VQM83
         fG0w==
X-Gm-Message-State: AOAM532cKONnYlR87UcUgkhPOt7u+aQJAy+nw7fgOO63tY8M+Y+YgmP/
        waIFToeV4lMiOpR5q0NPDZfFhLXn8Ae5nmIN86jat2IRUBqMY7L04BwWCk3HIModvu5iKgF39Oe
        XOFdT3nku4Rv5Q13Asq++qgll
X-Received: by 2002:a37:b983:: with SMTP id j125mr1175863qkf.266.1603134995876;
        Mon, 19 Oct 2020 12:16:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCn0wNscJOCMqRhXgA/ucHjLYH16vNEbKqklylUaRcAdCsvZmBlyUP8Nee0uq7BdcWquvi7A==
X-Received: by 2002:a37:b983:: with SMTP id j125mr1175847qkf.266.1603134995681;
        Mon, 19 Oct 2020 12:16:35 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g3sm401626qki.84.2020.10.19.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:16:35 -0700 (PDT)
From:   trix@redhat.com
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mtd: remove unneeded break
Date:   Mon, 19 Oct 2020 12:16:31 -0700
Message-Id: <20201019191631.9604-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mtd/mtdchar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index b40f46a43fc6..323035d4f2d0 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -881,7 +881,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		if (copy_from_user(&offs, argp, sizeof(loff_t)))
 			return -EFAULT;
 		return mtd_block_isbad(mtd, offs);
-		break;
 	}
 
 	case MEMSETBADBLOCK:
@@ -891,7 +890,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		if (copy_from_user(&offs, argp, sizeof(loff_t)))
 			return -EFAULT;
 		return mtd_block_markbad(mtd, offs);
-		break;
 	}
 
 	case OTPSELECT:
-- 
2.18.1

