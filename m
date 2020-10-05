Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12426283F5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgJETMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgJETMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:12:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6CTiwZikzwOayCgM9BdSR2MAppz360/FLOkaH+kTKSU=; b=iJdkPAuElAvxnFH4lJK4mzijHu
        xdZhrR9d0mF4/UcoP8ijav8lW3aD6kBPrk26VxOU12FmBaYlMNT1rS1n7PTzmfQDL1T1Hf1k0oqGe
        ZIqEQ8xGZYv0q+v+fVwoi/ZLLOUUPwb4I/hnGc+q0a4w0wPygx/8RmJOOhVlie5zSikgI51uLPBIL
        LmxfghuXGgBmRuN9+SbhEpaRkqNKu+g4WMPkY+pMb0i4GGYYWtsAn9R2cFjT1cnA61X8X63kfiClz
        Q468bT2AVVk2H6qJvTgc8lnrzU0I2CzAriAo6cBx5Pn3Z7gsnOu1TGsTNXgfb6Fdc4IZjoG2LUseO
        mV2bFrzA==;
Received: from [2601:1c0:6280:3f0::2c9a] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPVuO-000774-3v; Mon, 05 Oct 2020 19:12:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] sound: drivers: portman2x4: fix repeated word 'if'
Date:   Mon,  5 Oct 2020 12:12:23 -0700
Message-Id: <20201005191223.21514-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct duplicated word "if" to "if it".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/drivers/portman2x4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-59-rc8.orig/sound/drivers/portman2x4.c
+++ lnx-59-rc8/sound/drivers/portman2x4.c
@@ -467,7 +467,7 @@ static int portman_probe(struct parport
 	parport_write_control(p, 0);	/* Reset Strobe=0. */
 
 	/* Check if Tx circuitry is functioning properly.  If initialized 
-	 * unit TxEmpty is false, send out char and see if if goes true.
+	 * unit TxEmpty is false, send out char and see if it goes true.
 	 */
 	/* 8 */
 	parport_write_control(p, TXDATA0);	/* Tx channel 0, strobe off. */
