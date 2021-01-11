Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623262F2277
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbhAKWKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:10:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388713AbhAKWKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610402956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wAtnYWwrlK7tpbrs/+tnNUH4YreR07+THJRUh9/6qM8=;
        b=Fx71VGTsaYQj1tzMpI8V7d2w5tvT5cU9yD9ch22/F7HWc7/zJPP0nOF/L96znTT22Rqijx
        S0SwtAzzDRlp8rw14ovBvbos1ZRB5FkuM3dgp6/im7SjEEiVvHpFOJQsuHBtPCq0NGbryS
        LCPHxIXu/LeSUBz35b+1RVUmq+Y08kY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-6DsG8wt8Mbeu8wzFHbuE9Q-1; Mon, 11 Jan 2021 17:09:12 -0500
X-MC-Unique: 6DsG8wt8Mbeu8wzFHbuE9Q-1
Received: by mail-io1-f70.google.com with SMTP id r16so231164ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wAtnYWwrlK7tpbrs/+tnNUH4YreR07+THJRUh9/6qM8=;
        b=F70QvlCeqpthvTt79n/LmyNn3WY5wQDCxjd/c4FyfWwqu0IKboERXwBgriMa8xK6Ye
         4KpOm6Me7um/pK+pKmpCFTfcYbjcPXTd/aZOXRLN95M7mROxwrzP8L5r5qEWw7OdMgrR
         savJ5wR+qDrcXdWZv+XcW+DNjwbQ/eVgPjDIGaKAwg71p1vQTAIF+kpKX9b9ozcsYMqV
         FiykiHDVAVzZ0eqfvfgPozD5LNK/e7CazN3ky7weEiEalwnpmHRJRMjSXopbiOYbNYIM
         wuq9/lSPiDEGCDqDDOTVj6r1AWmcfyWi4KZUK2NAUYZGiaQesUX3i9qwT1WgcmPloCIF
         NAnA==
X-Gm-Message-State: AOAM530xTEBA9MvtPpdqwdg8Rj6s96TGkDENnSVjpJ5T5e1l6XNRywFp
        znbJQW4EdQ2GiUGlnROspS4zsZIRzSb0A69XX5HbBJMm2/SCb4ArP82qbCgoqSJo15PdYRw0+kf
        bKU9ZFrliZIu+7+GTfkFjBXrL
X-Received: by 2002:a02:bb99:: with SMTP id g25mr1555074jan.11.1610402951224;
        Mon, 11 Jan 2021 14:09:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxswd5YF7Eo0k165Z8e6I3dQ4wtHbxizYkFRXv1FPhiW6/Y1lObuf/ddgaiWUlhPY/R/ftasg==
X-Received: by 2002:a02:bb99:: with SMTP id g25mr1555056jan.11.1610402951001;
        Mon, 11 Jan 2021 14:09:11 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m15sm692170ilh.6.2021.01.11.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:09:10 -0800 (PST)
From:   trix@redhat.com
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] USB: serial: mos7720: improve handling of a kmalloc failure in read_mos_reg()
Date:   Mon, 11 Jan 2021 14:09:04 -0800
Message-Id: <20210111220904.1035957-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

mos7720.c:352:2: warning: Undefined or garbage value returned to caller
        return d;
        ^~~~~~~~

In the parport_mos7715_read_data()'s call to read_mos_reg(), 'd' is
only set after the alloc block.

	buf = kmalloc(1, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

Although the problem is reported in parport_most7715_read_data(),
none of the callee's of read_mos_reg() check the return status.

So move the clearing of data to before the malloc.

Fixes: 0d130367abf5 ("USB: serial: mos7720: fix control-message error handling")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/serial/mos7720.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 41ee2984a0df..23e8162c768b 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -214,6 +214,7 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
 	u8 *buf;
 	int status;
 
+	*data = 0;
 	buf = kmalloc(1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -227,7 +228,6 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
 			"mos7720: usb_control_msg() failed: %d\n", status);
 		if (status >= 0)
 			status = -EIO;
-		*data = 0;
 	}
 
 	kfree(buf);
-- 
2.27.0

