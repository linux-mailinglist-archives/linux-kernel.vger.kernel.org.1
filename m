Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079EE2678F6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgILIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgILItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:49:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B93C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id r7so16546573ejs.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNlcCZ2ctZFFGstfG2NKpVykJlm+0Zhh9Bla/mclhFc=;
        b=b5Gfedz+gPp1+6RaUAV8zy7K0+p3KhfHTn+qPPoyqH3KbpB65P5djELc54graLZ02E
         Qb1vT/w0dtsRJTz/IgaEI2QDX+xtbqcMrYyljB4exoZKWc2Mt70kiq2R8TgaW+KNWVZA
         pu0vg03fJMuxxmTjLHfi1xSK5OY5EZYOCHflacdIGsIGJlSYjV15ig3VUB8vdNo54ACc
         /Q57jsXENF7LQElqCavaMlKgzNoNtHhOi7spWhzQJxCrQGgoEhm1ku28Q//io5bStOBU
         RS/wHotpf6GxTG2jeoixrCmJ3ASkevow47N5nNKzTk0pwNrX4mQcQN86UzrOFhhg+/iJ
         RFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNlcCZ2ctZFFGstfG2NKpVykJlm+0Zhh9Bla/mclhFc=;
        b=oDuVELfLuWc9CgagHDOErxGnGQ+P2ADuWnPHrfKSpDVR31atCWqujRZHgofHXPTLHl
         piKpACffW0/tjMIP1RikXrgrqUJscl+lfJIW2XuC6O6NbEggA8cU3VZIJIzxLgfz9vJ2
         X8rw/lP8okF6pL6fSDf31KfiI4+CAo8V6TxSfkcOIDb7yBPygcN+cGe/+8IPK+oi9ppR
         5d1xQz079z+0FRh73T1fjQ03zRf5iYOVE3sdHTewrsAz6lq+o8cQfejJg8/HEmEJEpkC
         HXdwuzUuvj3t5SGERGgPmiAaVght2L1nmYD1D6ERjUHc6swiZKJbHJtXfWpWzyG34qdn
         9Fdw==
X-Gm-Message-State: AOAM530jsRfzREOXVdblyrJgooOdgCKEMmSNF+vsJcFM+DU/aecq/g3y
        GQYU0gzdH+F4X29WYadgN7Y=
X-Google-Smtp-Source: ABdhPJyNhpZuABz226SaBqkEh/eIC2A49g89/wT+lhD7ZhN9X8FCmqedCOT6RtxRrTDv6Mu18ouZkQ==
X-Received: by 2002:a17:906:ce30:: with SMTP id sd16mr5235036ejb.53.1599900569117;
        Sat, 12 Sep 2020 01:49:29 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id s23sm4009598edt.10.2020.09.12.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 01:49:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8723bs: remove comparsions to true
Date:   Sat, 12 Sep 2020 10:45:19 +0200
Message-Id: <20200912084520.8383-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912084520.8383-1-straube.linux@gmail.com>
References: <20200912084520.8383-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary comparsions to boolean values.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 7733d076af85..cad35ce0c21a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1767,9 +1767,9 @@ void update_wireless_mode(struct adapter *padapter)
 		else if (pmlmeinfo->HT_enable)
 			network_type = WIRELESS_11_24N;
 
-		if ((cckratesonly_included(rate, ratelen)) == true)
+		if (cckratesonly_included(rate, ratelen))
 			network_type |= WIRELESS_11B;
-		else if ((cckrates_included(rate, ratelen)) == true)
+		else if (cckrates_included(rate, ratelen))
 			network_type |= WIRELESS_11BG;
 		else
 			network_type |= WIRELESS_11G;
-- 
2.28.0

