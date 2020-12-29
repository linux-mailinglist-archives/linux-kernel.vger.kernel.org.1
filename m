Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5642E6DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgL2DxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 22:53:11 -0500
Received: from out28-171.mail.aliyun.com ([115.124.28.171]:43047 "EHLO
        out28-171.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2DxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:53:11 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.109993|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00600531-0.000138118-0.993857;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=bo.liu@senarytech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.JCdxAfz_1609213946;
Received: from localhost.localdomain(mailfrom:bo.liu@senarytech.com fp:SMTPD_---.JCdxAfz_1609213946)
          by smtp.aliyun-inc.com(10.194.99.21);
          Tue, 29 Dec 2020 11:52:28 +0800
From:   bo.liu@senarytech.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     bo.liu@senarytech.com, mirq-linux@rere.qmqm.pl,
        gustavoars@kernel.org, pegro@friiks.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: pci: hda: add a new hda codec
Date:   Tue, 29 Dec 2020 11:52:26 +0800
Message-Id: <20201229035226.62120-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: bo liu <bo.liu@senarytech.com>

The current kernel does not support the cx11970 codec chip.
Add a codec configuration item to kernel.

Signed-off-by: bo liu <bo.liu@senarytech.com>

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index be5000dd1585..e80fe8ba537c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1070,6 +1070,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 static const struct hda_device_id snd_hda_id_conexant[] = {
 	HDA_CODEC_ENTRY(0x14f11f86, "CX8070", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f12008, "CX8200", patch_conexant_auto),
+	HDA_CODEC_ENTRY(0x14f120D0, "CX11970", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15045, "CX20549 (Venice)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15047, "CX20551 (Waikiki)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15051, "CX20561 (Hermosa)", patch_conexant_auto),
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index be5000dd1585..e80fe8ba537c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1070,6 +1070,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 static const struct hda_device_id snd_hda_id_conexant[] = {
 	HDA_CODEC_ENTRY(0x14f11f86, "CX8070", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f12008, "CX8200", patch_conexant_auto),
+	HDA_CODEC_ENTRY(0x14f120D0, "CX11970", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15045, "CX20549 (Venice)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15047, "CX20551 (Waikiki)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15051, "CX20561 (Hermosa)", patch_conexant_auto),
-- 
2.25.1

