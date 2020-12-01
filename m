Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C881D2CA229
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgLAMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgLAMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:09:56 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B5920770;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=ghIJ/p1N/4FbaB4TdmPpcHQtFLY3nkgMQwC6FIEC/vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1K6BgrL7pFRFeQR1OrnZcLSDMWG8xROkg+n6zmguit/9EFPb/YzrNs1Q1VNUqGf60
         jwMPxrbbzW0OmTNUHVWRmbm/I/7y52UNTTevUYL4QeSVGPGmgGjz4KwtxFExgd3F3m
         pDjP+QYQKFe12p7bsC/WXI69kOP3sfuhhuOkYNDw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T2-00DGcu-QE; Tue, 01 Dec 2020 13:09:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/16] HSI: fix a kernel-doc markup
Date:   Tue,  1 Dec 2020 13:08:54 +0100
Message-Id: <a921e2212afc39f562a8015104e107665ca495da.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/hsi/hsi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index 47f0208aa7c3..c3fb5beb846e 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -323,65 +323,65 @@ EXPORT_SYMBOL_GPL(hsi_add_clients_from_dt);
 #endif
 
 int hsi_remove_client(struct device *dev, void *data __maybe_unused)
 {
 	device_unregister(dev);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hsi_remove_client);
 
 static int hsi_remove_port(struct device *dev, void *data __maybe_unused)
 {
 	device_for_each_child(dev, NULL, hsi_remove_client);
 	device_unregister(dev);
 
 	return 0;
 }
 
 static void hsi_controller_release(struct device *dev)
 {
 	struct hsi_controller *hsi = to_hsi_controller(dev);
 
 	kfree(hsi->port);
 	kfree(hsi);
 }
 
 static void hsi_port_release(struct device *dev)
 {
 	kfree(to_hsi_port(dev));
 }
 
 /**
- * hsi_unregister_port - Unregister an HSI port
+ * hsi_port_unregister_clients - Unregister an HSI port
  * @port: The HSI port to unregister
  */
 void hsi_port_unregister_clients(struct hsi_port *port)
 {
 	device_for_each_child(&port->device, NULL, hsi_remove_client);
 }
 EXPORT_SYMBOL_GPL(hsi_port_unregister_clients);
 
 /**
  * hsi_unregister_controller - Unregister an HSI controller
  * @hsi: The HSI controller to register
  */
 void hsi_unregister_controller(struct hsi_controller *hsi)
 {
 	device_for_each_child(&hsi->device, NULL, hsi_remove_port);
 	device_unregister(&hsi->device);
 }
 EXPORT_SYMBOL_GPL(hsi_unregister_controller);
 
 /**
  * hsi_register_controller - Register an HSI controller and its ports
  * @hsi: The HSI controller to register
  *
  * Returns -errno on failure, 0 on success.
  */
 int hsi_register_controller(struct hsi_controller *hsi)
 {
 	unsigned int i;
 	int err;
 
 	err = device_add(&hsi->device);
 	if (err < 0)
-- 
2.28.0

