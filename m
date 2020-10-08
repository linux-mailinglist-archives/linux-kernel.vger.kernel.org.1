Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C103287112
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgJHI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:57:33 -0400
Received: from ns.lineo.co.jp ([203.141.200.203]:38808 "EHLO mail.lineo.co.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgJHI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:57:33 -0400
Received: from [172.31.78.0] (unknown [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id 4AA6580535E29;
        Thu,  8 Oct 2020 17:47:44 +0900 (JST)
From:   Naoki Hayama <naoki.hayama@lineo.co.jp>
Subject: [PATCH 4/6] ALSA: hdspm: Fix typo arbitary
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Naoki Hayama <naoki.hayama@lineo.co.jp>
Message-ID: <e04a8c5b-8c59-3f02-34d3-c1a871d08cc2@lineo.co.jp>
Date:   Thu, 8 Oct 2020 17:47:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment typo.
s/arbitary/arbitrary/

Signed-off-by: Naoki Hayama <naoki.hayama@lineo.co.jp>
---
 sound/pci/rme9652/hdspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 572350aaf18d..a808b445afd8 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1217,7 +1217,7 @@ static int snd_hdspm_use_is_exclusive(struct hdspm *hdspm)
 	return ret;
 }
 
-/* round arbitary sample rates to commonly known rates */
+/* round arbitrary sample rates to commonly known rates */
 static int hdspm_round_frequency(int rate)
 {
 	if (rate < 38050)
-- 
2.17.1
