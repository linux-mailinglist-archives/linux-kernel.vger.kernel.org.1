Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF527B192
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgI1QO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgI1QOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:14:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7CEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:14:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so2000667wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQ50YOdSxMFM9m16k7oX3RqYQsmb0wGwdxhkB/xdkZI=;
        b=F4IiLxRU+38SOWM2Zo9DyrYhODuHKkgzNLU5wXreYzrGzIdPmA7/WfsbOQHc6YbwMl
         RkvBkODb07+6jrRlUqfEK5EBGI+dovMXPu3n84tKt/j/5cqKhFyZONXKTeoEgp/zm46k
         HXkGNy2Y0F6sPzuqBf1KHZ/i0mOEWifr+ebJiD2wAI4jm+yqujOrCrMzWsol9nKGkS02
         DgqkDaqftN9XMwJsDwwTu+vnqKn/PP773r4ljEQPy2791DMnsVqkDTs/vj56KxFKeRX2
         vA7JomF7ZpldQNR0Sk3MXZugpBi2g6w6dz4j5inTVxAPi4Z8YwoSPIbC/Z9QrsvQxOv8
         BcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQ50YOdSxMFM9m16k7oX3RqYQsmb0wGwdxhkB/xdkZI=;
        b=lXQOZmic4MvR/8pzgGn5dLHeQ0RLLq5LakJtEaBl7FwAEg7VTWookayBWtYccFMclj
         bAnzimeTSMhWqYFSoafSM0BMb6sHsEubkU7NMBWTVmQ+NY0Rgz+FsmD2BalNvbxzKYNE
         vWWVPAuwhcIBIMd68+1boSLUVxcuufpHamplCdM0wZyAgrSIfF94QwnUjghSOk5rxNoZ
         VNkbv7mlHKlokd9H8DyVmQTTTojEDJbHVltoNZ4FUcWvjwTmf9/NFBd1v1xBqZykdBFZ
         DbUPeRSmA1+7B68BicdZIknsDjutinTIOTAOT9N1y+J+nWIvhaR8Oh8V5J+fHLcFxxWb
         3wRg==
X-Gm-Message-State: AOAM531c1bFiqKeMjV1RzE9HVuujJwiO5QuSp5sTBBfuPJmcsORLSo86
        YOAT5/F2mI9cBVMqQaiwkB/YZg==
X-Google-Smtp-Source: ABdhPJwW//5crbFbhjbyCg9NFbGj5IXDQR2SsEenMHBN4x/XWgT8Axtu5L8N0fsFYSu+U/4svi5Rfw==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr2470824wrg.131.1601309660731;
        Mon, 28 Sep 2020 09:14:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:19c2:a71d:5af8:dbf6])
        by smtp.gmail.com with ESMTPSA id n4sm2004867wrp.61.2020.09.28.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:14:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil-cisco@xs4all.nl
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] MAINTAINERS: Add myself as maintainer of the Amlogic GE2D driver
Date:   Mon, 28 Sep 2020 18:14:10 +0200
Message-Id: <20200928161411.323581-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928161411.323581-1-narmstrong@baylibre.com>
References: <20200928161411.323581-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01fb9ee6b951..400887118b47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11302,6 +11302,15 @@ F:	Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
 F:	drivers/media/platform/meson/ao-cec-g12a.c
 F:	drivers/media/platform/meson/ao-cec.c
 
+MESON GE2D DRIVER FOR AMLOGIC SOCS
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	linux-media@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
+F:	drivers/media/meson/ge2d/
+
 MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
 M:	Liang Yang <liang.yang@amlogic.com>
 L:	linux-mtd@lists.infradead.org
-- 
2.25.1

