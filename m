Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83328AA84
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgJKUwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgJKUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:52:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5CEC0613CE;
        Sun, 11 Oct 2020 13:52:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so16819966wre.4;
        Sun, 11 Oct 2020 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BX4Ksw8KZPsLtrPcO58GtjEV3POmqSDp6KnUeCMIM/A=;
        b=puQfLXc6z9+ETjKkL3Ql8/IIvJrtTJ7yoOUQFZYaK56Am2Of/0p/QIkXYIls5tL0in
         sXD5MPMLKThYYDrcVtkjjdlNAfW1niIOCYs7z/EoBXfIhtZNd9+XCReGNYD6psFnvVrS
         zqYHwPJadWzCPZpMBOZRbMwKtBpVFa6VSc9dhZr6e8m6WhztVaOYRgrkpck8yjBPXthL
         FOVItwA6bhlnlUR28E12jFRSEeCRtF5tT8FXxRyQ/nt+iKEfxjmNUqQijUGOw7EfXxHs
         +4eSg9SAVBP2ey197ffk+f8U9ynPg7NsY7XU6oU5ssGeBPDX9LXDIAzIX3VuxlXDsm7B
         23lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BX4Ksw8KZPsLtrPcO58GtjEV3POmqSDp6KnUeCMIM/A=;
        b=Crg2pMrLN1iGfTtXVPTEBm7jI4/8wIyZU7lKbDC2gPYW9ZX0jhSGK2zWJA70oyqraj
         DFTjGYne0ey/89zlDuNjoB7w5foLRiu+2cE79HDXx1dbNqc6YvWe2Ma7d0n0pOePqzbK
         ksweNnBQVBG1jspQCgrmYFwOrKYR7p8Hem7Ro98x8bi0xTd23Njmqc2Kd72bJCeKvpYL
         9UuOTZQz8h2xDtbGh6xla0T3MXvMrzV/M3NMYNFYxHBbtoYQ6PebjDBievjZQrVHX5Xy
         bgvjUx6UCbKNCCIhAe9VwAptsYZgH8zighccG8rI/dAQib6UHrFSktr3MhSQyO1oYh/w
         DTqg==
X-Gm-Message-State: AOAM533N9jocDM7WDhkVZjk8XRSoBGeqjQwDc9NRKfzUzv/pySZ0kR+q
        YLjNo0dIC4Ok7TN/7v3Grvs=
X-Google-Smtp-Source: ABdhPJykx39k7lJpZgr3XUsTS9T3knOzW1oWqFZE6F2SU3I+AdRkgJbZGCoEbfMtNLTjpzWHHhv0NQ==
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr9957357wrw.80.1602449562207;
        Sun, 11 Oct 2020 13:52:42 -0700 (PDT)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id y66sm4070595wmd.14.2020.10.11.13.52.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 13:52:41 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] usb: host: ehci-sched: add comment about find_tt() not returning error
Date:   Sun, 11 Oct 2020 21:50:08 +0100
Message-Id: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment explaining why find_tt() will not return error even though
find_tt() is checking for NULL and other errors.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/usb/host/ehci-sched.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 6dfb242f9a4b..0f85aa9b2fb1 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -244,6 +244,12 @@ static void reserve_release_intr_bandwidth(struct ehci_hcd *ehci,
 
 	/* FS/LS bus bandwidth */
 	if (tt_usecs) {
+		/*
+		 * find_tt() will not return any error here as we have
+		 * already called find_tt() before calling this function
+		 * and checked for any error return. The previous call
+		 * would have created the data structure.
+		 */
 		tt = find_tt(qh->ps.udev);
 		if (sign > 0)
 			list_add_tail(&qh->ps.ps_list, &tt->ps_list);
@@ -1337,6 +1343,12 @@ static void reserve_release_iso_bandwidth(struct ehci_hcd *ehci,
 			}
 		}
 
+		/*
+		 * find_tt() will not return any error here as we have
+		 * already called find_tt() before calling this function
+		 * and checked for any error return. The previous call
+		 * would have created the data structure.
+		 */
 		tt = find_tt(stream->ps.udev);
 		if (sign > 0)
 			list_add_tail(&stream->ps.ps_list, &tt->ps_list);
-- 
2.11.0

