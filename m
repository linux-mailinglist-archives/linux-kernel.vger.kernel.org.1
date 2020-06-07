Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA41F0CCD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFGQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFGQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:08:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB0C08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:08:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so7420359pfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Q9umbjaNyLJJbHLsFd2bWboEFhcvRaO3ScYxQZJ+ho=;
        b=aFBmN6c3g3lxrVen3aXTH25OAqgPnEotLREV7gHBiADOnziI4gVj13YMDVeBIueS8y
         Vq/rzqAmDjilIEGhndGVYVmklyPAHXvyh9bPksJ8374iMiJYjDMcAntQdt8nBNOYOdVR
         myzgdHUVg1+ABYaivy1vPH8gbfiuK3fA9WDiEUsus1pwcg4ipdCWjbyP4v2uPy8q6Hi8
         L5+AIIzLuQ/VpfLdr8kAIqL4C1L3aa9fsDkGBLPvK07wOijvO/ax/4+att7dndNAL/v0
         c4oxZzqGUG8AWGPSa8lGql7tHzWlXdEf2pHcjjbf3UgylptOdpG4LabkW+j9YQjvXlFu
         I+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Q9umbjaNyLJJbHLsFd2bWboEFhcvRaO3ScYxQZJ+ho=;
        b=ceDpcX8gWpl+U/XcoJS1SwRQdsXTBiRiRDD5dBUqixOYgkoJ8sk1cNPpWnKJnasHVV
         UaSxztP+0oYgtYOSrTDIdHGuo1J0/9NNaDkPDi6biJO8q/CrGIV9jstO9fmae7RB1Z7T
         o0QAo4tAq2YLYTfDjWKkQSCg7wqpjeSdwzChkL2rEOOZovViJWETogr+00GcW/zHgUuS
         VPfUVwZr4QHZZB0ieqHoXVJq4AdukOH3XWwaavW8F+7Zb0OEksFkGS4pw8DCrj53aAal
         I+k22GBg4AEWCixgrTLKFtAIDMYnzzODuoPtDYJiJgxFDY8pS9E7k20YkYoaZrZpHU8+
         KdcQ==
X-Gm-Message-State: AOAM532nMzbgOKRNhSsnSrOjXGgkxEG1CTIGCR6TJ7WELpadu+1uoK5d
        aPQ+ApVUlqwHOIFKsTz+2H3y
X-Google-Smtp-Source: ABdhPJxFSdQLIiTkUSxdQUi8exHZeC48UYQ2lGufteC+HhdjlKQEgKMfZkMlFObtHBc0P28eg6cJ2A==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr17321031pfn.183.1591546116017;
        Sun, 07 Jun 2020 09:08:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e9a:8b0a:3d5e:1902:f17d:d125])
        by smtp.gmail.com with ESMTPSA id r202sm4739449pfr.185.2020.06.07.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:08:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v4 3/3] usb: cdc-acm: Ignore Exar XR21V141X when serial driver is built
Date:   Sun,  7 Jun 2020 21:38:09 +0530
Message-Id: <20200607160809.20192-4-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607160809.20192-1-mani@kernel.org>
References: <20200607160809.20192-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The RTS/CTS line discipline for this device doesn't follow
the standard. So, in order to properly support TX, a separate
driver is needed.

Ensure that cdc_acm will ignore it during probe time, if the
Kernel is built with support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 84d6f7df09a4..30e20d06d044 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1864,6 +1864,12 @@ static const struct usb_device_id acm_ids[] = {
 	},
 #endif
 
+#if IS_ENABLED(CONFIG_USB_SERIAL_XR)
+	{ USB_DEVICE(0x04e2, 0x1410),   /* Ignore XR21V141X USB to Serial converter */
+	.driver_info = IGNORE_DEVICE,
+	},
+#endif
+
 	/*Samsung phone in firmware update mode */
 	{ USB_DEVICE(0x04e8, 0x685d),
 	.driver_info = IGNORE_DEVICE,
-- 
2.17.1

