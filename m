Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269FC2DFDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgLUQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgLUQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608566495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2LYKHmksZ4OUxTuW+GqEvu3J6NNsLg0tPod120hM9DQ=;
        b=BOor04s+9n6ulCxWEhxBvozBNir++H/kxjSes5fNr9l0qGlkx+pmk0CK80dAAM85emU6xM
        5adIdPK/z9CiFarvwADb8zitwewnbpcOdMdlc33gmjJiV0ePVJwuqI7SQGTVObUpNV/ceG
        tM+7+9AmowPWFsDTBTHygEIvTQa0O+I=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-gZzOYHPtNb28_Cv8TXDKiw-1; Mon, 21 Dec 2020 11:01:33 -0500
X-MC-Unique: gZzOYHPtNb28_Cv8TXDKiw-1
Received: by mail-ot1-f69.google.com with SMTP id n11so5250923otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LYKHmksZ4OUxTuW+GqEvu3J6NNsLg0tPod120hM9DQ=;
        b=CXHtoHRjL2500PgeRHZ0z6qWm4jPo4LbT8agcDZbz4WnZap4+KGuI/6BaMBz99UzfA
         h1xNj8+Sn3Z5VLJhpHk+CjQlORaO5A3ajjSCf3mqhPotj2UkaRM5JUpmwodZ6EfYdYuR
         6p+5LfQy2hegn3i2tBr321fqOCv87pF+9kLiL/MMHSxosH9IBCaMZjl4ATh1LuIrZl2R
         a6cg3BBcs9NGaYPSpQl3/knEmmKbDefEJ1HhbpRXyHTop25REPpYQhNLKJNXXe4F+9O9
         6tOr7FuAimfA4eCWmC733fItdN5HJH8WllJJPhYl/DE1yBUBeXpxqEWG6ptknKSkvrDf
         MwpA==
X-Gm-Message-State: AOAM533ehhYaLgbFgE8hcn+BCjoTludF86sgcmdMY/xFTln+uuqTAI8B
        SKUtQBw+6Eoma4KHfglKXl+Y5Hi6FI30nFP0zKr5qZo0MBdSWhRT1MBPyBGOBdfIOKZ4sYFsb2K
        TavPkFnqrfBos9DELkepnhOKu
X-Received: by 2002:a54:479a:: with SMTP id o26mr11487900oic.48.1608566492536;
        Mon, 21 Dec 2020 08:01:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1dYe/JKq38wPEPorrGJxGJSjFQLly3DC/w1ANAcNmh8suodro6w8rNwBdoB4pr/mjnn4ECA==
X-Received: by 2002:a54:479a:: with SMTP id o26mr11487892oic.48.1608566492423;
        Mon, 21 Dec 2020 08:01:32 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n16sm3883212oop.9.2020.12.21.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:01:31 -0800 (PST)
From:   trix@redhat.com
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Input: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:01:26 -0800
Message-Id: <20201221160126.3752467-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Attributing the function allows the compiler to more thoroughly
check the use of the function with -Wformat and similar flags.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/input/rmi4/rmi_bus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 25df6320f9f1..62a93d7d98f8 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -195,5 +195,6 @@ int rmi_of_property_read_u32(struct device *dev, u32 *result,
 #define RMI_DEBUG_FN			BIT(2)
 #define RMI_DEBUG_2D_SENSOR		BIT(3)
 
+__printf(3, 4)
 void rmi_dbg(int flags, struct device *dev, const char *fmt, ...);
 #endif
-- 
2.27.0

