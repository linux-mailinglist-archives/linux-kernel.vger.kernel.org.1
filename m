Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB79292839
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgJSNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbgJSNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603114341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=D2hS302BQIxFqkZJYdUZZRcM72hDYJNZ0L302XD6ZGk=;
        b=LiRqxkWbCLLWFVkWX/XKjoRrJU8zL5g+LgM55uvRpYFZaRSJzWSHVpvtX93YqPW3xECUgS
        HvtI/bh/SpLnzkRkVziLwzPOMNAAMo/Bhsse5R6se1sPqcREexIQcAqe30+KlDoWJlFGxQ
        x/uQ0UmZfj+jj1X0nb740/9+nUFZwSw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Io9VYtkIPw-HZx_v7lZ9Eg-1; Mon, 19 Oct 2020 09:32:19 -0400
X-MC-Unique: Io9VYtkIPw-HZx_v7lZ9Eg-1
Received: by mail-qk1-f199.google.com with SMTP id y8so7200973qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D2hS302BQIxFqkZJYdUZZRcM72hDYJNZ0L302XD6ZGk=;
        b=OSy7ihJLaif9wR/Q8x7MeAIyDWQq43y11oJCWgkuw62Thf4NRMizD51v34sQLK/VDI
         vQbt4BJxx3GFGeOq3Z24e1TWB8mT+9Jm0LK0Fr/tn/Gy0cFmCRT4/xlGmeRSBdQrITmH
         e3RA+RcROka+ECc1J1vNHz5h5aqFfHRS9U3laP2BFlZMme+n/4iO0JdsxFan2J0Ek+xA
         otp3IcKhbhbiRfsbixcNvwI3wJSpLyXi6z37qm6gDB3LmbXltasstmAgJ/4m7eqSjK/9
         3tzAwPWDX6u75XGVM2Xq3Q6Ls+YS3S0p9FuzoSvn+/Mc+UVANL5esma5fHOJXHsxS+QY
         Yjmw==
X-Gm-Message-State: AOAM5337pH4BZ4MhTWcLCgUui4l0ujNkcxmjGsj5YG1ronod89RJp8b0
        6EWSYOmU+BLNBVNG7FD5OLnR7SorYP1893oj+/Xcu0UhfpZDGfDlFC4PwScMi08GL2PFk3Zc4GM
        kExraQteg67xSK2zWPX3rZu0e
X-Received: by 2002:ac8:4313:: with SMTP id z19mr3069623qtm.44.1603114339019;
        Mon, 19 Oct 2020 06:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHb8SJ6O+i94TVTF66NpsJNTNc2ZYIp7y9RbXT/7XfCFdh5MzP4tfoLDA6mUyCEN0mfn5mCg==
X-Received: by 2002:ac8:4313:: with SMTP id z19mr3069601qtm.44.1603114338713;
        Mon, 19 Oct 2020 06:32:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r62sm13097qkd.80.2020.10.19.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 06:32:18 -0700 (PDT)
From:   trix@redhat.com
To:     jlee@suse.com, hdegoede@redhat.com, mgross@linux.intel.com,
        malattia@linux.it
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: remove unneeded break
Date:   Mon, 19 Oct 2020 06:32:12 -0700
Message-Id: <20201019133212.12671-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/acer-wmi.c    | 1 -
 drivers/platform/x86/sony-laptop.c | 3 ---
 drivers/platform/x86/wmi.c         | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 49f4b73be513..1c2084c74a57 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -792,7 +792,6 @@ static acpi_status AMW0_set_u32(u32 value, u32 cap)
 		switch (quirks->brightness) {
 		default:
 			return ec_write(0x83, value);
-			break;
 		}
 	default:
 		return AE_ERROR;
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index e5a1b5533408..704813374922 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2467,13 +2467,11 @@ static int __sony_nc_gfx_switch_status_get(void)
 		 * 0: integrated GFX (stamina)
 		 */
 		return result & 0x1 ? SPEED : STAMINA;
-		break;
 	case 0x015B:
 		/* 0: discrete GFX (speed)
 		 * 1: integrated GFX (stamina)
 		 */
 		return result & 0x1 ? STAMINA : SPEED;
-		break;
 	case 0x0128:
 		/* it's a more elaborated bitmask, for now:
 		 * 2: integrated GFX (stamina)
@@ -2482,7 +2480,6 @@ static int __sony_nc_gfx_switch_status_get(void)
 		dprintk("GFX Status: 0x%x\n", result);
 		return result & 0x80 ? AUTO :
 			result & 0x02 ? STAMINA : SPEED;
-		break;
 	}
 	return -EINVAL;
 }
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index d88f388a3450..44e802f9f1b4 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1260,13 +1260,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
-		break;
 	case -ENODEV:
 		return AE_NOT_FOUND;
-		break;
 	case -ETIME:
 		return AE_TIME;
-		break;
 	default:
 		return AE_OK;
 	}
-- 
2.18.1

