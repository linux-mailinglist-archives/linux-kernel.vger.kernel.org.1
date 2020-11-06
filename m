Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879042A8C6A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbgKFCDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbgKFCDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:03:15 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:03:15 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x23so1697693plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NC+atGFUi6vwoiZDzmkoV4QuOQM+7BMTlJs1Zix+bM=;
        b=l+Zn2nV99/s9Th+oltoendtP8fTizY/wyD54At5Udp35+b884QsDPb6A7MFFKpIKXM
         0MSJ39mwug8jE2TiF85S7NncBa+cYOsUaldmBewRk79cJrnvf9kYub6Gvq7NAdsslXYc
         vcAesC2AKobbm0761ugyjcn1afkffS7Vkp1YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NC+atGFUi6vwoiZDzmkoV4QuOQM+7BMTlJs1Zix+bM=;
        b=ZlABm+8J6kVl453w3wp0UGWx9GMkhZEV7J/n2fIHOf5xPUA9ssRocjY3atCa8Ipfif
         aSV3Ta22MvBx17IcRVScwAXwh7H0TuTRXdm1b8rzJcnDAvyQeQXQuTumNJ9tiYqlJzUx
         7ONcxgrE/SGPhKhgPY3AS2hw/uOXkRmXcMfOxFWoftAgVsNDBPQCKYSPbBhdzaKykFWT
         ZnAdEEQn751Ix4ocQSAFGND70HH2HJvIbKId6j0DXw4/JzcLHuYBHRFqlqVfKS4vYGcj
         5mrr0feU7Zb85LkIFKO5YzWx7UBh8q2BaUTihtkQEOAEZsIEQ8rYki4toALzisD6uOGp
         OCkg==
X-Gm-Message-State: AOAM531iPZqkwufNacHA0Ro5qugZ55nAO215HCVSXW4luRmTnSxNsc6d
        QNKAWL65WEMyWCUtT4W4Ac7h1lyX2NlEdw==
X-Google-Smtp-Source: ABdhPJwPyUn6k+ZaWf+GfIkrTKKJYQyguBRecWUyWcozdxPQqQCvPpQAR4/3mnj+mEUvesZU4yY2kA==
X-Received: by 2002:a17:902:8e8b:b029:d2:4276:1df0 with SMTP id bg11-20020a1709028e8bb02900d242761df0mr4769865plb.62.1604628194797;
        Thu, 05 Nov 2020 18:03:14 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id p11sm3777579pgb.67.2020.11.05.18.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:03:14 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Keith Short <keithshort@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Tolerate unrecognized mux flags
Date:   Thu,  5 Nov 2020 18:03:05 -0800
Message-Id: <20201106020305.767202-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On occasion, the Chrome Embedded Controller (EC) can send a mux
configuration which doesn't map to a particular data mode. For instance,
dedicated Type C chargers, when connected, may cause only
USB_PD_MUX_POLARITY_INVERTED to be set. This is a valid flag combination
and should not lead to a driver abort.

Modify the mux configuration handling to not return an error when an
unrecognized mux flag combination is encountered. Concordantly, make the
ensuing print a debug level print so as to not pollute the kernel logs.

Cc: Keith Short <keithshort@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ce031a10eb1b..5b8db02ab84a 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -537,10 +537,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		port->state.mode = TYPEC_STATE_USB;
 		ret = typec_mux_set(port->mux, &port->state);
 	} else {
-		dev_info(typec->dev,
-			 "Unsupported mode requested, mux flags: %x\n",
-			 mux_flags);
-		ret = -ENOTSUPP;
+		dev_dbg(typec->dev,
+			"Unrecognized mode requested, mux flags: %x\n",
+			mux_flags);
 	}
 
 	return ret;
-- 
2.29.1.341.ge80a0c044ae-goog

