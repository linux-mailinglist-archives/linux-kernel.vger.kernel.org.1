Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1AF2DFE04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgLUQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbgLUQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608567954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KgDwPayZceRj0ay5WxA4Idk2hKnb73d2HewcvKPRHSI=;
        b=SEWjavYj3MLFXKI0AH2V3MqjOAJjuVqJ1tuOHOSR3glt5mOe3RUbpARygJSZAWSGzaKX+w
        FXaOqVuHN8At6RaYoKQeAKEaVU1SB6kf4NF1inmtqrPKeuEWPKLhMIAFTeh9gu/sswukFE
        53KxLtpJKHupPkYbEOQMq4XREmeJtJY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-akUHMqSwPqG7gkNTUuQ0iw-1; Mon, 21 Dec 2020 11:25:53 -0500
X-MC-Unique: akUHMqSwPqG7gkNTUuQ0iw-1
Received: by mail-ot1-f70.google.com with SMTP id x25so5287891otq.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgDwPayZceRj0ay5WxA4Idk2hKnb73d2HewcvKPRHSI=;
        b=NwyTur0vCE18exgmt3P8SJuIBif8FW2p3wDN4ZTqc0ng08Ea9hBMxBwrNR6JA4o/Eu
         295aiJWLwHnSFLTc6LZY5xj9h4I1/a+xy26r8hl0jLeg9dJ0ZfhF6dS8hvDaY2dRdI27
         wJPtCUexQFg3b8Cuv2NXnHx2wRKe/Pt/7skgZlcrfqqQwMPaRr2VnLM3OK9C6s3JOPbh
         3k8bY/oz7WtmK5gWjOLYu/rMF+mC/rH1q+JfBQnbOSO8GR+VgJCxs1pw5V1rLAIZ/BbZ
         +xpdX0IUbc+oidpmKLYLvX0uqLd0p80lTU2P+1ghZHgFnL5wnQjr3vp2kis/3akZl92V
         m2tQ==
X-Gm-Message-State: AOAM533ztqxWhhRxPLyzkY1r69EWw0HTdMIHinP3Sn4ZLB2iJGfn/UIZ
        YMO1JiRc1FL/jnkq0DKAqhkGBQXFDwsdC0N3wYKCD37XDAcf1ierucz4BTxpAjJy/qwhxKVd+wO
        xk5VxygMQaD64/rQAybGK0hWH
X-Received: by 2002:a4a:11c2:: with SMTP id 185mr12124314ooc.85.1608567952623;
        Mon, 21 Dec 2020 08:25:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFJxJULTiskpg9tHuVN2y6KgrzO2t2HGJPJ0ft+RMn1qj5mMl9GLBJUBmnPWOaE+zJBPpY1g==
X-Received: by 2002:a4a:11c2:: with SMTP id 185mr12124312ooc.85.1608567952470;
        Mon, 21 Dec 2020 08:25:52 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b188sm137341oif.49.2020.12.21.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:25:51 -0800 (PST)
From:   trix@redhat.com
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: musb: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:25:47 -0800
Message-Id: <20201221162547.3756889-1-trix@redhat.com>
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
 drivers/usb/musb/musb_debug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
index e5b3506c7b3f..dfc0d02695fa 100644
--- a/drivers/usb/musb/musb_debug.h
+++ b/drivers/usb/musb/musb_debug.h
@@ -17,6 +17,7 @@
 #define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
 #define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
 
+__printf(2, 3)
 void musb_dbg(struct musb *musb, const char *fmt, ...);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.27.0

