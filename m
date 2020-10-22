Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE25295978
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508783AbgJVHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:42:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:35428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506726AbgJVHm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:42:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603352545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+gXPSZ4YK0mj6VX7zgMh/c3+7HoLEk5WluQT9Z0yeU=;
        b=WUkn4x9r0qlY9xTRnQ8DIhORZkjrTb516b1OQh3oXGCkHDoEK3O35H4KKsTIbKvF0ysIp7
        8PWXisHXPbb1IzERtCyrFPHmdmq7qQs5zbXO6stE4UHq13ZKspWu1Okwvlc+eT5RG12i72
        XabaRzfVA7Um6FUlRe41BIpTyRf6tvY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC1DCB19E;
        Thu, 22 Oct 2020 07:42:25 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 1/5] xen: remove no longer used functions
Date:   Thu, 22 Oct 2020 09:42:10 +0200
Message-Id: <20201022074214.21693-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022074214.21693-1-jgross@suse.com>
References: <20201022074214.21693-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the switch to the lateeoi model for interdomain event channels
some functions are no longer in use. Remove them.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 21 ---------------------
 include/xen/events.h             |  8 --------
 2 files changed, 29 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index cc317739e786..436682db41c5 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1145,14 +1145,6 @@ static int bind_interdomain_evtchn_to_irq_chip(unsigned int remote_domain,
 					       chip);
 }
 
-int bind_interdomain_evtchn_to_irq(unsigned int remote_domain,
-				   evtchn_port_t remote_port)
-{
-	return bind_interdomain_evtchn_to_irq_chip(remote_domain, remote_port,
-						   &xen_dynamic_chip);
-}
-EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq);
-
 int bind_interdomain_evtchn_to_irq_lateeoi(unsigned int remote_domain,
 					   evtchn_port_t remote_port)
 {
@@ -1320,19 +1312,6 @@ static int bind_interdomain_evtchn_to_irqhandler_chip(
 	return irq;
 }
 
-int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
-					  evtchn_port_t remote_port,
-					  irq_handler_t handler,
-					  unsigned long irqflags,
-					  const char *devname,
-					  void *dev_id)
-{
-	return bind_interdomain_evtchn_to_irqhandler_chip(remote_domain,
-				remote_port, handler, irqflags, devname,
-				dev_id, &xen_dynamic_chip);
-}
-EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irqhandler);
-
 int bind_interdomain_evtchn_to_irqhandler_lateeoi(unsigned int remote_domain,
 						  evtchn_port_t remote_port,
 						  irq_handler_t handler,
diff --git a/include/xen/events.h b/include/xen/events.h
index 3b8155c2ea03..8ec418e30c7f 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -35,16 +35,8 @@ int bind_ipi_to_irqhandler(enum ipi_vector ipi,
 			   unsigned long irqflags,
 			   const char *devname,
 			   void *dev_id);
-int bind_interdomain_evtchn_to_irq(unsigned int remote_domain,
-				   evtchn_port_t remote_port);
 int bind_interdomain_evtchn_to_irq_lateeoi(unsigned int remote_domain,
 					   evtchn_port_t remote_port);
-int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
-					  evtchn_port_t remote_port,
-					  irq_handler_t handler,
-					  unsigned long irqflags,
-					  const char *devname,
-					  void *dev_id);
 int bind_interdomain_evtchn_to_irqhandler_lateeoi(unsigned int remote_domain,
 						  evtchn_port_t remote_port,
 						  irq_handler_t handler,
-- 
2.26.2

