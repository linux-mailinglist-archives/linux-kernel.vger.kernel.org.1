Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA77295C33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896149AbgJVJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:49:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896143AbgJVJtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603360151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVuxwJ3hyt25tYMDo7KA9FGUbENDEaFuW9/mMP2hjWY=;
        b=XdZFpfUX5Q4edukPRqbno2sAVNX/9lStsFCY0SbUMIZdMDeuyPiBXOXTtEtl5tfur0ohB+
        v75te7c9mliV8OqxcIfKDJgE5Igkrfgo8YRH5iJ8yl5l20L8mN4rIR4CY6qW1Sv+fYvd/3
        q+PdCKHsYamkNp0VFS8CEvO750kZgLQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 000A5AE2B;
        Thu, 22 Oct 2020 09:49:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v2 4/5] xen/events: unmask a fifo event channel only if it was masked
Date:   Thu, 22 Oct 2020 11:49:06 +0200
Message-Id: <20201022094907.28560-5-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022094907.28560-1-jgross@suse.com>
References: <20201022094907.28560-1-jgross@suse.com>
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
Reviewed-by: Jan Beulich <jbeulich@suse.com>
---
V2:
- move test for already unmasked into loop (Jan Beulich)
---
 drivers/xen/events/events_fifo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 243e7b6d7b96..b234f1766810 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -237,6 +237,9 @@ static bool clear_masked_cond(volatile event_word_t *word)
 	w = *word;
 
 	do {
+		if (!(w & (1 << EVTCHN_FIFO_MASKED)))
+			return true;
+
 		if (w & (1 << EVTCHN_FIFO_PENDING))
 			return false;
 
-- 
2.26.2

