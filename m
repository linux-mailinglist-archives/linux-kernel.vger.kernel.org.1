Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60A2C6B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgK0Rzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732436AbgK0Rzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606499740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Br/IPbdHx/OaYg6xCtsKtihEPu1TMwZ+6MkhSnyxsRs=;
        b=OlqeNknsyJOgPCiYYSBRTA1H+W8HdCu3r7pnY6q3humVeUUUN0epS5Txaj2k7smHLoJUsU
        OjDWByJeZc0ecyFyPUVGFzh+EGAOM3cdS/UiFDI6/RcnUHrfMY3HTbxZVQTdmx8M5Xcfsx
        7os+S7JElacrYsG1hPt69nx4xeRbU78=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-0ZPn9j7nMjC-5JWdCvVu_A-1; Fri, 27 Nov 2020 12:55:38 -0500
X-MC-Unique: 0ZPn9j7nMjC-5JWdCvVu_A-1
Received: by mail-qt1-f200.google.com with SMTP id i20so3662765qtr.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Br/IPbdHx/OaYg6xCtsKtihEPu1TMwZ+6MkhSnyxsRs=;
        b=TbUukwMJrSuWyIROHVqYTw0KooAVN1dbnSCdx/IjFJa9TP+rCjU0swywdm83B6C8Sb
         1senhNLjjPb5jG5S34S1YZjgBQnVSAPYMCV2ySFe1ZCt8G7KB0geu3uddwjrSxykPl5k
         MlH78qcV2OWJngZQzBpOROgtmNDhfZauezs1u6ft+5id8ZP50MKk8R/vWyWUJKA4OhT0
         gDCiHTFxfBNJaoGLHce5jGVCHVr+YuKeBIxoKWjgzFIYFpH+y0Gn3bGVM6hKJjqCsfvv
         eiKTrN/U1ZlMHbyQwho3uWPbyOiMyOo2E8RZTBGGGcG0pc8aZV6StpKPO816emlF8gsh
         inmg==
X-Gm-Message-State: AOAM531514dtlJLJ6waSyjDXath+MxoVWPXLm26fs8Ya8ZRdz8AoU2jD
        f8zn1ZLccyppvihvxnJ8xVDQZWW9zufr3/t8jehsHYz1ZpmJBkj+mOWR0HzgYK8eGHDyGxyQX2X
        7jv/BRwdY+T6Toem/Nl/nU1cQ
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr9511050qkg.56.1606499737598;
        Fri, 27 Nov 2020 09:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2L15Xpt+pzKI2tQJ1Mja1bZVxZ9cJq3+yTQqjAUjwGC9JUF+NSrylLZnhZYHe6hp4SZgoPA==
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr9511031qkg.56.1606499737423;
        Fri, 27 Nov 2020 09:55:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r48sm6421675qtr.21.2020.11.27.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:55:36 -0800 (PST)
From:   trix@redhat.com
To:     chunkeey@googlemail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: carl9170: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 09:55:31 -0800
Message-Id: <20201127175531.2754461-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/ath/carl9170/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/debug.c b/drivers/net/wireless/ath/carl9170/debug.c
index 19009aafc4e1..bb40889d7c72 100644
--- a/drivers/net/wireless/ath/carl9170/debug.c
+++ b/drivers/net/wireless/ath/carl9170/debug.c
@@ -45,7 +45,7 @@
 #include "cmd.h"
 
 #define ADD(buf, off, max, fmt, args...)				\
-	off += scnprintf(&buf[off], max - off, fmt, ##args);
+	off += scnprintf(&buf[off], max - off, fmt, ##args)
 
 
 struct carl9170_debugfs_fops {
@@ -818,7 +818,7 @@ void carl9170_debugfs_register(struct ar9170 *ar)
 #define DEBUGFS_ADD(name)						\
 	debugfs_create_file(#name, carl_debugfs_##name ##_ops.attr,	\
 			    ar->debug_dir, ar,				\
-			    &carl_debugfs_##name ## _ops.fops);
+			    &carl_debugfs_##name ## _ops.fops)
 
 	DEBUGFS_ADD(usb_tx_anch_urbs);
 	DEBUGFS_ADD(usb_rx_pool_urbs);
-- 
2.18.4

