Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE41A29EC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJ2Mwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ2Mwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:52:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:52:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f38so2268004pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6cYmcLzWqn8t2raSoU3UXP82vHv3Ts4/10s9DiA55o=;
        b=Wgs/1kG7yeta/HhuEd68GrCzeCJmFrctToJX/UfKovkLcp28DQFYM2BNWCWmUMNmnI
         ra+Ymuvx4utk5pduPoce4EHZupGHys5WwNaIsGM+mXKfhJvcazzet10rJ+yZxhmHEayj
         0FCg0vBxxixCvpQmOFsAMunZb0NhIYGlAPGsW8uXeLGmJu/jJALyeJhg+CXE5CUccgiS
         KsEat9DmRWpbFKoZDkWLZVMitWTRNtZNYCeAvrRa3rbq0x+bFF8N5CI2/iBRb8WwJOIG
         2AJmYjOZd0ZCBNFzLzfXJBC6fKRsobfAQNRCLaf0v9z07sNebJ5aJ1yUsUQxwiex6MBa
         nFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6cYmcLzWqn8t2raSoU3UXP82vHv3Ts4/10s9DiA55o=;
        b=TUhFdNk+nDVHGPlodtQ/FU+NE3So2wticHseKhOgb+dRFgAYRYDHFTx9pPy0oNh6FM
         9zkZKAUZRpUvSwUvrWDXoQu8EE4/bS9q/2QYg86tvPQsi7kZGXhsJM5djQ6XgGEhdQqq
         iQt9XGYCTej/PyBJPJW9PWx2yui9UNyPLnc1K/PswP/pZ9qt3T83cayj2bHP7YYdzDnv
         kKuxIsC8uls3zl1p28Ui/dSaIHYdp9tsIxgDrEXeSEWX+JxO24ktTXGHC3ekOowssxyi
         oC9Msl4lYSjAP3y8WUk4R3LD2BnxfhN1jKbevxcNkWVOehITPJFaeKf4VwRMg6uqImPZ
         M91w==
X-Gm-Message-State: AOAM531UZ7rV3j0f1DYI0DetQBUCKIsfNrQ4tByiMhQafl0mcRKeZQAm
        VtELM2bCwxZwip9l9Jh0qBU=
X-Google-Smtp-Source: ABdhPJwIFu3QhVL1EyTJYlcUSbYFJu3rXpJRiIlfxXx6/WUz+QZGannT1zfXk5AQiA0ifgK+uBBkYA==
X-Received: by 2002:a63:da57:: with SMTP id l23mr3808579pgj.390.1603975959273;
        Thu, 29 Oct 2020 05:52:39 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id h26sm493641pfq.139.2020.10.29.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:52:38 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V3] drivers: staging: rtl8188eu: Fix spelling in two comments i.e defalut to default
Date:   Thu, 29 Oct 2020 18:19:53 +0530
Message-Id: <20201029124953.3957-1-unixbhaskar@gmail.com>
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
 Changes from V2 : version change to reflect the correct one.

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

