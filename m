Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A982A2A35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgKBL6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgKBL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:55 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E8C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:54 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b3so8351164wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Z/rYVelMIJ0thLYpCaKwCBLjzrrX0gmiBVcQfZUNhI=;
        b=AiJMVfxKDihK9Za+BGUqabEGUMNQVBDKTAaw3DpR2BL6f/lmHDLx/Z2SDMfiDlfi5+
         hBUtxa4h5aQ4cwGakDVPV/nOssCfvfXSgcpbPXzcko79lDP2Ck49+/Suot4l5bxr9GIe
         xUAmoANIEsa5eR7C6GJp2GKLrTPnjW1K2p7BK+n8WYH2quE9lMa488UUeufSkta6wyJQ
         /JiaE0OClq6c5FsEYrjKYcqXhMVhFesegzhsis3jN4WNMicV37gPtcFYPL3b7dbNNnbr
         pWMo3ciRVYCs0uTn89AE917OtKQAuVMlvGcwz5BIH0vdmk455FJaCV3AWon3RFTV9sSm
         2T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Z/rYVelMIJ0thLYpCaKwCBLjzrrX0gmiBVcQfZUNhI=;
        b=Jj8nzNQMtX2ZMH4nUCjsssT1WBYLloZ7aO0u6KQQX6Tqz5N2R2vxv2P6VQrQqWOIoY
         xgqDEGEU9jDCUKBqp0IvCpStpZW1GS6e0DQ3lwPlIRzpQGn4siZIOVaY2IYdRr3omHz7
         MZsju/Zur6D2uJCWDQOmZj9rf5K/6mmQd33mXdSlZZsZ/Fa7K+EBx9OXAtd6Fy/7R8Vi
         GE5BkdI/FjHoZOdQ2Wk/PBMScNnhay5gGOFFBD5Lc23KYc9Exdg8VIFyWWBC8utXoA5a
         tVKND+m0eO3vR9oZOWgcD9qu1QLMDMBk8APnTnYQMEYis6vZeJ2DBcNkeO3lv5tIwhNZ
         1xWg==
X-Gm-Message-State: AOAM530z5bxp8WPh6JNLl1jzeHe1jSdZK+TOUrTLuL0QG37b4KtwpSJP
        YT5nqUY9xwcj8JzDHR6zwbe/bg==
X-Google-Smtp-Source: ABdhPJwn/y2U7nL+2COvmnay8P5hBVMTK2NdI9MUZNKZSkUuq9QTBQeMoUXwGjS6wm/kKvk4eyBTEg==
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr19557696wrq.259.1604318273004;
        Mon, 02 Nov 2020 03:57:53 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "C.L. Huang" <ching@tekram.com.tw>,
        Erich Chen <erich@tekram.com.tw>,
        Kurt Garloff <garloff@suse.de>, dc395x@twibble.org
Subject: [PATCH 18/19] scsi: dc395x: Mark 's_stat2' as __maybe_unused
Date:   Mon,  2 Nov 2020 11:57:27 +0000
Message-Id: <20201102115728.1077697-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only utilised when debugging is enabled.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/dc395x.c: In function ‘start_scsi’:
 drivers/scsi/dc395x.c:1359:6: warning: variable ‘s_stat2’ set but not used [-Wunused-but-set-variable]

Cc: Oliver Neukum <oliver@neukum.org>
Cc: Ali Akcaagac <aliakc@web.de>
Cc: Jamie Lenehan <lenehan@twibble.org>
Cc: "C.L. Huang" <ching@tekram.com.tw>
Cc: Erich Chen <erich@tekram.com.tw>
Cc: Kurt Garloff <garloff@suse.de>
Cc: dc395x@twibble.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/dc395x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index f838fe8d74578..7b522ff345d5e 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -1356,7 +1356,7 @@ void selection_timeout_missed(unsigned long ptr)
 static u8 start_scsi(struct AdapterCtlBlk* acb, struct DeviceCtlBlk* dcb,
 		struct ScsiReqBlk* srb)
 {
-	u16 s_stat2, return_code;
+	u16 __maybe_unused s_stat2, return_code;
 	u8 s_stat, scsicommand, i, identify_message;
 	u8 *ptr;
 	dprintkdbg(DBG_0, "start_scsi: (0x%p) <%02i-%i> srb=%p\n",
-- 
2.25.1

