Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07B927BE20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgI2HiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2HiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:38:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59487C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:38:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so3668631pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=io1cz9TQOCr2lsgpG0jFMP3QgjGEulFGbq1UdpXz5V4=;
        b=ZOFyvlCLR8T8JpIU79KN9MsP6sRAHSvMzIjIZONONWF7W/+U3LsaU1wt67X0ZP3Wn2
         mGZIaHbxB+vQzJGNYTotCQJhBH+z54Ff0okyevumh7NAhymfIacbmmYBsbRkFuQiK1bn
         QslXqt5AOL4KyTGwdLRHnoAhiSyL7klugyFjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=io1cz9TQOCr2lsgpG0jFMP3QgjGEulFGbq1UdpXz5V4=;
        b=W88vwDZbaR8rR6CB22eEMB0VNxYyhnQj1jhk/rks1BOFX061QS0hDWIh7u0okSsUV1
         2z84V240fgFiTTRKgYMlRb0FIvDoaJttsRa1fnT5JUkJDu+9/eHjuzyKd7hB/vrnDCNn
         dcOlhX8GeCvCy1cM0i4BBGcB94HIpVtqHcERR3Hfr+O5pautz1R6aJ9ouldIHM9VmivC
         MJaIu9P/MNeQ5I0oJ2dK9ZL2SP+iZNwlEVB04olbIXnEB5ekCUn6/zvLSpxtW+WxK0X4
         AF504px/AGlg6Pdf2TsP1DRw0fdJUs10PCsktekT9ic4tY1EoRkGF27YdjqfP7oX3Fxb
         Eu2Q==
X-Gm-Message-State: AOAM530Ar7qb6vZ5BSF1BKLMydQumDpstUU1bQtN6VGLG9AQyX/Ki2iF
        MS0UBnPAzWIJRmZ/1z+WxdhYfw==
X-Google-Smtp-Source: ABdhPJwXYEUsBsCIdgNi3hgFN2mrzey+Q3KLI0dKFDQsChyUPfOEB+KJ/+oKD8iGZQr8LY3JxgnjqQ==
X-Received: by 2002:a65:6883:: with SMTP id e3mr2228137pgt.250.1601365084796;
        Tue, 29 Sep 2020 00:38:04 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id e13sm3737317pjy.38.2020.09.29.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 00:38:00 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 0/4] spi: spi-mtk-nor: Add mt8192 support.
Date:   Tue, 29 Sep 2020 15:37:51 +0800
Message-Id: <20200929073755.3741416-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset adds 36bit dma address and power management
supports for mt8192-nor. Additionally, use dma_alloc_coherent()
instead of kmalloc() for internal bounce buffer for platforms
of only supporting 32bit addresses.

Changes in v4:
- Drop two patches from a list which already addressed by
  an another series and not directly related with mt8192 support
- Fix 0-day ci 'shift-count-overflow' warning
- Fix missing 'high_dma' initialization for 36bit address

Changes in v3:
- Fix a bugfix of v2 in checking spi memory operation.
- split read_dma function into two (normal/bounce)
- Support 7bytes generic spi xfer

Changes in v2:
- Add power management support
- Fix bugs in checking spi memory operation.
- use dma_alloc_coherent for allocating bounce buffer
- code cleanups

Ikjoon Jang (4):
  dt-bindings: spi: add mt8192-nor compatible string
  spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
  spi: spi-mtk-nor: support 36bit dma addressing
  spi: spi-mtk-nor: Add power management support

 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |   1 +
 drivers/spi/spi-mtk-nor.c                     | 210 ++++++++++++------
 2 files changed, 147 insertions(+), 64 deletions(-)

-- 
2.28.0.709.gb0816b6eb0-goog

