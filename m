Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE29213A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGCM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCM2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:28:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB42C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 05:28:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so27542671edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdPnMWpdzrbRt67bwm1DSi25zLJwZoxDBnLs4+Vo1Kc=;
        b=LeMr/3viJFTLuBiXm/1Gt2XOp4NVt1yhM5S3mpv6VmpbHpvTW4gvNROilqjboxI90e
         CHB658uMrK6NWt/ID3/dbE4aRCfOphioEgOf9uRpa/cr3z8+QVl8WZkJWSUHjh8ShbRx
         Ck+4JK7AblunoWpQLcXnqSKbmMzB1ktpxgIGKS/UIgqNwIZj/pWxtDXa2ZF+OBwksdWd
         unlgRahUuLGiSJwi75cDzeYLJb4Un8fZ+gxVtda7AzZTN0vjQFuP3Xydl4+7A32eZpv3
         mhi9TDvp5Xh+8tY6JrzML8UW9y4juWEbAGP7kQ9oGT+LYXRHOqPrjjOUtzLx+98zdX7T
         BX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdPnMWpdzrbRt67bwm1DSi25zLJwZoxDBnLs4+Vo1Kc=;
        b=W8JRc6qbYDbEzKZ9W290eR+XQZapMQIiiOXohXb1Zm569gbgqnizPyZyuNnNqdiLm5
         2neEp0gvp/+t304egeneKF8sdvDT35Es1lPS+Q0JOkLQuYtDomYK9lirYT4hH3QuAK4N
         h/v6UL4w3URaIfanf2npHF3F880PgbB+6S4Ab66m7mE1g6pj64c5Sl8fcVarhWe1wgL+
         8pKLxmzkZDbmCkmTLf7wSiAKHdMrJCt76lOI5MPJ1QHiLXEncJj6RS1GuXOwYlOpvS3L
         rdZPudQPnJQza5+dNLzfRvmtF/iOLFHJ/AXaPN8iOQlvHOFTFGffr+3Lto13WJObCnDV
         roZA==
X-Gm-Message-State: AOAM532Qo3KYiCq95+VxxhJkKdzzupsZoXd/7nod40dw5UNZzqVaxJdj
        diYnlSu9eLd2hglli0s/T3w/FFKr
X-Google-Smtp-Source: ABdhPJyuADDVczzLUiRgHzdRGkfyQZ3YqlbQwkJymMzIlE8zKSBrh4pk7w+rI9DPgXDii1avw4XleQ==
X-Received: by 2002:a50:a701:: with SMTP id h1mr39251800edc.170.1593779329629;
        Fri, 03 Jul 2020 05:28:49 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-057.092.219.pools.vodafone-ip.de. [92.219.207.57])
        by smtp.gmail.com with ESMTPSA id v5sm8979874eje.88.2020.07.03.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 05:28:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8192u: remove GPL boiler plate text
Date:   Fri,  3 Jul 2020 14:26:03 +0200
Message-Id: <20200703122604.12096-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX identifier is a legally binding shorthand, which
can be used instead of the full boiler plate text.

The file ieee80211_module.c has a proper SPDX line, so the
GPL boiler plate text is not needed.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_module.c        | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index a5a1b14f5a40..c52540b734fd 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -9,22 +9,6 @@
  *  <jkmaline@cc.hut.fi>
  *  Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of version 2 of the GNU General Public License as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- *  more details.
- *
- *  You should have received a copy of the GNU General Public License along with
- *  this program; if not, write to the Free Software Foundation, Inc., 59
- *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
- *  The full GNU General Public License is included in this distribution in the
- *  file called LICENSE.
- *
  *  Contact Information:
  *  James P. Ketrenos <ipw2100-admin@linux.intel.com>
  *  Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
-- 
2.27.0

