Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C232ECF62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAGMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbhAGMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:16:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A3BC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 04:15:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id r4so3372787pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 04:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9TCQ6C/YunsSznFXn3cNgWKl/p3/nhBeV7doRyTUnA=;
        b=fMgBEt6WLJ22Tku7dMkGz+lxsh5yEtgO3Myd9VFMXorNBjWpTpAR6B0yjshw38q1Te
         PVO0/5l5u96i6yVQj0cKdT8z/3BJdMKHNn8HKU5u7XnyXRjCP0FN3XJExxsjppXr9kOA
         ZkeWaNBRCMnXBerUmvEmtMBkuLbRNbeK/eiOaZflvCxohiS1PsPFhpIsfWOjodP8z5Dm
         sK6lCP/ZXk9ebGwJKZk8O6Qr9HyyIQ0ysLG2XdveLquDeXqDj+qSv3Q4CPZuMupNVQQt
         pMcAG61JjLtKWnWEzHVMrTVdcc3BqIljOt4+VZFv34PG7PpKJXZvxk7zy1va5nH3Ye4e
         kqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9TCQ6C/YunsSznFXn3cNgWKl/p3/nhBeV7doRyTUnA=;
        b=ui6+NGM3GQBWMETmOjxSNWYyZf4ORgDcpL6IKla9GJLVJSO1TMwjvKl086P8hc2GfT
         hnVXBQRxlRoRnOuYpvV8YO6RHC8f8nER73h4uVrAW1jZT3gwsCT0trgLAcQW+qDj/6Qf
         ZMcjKgR6Hibf29S8X0MQVA+sOyqL6wjkGdAyRrnfCMdOIlZCT1T3lmds+N3qkcU9LeOS
         g42UF+4U1WNJUhZjahDYmv2d4xj0TvZRLhsiXiBlVFbIxogWq9KEdr8epAUqx7tz/RPr
         5MHXahWwtPXC6/x60YmLBxdISf0qiHgZk9gW4WkAAaIhJjPkcYbPXnsCYDZuJ3jCDpA8
         IT+w==
X-Gm-Message-State: AOAM532UXxouflO1i7Z4dIhVf4E2nb6QeioktitIiaLodTzutGmCWfnB
        0yz0D7pvIFN3Ef9vvNXqdtM=
X-Google-Smtp-Source: ABdhPJx/qybdFpp0YGfLA81eLyx7z+aamDpd9XnYNDbCwGC45P6Me+xCbb9VlGKg3YQs2o9vuwMjtA==
X-Received: by 2002:a17:90b:11d7:: with SMTP id gv23mr9138531pjb.2.1610021742564;
        Thu, 07 Jan 2021 04:15:42 -0800 (PST)
Received: from an990131127 (42-73-236-79.emome-ip.hinet.net. [42.73.236.79])
        by smtp.gmail.com with ESMTPSA id k125sm6317330pga.57.2021.01.07.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 04:15:41 -0800 (PST)
From:   Shuhao Mai <shuhao.mai.1990@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     inux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuhao Mai <shuhao.mai.1990@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: winbond: Add support for w25q512jvq
Date:   Thu,  7 Jan 2021 20:13:25 +0800
Message-Id: <20210107121324.2314-1-shuhao.mai.1990@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
References: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for w25q512jvq. This is of the same series chip with
w25q256jv, which is already supported, but with size doubled and
different JEDEC ID.

Tested on Intel whitley platform with dd from/to the flash for
read/write respectly, and flash_erase for erasing the flash.

Signed-off-by: Shuhao Mai <shuhao.mai.1990@gmail.com>
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index e5dfa786f190..b1d307fcdf9c 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -97,6 +97,8 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
+			     SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 };
 
 /**
-- 
v2:
 - Change the name to w25q512jvq

