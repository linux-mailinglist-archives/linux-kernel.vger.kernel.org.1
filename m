Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3A1E53BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 04:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgE1CNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 22:13:33 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36466 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgE1CNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:13:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49XWT85v0dz9vKZB
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e1dgzPmyRaE4 for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 21:13:32 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49XWT84J4Cz9vKYS
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:13:32 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49XWT84J4Cz9vKYS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49XWT84J4Cz9vKYS
Received: by mail-io1-f69.google.com with SMTP id j23so10566317iok.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+A1YPokMCKgyjret0UYYQzUqVLYn99l1EAUInCbVEoQ=;
        b=WfjCj9PAtlXuuLhDKdQnyvqFbqNeBfy1HXfmSE8DB9kEXmc8aiyV8STRsAEanfe7ER
         zIXDQ2/YCJpIlGPgtva8TsOiHNpribBlXJrWzHLan836r2t0jFYN6EBQjqUuCdDEQALL
         x4n7xX7lOAujaEnUYH18h+qHElRDE3Ob9xkLwSdY0JeIuhcw8sSD3vz8E++kfCZlRZdp
         SMlp8XtbGU112kLPVGCw0bakf+OiHmbOxTcHVTqxQWAvrGp6azx7HtTDCT4WwZwkyJZu
         gneTskObuI1l6Ml/vY0HR2C/oV35nVKzu7wZaMka/xzZHTk9vKqseADdyhSRO9R3qd6G
         rWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+A1YPokMCKgyjret0UYYQzUqVLYn99l1EAUInCbVEoQ=;
        b=bvpDRn8WdSN42jBJPv/s4tcVTXF5q5xB3c9BzvsCKyk6dwho0Y+yjN4opXB5UQu1Mz
         WcQqG5xtI2IHOfLkd70YzwUa8p0rwpYZroB2jVL+Og6eZbBn2RKxhd7RafRvXwulaEwt
         Ak03RGCZSYDi2mJRbC5F69eInoHOLRhaIgz7RtddBgTs7Gwg2bGeikGUj28BFfDiw1AY
         iBeOjjniOVOfoL+RorkifXqU5xUMTDGg2OTeEJHZ5upr3dUrejJhd3cQ/4CYgGSodZrV
         uA9Kj/oPN7ZuCMP1rqR+a6xoLdCRRpBr5ZE6PF2BJ8F+IkI6A9miSeOc3cOSAaRtGepB
         WY9A==
X-Gm-Message-State: AOAM533/mRgE3eQyzeOWRyxCb4cM0oKH51aQgPOIvdU8wpbPYojBIxVh
        4tg7NcRR3rG1cduRgBUNRGt6Q59eDuP6pJ/7UzlzSbbb/q6Mjf11mJzLfTpNlXn51ozJb8t4HiL
        peK981nZzz8lHh7F8EeNXLXEBS3d4
X-Received: by 2002:a02:3e06:: with SMTP id s6mr712720jas.57.1590632011202;
        Wed, 27 May 2020 19:13:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpledpmRFG225p3UpKzQBSus1wf525XSOOKNI6xG7lhRUn81N/jpiuF4hbYE89ppULJCPG8Q==
X-Received: by 2002:a02:3e06:: with SMTP id s6mr712708jas.57.1590632010942;
        Wed, 27 May 2020 19:13:30 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id h5sm2398411ile.35.2020.05.27.19.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:13:30 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Bjorn Helgaas <bhelgaas@google.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Alex Chiang <achiang@hp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix reference count leak in pci_create_slot
Date:   Wed, 27 May 2020 21:13:22 -0500
Message-Id: <20200528021322.1984-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Thus,
when call of kobject_init_and_add() fail, we should call kobject_put()
instead of kfree(). Previous commit "b8eb718348b8" fixed a similar problem.

Fixes: 5fe6cc60680d ("PCI: prevent duplicate slot names")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/pci/slot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index cc386ef2fa12..3861505741e6 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -268,13 +268,16 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
+		kfree(slot);
 		goto err;
 	}
 
 	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
 				   "%s", slot_name);
-	if (err)
+	if (err) {
+		kobject_put(&slot->kobj);
 		goto err;
+	}
 
 	INIT_LIST_HEAD(&slot->list);
 	list_add(&slot->list, &parent->slots);
@@ -293,7 +296,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	mutex_unlock(&pci_slot_mutex);
 	return slot;
 err:
-	kfree(slot);
 	slot = ERR_PTR(err);
 	goto out;
 }
-- 
2.17.1

