Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F32D7876
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437350AbgLKPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406366AbgLKO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE1C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:44 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w22THikFfKHCLECoOptxohHdWWKTUwLYMUwx0YV5Puo=;
        b=fM5EsIkFz2gDhCQSaaNVgQ22UB08AcUkQxOy127ysMzyAdjgwbucOBrgPRHmp81ZrxrgPV
        dIrKQ+n8KLk7O5KaLaNapWB8f+tgksv4y6ZN9zj4lRss7miUtj1t3o6IwLHqj7zSPVYMjv
        C3K4QXxRFGgP68EeeGSynysu9zu0AL3X9FR0PnbglQGu6YS/NwVViXq5NlkuyGwKRG0UVV
        n3rHwYtsU66ZmHvC2jNGNAKo1xHgKn6lwOIHbSEdKqEpsRfLPWsqayCBaQbhsbRZAY2X61
        FZQ9EDrRVvFthBpIbS9hBoADrTMpjg97usw2R5BOwzJhbPPfAOtezoWhSlzZdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w22THikFfKHCLECoOptxohHdWWKTUwLYMUwx0YV5Puo=;
        b=MUIwJ94BHKUKS85twKjxt4guFukWd3Mpt8gZB0UK7GvRzH5iLH7RTqcq1l8LCAK4lT3TPB
        nOk5sBfntJHcNNDA==
From:   "irqchip-bot for John Garry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] resource: Add irqresource_disabled()
Cc:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        tglx@linutronix.de
In-Reply-To: <1606905417-183214-3-git-send-email-john.garry@huawei.com>
References: <1606905417-183214-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <160769872221.3364.5800155650709146004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9806731db684a475ade1e95d166089b9edbd9da3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9806731db684a475ade1e95d166089b9edbd9da3
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 02 Dec 2020 18:36:54 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

resource: Add irqresource_disabled()

Add a common function to set the fields for a irq resource to disabled,
which mimics what is done in acpi_dev_irqresource_disabled(), with a view
to replace that function.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/1606905417-183214-3-git-send-email-john.garry@huawei.com
---
 include/linux/ioport.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5135d4b..f9bf374 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -307,6 +307,13 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
 
+static inline void irqresource_disabled(struct resource *res, u32 irq)
+{
+	res->start = irq;
+	res->end = irq;
+	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+}
+
 #ifdef CONFIG_IO_STRICT_DEVMEM
 void revoke_devmem(struct resource *res);
 #else
