Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020DE28CCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgJMLze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgJMLzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:55:15 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965D422A99;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=uAmqZ5lhgQiIp+ZbTBM+IlrsfVig3NUg8EB06Ii3lck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AUv003PEQqzp/imI9kPO7WeM/6rd/WU2eND45jdZjIN9DKJA4sGPPIxyWQ5FGAIi
         QmWvS3GEar59Anl5Ay4udv9oVByPhCSUrO70oIN+3S/iT45MqoYrkhR6s2DnLGTpKi
         uTmpBcYN6D4HxgegcKbTyXzQ+YMLvosOxAp0pLo8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CWK-Kf; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v6 67/80] usb: docs: document altmode register/unregister functions
Date:   Tue, 13 Oct 2020 13:54:22 +0200
Message-Id: <4bbcc5551b3b991f6f4934381b3c2b114a93083a.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typec_bus.rst asks for documentation of those two
functions, but they don't exist:

	./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
	./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found

Also, they're not declared on bus.c but, instead, at a header
file (typec_altmode.h).

So, add documentation for both functions at the header and
change the kernel-doc markup under typec_bus.rst to point
to the right place.

While here, also place the documentation for both structs
declared on typec_altmode.h at the rst file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/usb/typec_bus.rst |  8 +++++++-
 include/linux/usb/typec_altmode.h          | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
index 03dfa9c018b7..21c890ae17e5 100644
--- a/Documentation/driver-api/usb/typec_bus.rst
+++ b/Documentation/driver-api/usb/typec_bus.rst
@@ -91,10 +91,16 @@ their control.
 Driver API
 ----------
 
+Alternate mode structs
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/usb/typec_altmode.h
+   :functions: typec_altmode_driver typec_altmode_ops
+
 Alternate mode driver registering/unregistering
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/usb/typec/bus.c
+.. kernel-doc:: include/linux/usb/typec_altmode.h
    :functions: typec_altmode_register_driver typec_altmode_unregister_driver
 
 Alternate mode driver operations
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index a4b65eaa0f62..5e0a7b7647c3 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -152,10 +152,26 @@ struct typec_altmode_driver {
 #define to_altmode_driver(d) container_of(d, struct typec_altmode_driver, \
 					  driver)
 
+/**
+ * typec_altmode_register_driver - registers a USB Type-C alternate mode
+ * 				   device driver
+ * @drv: pointer to struct typec_altmode_driver
+ *
+ * These drivers will be bind to the partner alternate mode devices. They will
+ * handle all SVID specific communication.
+ */
 #define typec_altmode_register_driver(drv) \
 		__typec_altmode_register_driver(drv, THIS_MODULE)
 int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
 				    struct module *module);
+/**
+ * typec_altmode_unregister_driver - unregisters a USB Type-C alternate mode
+ * 				     device driver
+ * @drv: pointer to struct typec_altmode_driver
+ *
+ * These drivers will be bind to the partner alternate mode devices. They will
+ * handle all SVID specific communication.
+ */
 void typec_altmode_unregister_driver(struct typec_altmode_driver *drv);
 
 #define module_typec_altmode_driver(__typec_altmode_driver) \
-- 
2.26.2

