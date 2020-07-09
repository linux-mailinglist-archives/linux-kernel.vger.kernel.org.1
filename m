Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225EF21A028
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 14:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgGIMl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 08:41:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32685 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726340AbgGIMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594298485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tpJNxP8waOOJpfsjd4XC3WT5kl8A0DcdvOVn6bZN3a8=;
        b=fyQw7Y/jvTpPogXDauGtPo3UuJLqFoAGnJSL62iQIdoPEXEIfSKEF1oQ1RRSRuumurpM7Z
        tVGInpgvqnHshNAQ9ceyRVtRxND1H2TF8bU0As8m9gIy/wiWF40DlfakKTqIe43R28uBvY
        7TTFLlEF4pM9yn3n3309te31lwnRD6M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-CZRNft4nPaiWjaT0p2H-8w-1; Thu, 09 Jul 2020 08:41:23 -0400
X-MC-Unique: CZRNft4nPaiWjaT0p2H-8w-1
Received: by mail-qv1-f72.google.com with SMTP id e6so1272857qva.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 05:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tpJNxP8waOOJpfsjd4XC3WT5kl8A0DcdvOVn6bZN3a8=;
        b=OUWNlSb08PxFdR2HRQUPwv1Z1MAWIFO2lqSqoJZe1rs3R3MzXncKvSnPtYBMTU4jHa
         r4b8m9Ojj3CZiRdinO56FdqpqApMXxJaJLudyaMYkvBW92jR9PGMLJEmolRaxYjjJLK+
         89eGWMca6dLV7rIHQACYtt/LbTSEMLr3MEQIIrRZorGQMkJ3LdubtZABoUqriQhgFoSW
         Ngkxczq451QuolXeAgfJRz4AkZyQeqbghop8hbUG9a8IF0XtaW4MMaYZaFWmsvCtJUEo
         VFYLkIUz1opW3JR2/2uebTT7wVLOB/Jq7pQK4ZzeWexvG0830Klxr1gFL7b/omnRMDYE
         fJTA==
X-Gm-Message-State: AOAM532Td6s7itIHiB2bfDUmy0aEA1PcidLwfI3buIJyCDVJqFOB8gAG
        5SHwXwVKU3YXyOonppy4yvhsal79edMqfgG8HBkmUhv8vlpgc9o1UxBctsv9mW5NYyudIoOBKRC
        cO/jghp/n/v6YLWe++PBNMqEC
X-Received: by 2002:ac8:47d0:: with SMTP id d16mr65801521qtr.349.1594298483154;
        Thu, 09 Jul 2020 05:41:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcpU7pTwX9WQtLj7PdrlfhtJk8kg3m8usW0TpTKA1vracbJcDrge1iTFu11tiAd+no4QhgOQ==
X-Received: by 2002:ac8:47d0:: with SMTP id d16mr65801500qtr.349.1594298482902;
        Thu, 09 Jul 2020 05:41:22 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g30sm3940598qte.72.2020.07.09.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 05:41:22 -0700 (PDT)
From:   trix@redhat.com
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] bus: fsl-mc: fix invalid free in fsl_mc_device_add
Date:   Thu,  9 Jul 2020 05:41:15 -0700
Message-Id: <20200709124115.5708-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

fsl-mc-bus.c:695:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(mc_dev);
        ^~~~~~~~~~~~~

The problem block of code is

		mc_bus = kzalloc(sizeof(*mc_bus), GFP_KERNEL);
		if (!mc_bus)
			return -ENOMEM;

		mc_dev = &mc_bus->mc_dev;

mc_bus's structure contains a mc_dev element,
freeing it later is not appropriate.

So check if mc_bus was allocated before freeing mc_dev

This is a case where checkpatch

WARNING: kfree(NULL) is safe and this check is probably not required
+	if (mc_bus)
+		kfree(mc_bus);

is wrong.

Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 v1: add a comment to explain freeing uniqueness
 
 drivers/bus/fsl-mc/fsl-mc-bus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 40526da5c6a6..df10ed430baa 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -691,8 +691,14 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	/*
+	 * mc_bus allocates a private version of mc_dev
+	 * it is not appropriate to free the private version.
+	 */
+	if (mc_bus)
+		kfree(mc_bus);
+	else
+		kfree(mc_dev);
 
 	return error;
 }
-- 
2.18.1

