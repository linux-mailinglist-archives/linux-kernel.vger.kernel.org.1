Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BB22E7179
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgL2OqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:46:03 -0500
Received: from st43p00im-zteg10073501.me.com ([17.58.63.180]:52036 "EHLO
        st43p00im-zteg10073501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgL2OqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:46:02 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2020 09:46:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1609252742; bh=u8vNBKkJBeENQUWHNcyHxDvh/UkfG24ft3OMmx23qEc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Oj/2yHclIjzJpO0410d80N/sS2kJ3CKdRl4j5ZGTKK2JnlRivQWuhTX2Lt7zsvtHL
         zHXCdlwS3I6BmNtGVeYZowdBT9Oc6tIDX0Kf88YyniReTVJ+UL492ofeefdGPf2eTe
         dLmR479mThZfwvBYMoJ3wDqX08iNJYTUjk6t3kRtnpxzvKuKaFWI2MCAlBuXFEBRcP
         eMhA/KACBC7c31T24Zgu6pUNyaQ6W+gNMuK7RId+3FmgXhaJxg30SaVs2ERzu+6TFz
         AvcIVwyb1Na7tef7QAlkyfwPCQjTa8xTZot1iVqDh2Arm4nM9FEHRUgSZVPYoepqOa
         RQ7HdxigYS+wQ==
Received: from HP-Pavilion-13 (static-168-222-226-77.ipcom.comunitel.net [77.226.222.168])
        by st43p00im-zteg10073501.me.com (Postfix) with ESMTPSA id 36AEDAE088F;
        Tue, 29 Dec 2020 14:39:00 +0000 (UTC)
Date:   Tue, 29 Dec 2020 15:38:56 +0100
From:   Manuel =?iso-8859-1?Q?Jim=E9nez?= <mjbfm99@me.com>
To:     tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        mjbfm99@me.com
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for more HP laptops
Message-ID: <X+s/gKNydVrI6nLj@HP-Pavilion-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_11:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=773 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2012290093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP Pavilion 13-bb0000 (SSID 103c:87c8) needs the same
quirk as other models with ALC287.

Signed-off-by: Manuel Jiménez <mjbfm99@me.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dde5ba209541..b77cef72c2d5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7964,6 +7964,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8760, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.29.2

