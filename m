Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4E269A50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgIOASh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOASe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:18:34 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8EFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:18:34 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y13so2168760iow.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MzGmDzzjMGRgvfVFgDwfx6ad7ejBUYi+ZapK1NYg/6M=;
        b=PXonXvA1hrw4+waEQbI3TBhVYqBei3TzTYxRwdjmoZL2oyVs7WG2X+gV921cUIEjua
         42FI7EcU6EA59xKC+ioqJbD6szSBomN1mYXh0lnZ8StF99qOg9JTwuCWz8tEtruwibTH
         wwvBNFbI8LloKxFmtm8yZ2fijZBEQObWveRBUIs3XrK5W3Y1P0Id/DBSthmz1S8Inr6Y
         gfF3XJUPImvctdJhhzzg1FrPhETOLthgTzT5CpmXKmOMckw+KmPIiK7KK0Nqjrg/2aV6
         R0KkKLEDPIuUrVkzMS2oRAPdWa9Mc3R0/wUsTL8tIALRecsoq/qOtMMD7UBGmrQlLL0r
         Hd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MzGmDzzjMGRgvfVFgDwfx6ad7ejBUYi+ZapK1NYg/6M=;
        b=N9f0Ljpi87DPEVDxljAoY32b8BLUpdLeLK5E1PzrAKYCwo4zrwR0gsxdxNrUoamINY
         KxSNHiOfq8P3hJDldh6BrmPB9iPn8x4hukUoTKlT/n++2mtI3lgjdJdZqlJAMIjCL0C9
         yOcq6qaKvIieAYSLKDk5JO+2OP40EvHvhbQW4pmCzDsJEhnOQnp3dp5MRkNAVORheIV+
         turV8FsN9Bgpm3hENemJjZUeCk8NChitOwvKDHIP+Lrn/sIWvNnnUJh+UctCu0Yvli2+
         TXmpic7DfB5ul9BsFN+zSbVUe9nsFywOMXJ6dQmRPT0bdUFgglqO0ZCfiKYl1S+qUDWU
         b/SA==
X-Gm-Message-State: AOAM530PSYXqvvezsBp6o3/pWgvaLLqwi7ttiikYTip9EQap5O8cyx7A
        mOWR48mDrX1HcGC9r15qZv8=
X-Google-Smtp-Source: ABdhPJxzykrgWjLUZOVn7PzAbwA/sVS46SDOici23G0yyIjXt9iq4zZv1iAeWlcKmjUL/mnbW4umEg==
X-Received: by 2002:a5d:9355:: with SMTP id i21mr5781062ioo.199.1600129113386;
        Mon, 14 Sep 2020 17:18:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id l131sm6728975ioa.31.2020.09.14.17.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:18:33 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 1/3] staging: rtl8723bs: os_dep: fixed trailing statements
Date:   Mon, 14 Sep 2020 19:17:29 -0500
Message-Id: <20200915001731.28986-1-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue by moving trailing statements to new lines in
sdio_ops_linux.c to fix checkpatch errors.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 50b89340465b..bc8cef5589b8 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -264,9 +264,11 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 
 		*err = 0;
 		for (i = 0; i < SD_IO_TRY_CNT; i++) {
-			if (claim_needed) sdio_claim_host(func);
+			if (claim_needed)
+				sdio_claim_host(func);
 			v = sdio_readl(func, addr, err);
-			if (claim_needed) sdio_release_host(func);
+			if (claim_needed)
+				sdio_release_host(func);
 
 			if (*err == 0) {
 				rtw_reset_continual_io_error(psdiodev);
@@ -355,9 +357,11 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 
 		*err = 0;
 		for (i = 0; i < SD_IO_TRY_CNT; i++) {
-			if (claim_needed) sdio_claim_host(func);
+			if (claim_needed)
+				sdio_claim_host(func);
 			sdio_writel(func, v, addr, err);
-			if (claim_needed) sdio_release_host(func);
+			if (claim_needed)
+				sdio_release_host(func);
 			if (*err == 0) {
 				rtw_reset_continual_io_error(psdiodev);
 				break;
-- 
2.26.2

