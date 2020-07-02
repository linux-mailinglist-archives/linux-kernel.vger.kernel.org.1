Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BFA2126C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgGBOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgGBOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D9C08C5DF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:47:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so28761777wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMwEsthS2XYuYqGurNM6AKehw8G1mrvga4W0hde7UB4=;
        b=Ec9+I5hoL4c/OhbpQoBFb0y/CZVujjYmRsG/1zskUnSQq8YXfTxz90ThqQYnal+8DG
         q9ZnLOIeC0Y/oOcogCkBJL2g4xr6q75hsSFPpXIRVaWXOdizoz2be1Z5wgaXaTcZiTK9
         YZRONflM9w29AwuNQ/AcRDs5Lv6oRcj6CI8ycLh1AeT/5ElyI6syYd2uy+U+X+pfBqxZ
         shRBecxJWCSOZLUfRifV1q3PVl+kl9TW7VEbPnqwP2BQEd8p+t35ZDnT1SBdK25xWKvh
         5OI0Mfcv1M37zgWEDFdhWdMpVFiuIlRDKUGFF891sC232jg1ZlgkdUIgF5MAqOhVBMzW
         T4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMwEsthS2XYuYqGurNM6AKehw8G1mrvga4W0hde7UB4=;
        b=hu58ckGbsi28ud+3WUiNrdGYDGRyFP/Jok7Oo2Ke2Hk8aRfnvoCNFibPfctEa6tJbX
         cOpY9pAbQKZWna1Qe3Tj0TZyLWs+bP8MagBOBIeIz58sCf7juZkGO5KgiXqc3ysgV5xf
         GH9Ga6S8FRpvJ1RezlinGZuJY8hwJc1ryhjj6IdX16SuNdBidSB6BJ08aQEW4zQ+g3kW
         f0jCGVJl7NMz6ycIPGBo455SeyP6hWsp7GTK3jbauxczPSOWm3p+KC2xfPZXd35qNuXF
         mpW1cqlNe7hk319LNLBCdOTek+WZKHhW6HCJgK7kdAApTAmw3XIlYbNDzCluCrnbp6a1
         h05g==
X-Gm-Message-State: AOAM532VgHSKDFp7HWGPEi5dIXKX6PpnWevfO3/7slxJfuP3duX9ZfAB
        1DKlNBt2NXp9l/qWYNpO+ldtvKysnhw=
X-Google-Smtp-Source: ABdhPJw7EjXi0Slg9JA5tb8YCf/T1dmVYfymH7vJT4eCDqjnytPxyDPB10JCVTRNqKL+qKYBCha9jw==
X-Received: by 2002:adf:a507:: with SMTP id i7mr34858253wrb.0.1593701224905;
        Thu, 02 Jul 2020 07:47:04 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:47:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 27/30] usb: class: cdc-wdm: Provide description for usb_cdc_wdm_register()'s manage_power arg
Date:   Thu,  2 Jul 2020 15:46:22 +0100
Message-Id: <20200702144625.2533530-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A good attempt was made to document everything else.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/class/cdc-wdm.c:961: warning: Function parameter or member 'manage_power' not described in 'usb_cdc_wdm_register'

Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/class/cdc-wdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index e3db6fbeadef8..4dceaeca46e73 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -940,7 +940,8 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
  * @intf: usb interface the subdriver will associate with
  * @ep: interrupt endpoint to monitor for notifications
  * @bufsize: maximum message size to support for read/write
- *
+ * @manage_power: call-back invoked during open and release to
+ *                manage the device's power 
  * Create WDM usb class character device and associate it with intf
  * without binding, allowing another driver to manage the interface.
  *
-- 
2.25.1

