Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E6268054
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgIMQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:52:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32259 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725876AbgIMQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600015957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=OnOecvlCsmh6JKu+PCBfRD+F9XU63TdFztNbTAcxKzQ=;
        b=OzU2tnO4VEnHHMXbFhu8aXGTulBd7ffB8pCcXxVVaNXSV0PjwOAewxQoIoiffhxg/7vJiW
        44mi6uLVZY0uhAmfp8TYhNcy6Hb3Nj1X06ARpngq79TFV468/wSuQVs9m4m+ioJaAQUvXt
        2E8KHshUvKkW9i5ZNcnsrcoGnvwrkKs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-zZSFPgb2OcmIF1Ji9XPgaQ-1; Sun, 13 Sep 2020 12:52:36 -0400
X-MC-Unique: zZSFPgb2OcmIF1Ji9XPgaQ-1
Received: by mail-qt1-f200.google.com with SMTP id a26so10282520qtb.16
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OnOecvlCsmh6JKu+PCBfRD+F9XU63TdFztNbTAcxKzQ=;
        b=fxMo65OnKX5F2jSwgY6H6puXo0kZeyf82f+YS68uW3AZw9UkKiuUhAAmtweuX2IJrO
         UtJ3aaeEck8nAtXAWl0h1x4XAYYI3spBt/Vx/P/BRrEJ2tCrSsDum/Wn8Va4/AMBYZif
         3Gbh1JI7Q+L0ZENxvp1nHOzOADu63CBsAOCZLAnM+qb98nDaCz7orTGLeaVn8QmVd1Sb
         6HoqwNFBRpSy/2I+5dfJSJqO6/xHBTxU4OnNx5qD8mScsHG37Xf6TfabyL/xA7UTDn2e
         RZjJdj9BUK9PXvM+3S7gxO+eGfno7gsXUxV0ZHlds9sUPArDKQ7e32sweU0ia6GAAClT
         hsEQ==
X-Gm-Message-State: AOAM532ne9Ea1/S6E7Sn1jh2HpsO0zcfvgRKlxfA1MmSmf8AVUnAj4XH
        hPtbC8/3Eqpn+V4SNvG4ffcVEsVPtkNalKFQcLl0Hrp8ZoJRG25N01jQQf4rS1z6iDjmzUdvQuJ
        WkVbC3Td/Kl/syP0jvzu5TLjl
X-Received: by 2002:ac8:100c:: with SMTP id z12mr9721955qti.81.1600015955837;
        Sun, 13 Sep 2020 09:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKjF1J+GeKF9ZXkHPfeiFmrEfSqgpwFwO2TqwgCrLbYQUDsHZHFMMJdU6H5SApjSbMKUclEA==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr9721935qti.81.1600015955583;
        Sun, 13 Sep 2020 09:52:35 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g19sm11332392qka.84.2020.09.13.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 09:52:35 -0700 (PDT)
From:   trix@redhat.com
To:     perex@perex.cz, tiwai@suse.com, natechancellor@gmail.com,
        ndesaulniers@google.com, eblennerhassett@audioscience.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: asihpi: fix iounmap in error handler
Date:   Sun, 13 Sep 2020 09:52:30 -0700
Message-Id: <20200913165230.17166-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this problem
hpioctl.c:513:7: warning: Branch condition evaluates to
  a garbage value
                if (pci.ap_mem_base[idx]) {
                    ^~~~~~~~~~~~~~~~~~~~

If there is a failure in the middle of the memory space loop,
only some of the memory spaces need to be cleaned up.

At the error handler, idx holds the number of successful
memory spaces mapped.  So rework the handler loop to use the
old idx.

There is a second problem, the memory space loop conditionally
iomaps()/sets the mem_base so it is necessay to initize pci.

Fixes: 719f82d3987a ("ALSA: Add support of AudioScience ASI boards")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/asihpi/hpioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 6cc2b6964bb5..bb31b7fe867d 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -352,7 +352,7 @@ int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	struct hpi_message hm;
 	struct hpi_response hr;
 	struct hpi_adapter adapter;
-	struct hpi_pci pci;
+	struct hpi_pci pci = { 0 };
 
 	memset(&adapter, 0, sizeof(adapter));
 
@@ -509,7 +509,7 @@ int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	return 0;
 
 err:
-	for (idx = 0; idx < HPI_MAX_ADAPTER_MEM_SPACES; idx++) {
+	while (--idx >= 0) {
 		if (pci.ap_mem_base[idx]) {
 			iounmap(pci.ap_mem_base[idx]);
 			pci.ap_mem_base[idx] = NULL;
-- 
2.18.1

