Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F562A88F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgKEV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:28:19 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:54277 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:28:13 -0500
Received: from spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115])
        by plasma.jpberlin.de (Postfix) with ESMTP id 9D135ABAD1;
        Thu,  5 Nov 2020 22:21:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id yWuW4MU0CXNr; Thu,  5 Nov 2020 22:21:50 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 7B031ABA7B;
        Thu,  5 Nov 2020 22:21:50 +0100 (CET)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>, <anton.yakovlev@opensynergy.com>
Subject: [RFC PATCH v2 08/10] firmware: arm_scmi: Add is_scmi_protocol_device()
Date:   Thu, 5 Nov 2020 22:21:14 +0100
Message-ID: <20201105212116.411422-9-peter.hilber@opensynergy.com>
In-Reply-To: <20201105212116.411422-1-peter.hilber@opensynergy.com>
References: <20201105212116.411422-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.75 / 15.00 / 15.00
X-Rspamd-Queue-Id: 9D135ABAD1
X-Rspamd-UID: 79b47f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi-virtio transport driver will need to distinguish SCMI protocol
devices from the SCMI instance device in the chan_setup() and
chan_free() ops. Add this internal helper to be able to distinguish the
two.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/bus.c    | 5 +++++
 drivers/firmware/arm_scmi/common.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 1377ec76a45d..4f19faafb2c5 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -108,6 +108,11 @@ static struct bus_type scmi_bus_type = {
 	.remove = scmi_dev_remove,
 };
 
+bool is_scmi_protocol_device(struct device *dev)
+{
+	return dev->bus == &scmi_bus_type;
+}
+
 int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 			 const char *mod_name)
 {
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index ec9fd7fce3c7..13c9ac176b23 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -158,6 +158,8 @@ int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp);
 
+bool is_scmi_protocol_device(struct device *dev);
+
 int scmi_base_protocol_init(struct scmi_handle *h);
 
 int __init scmi_bus_init(void);
-- 
2.25.1

