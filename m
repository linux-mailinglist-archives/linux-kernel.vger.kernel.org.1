Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E724F26A291
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIOJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIOJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:55:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A47C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:55:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so2598683wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJPP3VOUhhMjWg+fdtc10hDSx+5MSLkdMdu69j7VsYk=;
        b=oql0qcrxZ/7BkQPztc8ldLY4fggx/gEPNqio5VSAk60RK9YMp3j1LsItuUPW6T/Hwj
         VyKxcG8a3u48jSmd9vvCfYNfAEyU4fOkmTydUOXp4wEhwrwgNthmr75Nt51DK279LrqP
         w/tEtaXNcjX08510hi0Dc8T4DR1+ph//6c4NYyVyr0+nbXojgyiYIctqErjjnhb+E6TA
         trHE7CHLJKaCa0oXJHOyq/PEGcYii6yd3rnCGpehapT1gZzBKo0PqO3/s+uGak32kjRe
         wKH7h4ByLFUuTusx+IGW+jIz/QF7wXGcE7nMDIuG4Q95g2oYyho66F15p5xNzj073q0y
         aiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJPP3VOUhhMjWg+fdtc10hDSx+5MSLkdMdu69j7VsYk=;
        b=UN3iQ1NqKto1FMp+iLq5qs9elceNrlNnUSTfiXJgyEESEc6UTAz7CfBoOKgpDp+ui7
         zQ+6BIERtZQ7igwe0eLFl04fchKwVYMHAkrXnMBeKcBYci84AKiL+wL2NhHmVd9Hqfs8
         /TicIm58oDtsaDlG2Tr3aqPP8B8mSBtZDRR1I3WsfjyqRMlDfJ6gnqne1SK/cMTtZ3nm
         JHMQFk19ePvYUwv1/w0tlpV5gE0Ca4POXs/039To3zcpTLPQyeohpWB7OcrR7Dlt7iqB
         fylac+2GXvGlMx27yDssoe0aCCWzKyVlUIJlm7ca4x0Iw9MtDPC9FekDEPASujYqWxUJ
         VOpA==
X-Gm-Message-State: AOAM531Hs0yCtNzfL1LDWxMvpea3l0VouVW8nADwq060Ks1FKXOZb1pp
        ZUcn64jtLzM4NdlWEL7LikM=
X-Google-Smtp-Source: ABdhPJzhKG/JC+VvrxBavdCbabMiHAvZnjK1S/hwLH5C208sdsY37rEvlbYI3WwQ6gqvvphJMI3p2w==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr19959327wro.240.1600163717590;
        Tue, 15 Sep 2020 02:55:17 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id i26sm23903149wmb.17.2020.09.15.02.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 02:55:16 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] staging: rtl8192e: fix kconfig dependency warning for RTLLIB_CRYPTO_CCMP
Date:   Tue, 15 Sep 2020 12:54:09 +0300
Message-Id: <20200915095408.28092-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTLLIB_CRYPTO_CCMP is enabled and CRYPTO is disabled, it results in
the following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_CCM
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTLLIB_CRYPTO_CCMP [=m] && STAGING [=y] && RTLLIB [=m]

WARNING: unmet direct dependencies detected for CRYPTO_AES
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTLLIB_CRYPTO_CCMP [=m] && STAGING [=y] && RTLLIB [=m]

The reason is that RTLLIB_CRYPTO_CCMP selects CRYPTO_CCM and CRYPTO_AES
without depending on or selecting CRYPTO while both CRYPTO_CCM and
CRYPTO_ARC4 are subordinate to CRYPTO.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: e0e3daddad36 ("staging: r8192e: Fix possible error in configuration")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/staging/rtl8192e/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index 1007eea6c8fc..4f45a006f901 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -14,6 +14,7 @@ if RTLLIB
 config RTLLIB_CRYPTO_CCMP
 	tristate "Support for rtllib CCMP crypto"
 	depends on RTLLIB
+	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_CCM
 	default y
-- 
2.25.1

