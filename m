Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6B26D562
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgIQH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:56:31 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:17585 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIQH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:56:24 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id A3D604E17A0;
        Thu, 17 Sep 2020 15:56:18 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Wang Qing <wangqing@vivo.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound/pci/asihpi: fix spellint typo in comments
Date:   Thu, 17 Sep 2020 15:55:52 +0800
Message-Id: <1600329372-2266-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR8fS0kYS01CGEtOVkpNS0tISUJITENCT05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Cio4Vj8vOBQ4HjgPMkM8
        FTcaCjJVSlVKTUtLSElCSExCSExPVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKT01JNwY+
X-HM-Tid: 0a749b106c0d9376kuwsa3d604e17a0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the comment typo: "ununsed" -> "unused".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 sound/pci/asihpi/hpios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpios.h b/sound/pci/asihpi/hpios.h
index 26f7cf4..9e551bc
--- a/sound/pci/asihpi/hpios.h
+++ b/sound/pci/asihpi/hpios.h
@@ -67,7 +67,7 @@ struct hpi_ioctl_linux {
 };
 
 /* Conflict?: H is already used by a number of drivers hid, bluetooth hci,
-   and some sound drivers sb16, hdsp, emu10k. AFAIK 0xFC is ununsed command
+   and some sound drivers sb16, hdsp, emu10k. AFAIK 0xFC is unused command
 */
 #define HPI_IOCTL_LINUX _IOWR('H', 0xFC, struct hpi_ioctl_linux)
 
-- 
2.7.4

