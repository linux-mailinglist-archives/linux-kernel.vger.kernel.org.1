Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0760D2A2A04
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgKBLyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgKBLyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:14 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA9C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:14 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s9so14229838wro.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVJkW4LmyroUVjovOSWNFjSdGZNlIx0pxp8qFDF0ggw=;
        b=pAZZi3Uta7aFzWrgyCL6bbcYbkm9xVJ+7qQhl47RDvzTK3qvcR//TqO3RF2QKTYUSh
         MLCd7sso9gBkagrfQyXpGcm+Eqs8Z0lCu6OuIi3EDB1NDgNWpW1lrumQKcEkYMoe2+ls
         81xA9AWIFf7KAqxJ/VDxMWEkTHh+2uZkt6ktOBiDyk/DqqU1I2V0cE3WvQLt1WxzCH7d
         AT8XOYQD6Vs1uaJED/RTgZPT/7D3gDzYxhMiz1ewaFIn7F14f8bas1ODWRfDzByUoyCJ
         LM08lMsIGEQYS2tfvkiShP+jspynsO43xg8EjnF1XCHHPm5aIkIUt2y999UgRCsIlIgq
         3yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVJkW4LmyroUVjovOSWNFjSdGZNlIx0pxp8qFDF0ggw=;
        b=LBv8DRVcJZ/hObIjoN+9IRHyNSni2wzF2DFrV1EPdt8QTvJns/Hpbrc0AxRqMqJF1v
         SDnyRDGMHhDhDZXIR1/DagVJahn1CKcjBJZdFqjX5pjQAW+xv7+qHbDicOPTdypGcEyc
         JdWhVOGyrYbt3KBPNIRUo1NSHW/hdLZO3p4VVKl/4n9fKFBPdr69vAbgSfplGmtZsBbi
         8ajwlO1174fpKyo3Gc3K5QzCzQExq99/mD4iTeThGLjAM04hZ++Ri2QZPLFTHAkzQ4JK
         3YLb6HlFIZM7WkWYURj0rhegGSwHGf8IesGe1/Q1BXQj29KzRXyEorgee8P8ug8Fyv8N
         v+8g==
X-Gm-Message-State: AOAM532JQH2d2ayO0qHrziJ8mRjvOQjt9M4vRDGOcs+qoowQoXTkoPSI
        +XB3xQ7c0KttS0/JM3XTyI63og==
X-Google-Smtp-Source: ABdhPJxfFP8oliMR6cPqZdYxfpBor8n3wV4rDuQzSLtZBeYIk6dWnLH46B9Z8j1GarQB0Wh806pqiQ==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr14004647wrt.244.1604318053338;
        Mon, 02 Nov 2020 03:54:13 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?q?Jochen=20Sch=C3=A4uble?= <psionic@psionic.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 02/23] mtd: devices: phram: File headers are not good candidates for kernel-doc
Date:   Mon,  2 Nov 2020 11:53:45 +0000
Message-Id: <20201102115406.1074327-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/phram.c:19: warning: Function parameter or member 'fmt' not described in 'pr_fmt'

Cc: Joern Engel <joern@lazybastard.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: "Jochen Schäuble" <psionic@psionic.de>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/phram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 087b5e86d1bfb..9e4d60bd427fb 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) ????		Jochen Schäuble <psionic@psionic.de>
  * Copyright (c) 2003-2004	Joern Engel <joern@wh.fh-wedel.de>
  *
-- 
2.25.1

