Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBECF285598
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 02:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgJGAuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 20:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgJGAuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 20:50:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD5C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 17:50:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l24so357305edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRUXIUPW9gOf8Xu9KYj+IxZzLpARb4saek0+Bb/SUfA=;
        b=q/V3uGIo5weyK1Q3xEWwp7EZAle9uGvntQtycbOdoiMoX1VvH5qO60svdD2V/lI8zG
         GQPMIYJAu7KE7swFZgzQlZNudYXjJa/mar+wp53qD/WqRv1Jr7BqxY3/uC+S/QZO9206
         WxKSiiU14ZRA5T7Wwe/scXWBVbYJxzU2L/oW0zSjVjxbup7aF5YePNRm2SuWw/DTAELt
         68yPMIBczs54KF7yIsNiEoNdHU7tbs+p4BSRUVZj0LQ7VfKMTqE4wQzI2me0jq+7bUnm
         a03RKWRwutqqsSOCrxSOCJk0L/kIh1oNaqXIkfS9g2ZvFWPrjhVuCgrAvvhRILgqXAYZ
         NrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRUXIUPW9gOf8Xu9KYj+IxZzLpARb4saek0+Bb/SUfA=;
        b=Q2st/bxpPt9OJtQYESr5GpwBbKJv/7IQP0cEdgDfRK6xYO0d2dCFssNUUba3IRxyfD
         1VTRXyLQuLBOMwgl3xsOp+kdDzKp5XoM0jSKLB5wyq/pJF9hY2Uu73gQSjydbDyvGTdX
         AsbGtCiVLulT1B9qdL+2PRR131zR8/9nxUTbhDrCtZXfGjTsBXaeWkWF6We9GZSMASRi
         DYtH95ViTf+FKXeHntXPBEFGXatbIpZ1StwuQGUt22ncI2/x5QzHs9YomS70YU2gfXMa
         7tmfsHbGmoL/1oG36OrQijjqf6eZhoiwwPUk+bnDn2NRUj68EFhaOIfKgAiTE75vvd8I
         uh0A==
X-Gm-Message-State: AOAM532HxxY7tyFvRpdCkzJPyVaTQIuLVwAA0cX8KFcdKpTeq4zGIRMz
        8hpb3Nf73mdiYxP/FKzoCKCvp3BiS8t9WEGhBVVe7SboasN+vscDqA0isiAsWIxPlG58zF89as6
        6+exFe9VajQ3VWMMc+TTUi38ga/XzVNTW0X/ywNVdnBbrIW99bTVPDwzopLbsiYcDMYVexFrvia
        OlmEavqIm1Gg==
X-Google-Smtp-Source: ABdhPJy/KIFNtYEAMF5iDj0TRNRLBv5tDl8vpCTs6g16124IMX8nRVGsecZDCgSa0MIx/trUCyHskA==
X-Received: by 2002:aa7:d7ca:: with SMTP id e10mr807758eds.269.1602031805865;
        Tue, 06 Oct 2020 17:50:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3002:290:faff:fe54:449c])
        by smtp.gmail.com with ESMTPSA id bw25sm261090ejb.119.2020.10.06.17.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 17:50:05 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-leds@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        marek.behun@nic.cz, luka.perkov@sartura.hr,
        robert.marko@sartura.hr, Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH v4 6/6] MAINTAINERS: Add an entry for the iEi WT61P803 PUZZLE driver
Date:   Wed,  7 Oct 2020 02:49:01 +0200
Message-Id: <20201007004901.39859-7-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007004901.39859-1-luka.kovacic@sartura.hr>
References: <20201007004901.39859-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the iEi WT61P803 PUZZLE driver (MFD, HWMON, LED drivers).

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33b27e62ce19..7b17195511ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8455,6 +8455,19 @@ F:	include/net/nl802154.h
 F:	net/ieee802154/
 F:	net/mac802154/
 
+IEI WT61P803 M801 MFD DRIVER
+M:	Luka Kovacic <luka.kovacic@sartura.hr>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/stable/sysfs-driver-iei-wt61p803-puzzle
+F:	Documentation/devicetree/bindings/hwmon/iei,wt61p803-puzzle-hwmon.yaml
+F:	Documentation/devicetree/bindings/leds/iei,wt61p803-puzzle-leds.yaml
+F:	Documentation/devicetree/bindings/mfd/iei,wt61p803-puzzle.yaml
+F:	drivers/hwmon/iei-wt61p803-puzzle-hwmon.c
+F:	drivers/leds/leds-iei-wt61p803-puzzle.c
+F:	drivers/mfd/iei-wt61p803-puzzle.c
+F:	include/linux/mfd/iei-wt61p803-puzzle.h
+
 IFE PROTOCOL
 M:	Yotam Gigi <yotam.gi@gmail.com>
 M:	Jamal Hadi Salim <jhs@mojatatu.com>
-- 
2.26.2

