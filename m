Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD82DE281
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgLRMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgLRMMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:12:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43562C061248;
        Fri, 18 Dec 2020 04:11:32 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h205so4866013lfd.5;
        Fri, 18 Dec 2020 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb26vIZYqeziwIPNEQ8WVlNQ04/gel37gYLbp0DOH98=;
        b=KWGFFz4IWee7OD2piRCcpmdPhWVIxNVW/wQw8mLm1Ep/Jvgi4y2Ufrcucel1eYpH2I
         uaZcquGEPhiyDsFVJb4HGht5qr+K111F0dmEyn6M3lkLdwTzgOfgyBh8D0F1izSOagix
         Yjg0GqA/b1fExnDiLhoFNvok8w4a9IfuXpIVcF/P3Y+2flLsZEvcz1TNKzwvv0aTFj95
         NXtVa1g+Gm2aL6e8jZNtC0BUVGB1NN18b5hmdg6dkN8vxx9JfqshX23q/WBfmWw6W49Y
         A/ZoykIHjmhAfphdHYe1NdqI1Jl0zaz+MqcwyTTdq+VpP1WKsOduG98aGMhUeHn2CHTX
         LJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb26vIZYqeziwIPNEQ8WVlNQ04/gel37gYLbp0DOH98=;
        b=ClZkJuLMsGPNhPCgFnyUwY7o20F5EdqZbPjlmnRm5ZnR26/DCGU3mhgr2u/nObS2Hh
         7BvFryng4shCHqYrzINncLOEk/yFQBaJ7VhHJjRa0p9cfLd4Ow3j73vKd2dolCAY7q7T
         ohwi9zO5HCrhf2MWm33iQDGtluRy6C7SWzUQuDnUqCI1vrvYYKECXsxaJi6GMSZRK50O
         d3osMT5ef1/nEjxUaK3DaurNb+ll4w+8D790DKXYA9+nlsUuJdojfZxdW6KAig8ieU6e
         NIZUcFtrguwsvzMFiS7nmYPAmp+tIKIJAio7wqpGywo1wXLtQipLfxrlAu8AMTPTV7Au
         OJiA==
X-Gm-Message-State: AOAM531JQfQpeOQRtaUv6rNBr38RPJDpIldbZ0HdBGWM8ok2IVm/x/mX
        8AjNdtbiszs5u3zNWIDylu4=
X-Google-Smtp-Source: ABdhPJzvNJdt6gjSkdmyX66B0R2GPawK0k1IPzkajYkhnLWXW21G4TsLpr94bIki0hwptfoJ2j+nLg==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr1583096lji.209.1608293490838;
        Fri, 18 Dec 2020 04:11:30 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id i9sm1036472ljn.18.2020.12.18.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 04:11:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, Ion Agorria <ion@agorria.com>
Cc:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] usb: chipidea: tegra: Remove MODULE_ALIAS
Date:   Fri, 18 Dec 2020 15:02:40 +0300
Message-Id: <20201218120246.7759-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218120246.7759-1-digetx@gmail.com>
References: <20201218120246.7759-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF core adds an alias based on the OF device ID table, which is enough
to have the driver autoloaded. The legacy MODULE_ALIAS macro was relevant
to a pre-OF board files which manually created platform devices, this is
irrelevant to the modern ARM kernels since devices are created by the OF
core. Remove the unnecessary macro in order to keep the driver's code
cleaner.

Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Ion Agorria <ion@agorria.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 7455df0ede49..10eaaba2a3f0 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -128,5 +128,4 @@ module_platform_driver(tegra_udc_driver);
 
 MODULE_DESCRIPTION("NVIDIA Tegra USB device mode driver");
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
-MODULE_ALIAS("platform:tegra-udc");
 MODULE_LICENSE("GPL v2");
-- 
2.29.2

