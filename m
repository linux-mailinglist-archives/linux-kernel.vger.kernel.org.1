Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE45829918D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784614AbgJZP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:58:28 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37931 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784606AbgJZP6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:58:25 -0400
Received: by mail-pj1-f68.google.com with SMTP id gi3so3305595pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BvEOtcmMKZgMMz/Q+k5oijPH7ubZ+igE6I4Ohn9FqQU=;
        b=McHEw2zgFjmlMlUX19G9RU+BJlEp+gogUMsf0ZsfbmpynDl+3uiCrbSPheXSx3DvzZ
         doVPFOKg7U5A7ofPLHy40A18gmMfRFU2RB/M0UXmwng7y7nhRmYyLTA3vGBv1tkh8uBh
         jNANCkfIFeVa3+qnxqTwWyamOUfxBUxyevmtLlJYZb2nkBU68rXoTyZypQRq2OFp31Xe
         702L+v6/hxNeye6Bmwtle9JoLsSFfGfCjtxJLV2LWwWi32LORTr9cGjhSx2s1didn3GZ
         zg6QoiP7AnnMLyb4W6ixHWrZSlEAHhU+xu7N2lE7ZMKBazN7QdVUVovMVgwH5kEnHI/O
         JSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BvEOtcmMKZgMMz/Q+k5oijPH7ubZ+igE6I4Ohn9FqQU=;
        b=ehyldEbK24vgexAUTHlUdkeqKxa/AYt8dIjohKmVrrJjTtfdxgQxOsZczKVxRgbswk
         GoTaO92ncSuUv49JO9AZxDDpO+AEAzYZVBsyJ7VVjFe2oT4WLWkEVL27Pe+o0L8D7Tic
         KgBveVLaNHKKPEVRXw3xmdgpxb5ND+rf1jvmcZzF1/tvrAwnB72e1nC29kJjB8W1XyEp
         hFmyp7YI6l+FCOoybHazBqBMLxukfqTVZHy2Ev99hX9y3aFHjJMm76xPr83FRr1gOI+d
         ar4tSGpCywcLr/lRxqiQ7UdwbU8oGYT3xsi115rHmAGCLC9P8obKIN/UgDon4U5icPPv
         0xeA==
X-Gm-Message-State: AOAM530xOoFQ4ks3CjEZZc50swGwtssF0X3O+XLL4SbDp89Lk5KveP6Y
        InZnkId4ARt6x/2TQgvAZqlnf1EWdca3Ya4M
X-Google-Smtp-Source: ABdhPJzmUBs7XaQ0R3IOgLV74nZT0a4GzGao8pzB8n9NbQcuz/P4c82htNxTybmCCopmGChRZZhiRA==
X-Received: by 2002:a17:90b:f8b:: with SMTP id ft11mr22349279pjb.88.1603727904412;
        Mon, 26 Oct 2020 08:58:24 -0700 (PDT)
Received: from localhost.localdomain ([150.242.63.159])
        by smtp.googlemail.com with ESMTPSA id s38sm2958525pgm.62.2020.10.26.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:58:23 -0700 (PDT)
From:   Harshal Chaudhari <harshalchau04@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] misc: xilinx_sdfec: add compat_ptr_ioctl()
Date:   Mon, 26 Oct 2020 21:28:01 +0530
Message-Id: <20201026155801.16053-1-harshalchau04@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver has a trivial helper function to convert
the pointer argument and then call the native ioctl handler.
But now we have a generic implementation for that, so we can use it.

Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 92291292756a..6f252793dceb 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1016,14 +1016,6 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	return rval;
 }
 
-#ifdef CONFIG_COMPAT
-static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
-				    unsigned long data)
-{
-	return xsdfec_dev_ioctl(file, cmd, (unsigned long)compat_ptr(data));
-}
-#endif
-
 static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
 {
 	__poll_t mask = 0;
@@ -1054,9 +1046,7 @@ static const struct file_operations xsdfec_fops = {
 	.release = xsdfec_dev_release,
 	.unlocked_ioctl = xsdfec_dev_ioctl,
 	.poll = xsdfec_poll,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = xsdfec_dev_compat_ioctl,
-#endif
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
-- 
2.17.1

