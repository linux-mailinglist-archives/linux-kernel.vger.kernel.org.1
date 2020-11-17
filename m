Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9302B7263
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKQXZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKQXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:25:04 -0500
Received: from mail-oi1-x262.google.com (mail-oi1-x262.google.com [IPv6:2607:f8b0:4864:20::262])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82684C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:25:04 -0800 (PST)
Received: by mail-oi1-x262.google.com with SMTP id o25so118979oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=193aMqagerhYWtykqX3L9GrnDe5ORhw+ezJXlY/ONdc=;
        b=GG3Y9PbipWnfLfCF6ktqU4CAa17U83W/dNLZGxMYDC6yRJi/8YdUu2hQDrYNyksbu/
         cAS4T3075yDebRoYlifE3zHlPHWsOozBBEUA0dSZX+Da6wXUs6z9Gvf+hOJTXA+LyntA
         bOKZv1HoyOiV5tAi9f9iz4SkAfsw6+bzBRohU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=193aMqagerhYWtykqX3L9GrnDe5ORhw+ezJXlY/ONdc=;
        b=SNcZ+5yKxCMClS1YS5YXdwRfnga9F0qSXgu4MuAuZ3MduxQpcA0IZertLhaf1lzNXK
         KS5KffjVtiuJBgXfjurxyrxN+oHHoXLw0EnT2ycRQfcrRv3mf5IJNsSwz6K7SK5C4sFD
         WGazisaYGhMwZg8isQuie/mrLUBR4RhbiNxJ97S3+bLJYfpVirTaU0KbPZxKOcXNXwyu
         dcDlrc3TJKhx+MEgC/1ZkMkzPT92ZEzZn5DVmhhPtTEH+Jq9XjC3HEt8L6ILa3p1DBQT
         8ogXvTCBQJRbOn/I1RVE2Nx/c6+16AQvzd++8etfswnKVWDJaL9XuQPlQHoyD+mrm1/v
         RZaw==
X-Gm-Message-State: AOAM530pMdxWPzB94/+/DoA0ilzwbdWZowHeWZsHMimgJxq5qTHQe2rp
        qvxfbB0DN2Ccd5iSEsSMoXPKcqRLWpKq9fqgUZtGAFJO8W9A
X-Google-Smtp-Source: ABdhPJy0rTl7Lsy3XJav1qcLSx5+6DFKorlYwfR+GvYsRCfFmsXzr9vY0KGmlL7h8IauFFLNjRAu9pvuimHb
X-Received: by 2002:a54:4704:: with SMTP id k4mr1059949oik.39.1605655503830;
        Tue, 17 Nov 2020 15:25:03 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id q22sm5867076otg.13.2020.11.17.15.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:25:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v7 12/13] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Tue, 17 Nov 2020 15:23:19 -0800
Message-Id: <20201117232320.4958-13-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117232320.4958-1-scott.branden@broadcom.com>
References: <20201117232320.4958-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e451dcce054f..f574946f2f56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3716,6 +3716,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

