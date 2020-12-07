Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1C2D14AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgLGP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgLGP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:27:48 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C675C061793;
        Mon,  7 Dec 2020 07:27:08 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id g20so20079998ejb.1;
        Mon, 07 Dec 2020 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rp+P9Or0j6DWseCgzSCSqRpb92TpbMCw1CU1y05qoqE=;
        b=Pq2ZX5lkuoFxgjEs2KbqSFVL8cPKnNUupOT96huS/FSYFvGZngyjS0dyT0ePGCtmcB
         gi/GMTzAOEnvAUyxuDq5cP8wyz7sQcmF92iWmYEFgo7kgdu1sidKig17oX4pI7O8DXx1
         KrURhX8NWWPXWsbNp5MAvZqqlRUD8Wodenq9EBCEI+OX0bzjZ6xpQWoFhn6sBNOAjbjo
         eXwPMOKEWaNCbt2RJt2YoTVTPw3WFGUKHtS2t20PC0ebnTaDjuTrelb1c7k0nIYVmSiH
         upX7oDZ7ld38LnxUCLBcROz3K3WK3w05gVt993YAnw0bYDFCOBCFWZ4c5AHVyEa7ARgP
         z7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rp+P9Or0j6DWseCgzSCSqRpb92TpbMCw1CU1y05qoqE=;
        b=UvWwCK3gJt7thPm5rcNtHW+sVHNlKYez5UBKKOHe4Bli4/JR6Tgi6uQAWughXbyk7R
         dB28AVawOjlrjxuK9f5b7SC8lp5bYp/+iJFwUoGKV0xGrNHUyKwoXDTmiPTCEwrMbMvM
         GaGnZRite55Nb8Xi2XLRZ5TFoSW2n+WemlRxeHhEyx/Irh6Q32+bTbVSamTTd1l4HHo6
         gI6Mk295yA2sBSgkeqHVzGMQwLw1Fcx0fbm6qPC7FOOiqZJyEkjFMN7Qsm09dKgswCU3
         +UDGyIyvk7vBNWM+igssOHm1+wWXprSLCtCVGuVdhq5kaiLtHAfnV6zPxivWTf5t32AJ
         nPpg==
X-Gm-Message-State: AOAM532/1pVGQFwBRZUzEmIsahG1CRWoNLy2Jex86fT2/vZNKDuug7vz
        1d+JXz7QPEE4VXkQWAj7As4=
X-Google-Smtp-Source: ABdhPJwS+yVLfyk+DMzk+wdAwq7aCn8HcI2xyoCiXvzJWGCYxKrDcHFWVHOYMkjyDqbUA+sV2oJILw==
X-Received: by 2002:a17:906:118c:: with SMTP id n12mr19888808eja.167.1607354827345;
        Mon, 07 Dec 2020 07:27:07 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4a:c600:c0f8:50a9:4ab0:a9ab])
        by smtp.gmail.com with ESMTPSA id t26sm13928513edt.69.2020.12.07.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:27:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] hwmon: pmbus: correct title underline length
Date:   Mon,  7 Dec 2020 16:26:58 +0100
Message-Id: <20201207152658.32444-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b722d7b9e4da ("hwmon: (pmbus) Driver for Delta power supplies
Q54SJ108A2") provides new documentation for DELTA Q54SJ108A2NC* drivers,
but the title underline was too short.

make htmldocs warns:

  Documentation/hwmon/q54sj108a2.rst:4: WARNING: Title underline too short.

Adjust the title underline to the correct length.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies on next-20201207 and the hwmon -next tree

Guenter, Jean, please pick this minor doc fix on your -next tree.

 Documentation/hwmon/q54sj108a2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/q54sj108a2.rst b/Documentation/hwmon/q54sj108a2.rst
index fabce671985a..035312d25c34 100644
--- a/Documentation/hwmon/q54sj108a2.rst
+++ b/Documentation/hwmon/q54sj108a2.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kernel driver q54sj108a2
-=====================
+========================
 
 Supported chips:
 
-- 
2.17.1

