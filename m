Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9C28A6D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgJKKCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 06:02:47 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:50836 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387536AbgJKKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 06:02:45 -0400
X-IronPort-AV: E=Sophos;i="5.77,362,1596492000"; 
   d="scan'208";a="471981619"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 11 Oct 2020 12:02:41 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] ALSA: hda: use semicolons rather than commas to separate statements
Date:   Sun, 11 Oct 2020 11:19:33 +0200
Message-Id: <1602407979-29038-3-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/hda/patch_ca0132.c |    2 +-
 sound/pci/hda/patch_hdmi.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9779978e4bc7..2b38b2a716a1 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3114,7 +3114,7 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 	}
 
 	data = fls->data;
-	chip_addx = fls->chip_addr,
+	chip_addx = fls->chip_addr;
 	words_to_write = fls->count;
 
 	if (!words_to_write)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 055440740184..0ffbfcb91256 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2451,7 +2451,7 @@ static int alloc_generic_hdmi(struct hda_codec *codec)
 	spec->chmap.ops.get_chmap = hdmi_get_chmap;
 	spec->chmap.ops.set_chmap = hdmi_set_chmap;
 	spec->chmap.ops.is_pcm_attached = is_hdmi_pcm_attached;
-	spec->chmap.ops.get_spk_alloc = hdmi_get_spk_alloc,
+	spec->chmap.ops.get_spk_alloc = hdmi_get_spk_alloc;
 
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);

