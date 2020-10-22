Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F320295977
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508774AbgJVHm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:42:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:35524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507030AbgJVHm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:42:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603352546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSsu2Z5Xpwi6tRqum0tsNqNsbAp7L8TAp9ugr1gvsVI=;
        b=atQVgRElJPObBm4D7xYVyo/SuLwtBvhCQM9dSvPAK4KyHUJGtLTLR/ibBuL5cHA1w1q9BD
        TsaPzGWVrDRKrB/bssKNhDFnxlZJ5vs6T7Z0NsBy06HFiVay+eoJpwM7REhV/VPwOYQbl7
        rhiGlLE8UurIByn89SWD+6pLMzqgBUk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E5C2B1A3;
        Thu, 22 Oct 2020 07:42:26 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 4/5] xen/events: unmask a fifo event channel only if it was masked
Date:   Thu, 22 Oct 2020 09:42:13 +0200
Message-Id: <20201022074214.21693-5-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022074214.21693-1-jgross@suse.com>
References: <20201022074214.21693-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmasking an event channel with fifo events channels being used can
require a hypercall to be made, so try to avoid that by checking
whether the event channel was really masked.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_fifo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 243e7b6d7b96..f60c5a9ec833 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -236,6 +236,9 @@ static bool clear_masked_cond(volatile event_word_t *word)
 
 	w = *word;
 
+	if (!(w & (1 << EVTCHN_FIFO_MASKED)))
+		return true;
+
 	do {
 		if (w & (1 << EVTCHN_FIFO_PENDING))
 			return false;
-- 
2.26.2

