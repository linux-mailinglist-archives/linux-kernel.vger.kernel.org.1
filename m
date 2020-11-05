Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7FB2A7632
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbgKEDsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733135AbgKEDsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:48:09 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:48:09 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id k21so380608ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 19:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k80CcVAqwcU/fHTAk6XVOjxvhN4AIfZv8jlW+iQqs8s=;
        b=csv9UxyVJW7JhF+k3wMgQPsZgjOM7KStiEjJUv4zPjABxZLwwMWdoVy/LcggGFfQBP
         MdwBIVX27X6TcG4e+vy/FcESevFYNLylj16RZkN2Ni3OpgEYt0vBUGwllWtp3TqggLfX
         5QAXYbNRgbCw7hLkgGiNf4hMfmLrFS5h0rcXrTh20GYqz5nn9nAKSR3Oy3bEq2Uiazpy
         O2i2LodnF+cF5xzKdmYbDY5m9SoiWwOt3iQqdJnTjqXQGnwFg5eEOGparxzyJYWvV9zT
         GxqEd5P4hcqts/m5obTnvvgLc4MbjHqhPZJdh0WEhAv5q7cATIY6DKlkVZDu39ILPDfA
         4lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k80CcVAqwcU/fHTAk6XVOjxvhN4AIfZv8jlW+iQqs8s=;
        b=cxkFhvjprlYfJPxgtR57HXFIbNZvBahNN9nvDNTpGOOOgWe+43FXzEx4pFdus1dn4T
         UBAD1vpvXOgXfkwvmxrUjK3lzDzvMP4RvQL2+YSCYps53DXOYNlKqHwoLBh6gfxi+NyF
         XPlfdNvaFXC5lWi5E8y0P/7nPcOxBxKHx3Dmgy7cTdM9YjEjZn/j+WC0jRZyR3oBomzg
         iJAbRCQisRPFqB7Aa+NSdCN1KY63JmVXLDF7bIWFy/ge7CuHtrvkc1eY5CLRB/1whUUJ
         lqSmTgoQc69BhpEmV8lpxr5lcHZfy5FXFbPuMIn/JQkQOEdf7dZ/OYp982QBr5qIFyJQ
         bWDA==
X-Gm-Message-State: AOAM531QCGwvOxIoWoMYJFALm8S7bnWgQK0ZTu/AxQUw07KruOEijzMc
        O+7/ntBv3hZV+LdKcol+SWM=
X-Google-Smtp-Source: ABdhPJw6hLdNWVJk8o6s71rRevUeu4s2y5EoaCC+fEague22GEKsV8H5kJWBdcilE6UYRrq1ZlyZMQ==
X-Received: by 2002:a02:9981:: with SMTP id a1mr595055jal.54.1604548089110;
        Wed, 04 Nov 2020 19:48:09 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id p6sm172877ilc.26.2020.11.04.19.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 19:48:08 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 2/9] staging: rtl8723bs: use %pM format for MAC addresses
Date:   Wed,  4 Nov 2020 21:47:47 -0600
Message-Id: <20201105034754.12383-2-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105034754.12383-1-ross.schm.dev@gmail.com>
References: <20201105034754.12383-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %pM format instead of custom printing code.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index e42d8c18e1ae..08abfb8ec4c7 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1231,19 +1231,8 @@ static void Hal_EfuseParseMACAddr_8723BS(
 	}
 /* 	NicIFSetMacAddress(padapter, padapter->PermanentAddress); */
 
-	RT_TRACE(
-		_module_hci_hal_init_c_,
-		_drv_notice_,
-		(
-			"Hal_EfuseParseMACAddr_8723BS: Permanent Address = %02x-%02x-%02x-%02x-%02x-%02x\n",
-			pEEPROM->mac_addr[0],
-			pEEPROM->mac_addr[1],
-			pEEPROM->mac_addr[2],
-			pEEPROM->mac_addr[3],
-			pEEPROM->mac_addr[4],
-			pEEPROM->mac_addr[5]
-		)
-	);
+	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
+		 ("Hal_EfuseParseMACAddr_8723BS: Permanent Address = %pM\n", pEEPROM->mac_addr));
 }
 
 static void Hal_EfuseParseBoardType_8723BS(
-- 
2.25.1

