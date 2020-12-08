Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA512D21D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgLHEJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgLHEJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:41 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C99C0619D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:08:02 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n14so15622178iom.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9YK23rigNo4fAHt5FAnHz48ScTShF2RcQD5zdVR6cE=;
        b=Wcn1Juryu3qkMZUKfIfG170JSh7UMKXs12S4Ml8pa09DSqzulQHnxGPi5zfs+lzueV
         kkr9Or9sHHxs8REwiJcdAHg4N6TehE5EZPtwYfGPSodtqgvZHReseyIG6ouT7e/KGW6h
         iog63eQumvX1bnGwoqhFK4NI26AkjHZRzKhNNWue1llPOvzcF+sSFyyENMjka5MjzMhQ
         3CBLEaTiUht2SnG0oTV3EGGDhOvQnD18d2dKZ82zriyQxNap3/wePAtBq8SN3QselckJ
         YbXCqn1ZiRosMq9u7jNrHMnp0afvvbEtI98NFCzmUiuFgRpzrNK9NA6lmlOg5+4AfOUu
         mniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9YK23rigNo4fAHt5FAnHz48ScTShF2RcQD5zdVR6cE=;
        b=Dsl5yZ4RClmkaZKDrFsCCG0s/8sHFWm2BpJmlJfpuBkqsNMC0Bjavc7yPSAYaQGQXC
         eHZC56NBKIbB5pbHEbdaN/XhvR2EW21DnYaIMWTXqB6m+bvi+yKQpiGdgUj5hQNpgVPO
         jc87Ear+YB4jAmHlDRJA9M7gOyUur1pscZ4kEwntUPjerMzYN92gJ6h50/XlctcL9huv
         Gtn/vloBxcbz/9pGuQn6lXwI9Y3ooV1zBIoB6fYiVodIq/47eBFT0FAkF12fTJE6DocA
         EfebPzjr6jKmpKVEm+F+Vq6TMAdzrhdhzOx0Rg6eV101a7PfS/81y20RI51eaR6orOR4
         s/hQ==
X-Gm-Message-State: AOAM532T1IAf4BKnEfgZFsBeCZ1iI6KtufVvjBtnqh7qSr6536f+/lv6
        7KUwPGxTFY6cglWGCfhkwus=
X-Google-Smtp-Source: ABdhPJxWb8DUiF60yGXfPP+EaqbFAuy3gs56WZmQ+rKN9NG+Xm2chom1s5shL8zHfpUS+Tpa3zgecQ==
X-Received: by 2002:a02:93ac:: with SMTP id z41mr24939609jah.127.1607400481315;
        Mon, 07 Dec 2020 20:08:01 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:08:00 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 21/21] staging: rtl8723bs: remove ELEMENT_ID enum
Date:   Mon,  7 Dec 2020 22:07:33 -0600
Message-Id: <20201208040733.379197-22-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELEMENT_ID enum is no longer used, remove it.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 76 ------------------------
 1 file changed, 76 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 7f482a45705b..fe984fcb66a9 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,82 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-enum ELEMENT_ID {
-	EID_SsId					= 0, /* service set identifier (0:32) */
-	EID_SupRates				= 1, /* supported rates (1:8) */
-	EID_FHParms				= 2, /* FH parameter set (5) */
-	EID_DSParms				= 3, /* DS parameter set (1) */
-	EID_CFParms				= 4, /* CF parameter set (6) */
-	EID_Tim						= 5, /* Traffic Information Map (4:254) */
-	EID_IbssParms				= 6, /* IBSS parameter set (2) */
-	EID_Country					= 7, /* */
-
-	/*  Form 7.3.2: Information elements in 802.11E/D13.0, page 46. */
-	EID_QBSSLoad				= 11,
-	EID_EDCAParms				= 12,
-	EID_TSpec					= 13,
-	EID_TClass					= 14,
-	EID_Schedule				= 15,
-	/*  */
-
-	EID_Ctext					= 16, /* challenge text*/
-	EID_POWER_CONSTRAINT		= 32, /* Power Constraint*/
-
-	/* vivi for WIFITest, 802.11h AP, 20100427 */
-	/*  2010/12/26 MH The definition we can declare always!! */
-	EID_PowerCap				= 33,
-	EID_SupportedChannels		= 36,
-	EID_ChlSwitchAnnounce		= 37,
-
-	EID_MeasureRequest			= 38, /*  Measurement Request */
-	EID_MeasureReport			= 39, /*  Measurement Report */
-
-	EID_ERPInfo				= 42,
-
-	/*  Form 7.3.2: Information elements in 802.11E/D13.0, page 46. */
-	EID_TSDelay				= 43,
-	EID_TCLASProc				= 44,
-	EID_HTCapability			= 45,
-	EID_QoSCap					= 46,
-	/*  */
-
-	EID_WPA2					= 48,
-	EID_ExtSupRates			= 50,
-
-	EID_FTIE					= 55, /*  Defined in 802.11r */
-	EID_Timeout				= 56, /*  Defined in 802.11r */
-
-	EID_SupRegulatory			= 59, /*  Supported Requlatory Classes 802.11y */
-	EID_HTInfo					= 61,
-	EID_SecondaryChnlOffset		= 62,
-
-	EID_BSSCoexistence			= 72, /*  20/40 BSS Coexistence */
-	EID_BSSIntolerantChlReport	= 73,
-	EID_OBSS					= 74, /*  Overlapping BSS Scan Parameters */
-
-	EID_LinkIdentifier			= 101, /*  Defined in 802.11z */
-	EID_WakeupSchedule		= 102, /*  Defined in 802.11z */
-	EID_ChnlSwitchTimeing		= 104, /*  Defined in 802.11z */
-	EID_PTIControl				= 105, /*  Defined in 802.11z */
-	EID_PUBufferStatus			= 106, /*  Defined in 802.11z */
-
-	EID_EXTCapability			= 127, /*  Extended Capabilities */
-	/*  From S19:Aironet IE and S21:AP IP address IE in CCX v1.13, p16 and p18. */
-	EID_Aironet					= 133, /*  0x85: Aironet Element for Cisco CCX */
-	EID_CiscoIP					= 149, /*  0x95: IP Address IE for Cisco CCX */
-
-	EID_CellPwr					= 150, /*  0x96: Cell Power Limit IE. Ref. 0x96. */
-
-	EID_CCKM					= 156,
-
-	EID_Vendor					= 221, /*  0xDD: Vendor Specific */
-
-	EID_WAPI					= 68,
-	EID_VHTCapability			= 191, /*  Based on 802.11ac D2.0 */
-	EID_VHTOperation			= 192, /*  Based on 802.11ac D2.0 */
-	EID_OpModeNotification		= 199, /*  Based on 802.11ac D3.0 */
-};
-
 /* ---------------------------------------------------------------------------
 					Below is the fixed elements...
 -----------------------------------------------------------------------------*/
-- 
2.25.1

