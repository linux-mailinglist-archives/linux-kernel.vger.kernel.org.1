Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01C02C4502
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgKYQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbgKYQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:32 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C249C0613D4;
        Wed, 25 Nov 2020 08:25:32 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id t6so3902468lfl.13;
        Wed, 25 Nov 2020 08:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmlCoHVPOl8J4Y5Va4Rv3QYqyzVFu+EFS+LGEEWl1j8=;
        b=jmtMDxB+HIV04Z/eDaAousylAEXuv8AkDRNVx4h2NfWcRn38W3aOQWqxjKUSGjXwlH
         eaMSh4+8F9MK/lMpmRmJMRlPQq7urOs0czKUQmf75F/jG27lQGO7UUyThcEtleAMZ5e9
         H34MnSYtX8wotXu6fNnWYIOanrYhQiZDX8QMl2Ecu8JXyeSZrRKL1EODhRIlg8h29BD3
         0qNnusifor5Nv1TItqEj7Scsfkd9GjqZuWffyUZrUzj7+lJOQ7nhVqsOooCX39a77+oz
         pxovhmaXW4SEAJoSdKBVQgcSon6TTeglxIAcB6iHEV83j3L1XYQUtCSDZeEGaGNntMg4
         0yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmlCoHVPOl8J4Y5Va4Rv3QYqyzVFu+EFS+LGEEWl1j8=;
        b=Y7+kd9XBaRfHSr4CC118ALk9VbfGSFLY46PM0HtdkzOMfxmf//6M6M3NRYLjRqXnXi
         1T/5/zhK6EGmEVPdUUPNC3m0VhGG7F3qHIx13QD3R+szu2pX2QlfBYUgfSexFrqNX6yn
         jlYQRzh3DN82h2k9omVDhvsOO6XJ6NrGA6VY1t3diPUub4twG+wPXAkvaow3M1J5elpX
         jnjhErkz5iDeNnrBWvJs8R9JdJHuBTKSUXhgIkE/c4y4tPGruN7/wgUiZ6yjybKjX2Av
         lh/HUaaskcHvvdlziLEzJytf7Jm75ABNv78yoO63DEZOB9z+jUP0ScsRCDSMJtEkG/9d
         ImmA==
X-Gm-Message-State: AOAM530LW2Hj8DsI2zbJMgBYpfFP7ouDqac6eBFETpDVIXSVUXOnliaw
        mBZJBEue0jbZIjFea6pCWXw=
X-Google-Smtp-Source: ABdhPJwObpVG0MMxG1e/+9lWVrL2YTgEGvMaGH4lrX1Vq3qPqqMYofnTMhpCVK0DY80t7ug9Imawug==
X-Received: by 2002:a19:c605:: with SMTP id w5mr1594297lff.58.1606321530638;
        Wed, 25 Nov 2020 08:25:30 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id z131sm313881lfc.56.2020.11.25.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:29 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/3] usb: common: ulpi: Constify static attribute_group struct
Date:   Wed, 25 Nov 2020 17:25:00 +0100
Message-Id: <20201125162500.37228-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125162500.37228-1-rikard.falkeborn@gmail.com>
References: <20201125162500.37228-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never modified, so make them const to allow the compiler to
put it in read-only memory. Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/usb/common/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index a18d7c4222dd..ce5e6f6711f7 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -118,7 +118,7 @@ static struct attribute *ulpi_dev_attrs[] = {
 	NULL
 };
 
-static struct attribute_group ulpi_dev_attr_group = {
+static const struct attribute_group ulpi_dev_attr_group = {
 	.attrs = ulpi_dev_attrs,
 };
 
-- 
2.29.2

