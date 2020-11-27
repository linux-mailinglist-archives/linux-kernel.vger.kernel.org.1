Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A812C6B31
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbgK0R6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732628AbgK0R6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606499909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4LunoHOSViYokVYuRCQyRja8YCLtsagi9dLGWhl23qk=;
        b=J+X0KHhY3a9WUY2q47gY3A6Rv1Zgz2tYurLlO7wew49c7pBDzA9cky4OOzOPZobNhYG+f/
        BLSDsqg1SRc125GAtHDNXGGqJB4lMivGZ8cCfLPwQqWiiAQXCVPRiayfrH4/++shc5/usu
        UBGxaLrASix8iYIe6zZMdcS8Fb1NGtk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-D_ktoVNdNG2YXnwq-9mrFA-1; Fri, 27 Nov 2020 12:58:28 -0500
X-MC-Unique: D_ktoVNdNG2YXnwq-9mrFA-1
Received: by mail-qt1-f197.google.com with SMTP id o1so3651031qtp.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4LunoHOSViYokVYuRCQyRja8YCLtsagi9dLGWhl23qk=;
        b=nQiPv7VRfPa8birdyiT6JGBeCKIXZGzo3M9BPTH087XAQJDfDSuk+56nPixU9Uu4W+
         BQRLaEnrJvM21iUhkdDdy7NNiVPqfFoJnPhmRIZcrtfAyklhCwjlpNy2Serm0BT3u1x2
         hdvg92yIqa5l047Kv4TBK6EJycWHpHG0IH3hGWpTgEiNvpx5+z50aEmV/frfTicNv+w+
         XtV2GfS2GNvchNNo0silV3xI0F1oeB6eFYKFbf7jrsPjojX2rLlR7kGuwiBpQm/q+RZG
         7V3SYavqgM6/1wae6mFlpok1bjUOs/SHf4l3FoIAfuABKVSs/s0ldkzcsrVKfGnWu1dG
         F+GA==
X-Gm-Message-State: AOAM530NPlayhPJDby42OfzkwdXxDCWL8fFPkF2EKxure4WidIWkOXmT
        36xLTbA8jTcD+ODZaf6TC6ZQjkhNlBpc0HstSsakjOmIg6O6UFXANswY5QQH/sWDs3Ig3Dlz6Zm
        RihOO3VTQL68OBQB8l9vajFA8
X-Received: by 2002:ac8:6b11:: with SMTP id w17mr9671575qts.150.1606499907468;
        Fri, 27 Nov 2020 09:58:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqc/CVfNGFpfgITGO2zbYhtL/kIf2QRQ37Phb2eGz1BpPgYqPvhZRP+ayREWsyzYkbW84qZg==
X-Received: by 2002:ac8:6b11:: with SMTP id w17mr9671560qts.150.1606499907295;
        Fri, 27 Nov 2020 09:58:27 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s68sm6416127qkc.43.2020.11.27.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:58:26 -0800 (PST)
From:   trix@redhat.com
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        bigeasy@linutronix.de, mpe@ellerman.id.au, lee.jones@linaro.org,
        kieran.bingham+renesas@ideasonboard.com, dan.carpenter@oracle.com,
        adobriyan@gmail.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: cisco: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 09:58:21 -0800
Message-Id: <20201127175821.2756988-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/cisco/airo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 74acf9af2adb..ba62bb2995d9 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -5785,7 +5785,7 @@ static int airo_get_quality (StatusRid *status_rid, CapabilityRid *cap_rid)
 }
 
 #define airo_get_max_quality(cap_rid) (memcmp((cap_rid)->prodName, "350", 3) ? 0x20 : 0xa0)
-#define airo_get_avg_quality(cap_rid) (memcmp((cap_rid)->prodName, "350", 3) ? 0x10 : 0x50);
+#define airo_get_avg_quality(cap_rid) (memcmp((cap_rid)->prodName, "350", 3) ? 0x10 : 0x50)
 
 /*------------------------------------------------------------------*/
 /*
-- 
2.18.4

