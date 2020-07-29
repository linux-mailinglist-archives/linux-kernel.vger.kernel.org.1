Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFC232788
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgG2WUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 18:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2WUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:20:09 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C0720656;
        Wed, 29 Jul 2020 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596061209;
        bh=KLvPsavYrofWM6f4AXDigwHYBLrvjA0P788PW9BOn3I=;
        h=Date:From:To:Cc:Subject:From;
        b=lQ6SWJrwmliagnaaj9AARYqFgysmTQLl9kIdZPWtkh9xXkOIBIpNnBRq2/xX9rbNM
         KJxT6KVIXBtwPDzKKUE7379wEXYB6xKcVN1vG2gwRoOUsqR7ZK6MNVqLwoSI9wV5ea
         mnP7+7JCN8ciFZRnbDmEazP0YfwViqMXbk5m542s=
Date:   Wed, 29 Jul 2020 17:26:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] ALSA: hda_codec: Use flex_array_size() helper in
 memcpy()
Message-ID: <20200729222607.GA11750@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer overflows
and makes it explicitly clear that we are dealing with a flexible array
member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 58c698f4d131..453c4ec77c48 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -113,7 +113,7 @@ static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
 		return -ENOMEM;
 	p->len = len;
 	p->nid = nid;
-	memcpy(p->conns, list, len * sizeof(hda_nid_t));
+	memcpy(p->conns, list, flex_array_size(p, conns, len));
 	list_add(&p->list, &codec->conn_list);
 	return 0;
 }
-- 
2.27.0

