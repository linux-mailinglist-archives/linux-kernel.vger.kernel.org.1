Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93162D21D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgLHEJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgLHEJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:39 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1FC0611D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:58 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n14so15622109iom.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MaVqJz1MuuStc7gDSsvfbbKwLVl2c/1PaFY5X49f+I=;
        b=Dw2PYBS7dZNE4iApn4YXNNn/BPheR9wKellsPeZngD3fTgGfr57vWfsZh/iU0WSkTi
         uciEUxlx46dda8SwY0QnkhlvY5DNR4dpVrCK+A6U4h/1dm/COuxJ8YkOzXDkEIYe+RyM
         TBerNobNeuqUvxuyNj7QCc9RY9BSbdYMzxJ4XcsnfTQDnt98eOWT50RMeUIZWRTjmsdF
         qN+hW8ryeXP0hAyJ7xys3jTRl4r7a4Q/Gvb/FyhliRcah+yOMf+y+4zT5/rDxqakYGe1
         qP+GAGkiPJVywVNeHWOzlACyAF6Ig78MBrfZTZ7RYQy0JVbPmxGUWLl5M0f9wwJ5Mv/B
         dwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MaVqJz1MuuStc7gDSsvfbbKwLVl2c/1PaFY5X49f+I=;
        b=cDmg20x+ogADlfQXTLpb+sG4pHFjp8h/iPGgaqi9IfVWNPHnr4egb6Kem4W+CAmyGb
         bThTFO4+UXlFvBgD+UM8CLA/vRBmWWvtWeOZ+6j5SvHMpm2XIuynYstwpXWtcyTwDEXK
         o7/LxaiW6kuU3peKy7lziNCgj/J6yTAXhLtqaUiU0p7bFYbz32V6+W3iLFeOYYoCUq6x
         MGnYBC0Xp6NwN/lcZHjA97tt/616P4GdHosOTcoRN9BNBVkzBTxIkP8680JHFP9fbsw0
         r9rzq11Sw+0zww5HDo6tLOtzFbP+tOPTDj0saeyD03X5xjmwhaUOZOqGHpXJVibjSlwh
         9SYQ==
X-Gm-Message-State: AOAM533byBd2T6Z5/9s2ZSLY1Lvu4GjAolWzmA+d8QX5F90r/OV6ho0F
        4rud+va3rPmDMrPVpNVtf91PblrUX/o=
X-Google-Smtp-Source: ABdhPJwNTdDKjmZcYmE4d/l04GJR52zwFDSWh8HKV47/GioKHFbmbKYYC8Js3uH2Ow25r5WpERbboQ==
X-Received: by 2002:a02:a419:: with SMTP id c25mr24706945jal.91.1607400478188;
        Mon, 07 Dec 2020 20:07:58 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:57 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 18/21] staging: rtl8723bs: replace EID_BSSIntolerantChlReport
Date:   Mon,  7 Dec 2020 22:07:30 -0600
Message-Id: <20201208040733.379197-19-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique EID_BSSIntolerantChlReport constant with kernel provided
WLAN_EID_BSS_INTOLERANT_CHL_REPORT from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b6e255f6cdc5..9d172bd23911 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4160,7 +4160,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 					}
 				}
 
-				pframe = rtw_set_ie(pframe, EID_BSSIntolerantChlReport, k, InfoContent, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, WLAN_EID_BSS_INTOLERANT_CHL_REPORT, k, InfoContent, &(pattrib->pktlen));
 
 			}
 
-- 
2.25.1

