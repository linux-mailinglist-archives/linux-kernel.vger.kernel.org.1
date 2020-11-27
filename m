Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E42C6B61
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbgK0SKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732038AbgK0SKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606500634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ClSEA+oHo66dgHnrI/FfViP9bxY+tUBfKOzJZRbRpDw=;
        b=TbJBB5peA/ffKjrJNjbx5INVmYmsYGInc9sDrQfxOvJz6WGBU+3pVZltGB6RJHkG1vEOTb
        vHvlyiFKuzqAVo5yqRbh4jMPNsbwI7omHeJ/3xadsZU1ofk7XayQwjdNkDuY4JPp8DNiYl
        XWjSwJomNRT8qLa2ADJdq2Oc8vCQ5+g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-vkJJ6-02OjGjoOet1TCBsg-1; Fri, 27 Nov 2020 13:10:30 -0500
X-MC-Unique: vkJJ6-02OjGjoOet1TCBsg-1
Received: by mail-qt1-f198.google.com with SMTP id f29so1890474qtv.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ClSEA+oHo66dgHnrI/FfViP9bxY+tUBfKOzJZRbRpDw=;
        b=mESQn/VIDLdkig/lVFvmE4RBz/VyMuso3IvFcC3NIddftXNo4sUZCM6Hs05EZzB04m
         aLTXc4kXAcXmPHNnUDye/lvRDv+S5uvkYMv3E3dLYWOr+JmXVq9CmiQ/4ZRUXInuDW9w
         r4d0OwjhiTesWvpsA5u8YJToFHqNuGlT6ye60oRwc90+x3suG57svkkjCeLMhtAs1tRf
         bWym7qzgFW/SPuQs/SlE3207Q0B+J0x+L9jjdNNWjCZPFNlw0hl9b7uFaAmtwTPuFTVp
         TC1c456SMrjsWsqu6ARd11+FI8TazTOLEt9fPxuO36u8c139mZXhquKAtPtUNoDlk8FS
         d3hQ==
X-Gm-Message-State: AOAM532KEJ0GwN3eaf+RUOXnngvPd8J/njmvyNwqMgp0dmyBlusFYqIV
        N3tG3yhKp63SM4iUh0Ej1N48QPCzqnfR1xnI9dms6SpPgP6MBrNU8H2ch77pXoOtClBbD4g4+xY
        cdlCNUdJ0R5KRg9qcY8ikEpCA
X-Received: by 2002:ad4:42a7:: with SMTP id e7mr9345592qvr.45.1606500629890;
        Fri, 27 Nov 2020 10:10:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHlAuYcSOipUdB/xqu5jZZbBOTsmuzbrp24uGjZ7nun8E4njIwLiGIDZUNLb/aa/WA1qAH1w==
X-Received: by 2002:ad4:42a7:: with SMTP id e7mr9345579qvr.45.1606500629762;
        Fri, 27 Nov 2020 10:10:29 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h4sm7119708qkh.93.2020.11.27.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:10:29 -0800 (PST)
From:   trix@redhat.com
To:     ibm-acpi@hmh.eng.br, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 10:10:24 -0800
Message-Id: <20201127181024.2771890-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 36d9594bca7f..5bbb378d1a37 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1025,7 +1025,7 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
 }
 
 #define destroy_attr_set(_set) \
-	kfree(_set);
+	kfree(_set)
 
 /* not multi-threaded safe, use it in a single thread per set */
 static int add_to_attr_set(struct attribute_set *s, struct attribute *attr)
-- 
2.18.4

