Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C54F234C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 22:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGaUQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 16:16:51 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:11918 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbgGaUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:16:51 -0400
X-IronPort-AV: E=Sophos;i="5.75,419,1589234400"; 
   d="scan'208";a="462075490"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 31 Jul 2020 22:16:49 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: docs: fix typo
Date:   Fri, 31 Jul 2020 21:35:29 +0200
Message-Id: <1596224129-7699-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_KRENEL -> GFP_KERNEL

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index fa49688..aa9d5ab 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3579,7 +3579,7 @@ dependent on the bus. For normal devices, pass the device pointer
 ``SNDRV_DMA_TYPE_DEV`` type. For the continuous buffer unrelated to the
 bus can be pre-allocated with ``SNDRV_DMA_TYPE_CONTINUOUS`` type.
 You can pass NULL to the device pointer in that case, which is the
-default mode implying to allocate with ``GFP_KRENEL`` flag.
+default mode implying to allocate with ``GFP_KERNEL`` flag.
 If you need a different GFP flag, you can pass it by encoding the flag
 into the device pointer via a special macro
 :c:func:`snd_dma_continuous_data()`.

