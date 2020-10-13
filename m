Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E307928CE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgJMMoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgJMMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:44:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A44C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:44:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gv6so672066pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kROrNp0/vnBVDqgh6bMB0Lv2qonHQWx62hPvR0JVLiY=;
        b=JBmDR5ZcqT+4GTHKuB+FFmQCvAlkmIgjMAlqirZ8kwu91L7bvvvrfNwZPKo13RgEzC
         IOEmqZPnyu5dNhNMFgjhQlwOnOZlxzt9Fl4tO+jc/+6p7XZM96jpwtFpCEIM667Z+lDT
         7gyjHo0935+9qEBN0Gi/B74PjwgZrFmkjbjs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kROrNp0/vnBVDqgh6bMB0Lv2qonHQWx62hPvR0JVLiY=;
        b=gJW+c7uhu3mnOelnLAfRYfn+UyadT39QhJ5lO/Lyd2XmOoj+g2/GlsmYKKBDrsDxrJ
         VHCacxgYll2NLgR6SdDatOqsJlYMoL8e7Y8W5MSrwaqeqdui2jGCtLAemhHHmQzoqkFq
         WbO6CwFY/Da+mTi9sPC4LmGRHCFXLLmPWI97zygYWgv6AtXAXXFOyMyxfKcnsfwWZA4P
         DiTQMyjKmD+bq57Lk23bohvIzzR3DM9QqYoMuZ++pomPwNtBBk1qAoOeLNrEqhp5cGly
         3vTobkvbOQhmRIMvqnNer1gByUbzdf97zP81/X2fqvJ9h19KRrrxc5VQGt3/aZWMwhdv
         KDSg==
X-Gm-Message-State: AOAM533fMlfvE9lNkUgzdYilHIhkbrV1KiOJxG7jnZu2rh9TzBhPjywO
        kwJeoS2pf4wsM0hhqT8PU443Ag==
X-Google-Smtp-Source: ABdhPJzoAbnC6phIDBdMm/XQSDq3CThGjLMNwHM+FB8/E3vUaoqNolC/D6w3MUMgFcIZGCXg98d4ow==
X-Received: by 2002:a17:90a:ff92:: with SMTP id hf18mr26653376pjb.171.1602593079032;
        Tue, 13 Oct 2020 05:44:39 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id b20sm18914536pjo.37.2020.10.13.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:44:38 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 0/2] media: mtk-vcodec: fix builds when remoteproc is disabled
Date:   Tue, 13 Oct 2020 21:44:26 +0900
Message-Id: <20201013124428.783025-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes since v3, but it does the job at fixing the build
breakage. :) Please kindly take a look.

Changes since v3:
* Removed obsolete Acked-bys
* Fixed indentation in Kconfig file

Changes since v2:
* Use the FOO || !FOO magic suggested by Hans to ensure a built-in
  module does not try to link against symbols in a module,
* Added a patch to split the VPU and SCP ops into their own source files
  and make the optional build cleaner,
* Control the build of firmware implementations using two new transparent
  Kconfig symbols.

Changes since v1:
* Added Acked-by from Randy.
* Fixed typo in Kconfig description.

Alexandre Courbot (2):
  media: mtk-vcodec: move firmware implementations into their own files
  media: mtk-vcodec: fix build breakage when one of VPU or SCP is
    enabled

 drivers/media/platform/Kconfig                |  28 ++-
 drivers/media/platform/mtk-vcodec/Makefile    |  10 +-
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |   2 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |   2 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_fw.c | 174 +-----------------
 .../media/platform/mtk-vcodec/mtk_vcodec_fw.h |   7 +-
 .../platform/mtk-vcodec/mtk_vcodec_fw_priv.h  |  52 ++++++
 .../platform/mtk-vcodec/mtk_vcodec_fw_scp.c   |  73 ++++++++
 .../platform/mtk-vcodec/mtk_vcodec_fw_vpu.c   | 109 +++++++++++
 9 files changed, 277 insertions(+), 180 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c

--
2.29.0.rc1.297.gfa9743e501-goog

