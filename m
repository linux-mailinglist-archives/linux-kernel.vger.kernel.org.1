Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C82E717B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgL2OrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:47:01 -0500
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:52394 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgL2OrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1609252552; bh=XO8zq2EXDKAyfVYGEamn7GG/YHuzCZsXUCUrRThi74Y=;
        h=Date:From:To:Message-ID:MIME-Version:Content-Type;
        b=ofTQu6C+ge0Xnv86Z/k/7QGh5P8W869S49EkUSSPlq+U0GIACDhr7izMJ5fRGpIdi
         O0AnVTfOOeqPFd+SyyLEebGvBzZVosl7AjxJeWSpnft3tPbFlq9BNqfizGQlAKw5HJ
         l6YCbPbIJVuBqw2N8tVihMK8r1h4Ju/wlAa8SPUqtBtWyBwUsfaZiNBG6BcqLTPKdV
         gj8t4XHWeifhTa+9nzQyS6xEbtIk43M4WtnIyumgW51To8DgaXNyTGdxjH0ioq1+Ik
         43Sw+fJ0MBcJby3pzdg1xmijNLAM9ylqlFfz7HLFEcwu62UgJuzL/se13ASflw1VBA
         +qcY87Q/724tA==
Received: from HP-Pavilion-13 (static-168-222-226-77.ipcom.comunitel.net [77.226.222.168])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 3C990AC08E4;
        Tue, 29 Dec 2020 14:35:50 +0000 (UTC)
Date:   Tue, 29 Dec 2020 15:35:46 +0100
From:   Manuel =?iso-8859-1?Q?Jim=E9nez?= <mjbfm99@me.com>
To:     tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-ID: <X+s+wvhNhzL32+Dk@HP-Pavilion-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_11:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=624 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2012290092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mjbfm99@me.com
Bcc: 
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for more HP laptops
Reply-To: 

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

