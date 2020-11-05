Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC0E2A88F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbgKEV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:28:29 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:51579 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732241AbgKEV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:28:15 -0500
Received: from gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173])
        by plasma.jpberlin.de (Postfix) with ESMTP id 6BD00AB846;
        Thu,  5 Nov 2020 22:21:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([91.198.250.140])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 92hKAi0Qer6N; Thu,  5 Nov 2020 22:21:44 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 25D6CAB7EB;
        Thu,  5 Nov 2020 22:21:44 +0100 (CET)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>
Subject: [RFC PATCH v2 02/10] firmware: arm_scmi: Document that max_msg is a per channel type limit
Date:   Thu, 5 Nov 2020 22:21:08 +0100
Message-ID: <20201105212116.411422-3-peter.hilber@opensynergy.com>
In-Reply-To: <20201105212116.411422-1-peter.hilber@opensynergy.com>
References: <20201105212116.411422-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.80 / 15.00 / 15.00
X-Rspamd-Queue-Id: 6BD00AB846
X-Rspamd-UID: e67bd0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

struct scmi_desc.max_msg specifies a limit for the pending messages.
This limit is a per SCMI channel type (tx, rx) limit. State that
explicitly in the inline documentation. The following patch will add an
op to override the limit per channel type.

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index aed192238177..38e6aabbe3dd 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -231,8 +231,8 @@ struct scmi_transport_ops {
  *
  * @ops: Pointer to the transport specific ops structure
  * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
- * @max_msg: Maximum number of messages that can be pending
- *	simultaneously in the system
+ * @max_msg: Maximum number of messages for a channel type (tx or rx) that can
+ *	be pending simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct scmi_desc {
-- 
2.25.1

