Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9662D0ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 07:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgLGGot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 01:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgLGGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:44:49 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FAC061A4F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 22:43:55 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t7so8827025pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 22:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MzWU26NA6WzGVu02R2++Pobfkc6wq7hjaCWSX9ojMc=;
        b=pcmgLXzy36HZaEATgxETcWogWAyO2mZ4FTMmpgTaX4L+oj4LW5Kb+zMnGBeHj4Cy5s
         nNyjB4FESSefsd+7agRvbSP7xOob/FNjzm4v0Uu+cQOeGULFb/+95ExGv8x5GzJyW5YD
         dBRZVhR0qSI9sryog4rURcCBXSsRFfcosaM2xT8SnQyExtvOEMgMj5PXq7k3d8oBxKc7
         DZBnw0sONT26YXMdlowx62kWDVjTG8HZytG8ZrH3+No3eHTJxtcrv8Hz9fALYkZDX90k
         ZmU9m3NsPMHAh7Cr4oWxlCzEMVzjltif1JS+948BtuGYJX76WPkVLkQ+oAYIfiFDZ7H9
         4M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MzWU26NA6WzGVu02R2++Pobfkc6wq7hjaCWSX9ojMc=;
        b=YQxW019vMR7z7U8s1yWvaUGLTedthXyd0SE9LybVvO7P6+ti4WNQB/QchBdGFdvZqH
         Q3EjC+mUJQb2Vfgq7ypD2z3zvbj4BoD64HBCiHoH/bFE2WeiLi2CAVwe0LC2MOR0STrW
         uuUubFQlRV5pzL63VTKGiq+hGZicm1diBRIqm1vGpBxSrwDUmDFJEzWLzzCzy5UzEdxw
         iGpaX/x9RxCfjwsBv2sr7ZWDzCqhP8kTUp7BDcG7GT2kJFPMoGbrbTKElQXjYyKvcB9R
         8b+8gko15g56+Lj2kZfRX3c88+GU3uviYkX1JRtG20SHf5V/iuBIXt0MaLVB4QmH+P4K
         M6uQ==
X-Gm-Message-State: AOAM530dwso/EV5uAoh7ghVCU+g5ngurT3NbCfcZU4/Ov+tOJjcJdPh7
        s4ALbZ9tPwKzV7BpzGcJ2XX77g==
X-Google-Smtp-Source: ABdhPJyL9fd9WGzslRmf14Luh5pVxh/d5EGWPI1fNAbgfIKcSBsaPibZqKtAc8hLEI0/0e1jd7ejNQ==
X-Received: by 2002:a62:1dd5:0:b029:19d:fc87:5f45 with SMTP id d204-20020a621dd50000b029019dfc875f45mr4817465pfd.63.1607323435367;
        Sun, 06 Dec 2020 22:43:55 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id js9sm22865087pjb.2.2020.12.06.22.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 22:43:54 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Daniel Drake <drake@endlessos.org>,
        Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] acer-wireless: send an EV_SYN/SYN_REPORT between state changes
Date:   Mon,  7 Dec 2020 14:43:22 +0800
Message-Id: <20201207064322.13992-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessos.org>

Sending the switch state change twice within the same frame is invalid
evdev protocol and only works if the client handles keys immediately as
well. Processing events immediately is incorrect, it forces a fake
order of events that does not exist on the device.

Recent versions of libinput changed to only process the device state and
SYN_REPORT time, so now the key event is lost.

Same fix as 'commit <bff5bf9db1c94> ("platform/x86: asus-wireless: send
an EV_SYN/SYN_REPORT between state changes")'

Signed-off-by: Daniel Drake <drake@endlessos.org>
Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/platform/x86/acer-wireless.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/acer-wireless.c b/drivers/platform/x86/acer-wireless.c
index e0976180532a..1b5d935d085a 100644
--- a/drivers/platform/x86/acer-wireless.c
+++ b/drivers/platform/x86/acer-wireless.c
@@ -28,6 +28,7 @@ static void acer_wireless_notify(struct acpi_device *adev, u32 event)
 		return;
 	}
 	input_report_key(idev, KEY_RFKILL, 1);
+	input_sync(idev);
 	input_report_key(idev, KEY_RFKILL, 0);
 	input_sync(idev);
 }
-- 
2.20.1

