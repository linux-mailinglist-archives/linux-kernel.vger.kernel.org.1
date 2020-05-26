Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5281A4A00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDJSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 14:48:29 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50561 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJSs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:48:28 -0400
Received: by mail-pj1-f66.google.com with SMTP id b7so1096000pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GDlhvc737A1B7cqsgBD4sqvBWI/XRw9Xyu07r8MIXfc=;
        b=mT8ZqmB5a9bl0OGDjI6ftL1heRzJQ9Muiz3UgW+QH/iqaDz7TeV23rAllAwKs6NKFb
         KKJgab8ftLZAuE4FwVh2LzuvDvQssOBccrT30WDH8S4YkF9QABOr3C+q28elqXqNlW6D
         4F7BLE/acJZgPQvH/PP0Kqh10ygzz/WnfBGpFgHyyhZ7alb7OuyHvBUVzI5ayt0RRnII
         2ko1H0m+scD6lIcYskm5P/WewB6mVnWOpIWgnUXK8sTbXB3SgVAPPPGmmixva4s2F1Db
         n+VrYaxpY4+Mg5VOoMXoAVjXNF9MzD0azmeAhN7kPuUF9Z2/NIFO3TQTFAXAQsvdoHN6
         jd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GDlhvc737A1B7cqsgBD4sqvBWI/XRw9Xyu07r8MIXfc=;
        b=CIDVziHJJ4qlMKUCbT7zGji59APoGyx25uT4qLSngndlt/SZiT6H4TmDZ+SzSiGJ3Z
         Sp/+/qt4+L6FSV0ZQpk2FL9Hjv3h4AYv+VUSpwbb0tZhRvhfWm8zNd+/6TSxckeKC0rF
         SoR/twKdRcNjbv8l3y8STe7+n3qrQw4GAGrIH4NdOJlMCUqVJ1ynHQftr/vYQcNL9Rg0
         cTj7zx8GClspkAB1N427d+OOQ7j35zGqN9Z1MCPhLKfksG0eidDHY5uh50MiCKZYLzMx
         zvV4/6/k5KF+nWItgRO5ZoDa911TWS57btHh58hMQprBgw+fP0hLtjmctCK1hEp20zPE
         yAwA==
X-Gm-Message-State: AGi0PubjEdP3aTTLSW/jfZ4TJccywKAThXwOjN0YZP/01e1gQP919eM3
        MURTLNb/pu5OxtPZezwnsSdRufG2b1s=
X-Google-Smtp-Source: APiQypITCmOjMlF7oMcP8hYQCto8Gc0uxLeigoyYZ68+fhV9ErbYZsK+3ARklA9XJdGzoj4RtmXEZA==
X-Received: by 2002:a17:902:9f8f:: with SMTP id g15mr5742612plq.221.1586544508317;
        Fri, 10 Apr 2020 11:48:28 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id u10sm2382619pjd.13.2020.04.10.11.48.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 11:48:27 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, kishon@ti.com,
        bhelgaas@google.com, martin.petersen@oracle.com, vidyas@nvidia.com,
        efremov@linux.com, kjlu@umn.edu, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH][next] PCI: endpoint: functions/pci-epf-test: fix leak of buf in pci_epf_test_write()
Date:   Fri, 10 Apr 2020 11:48:18 -0700
Message-Id: <1586544498-29978-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

In the case where pci_epf_test_write() cannot transfer using DMA, the
allocation of 'buf' leaks on the error return path. Fix by jumping to
the label err_dma_map to free the 'buf' before returning.

Fixes: a558357b1b34 ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 60330f3e3751..22fb2858f20a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -438,7 +438,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
-			goto err_map_addr;
+			goto err_dma_map;
 		}
 
 		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
-- 
2.7.4

