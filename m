Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65D22D6C4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGYKa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 06:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgGYKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:30:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FECC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:30:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so6616134pfu.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57uUt3PSE6mzDygoHqoCo++awV+qrNFKFMncsAlSLb8=;
        b=MeRVsiWKP7IpjY2Oleb7YUL7lIACw3+XAuJEJydUpvT1lXp/Ggq/oYMqWLUKNFnDyD
         ihmn35hiaWGUdd16rTB0GNhBaAZH6AssqQKlw1Pa/QjDGMfCeIaNFc7G/zmAyMHIzBiE
         c01X/Aiw11Xwbnao+Z8ePHD/p0o4b6hE4+hnBq8ZZLmADRnE4NHtYdwHdN2RsaKR6hQB
         A3KHpI/mnkkEAbeXEv1kooxNEnCtuBkSoN8uc+C6a7JsbhB5jzUCC8XS6Ld6QiUbVxRn
         AzCepakLEAZPBQvv/UICiOMnXSnwmZaixcN8hUemd/vUFuzjl1146BOu4NUfJV5hun4O
         GhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57uUt3PSE6mzDygoHqoCo++awV+qrNFKFMncsAlSLb8=;
        b=fIivJR6Szrn4mKRmdfv91y6gNvVgxqZrnikbMtvsZRJdOQKJqIDiYJJB5ZVJMJPYLb
         Ot4n0dsu50Oj+qgXvatrkB56VHZRgqd5EWiH+m9RfCi8qjiwoWmbCof452hDqYPBbpL1
         UcI6KPU3g3SW68fE543RHA8Zu54usQnsxpo3XvlFjE2/qnKtF+swssJJAQFnMrYA8jNw
         3k8cpZVQ+iMI56O6SBRkLmXHOHlj8WVpLS5e9HY4JPtgaCHNpJjzBMQMlZcraDHxKCPM
         JbPc4jPSbg/3lx9Rv1DKlLcdBfFwuJ4xYYic0qENe7kR5iBpiyNMI59M4nZCsdUnivo0
         Jm3g==
X-Gm-Message-State: AOAM5317jXPKm1k7BplDKitavfxlWLDkEBm7Tx4c9wVpXLMN1Z8zELWy
        XZQdUPP+b8kt0zME131aLZw=
X-Google-Smtp-Source: ABdhPJxPbDsWd3Twe2k17iP3Lf2crJgVogIVE5m2sfYrBO5WFpidaZYLbL8d2Hz/VRJvYkmkGOLYGQ==
X-Received: by 2002:a63:338c:: with SMTP id z134mr11756797pgz.245.1595673055726;
        Sat, 25 Jul 2020 03:30:55 -0700 (PDT)
Received: from localhost.localdomain ([106.51.23.74])
        by smtp.gmail.com with ESMTPSA id e18sm8964956pff.37.2020.07.25.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 03:30:54 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     anant.thazhemadam@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Rahul Gottipati <rahul.blr97@gmail.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix one coding style issue
Date:   Sat, 25 Jul 2020 16:00:03 +0530
Message-Id: <20200725103008.7261-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coding style issue that raised an error (upon checking against
checkpatch.pl) has been fixed.
Exactly one coding style issue has been fixed; as required by Task 10
of the Eudyptula Challenge.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 21f6652dd69f..dc22ee9c24ad 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -718,7 +718,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 				res = _FAIL;
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n",__func__));
+			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
+				 ("%s: stainfo==NULL!!!\n", __func__)
+				);
 			res = _FAIL;
 		}
 	}
-- 
2.25.1

