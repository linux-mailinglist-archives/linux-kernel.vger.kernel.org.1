Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580DC269E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIOFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgIOFsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:48:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B40C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:48:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so1291794pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajoQueMBujUuw1C0JmEIu2PRwKxBFaE7by2u7sZoZh8=;
        b=lhwF0mVEGZ9J3xNUDzGy1qYVGT40a/VHeqrvRc0rB+l4kY17O5nWvmZ3KwXPwgYMoO
         +6HM2/5N/2OZUYKxr3mGw91wwiSlX5s+aNMBp3VtiHZO2jbVDTjA9IfBHKBAEWodac8z
         oe6uDZK42z6+D+5MJefG+sNmpqgWbe5D19vrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajoQueMBujUuw1C0JmEIu2PRwKxBFaE7by2u7sZoZh8=;
        b=aeiIChTHOdBZ2vUkcWROViEQ1sy7EioOVmMJn3FlEUhGcqZ9quwyTP7P4cJjN9YMaF
         JS4GXZp9deNUwUa2ppUsWVB/vW1YRghwfUNRVWNYM+ywk90duA+FXwb7N20uPFGu28ZK
         bYXNrEMbEEKb00AkQ18NNK9/sLNsqBD3hjQdLsWSdFRtpVkPlakySpXndPk7u6KOVkwj
         YyZL8n6mySreTOg8RsDMxdb40+2AfMsA8AtdAnj73NRpJQm+Ip8qTnY1VTipf3S/BIwW
         GVAEQNfQSU33WI3zL+fOHEYJSzq//b9zir8hRZ/YrU84uy3vylvo1OKCSclhFmLldGlw
         JQdQ==
X-Gm-Message-State: AOAM533nrff0wLWqxDK/+4iA42xEkGU9wBmCWv20u2r1Udgm+j6mfyXX
        pgB1dZoAeudlhhV8o2/NbM95ow==
X-Google-Smtp-Source: ABdhPJx0DAS8oOMzQIF5bJW2RhKW9+TgJutsnK0EusfXFCToH4RzyIAADhtvDYQNvLhwg1sFyQ8kyQ==
X-Received: by 2002:a63:5d07:: with SMTP id r7mr620189pgb.440.1600148930542;
        Mon, 14 Sep 2020 22:48:50 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id gn24sm11034935pjb.8.2020.09.14.22.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 22:48:50 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v2 2/2] tty: serial: 8250_mtk: set regshift for mmio32
Date:   Tue, 15 Sep 2020 13:48:27 +0800
Message-Id: <20200915054825.3289105-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915054825.3289105-1-hsinyi@chromium.org>
References: <20200915054825.3289105-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use mmio32, we also need to set regshift.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change:
v1->v2: none
---
 drivers/tty/serial/8250/8250_mtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 7b0dec14c8b80..41f4120abdf29 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -669,6 +669,7 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->port.iotype = UPIO_MEM32;
+	device->port.regshift = 2;
 
 	return early_serial8250_setup(device, NULL);
 }
-- 
2.28.0.618.gf4bc123cb7-goog

