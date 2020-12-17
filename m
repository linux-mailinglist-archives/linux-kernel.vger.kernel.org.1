Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13FB2DCEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgLQJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgLQJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:46:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41FC0611CA;
        Thu, 17 Dec 2020 01:44:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x20so36201089lfe.12;
        Thu, 17 Dec 2020 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiGZvLOgQKcEvFh0a0FUmNFhvqrnqyE23ruUDRJZB2I=;
        b=bJaUBEUrRVNaJKSroeHcNR2iyhlfdtISVv6VtoBzpoW3h3EcNNEgHIyolw+N+AqEha
         eAvslM6vlg3iMHRuWw61bGtmaIXs/X5F7aOOUsG8G78kVqL0A//2gZHj75VGS3Ji6v0O
         ead0dq+cfpWnzAgTg38/KQXUhJksqh5VFniDEODXICymN8uDK609I0QDIvOe9anLZKOu
         0b3H/DJ9OJ3oXubtoeqi79o+IG1vKyGFIHmzN/OjJ9SEEyvsekpmJU9ylpP1rRnQs1lA
         zTs6+bCdG2NbHHG0S+24Ai4zZatvCsc4BcIbniHOIi4tCGBhi6AXLmKpAvNpFU43OYNj
         nIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiGZvLOgQKcEvFh0a0FUmNFhvqrnqyE23ruUDRJZB2I=;
        b=D3mYUgIZvgm/DWdj4sehFJIhp4krIL80PxSKfNCnQa8oP1IQ6QgsdXOOtsWZchSMz+
         a56F27p7Yy2LeGykyzW9hjTlDBjq7yhDkNjtUOZNYjZHvketSQzdCu4rEJwV/i8Dt9RO
         cFo36izIkWXyoDvtpI+/XFiLbDePRPm7XOWqEKkUSPXnffKDr452JDMX2kmsN5/WebMY
         pDF/fHGGUhj/guRxdHA6koKPeonR3QfbzAqo8EnKlqKNkHh1VW3BrjSkEbgdC4/4PlrN
         LgUo6dTmnY+WW+5Ak1GgjhdWGgS89GjoD+W0JfEchxB/tOznt2lMsA3tFRrg9aPVpX76
         86Lw==
X-Gm-Message-State: AOAM530n3W6eDj8UZ5y9r5cl8vUYzfo8naCaMPFtqet4i8fjjzn5PZff
        DU7fBnOm2H7GCmGMCZvkCAY=
X-Google-Smtp-Source: ABdhPJwfhFCIk0ELGALVWMZvc0K7fA4ZP/K9n5/OyHwpd8iph3OXAtKks+B0Z+CSUfMjckENyxUVLw==
X-Received: by 2002:a05:6512:333c:: with SMTP id l28mr13790532lfe.164.1608198294237;
        Thu, 17 Dec 2020 01:44:54 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id u19sm613917lji.2.2020.12.17.01.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 01:44:53 -0800 (PST)
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
Subject: [PATCH v2 8/8] ARM: tegra_defconfig: Enable USB_CHIPIDEA and remove USB_EHCI_TEGRA
Date:   Thu, 17 Dec 2020 12:40:07 +0300
Message-Id: <20201217094007.19336-9-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217094007.19336-1-digetx@gmail.com>
References: <20201217094007.19336-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ehci-tegra driver was superseded by the generic ChipIdea USB driver,
update the tegra's defconfig accordingly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 74739a52a8ad..ae0709265493 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -237,12 +237,13 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_TEGRA=y
 CONFIG_USB_ACM=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_CHIPIDEA_TEGRA=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=16
-- 
2.29.2

