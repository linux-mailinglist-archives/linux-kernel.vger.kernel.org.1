Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA229EB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgJ2MKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2MKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:10:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D53C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 13so2177517pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3zwufxytovsv4kTwRU+SnKdZVRbVzOWxEcKZCYZJzA=;
        b=qMPSaiNsNNw1cLS/+knNFxPSAew/E3ROh1Rj3BJT2ujT/W6pNbKKGjfL5qh75gWxLW
         dzFRoWfhf3GYOnbEomh0cdRia4e24Fsrie4SI+r2ydiJ3ndOMY4sZm0puPCaBh+Q+CLS
         jkpraxFWJGESt8U57TNgsvwZqjdgM6NpcHi7xC3sxIHyKA/2LLIccSD441m1yS1RgTZ1
         syi9r1TBjFqSnDHRfcQHRhj6dmgZwATX7x+npojGAh1rxS9XLtBpJXS6CgyuMLW6iEag
         w/CDn5gA05HJLjKG5JSH9O3yo4m7HiSHcQ84WXhiew6sRuHV3MjNGU4VB2kFWGifJNBt
         4P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3zwufxytovsv4kTwRU+SnKdZVRbVzOWxEcKZCYZJzA=;
        b=VrnDqmW67EFwPNs4r399NVIN1OShC+LNj7GJSRjnTnrWSborWLcITjpi5dyOFe36xk
         Axfuih7/VbGOubouJRkaW4l1aDjNZ/neZJcM2WeoDuHWqgyH9BkNVwZMmANX2OFvoYyJ
         xTdoUUl9EQOl/zzH0jSP7PzRniGQIxvt9QJuGEqtfvRSlAQ0rCWxEWFHu+ooL4Q0vN0m
         wky9FrTh9pKTTn+VaVk5KHg3y8umWQfTV/Nnc/e/IFDxzpbm/iRV78cjjD0mwKdZWOSD
         Y3sTX24T8G59phcqYOhYbrE0t3tPXx+C/yYAGmN2bv34w4w6M1RvCscUjfdWWYkgbm5q
         bnqg==
X-Gm-Message-State: AOAM533zw2FhonUiZQaVfLnU0uausgb62i3AvgJ3vONBlBpQZx+p0e74
        VYEl0j1WSkdY3zCRxFp8r7o=
X-Google-Smtp-Source: ABdhPJx/V53I2aR34hRM5gw1I0M+6niOr2UOg5NebdJphF9Ww4O/OwCYFcBKYY1A1+in6Sg0d/FIDg==
X-Received: by 2002:a17:90a:7e4:: with SMTP id m91mr4322725pjm.47.1603973451313;
        Thu, 29 Oct 2020 05:10:51 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id d10sm2528713pgk.74.2020.10.29.05.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:10:50 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] drivers: staging: rtl8188eu: Fix spelling in two comments i.e defalut to default
Date:   Thu, 29 Oct 2020 17:37:25 +0530
Message-Id: <20201029120725.11666-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two spelling in two different comments.

s/defalut/default/p

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 1af919ff6d93..391c59490718 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -52,7 +52,7 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 	 * The base index =
 	 * 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB
 	 */
-	dm_odm->BbSwingIdxOfdm = 12; /*  Set defalut value as index 12. */
+	dm_odm->BbSwingIdxOfdm = 12; /*  Set default value as index 12. */
 	dm_odm->BbSwingIdxOfdmCurrent = 12;
 	dm_odm->BbSwingFlagOfdm = false;

@@ -109,7 +109,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	 * The base index =
 	 * 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB
 	 */
-	dm_odm->BbSwingIdxOfdm = 12; /*  Set defalut value as index 12. */
+	dm_odm->BbSwingIdxOfdm = 12; /*  Set default value as index 12. */
 	dm_odm->BbSwingIdxOfdmCurrent = 12;
 	dm_odm->BbSwingFlagOfdm = false;

--
2.26.2

