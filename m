Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18D26698F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgIKUfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgIKUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:35:18 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC931C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y2so7113460lfy.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cK3TK/fs1pnbnrA1hWHLmUQcDzDuC5CU6RbCXURphFo=;
        b=Almop6EGbfIXV3InpALv1RW/cCdrAzH9N+pnMrqDVI6PSyXDcts61KSAthYxbNw1oA
         W2CrRnUD3/pAuW5Z8bt7NtMuY2LRT6B9H6d1F+juFymwPxA8P9rnR4bHaT1wrbK1LNMI
         y9SMKwKymbxMsMZyr5siNxaNO3t6jGnryg1it2IHkSek14XtOelrSzLi5Xp2R07UKKfY
         c+v6F/FhxbC0O3qT4OxS1XKDf8vi/zt62FR7OPEU6lUs8l4Xg56PtYsOPv0UOUj3iwYm
         hfEWvri99d7ssSpb4JE52+t9Wmh3RHW47HDTOn/aGUWvUb3KxfLRkyMAOceArA3GaRrK
         fWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK3TK/fs1pnbnrA1hWHLmUQcDzDuC5CU6RbCXURphFo=;
        b=JTDkh69eqsOyHlKO1NtQAQpMDbBD2FwVHQvWRYYuhc34xP+a98okd5DaQ9V18PcJW6
         zV17bRbCqPsz3h37Qc32DQfnrYHsca4GK3K7PWR43E6ZMKw1dfpODCJ2iAnX6oRttr22
         2gLhYZ3skB6erXiYF4wteU3rYVspQAE73SP2jg/qI08JJlDoLSLd+LZascy8VKaaL22w
         QK9o35PVypTsnFzx3d1ZRgZouflAQPYDsyOoANz/y6t8mA34amLbMG32GboOJCnN76gX
         Qtip+NKBu2gAw/B2Q2d0iNgag3XsoEsiXw73ebSrjibYJTkAZ5bVwbVu0B8skVAWNo5U
         RgUg==
X-Gm-Message-State: AOAM533wRg5Q6/zWfi/N7SXMc3K+45IBXz0Izeer0IODuReLar1vNeaN
        kHB7vXCeamIYVHGhR3gTH48=
X-Google-Smtp-Source: ABdhPJynO/6gQoyzWIlfZQB7G1vrnKTbPTWgK+jqbykGdFE7AXv/8CqgNmCVKZtcUgYtnQE6ZIRxRw==
X-Received: by 2002:a19:4186:: with SMTP id o128mr1191149lfa.148.1599856516203;
        Fri, 11 Sep 2020 13:35:16 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id d1sm214390lfe.180.2020.09.11.13.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 13:35:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] virtio-balloon: Constify id_table
Date:   Fri, 11 Sep 2020 22:35:07 +0200
Message-Id: <20200911203509.26505-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911203509.26505-1-rikard.falkeborn@gmail.com>
References: <20200911203509.26505-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

id_table is not modified, so make it const to allow the compiler to put
it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 31cc97f2f515..481611c09dae 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -128,7 +128,7 @@ struct virtio_balloon {
 	struct page_reporting_dev_info pr_dev_info;
 };
 
-static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
-- 
2.28.0

