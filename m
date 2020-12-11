Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67D2D6E85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395057AbgLKDZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgLKDZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:25:02 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABB3C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:24:22 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g20so3068728plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n/eeYVwxJrNDZsKAAjkQX08k6NxE/+8eKZlDKoFUrYg=;
        b=QmjV+uu8e0ptwQwnOHUl9K7/BIUfuWUoF4VdFRquA1cbRUQXBE9Lupbi+qMFBZOzP4
         cVJ4owdMaynzTOZ5q/NNTA0gO6LJ1ZfKio5Myou0C88hmJ+OU9A+NSxUSMIJDnh7p2pL
         lSiYJ4KVLzNgKBlWbvnvKHfigYA2W8NsD9UhjF8MT8CzRufbMcup2cmAdlYV77BPJ2KY
         gKmw4hnXf9mA4Mo/vYewXXGOJ3HUbh5lltetjx2momPOtT9otiz/OuM9LDukOdWOJ6p/
         g3Wh/StZcdpDX7aeIsp+bwYCnpGax0gDjQQnqwKWfub/f6+qNF3s4wWsmWU0QQm/SuRH
         eyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n/eeYVwxJrNDZsKAAjkQX08k6NxE/+8eKZlDKoFUrYg=;
        b=RdQ2mCtBMip0Zi0GEMytrOgH/opy+E2Kb9xWG1RYOwkODvaIWALhtQ4OQvniqqmzpX
         6w9ZSldNo5tuBHEkHTO4mGFkkiXV0oEEIU40jNKYDmsQ2xIXUwd+rjMFh+RA3KO4QfQW
         Ye+QwBQcmQmVZtyOYyMOJMuFXy3easbn1utQfCmnIeT/gsgI+017JQ6S881qz/CybxQC
         dnGPz4/rPkch4pFPZSgxpNMa9hbQxSPVMZZ31+CbSi0W5r1p4R40loU7FyjhiL7JKMSH
         sPsqE5oahUKjutST/vLhwH65El8oI9Vix8FkL/wzjmEa9tjjNtdnQ7r4qP3gPcCV+fiP
         /FxA==
X-Gm-Message-State: AOAM533vNwSBVmbkCrxL7dSQqDvKIZ12e2BN7Uiu3F9BfTB8tHhqpVHE
        KiZ2C1Z7xo4+Da4PO/hi3XA=
X-Google-Smtp-Source: ABdhPJx+B+SksLoGeJMA4Pcho3nS5bv70t+XUonxcQFIlK1pWG4Ntv7vND4ZSbGh4b26pW1FuUL83w==
X-Received: by 2002:a17:90a:f194:: with SMTP id bv20mr11048521pjb.11.1607657062401;
        Thu, 10 Dec 2020 19:24:22 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id u4sm7846325pgg.48.2020.12.10.19.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 19:24:21 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     axboe@kernel.dk, hare@suse.de, jack@suse.cz,
        gregkh@linuxfoundation.org, tj@kernel.org,
        linux@dominikbrodowski.net
Cc:     yejune.deng@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] init:  fix msleep() is not accurate
Date:   Fri, 11 Dec 2020 11:24:12 +0800
Message-Id: <1607657052-17608-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See Documentation/timers/timers-howto.rst, msleep() is not
for (1ms - 20ms),use usleep_range() instead.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 init/do_mounts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44e..e007b47 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -606,7 +606,7 @@ void __init prepare_namespace(void)
 			saved_root_name);
 		while (driver_probe_done() != 0 ||
 			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
-			msleep(5);
+			usleep_range(5000, 6000);
 		async_synchronize_full();
 	}
 
-- 
1.9.1

