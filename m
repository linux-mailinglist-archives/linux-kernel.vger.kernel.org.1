Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5F26B7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgIOOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIONxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:53:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECCCC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u3so1738475pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MeLJEQ5UzKvpRw+f0TuQfsNut0rOub9KBNZ3XbT5R4w=;
        b=VyzI3l68YaIDGZSJqqVNoBbU0lqcqpmQ6neoGauVB0ydm6bSCbf7jtSUa4s8rToSTJ
         /z8S4X4jJkwIMTgZfJeey5u122Wby9vkT234yCMTUPuB3aURQZmv02RxTc9VzHahY5rZ
         lbx0AeZL11QpO4mI9KEvtNJfUg+F33YmToIwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MeLJEQ5UzKvpRw+f0TuQfsNut0rOub9KBNZ3XbT5R4w=;
        b=kiC9tWKURZULE6kr50ooBl40ObO9h/N+ugPeznrVN9ayPloNpCkDBx9fiTc89A+Ulj
         XQwnb/CKKj+Xg5jkZ4G7WwzJ4iYbkDwcmDzBWLqMUr0Ehr5g1OMwBDIGz+nnZim3Og2s
         +SwAIX1vKe9JH0NQ8emPrJQUlVXDOnLRODOkbqPqMrKqlfMYit5/iJZI5EqUUKISr44D
         Dabw6PXDfAg9AarJHm6QEMIoLjxOBbM4JMpjsJfG5RiAdlL/XCzfAj+N5PW/2DhJASnl
         YnP7716F+B/6nW/AtI+2vPQH9JtZGlX0JMxaTzzCC3Gauk+XqVlDlPCd4X7moMpmVzVS
         TJPQ==
X-Gm-Message-State: AOAM531XFgHJTwGesQahTos8IqpPUm75q8ZukDfcAg9suNr6Wxp7dyMk
        kkdBDUCYClr7LVB5MjmMXm9LPg==
X-Google-Smtp-Source: ABdhPJxcNnN5vg5uojXyT3K7ps9jzvHo60XPiUNDKPGLzN1OH9DK612rrF6YmNusesVGKbdSWANS/g==
X-Received: by 2002:a17:90a:c28e:: with SMTP id f14mr4105023pjt.83.1600177572607;
        Tue, 15 Sep 2020 06:46:12 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz6sm12471478pjb.22.2020.09.15.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:46:11 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/3] PCI: iproc: Add fixes to pcie iproc 
Date:   Tue, 15 Sep 2020 19:15:38 +0530
Message-Id: <20200915134541.14711-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains fixes and improvements to pcie iproc driver.

This patch set is based on Linux-5.9.0-rc2.

Changes from v1:
  - Addressed Bjorn's review comments
     - pcie_print_link_status is used to print Link information.
     - Added IARR1/IMAP1 window map definition.

Bharat Gooty (1):
  PCI: iproc: fix out of bound array access

Roman Bacik (1):
  PCI: iproc: fix invalidating PAXB address mapping

Srinath Mannam (1):
  PCI: iproc: Display PCIe Link information

 drivers/pci/controller/pcie-iproc.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.17.1

