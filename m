Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554C02DB4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgLOUWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgLOUW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:22:27 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38692C061257;
        Tue, 15 Dec 2020 12:21:47 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so42739612lfh.2;
        Tue, 15 Dec 2020 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtdH0LNE+NSh6TW8ldGVLX31qyTyLDOz4GRbXPCqTQ0=;
        b=JJAwolf5vyTCjYLv6qT+h+KCPXlFFnj5p/D/kGRQVyqeVQv5XWe+HzpA5di+MRXj1E
         9tzQGum618T5dEEjjTJ3Yn7QC8TPgeMhRdmAPkBBCrtiizeMzT37UnN+Vw166bORwWAD
         /folXNiPFzJeJvBdZOcze9xzFX2fQVEJxIkwwcA6ZmX8/gL5oDEKG/557dNdp9R8dEDN
         035G5Sjp3t0m3wnzJdwn5p8UqcdJzTZryi4BHo8W6xeY7lc9tJ5AjdIzAtnuGHC9hbYA
         5eH1CDY4ulErdyh92YwUhm99TR2cBBVYofUTsKCGIM9jL/eNGA3GkjzRt/sbuS3L+oEV
         gOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtdH0LNE+NSh6TW8ldGVLX31qyTyLDOz4GRbXPCqTQ0=;
        b=J+K8gGgdrp+YzB5x+PcGBWdHxdIL1OZ8MKjHfNu9InILSll9yoRrEyI0SWBB/AkboQ
         5lpWe9DL0lKysZl+3SF/hhdnXK+E6Rw4hglRYApctkJrfQA4VIVZVFbLbTraXLNw0CVM
         9Z9Hv5ZBYCj0DtyEcr11CntqzrBxrJ6LQ+4cxZxUmA6flI5OVOscNyoEJngOTJQxFFUh
         vlh8IPUPENiRKr51ZEYQVMtnKUOfldjc2ozJOTVrYJkeqK4f4ziKsOoO+EELfrs7BLyg
         /sE1R7j010mlZcmQZw/r1wQej2bRtA5mF/ooOzTgGCwS2cl7sIb84vFrkqcFC2H1XVcs
         bf7w==
X-Gm-Message-State: AOAM532zdaUVO+MSldK7GpVDwjSnrLQsdTJiJWfzphuMBsC7I076C7fL
        xfiQxxdSsb47dsNgDojzAVU=
X-Google-Smtp-Source: ABdhPJzITjqOSIEwAgaIe7Ic1rXMNJAekEbaepZ8B4LNaIUWC63Ul7cV5BeIKu5fRvTPGZ4cIoi1Dg==
X-Received: by 2002:a2e:b0d5:: with SMTP id g21mr13163485ljl.372.1608063705777;
        Tue, 15 Dec 2020 12:21:45 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f3sm2873711ljp.114.2020.12.15.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:21:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/8] usb: phy: tegra: Add delay after power up
Date:   Tue, 15 Dec 2020 23:21:06 +0300
Message-Id: <20201215202113.30394-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215202113.30394-1-digetx@gmail.com>
References: <20201215202113.30394-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY hardware needs the delay of 2ms after power up, otherwise initial
interrupt may be lost if USB controller is accessed before PHY is settled
down. Previously this issue was masked by implicit delays, but now it pops
up after squashing the older ehci-tegra driver into the ChipIdea driver.

Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 03a333797382..cee9c9dbb775 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -784,6 +784,9 @@ static int tegra_usb_phy_power_on(struct tegra_usb_phy *phy)
 
 	phy->powered_on = true;
 
+	/* let PHY to settle down */
+	usleep_range(2000, 2500);
+
 	return 0;
 }
 
-- 
2.29.2

