Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C98241923
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHKJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 05:53:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37318 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgHKJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:53:58 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k5QyV-00079C-Uf; Tue, 11 Aug 2020 09:53:44 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Nikhil Mahale <nmahale@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/hdmi: Use force connectivity quirk on another HP desktop
Date:   Tue, 11 Aug 2020 17:53:34 +0800
Message-Id: <20200811095336.32396-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's another HP desktop has buggy BIOS which flags the Port
Connectivity bit as no connection.

Apply force connectivity quirk to enable DP/HDMI audio.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4bbd12d3b1b5..b8c8490e568b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1863,6 +1863,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 }
 
 static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	{}
 };
-- 
2.17.1

