Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF3224378
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 20:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgGQS5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 14:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgGQS5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA23C0619D3;
        Fri, 17 Jul 2020 11:57:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 6so8450213qtt.0;
        Fri, 17 Jul 2020 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfFbKFG69UIk23n0jK+AFfP/kSnJH74mIm+r1eI6Phg=;
        b=qLk5G56nHz/exeW7iYiDTiUyXrSzRaR1oXu5E5flAIG0nMJhoic1TFW8jZRu/xy807
         rWEVKSkI0aQB8Icfx7wy2CZhExHGdwzYRmQBnTSGn8ivUJ/lgT7jF0JNYQ0xw/5OnqNS
         zsyN3P98NIhGYUGFT3cx1axS7dE70ijsz4DXuW9RhpUJuIcE4aMt2JLS8CH6umH5sPii
         WzCwCo8rU8MJNBJlRYW9PxaN3QWLliNR4MfQKLZYeWUT/NHxy3Hqa65rKwT2w7lEuk1u
         XBWoqQSgQ6F5PBbNu+M80OOypn44Yj30GSyREqkfu/obLUnDrBV+cSoqV9DZDY4Xk13u
         vBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfFbKFG69UIk23n0jK+AFfP/kSnJH74mIm+r1eI6Phg=;
        b=qmHhPhLuU3ZjiqDYKjjutGw2ZnMIsw7AQhND+mgPyn3Y4UnpS6iR4sJfhtkTfdpZbk
         q+lB+l0uKt7ABqPnU0+NPXyX0gzWlx8KMOIndqM+bwNDrGADtNvdmE143xsD/tcDX/hi
         9FkbWksytXgHtil7nwIG8trFehebDiH4PBkX86lelwHrPd2bTfm1Te3X1O2EqrdaHGWj
         E7laHvYIiOxEUUQ5S4+N0QTWj9oLZAh9l0vMgrQJT30r/+c9vOmwqamZBpuHOK1HHphI
         N6N+qQd7NFcmcPlbZiQYiWN3yoNkATTnJr8BZ8goqFyFKdFAf/rkhRIEO7SRnRPKCNPA
         Egdg==
X-Gm-Message-State: AOAM533qbiIEWcy/TO9YB3FtfqKJDy4MeQv87kcS/vPx9y5/CrXTRfrr
        GE9oVHxlqNnBvQDaHHdfJcoxqT5jEik=
X-Google-Smtp-Source: ABdhPJyBuOwQ1TNyDnas4XJm6pnXofaYRXWxllaSoGhFSknVXWk2rrhrvFQcl1D7oj9/rvUDHTHfMA==
X-Received: by 2002:aed:2cc5:: with SMTP id g63mr11805793qtd.59.1595012224864;
        Fri, 17 Jul 2020 11:57:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:04 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/25] Documentation: usbstring: usb_validate_langid: Fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:05 -0300
Message-Id: <20200717185624.2009393-6-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

warning: Function parameter or member 'langid' not described in
'usb_validate_langid'

warning: Excess function parameter 'lang' description in
'usb_validate_langid'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/usb/gadget/usbstring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index 58a4d33250902..2e9735abfeb95 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -16,7 +16,7 @@
 
 
 /**
- * usb_gadget_get_string - fill out a string descriptor 
+ * usb_gadget_get_string - fill out a string descriptor
  * @table: of c strings encoded using UTF-8
  * @id: string id, from low byte of wValue in get string descriptor
  * @buf: at least 256 bytes, must be 16-bit aligned
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_get_string);
 
 /**
  * usb_validate_langid - validate usb language identifiers
- * @lang: usb language identifier
+ * @langid: usb language identifier
  *
  * Returns true for valid language identifier, otherwise false.
  */
-- 
2.27.0

