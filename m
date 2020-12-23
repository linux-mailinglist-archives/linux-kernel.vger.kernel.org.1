Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED02E2104
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 20:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgLWTqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 14:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728617AbgLWTqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608752674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EuGy6qIW0/paAvyDjWz+UUhD6lrJF9atn4prE3pJJ6w=;
        b=HLMpZ9l3hlhJ4r+PSfiTCG6+Pg8no01FMHfPPT3zNz7BLjXk3d4J+GJRAED1v41NkbOx3z
        Y+YCC51gsuqIQUE6DMcLOhBlbVyhmQR/3qdOeArtnCSovoMkKRMwNDvAUyGDX0yORX/zfm
        SJ/PtL9MHXOXqtOWdf2IMNsjuC8l9L4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-INtBh6KiOQ62Dmy5gx8oAA-1; Wed, 23 Dec 2020 14:44:32 -0500
X-MC-Unique: INtBh6KiOQ62Dmy5gx8oAA-1
Received: by mail-qk1-f198.google.com with SMTP id u17so52659qku.17
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 11:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuGy6qIW0/paAvyDjWz+UUhD6lrJF9atn4prE3pJJ6w=;
        b=Tz7jW0dpdlfkY8J/2goX2pnx7wpNwukPBWC/wtqyV/s0Gpx/G3nt3Ji1bwceXykkl/
         niLqid/2LtlLqzZS2KV5aN8udfA7iqSbnGOgj0L9Z4oE5ozuuqxp9hGrhfd2lp/l0LMb
         dM73R1v0W+ccEdDzwriXGYh7ohXRiWFnX0CDRRbkruaIJ7iA/mU6eaW7+MXf2ohuWwfB
         ruHqzTInTt+xZnlr92ySmUv5UW3tU5CXqSeH2kH+eB58HTZuPUT7u0ru/V3BWelN76dd
         4OwH0WWZ4YKE0aQT4k+sAxqWwzjBW66IriHxoSKdyBI5bg48fgw74mqci5mL74OCVRmT
         cO7w==
X-Gm-Message-State: AOAM5327F31vzUtis4SBAd4oUZ5Fv/Ywf3uGjygw378KBxlkstS9cJU2
        pnDRdFPDn/bLEVI3hjUvGmU05kjRQk8FduAYJt3K1HruZLwLTXsXfXMAAA8xzq+gvFv69UXzvBU
        rY3BxhCcfA8KKrcXYCtdwt8M/
X-Received: by 2002:a37:5b46:: with SMTP id p67mr28428049qkb.124.1608752672457;
        Wed, 23 Dec 2020 11:44:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnc84b1xei0cRwwa2LGRxGKjZwkeTxy1ErJZY1x5QNthF2Qqq8Btc61gyWkWl6PYehaSPqyw==
X-Received: by 2002:a37:5b46:: with SMTP id p67mr28428041qkb.124.1608752672297;
        Wed, 23 Dec 2020 11:44:32 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p75sm16054644qka.72.2020.12.23.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:44:31 -0800 (PST)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] igb: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 11:44:25 -0800
Message-Id: <20201223194425.125605-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 03f78fdb0dcd..cb682232df16 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3156,7 +3156,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * the PCIe SR-IOV capability.
 	 */
 	if (pdev->is_virtfn) {
-		WARN(1, KERN_ERR "%s (%hx:%hx) should not be a VF!\n",
+		WARN(1, KERN_ERR "%s (%x:%x) should not be a VF!\n",
 			pci_name(pdev), pdev->vendor, pdev->device);
 		return -EINVAL;
 	}
-- 
2.27.0

