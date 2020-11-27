Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5372C6A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgK0Qya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbgK0Qya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606496069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=PvAkNY0hmzSRqQ141kEN8iav9gK21okulo+qyaHKwNE=;
        b=IFVS2+3A4U91VjeGRaRO2F1Yzh18yxOS+5XjxbJHXrOv+kCdgWZX21gxPjLlOec9Pi3eGi
        w2VxSuEHwRGgrc/ppdL7pnOmfEO6+HWn+Qxe1/5WUYm+IBRpsTgLYzfcAWS5GKTC1waZ85
        b0GcybuiE48rUu7QxVBXRT7aid7lvs0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-ULM0fQd0M-6llQwmf7lo6w-1; Fri, 27 Nov 2020 11:54:27 -0500
X-MC-Unique: ULM0fQd0M-6llQwmf7lo6w-1
Received: by mail-qk1-f199.google.com with SMTP id x196so4037951qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PvAkNY0hmzSRqQ141kEN8iav9gK21okulo+qyaHKwNE=;
        b=q8L+L3UkcJsricfjje1S1Au3QmV9bu9qjaJw6SmV0vdqJ+MKnP04tYn22oMfdcz4Kk
         IXJwXFrALFTb/jsok4qUjb0hhtZXohTu0wC29qSxKKSMkK77tIxmedkmJE1uIDuhjKq4
         8fhsGGyXgc+3RV6ViGizeylCbmRPoxV/zgxN04lUYTAk+KbHbR0oZA3dRVA0H3mZgFsv
         KiS7x8lbXixgscqYJ2UJ8gKTfF1J8ogs8r9xb9qUOjgKZuJ6dPX/TideUYRfmpZe6KPn
         zRw4y7w1sDSV7im5wECpgVky8Wm/omMueYPXxxzYrtSw/xLAKm7rKxOk3x5Yo6AoLY1I
         1TzQ==
X-Gm-Message-State: AOAM532d3c1lmGSbYODGugxzkBuIjFH9EvqH9VldnVdd7Qa1VozD85Wv
        ZeVgqq2iHitPlwzng02/N/XNdmsfFzfdQ5ssD8lLvV2gbJjmY8jxxPNmmoG8oidSqnxiKNDm1M/
        DtJyR15NQzTVBtXIj3lHzgWiN
X-Received: by 2002:a0c:f20f:: with SMTP id h15mr8270660qvk.54.1606496066605;
        Fri, 27 Nov 2020 08:54:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEC9PWmFahg7bLWWW06umvNcuxWvzV6EQHywOlyA/1rUnRohCguSPxHVe2pNUgzzQLdW5TMw==
X-Received: by 2002:a0c:f20f:: with SMTP id h15mr8270647qvk.54.1606496066449;
        Fri, 27 Nov 2020 08:54:26 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n41sm6492534qtb.18.2020.11.27.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:54:25 -0800 (PST)
From:   trix@redhat.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: altera-stapl: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:54:21 -0800
Message-Id: <20201127165421.2692469-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/altera-stapl/altera-jtag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera-jtag.c b/drivers/misc/altera-stapl/altera-jtag.c
index 27e8e0c9e8cf..0238600107b0 100644
--- a/drivers/misc/altera-stapl/altera-jtag.c
+++ b/drivers/misc/altera-stapl/altera-jtag.c
@@ -17,9 +17,9 @@
 #include "altera-jtag.h"
 
 #define	alt_jtag_io(a, b, c)\
-		astate->config->jtag_io(astate->config->dev, a, b, c);
+		astate->config->jtag_io(astate->config->dev, a, b, c)
 
-#define	alt_malloc(a)	kzalloc(a, GFP_KERNEL);
+#define	alt_malloc(a)	kzalloc(a, GFP_KERNEL)
 
 /*
  * This structure shows, for each JTAG state, which state is reached after
-- 
2.18.4

