Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3450262855
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgIIHT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 03:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIIHTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:19:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07137C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:19:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so902048pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7yi/vsERj3XSiUmPF9/ytkB61PwQoPSacfDXXxnQXzM=;
        b=hn4uTxWfwCO2Go8jK7YZ0cVEpAJS7tuMGyZgZkA8UNovAOsFFk0FIruGG0U1lQTwXH
         ZvNE0IIUZX1ZbYH2oYr412I5ddkmOu2Bl3bYaiOPMJyNfs1P2q16x+yq9n37Dc+41Wcx
         /EsjKmVoHkYRBAVorjpKp2UiBc7pHcKJDR3sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7yi/vsERj3XSiUmPF9/ytkB61PwQoPSacfDXXxnQXzM=;
        b=VeupulzwG+cy84nLO9EmmtUNumXtOdUglcnFE2GbQsy3HpPqGhg28hhLJSPkEJyZTu
         kSc9p+RY3b5pTwhGz82tQTK95OLGgTlJP9wetWsdFJp/QQ61h1lA6IqK3deUiPUwCvka
         AZ7Q/jFnp2HZnVobg+s4JU5K6631PlaxtEeobhzC7XBwo7AvlyM6rFiQBjvYvLhFHZbK
         h3X1RNikn80i2b/Q/URHg7uQTit73+fczTQrIY8EMyKw+ZxmoK8dYI4n2d6oBb2ktAfe
         KyOCpsB2HPd3MJAwNUM4hFzETZbo2quitEuPunk3/dSnYpAmjAIG1aGBq6EZQ3XXy1Sc
         dEjw==
X-Gm-Message-State: AOAM531bXUwoG9q6mjuVJz4M2qx/G6qjXKk7Stt16s9lRJIP8RhvgyAK
        TzvtMquMGnJgLGQq72jjvoGJzA==
X-Google-Smtp-Source: ABdhPJzsoWtEs9yiO0+OBwfOeMP55wB7jvsEYZFOrTReGuLx2A5RE6IU3IIYxMb5LEaNl//q6iPS2A==
X-Received: by 2002:a17:90a:7084:: with SMTP id g4mr2224010pjk.116.1599635963495;
        Wed, 09 Sep 2020 00:19:23 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id 194sm1583885pfy.44.2020.09.09.00.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:19:22 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        Ricky Wu <ricky_wu@realtek.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: rtsx: Fix memory leak in rtsx_pci_probe
Date:   Wed,  9 Sep 2020 07:18:51 +0000
Message-Id: <20200909071853.4053-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mfd_add_devices() fail, pcr->slots should also be freed. However,
the current implementation does not free the member, leading to a memory
leak.

Fix this by adding a new goto label that frees pcr->slots.

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/misc/cardreader/rtsx_pcr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 37ccc67f4914..f2b2805942f5 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1562,12 +1562,14 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 	ret = mfd_add_devices(&pcidev->dev, pcr->id, rtsx_pcr_cells,
 			ARRAY_SIZE(rtsx_pcr_cells), NULL, 0, NULL);
 	if (ret < 0)
-		goto disable_irq;
+		goto free_slots;
 
 	schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
 
 	return 0;
 
+free_slots:
+	kfree(pcr->slots);
 disable_irq:
 	free_irq(pcr->irq, (void *)pcr);
 disable_msi:
-- 
2.17.1

