Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63612303780
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbhAZHvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730868AbhAYQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611593137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L83MYPgs4J2VwvcROYLbVnXEo5PX6k5Ym5D1jARCBQ8=;
        b=EFuN9b1Ian0iWl5P7VgeKd5BI8e30RJfhbjy+MVvvt9Iq9BSNkgtF1/P/3/HDKpRrbLIua
        +vmjd0qG0JVuYTZBfo9CpXG5xcIOXosTMGI8uZfyzBBNlpOenPl0H2OuxUTAajz4wtP+dL
        17lUjX+Aseq+1s3IyzPZc58tHel7mcg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-A4_2_6eANpa6eOefdzIumw-1; Mon, 25 Jan 2021 11:45:35 -0500
X-MC-Unique: A4_2_6eANpa6eOefdzIumw-1
Received: by mail-qt1-f198.google.com with SMTP id f5so7608534qtf.15
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L83MYPgs4J2VwvcROYLbVnXEo5PX6k5Ym5D1jARCBQ8=;
        b=Oip/44vcYp7AWclmasgpZQ0/dLXgca/c+U3O6tp6jjbNaQUPvLXE/vxD+RTSS8WSwt
         SAmxnNyFMtka8d/9diyV9M2+dSb4ycvB8e7S5ftHogyZz58drh6UtSr8MqVBG9+Bn2YB
         yxJFXTYdv0Y7G2hUv34IcQTCKF6G0HIIilnwQjSh/N8mGj2GLqO8khbn8SKIRW268xEU
         BEbYRAbxqscECL/DDwwmflEQOjDvRdFaXhDFdZdnbQpLdfS40J4ZBqKu1AUWdK7KT7Eg
         HnYrCdjs3Soa12nCNQkahx59wvb7EB1sugpMin6Nda6dt8lOZ7XrU2Zj8cGIIv0eHvHv
         7y5Q==
X-Gm-Message-State: AOAM532NrslFxUY6GAfTMZcRzO3vfzyhDJKBQfpfihEFCNNEgRGg7meE
        O03VRKFlE9Byjx7CcEnIR4H3yuUilr33PMrFW7csQ+oRX0BWv+HXcNP2ZM3HvxpEbq6xXdFmqFp
        frVdK/QWKMCcpKsI9ESiWVPYr
X-Received: by 2002:a0c:b4a8:: with SMTP id c40mr1586083qve.60.1611593135160;
        Mon, 25 Jan 2021 08:45:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9l+q5LUi2NmCnhljUwgezyQmGQ8e1AZtJkI9MpfC9tuDiC1/GVJ0StQQ2VZwdI88MJdlTcw==
X-Received: by 2002:a0c:b4a8:: with SMTP id c40mr1586073qve.60.1611593134967;
        Mon, 25 Jan 2021 08:45:34 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w42sm11941262qtw.22.2021.01.25.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:45:34 -0800 (PST)
From:   trix@redhat.com
To:     richardcochran@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: phy: remove h from printk format specifier
Date:   Mon, 25 Jan 2021 08:45:28 -0800
Message-Id: <20210125164528.2101360-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
  unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/phy/dp83640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 0d79f68f301c..1bc68a3bffa2 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -186,7 +186,7 @@ static void dp83640_gpio_defaults(struct ptp_pin_desc *pd)
 
 	for (i = 0; i < GPIO_TABLE_SIZE; i++) {
 		if (gpio_tab[i] < 1 || gpio_tab[i] > DP83640_N_PINS) {
-			pr_err("gpio_tab[%d]=%hu out of range", i, gpio_tab[i]);
+			pr_err("gpio_tab[%d]=%u out of range", i, gpio_tab[i]);
 			return;
 		}
 	}
-- 
2.27.0

