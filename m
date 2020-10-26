Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3228299685
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792654AbgJZTNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1737697AbgJZTFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603739109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=CeSxyJXbIAWmg9ma3wabvh6TND1xY66CvqM05CqNLic=;
        b=cVu5URo45COpMDXCOUf4+3iwE+xtON6VgJc9qrNngICUyn65ZkB9VfSRy7PcuzEUuLVkdC
        +ihGdwwLVX/tBUV8jA3mtUmro0Ng1YHvUVcIDIfLFyk2YGAWDOawXiXoItZtLgU9ODfN+T
        xCJwfoOpHKwufqBSZzD8zUZVpBAP5bI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-8966TMy7N5qBJkFyqvQ9qw-1; Mon, 26 Oct 2020 15:05:05 -0400
X-MC-Unique: 8966TMy7N5qBJkFyqvQ9qw-1
Received: by mail-ot1-f71.google.com with SMTP id e1so3957722otb.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CeSxyJXbIAWmg9ma3wabvh6TND1xY66CvqM05CqNLic=;
        b=sG9+k7Etjlyp38T3jcQFM04/x/HFWn6otFZPAVMR7zI0YyomUH4dHquOztthfXTOkc
         sEFdZ1jZcNB1kFiFLmi3e2Wrd0I9OEkOw1iFDYETcRBnwUsBJ2ZzEU4JN+0DhzoxmYKq
         YVNe1FoK4eJzDgB1ZkbOpv/jG1xXo7vCf4JNDLPlnl39vGujkcDcTPK32uFwUmApZ391
         O6mg4bgBJfg9BjwffsNfDlop37LY5LOnb5Hhww/e0KzWWUTZSA4Q6bntHiTzYvZP7Ggi
         gcw55+YjM6DJcDiAPnhFs+U4ixjRcc/zdrvGpGtF+WcufPUXYZxNJwSOZy2FJawjghnI
         8S5A==
X-Gm-Message-State: AOAM531PCJdAGx8tYDZYb8WC29g/AQq4oy4aslLRp9GvLjbJa9HNPYni
        jGGO9E+Lya2pHTWNg1YOkHmYBQmm7C6M8moFq+x7/tfAV4LP2+NNjYwwXywz+G58mKOV/tqGmpG
        PqmIJ5nQRzNbhY8jIBZmS9WtK
X-Received: by 2002:aca:2b05:: with SMTP id i5mr15353015oik.57.1603739104684;
        Mon, 26 Oct 2020 12:05:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDzUzZb1se/ghFrljj0r4jK+qZOmg7H/2p/u6170SKKqrlq3uXimvsSk1NAmvcYmDQLE9vRA==
X-Received: by 2002:aca:2b05:: with SMTP id i5mr15352977oik.57.1603739104214;
        Mon, 26 Oct 2020 12:05:04 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s27sm3044196otg.80.2020.10.26.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:05:03 -0700 (PDT)
From:   trix@redhat.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] usb: storage: freecom: remove unneeded break
Date:   Mon, 26 Oct 2020 12:04:57 -0700
Message-Id: <20201026190457.1428516-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2 : split from original large patch
---
 drivers/usb/storage/freecom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/storage/freecom.c b/drivers/usb/storage/freecom.c
index 3d5f7d0ff0f1..2b098b55c4cb 100644
--- a/drivers/usb/storage/freecom.c
+++ b/drivers/usb/storage/freecom.c
@@ -431,7 +431,6 @@ static int freecom_transport(struct scsi_cmnd *srb, struct us_data *us)
 			     us->srb->sc_data_direction);
 		/* Return fail, SCSI seems to handle this better. */
 		return USB_STOR_TRANSPORT_FAILED;
-		break;
 	}
 
 	return USB_STOR_TRANSPORT_GOOD;
-- 
2.18.1

