Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865626A276
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIOJoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIOJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:44:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7355EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:44:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so2745070wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MZenw7ivkEO7G0cqGbvnXeO0j0tykvYhq7DAb7ri5A=;
        b=QwexKL3/mXpdmI3QfPiic+6kNLVREkv+eBUeY4gzTMZ8JLvTMGXQ+UJfjm8NR4A6U3
         PBaE8ktM9/9QPojYJV2pUXFfq2+cvOWDW0fkHuVx3+eijz0f2kp2B//5Ojk7QRWT5ly6
         RJ/90ybEy9tCcIpZLXFLlMO+tJxqseWAaG2hvGq/0vP4TJOJEmzBpHP74xDUqkGC+sCn
         rJ5ggnlVajI03rpZ4muu3MuMO7isGf214UcggMGQMCHppH6D6B3aviMaUX95eUPguYdZ
         mEqADPUX96pHo2IaZGs2Pr4ykzAnAtGAAQ9mZoWW5KQGg4w/ArQjwwHk+7lVIRGQ1kKB
         C5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MZenw7ivkEO7G0cqGbvnXeO0j0tykvYhq7DAb7ri5A=;
        b=D1yz/bBQb8Hk28drl9N36l8Cd8DqqIlKBRbeM0/LSbMV330e2UI/RLH+LZ0j5+WLei
         trv6hJi0a3ar5UpEhpqPzi4oA3TZw9pWRJxZwGx6RH2bpnitiJBW7WTx0boUOQzazBy/
         IXOlk86A2bSjEQnU3DCkUzdX46Zmm3xb4S8VFVCtKUo9IjqnmYeSNwoygE2MjP7RfrDo
         VCf2G6baankWIZLB9A7JT50g6P87Sbybhkim5T6JDp0jKn30QbIiS9gineQhLIBhWwzL
         Ewe/aTsHhPkaiRN3ZcuwNhTzY8gSbvdIjPzv8fsvjDTXDVYqp8xWxYVJG43qdIyH9Wqc
         RSrw==
X-Gm-Message-State: AOAM5300/hrqm9SkKYv1HnjCCGrE2UTDBSBKJum+VDPyabMvkGIqAnPf
        XwggxXW1kIRCoMdlkKABI04=
X-Google-Smtp-Source: ABdhPJz5jdPwQfUSVTZM76f+2wCqMeIIFzkbMvMWQ4M2CCmdbqpMG6URc2VFaUjtSpl2wwdscUAX7w==
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr3701532wmg.173.1600163040073;
        Tue, 15 Sep 2020 02:44:00 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id 91sm28149156wrq.9.2020.09.15.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 02:43:59 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] staging: rtl8192e: fix kconfig dependency warning for RTLLIB_CRYPTO_WEP
Date:   Tue, 15 Sep 2020 12:42:10 +0300
Message-Id: <20200915094209.22664-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTLLIB_CRYPTO_WEP is enabled and CRYPTO is disabled, it results in
the following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_ARC4
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]

The reason is that RTLLIB_CRYPTO_WEP selects CRYPTO_ARC4 without depending
on or selecting CRYPTO while CRYPTO_ARC4 is subordinate to CRYPTO.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: e0e3daddad36 ("staging: r8192e: Fix possible error in configuration")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/staging/rtl8192e/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index 1007eea6c8fc..5ac06061cfce 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -35,6 +35,7 @@ config RTLLIB_CRYPTO_TKIP
 
 config RTLLIB_CRYPTO_WEP
 	tristate "Support for rtllib WEP crypto"
+	select CRYPTO
 	select CRYPTO_ARC4
 	depends on RTLLIB
 	default y
-- 
2.25.1

