Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2F29311D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbgJSWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733073AbgJSWTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:19:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197BCC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:19:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o18so934000edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1eT9+f8E9Rdu5LlhMetVCscQccHc6i1e7dX0+vR0H0=;
        b=fKLKZZsJGfqFbLfIScBogF6GMs2tS1L1qFyCLGRsvIBAT7YOT5KzZc2CMUxr6jCI+B
         oHgp3KLcUj7V5rCGH+HU1xcRbihZJTNJHjnWfuA3m2WR/9It+UaypdNqpRqezrAYf2bT
         wDEXptP2Dkx690t1nwf2ZFcrMIuoT3kKDPTytzv+FsSDWXU9QikA7MLYuwznN4zt/GDO
         n5N6p8udzD8xA5TPY//w9SMzUq43y7b29c+bBd01hmp8JArkuG1JZGsbsoOVdaLFGl5F
         bBdzbBPe05hh+XNtfYOWkRzBpB24xrDybw3qXb6XtdHwWrtDzDQd87qT/8QJPLCEg/KE
         V0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1eT9+f8E9Rdu5LlhMetVCscQccHc6i1e7dX0+vR0H0=;
        b=CKQ014jwfMg3oZ20UpTV2h9/+eonVT7vwCSWuUePL0DbBg7rl+UQUf00iECBwlZdEo
         QXQEGReMXW/u4Yhea0h7wC83X1ubPGcnhTn1XjVXkzCI+HKCYv0dEFzsYVC2DYxXKfLW
         KOw0Re91qX9SFnsiiBWn05lULuOvdoxIuiGLSsPyUgFAqflFB2JhU1f4zcwd7yKD+xJ2
         4KQ17XFeG7KvcIAvvk2NolahKOSgiV9RAKzpQxZk8nnR+Uyz3frPfzS0ghduLtN/WWTm
         nzNuh18zO1pb1bfNL9NcjVD2EThADDUGfNcSNCEohw3p7DnN2LxKrh7CZ3PUSge7pcas
         Bf5Q==
X-Gm-Message-State: AOAM531aVrcJSah1t20ZmwvllwI9XQvSPcpZR+fN4NvdLKJsHaZH1NOi
        J8+VA8M8kEwy7qSabCEb8iQXXI7a8SrXml+R9l5dX7e9G0PkL/XyecO2NYjbHfQ2eJkl8Zv46U8
        pd5IwZ9t0OCKni3wXqByXFZfaQTJoQrYbAkGI5Lmz0uletoL/hawHLD0quzu/NlSKrpoh5ftiuA
        zWuIgI5fJE9g==
X-Google-Smtp-Source: ABdhPJzn4Jj7OS31YF+yBfhXsRD+PbYIP2mZJM2yNeukc1mEegntzHXBcY+Z/yR/3aas3P6lynFQ1g==
X-Received: by 2002:a05:6402:124a:: with SMTP id l10mr1996766edw.99.1603145969470;
        Mon, 19 Oct 2020 15:19:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3001:fbc5:498b:ed6d:cfac])
        by smtp.gmail.com with ESMTPSA id e17sm1645400ejh.64.2020.10.19.15.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:19:28 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        marek.behun@nic.cz, luka.perkov@sartura.hr,
        andy.shevchenko@gmail.com, robert.marko@sartura.hr,
        Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH v6 6/6] MAINTAINERS: Add an entry for the iEi WT61P803 PUZZLE driver
Date:   Tue, 20 Oct 2020 00:18:59 +0200
Message-Id: <20201019221859.56680-7-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019221859.56680-1-luka.kovacic@sartura.hr>
References: <20201019221859.56680-1-luka.kovacic@sartura.hr>
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
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 867157311dc8..d56fdc300066 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8460,6 +8460,20 @@ F:	include/net/nl802154.h
 F:	net/ieee802154/
 F:	net/mac802154/
 
+IEI WT61P803 M801 MFD DRIVER
+M:	Luka Kovacic <luka.kovacic@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
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

