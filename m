Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C228A245
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbgJJW4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:56:07 -0400
Received: from mail.teknik.io ([5.79.72.163]:56540 "EHLO mail.teknik.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731502AbgJJTaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:30:46 -0400
X-Greylist: delayed 3067 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2020 15:30:45 EDT
dkim-signature: v=1; a=rsa-sha256; d=teknik.io; s=dkim;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
        bh=9J/Xx1xk+63xPy4JqmRp6MYQEE6DY0yvVWSnsb8siCo=;
        b=IjFQpjEg3uUx11+IOqUqaX638+ha4ghGwGOyALNxRKZM9+SWusUG4Mb8ONH7qd2WREFylM/7TxjOMhXD7ytcgj1Q/Ja1y0IWeLyv4SWBpJ+3ndtJxKAaTyIg806mJnFj4Kakj+GCziiQyCjmPdqpCv5cnozH5txhCy3p2eqO5V24tKxfoqGm3mIkIiIec4NLH3MkiYp65UrhkvX6DpzDB3EmiuFAwRZGFdKm4cI/4hfLqWow//BFPRR8KZ
        8161UuLMviahmKnnILOwMO8awXyx+Y9Z5MrQU4Ol1sq4NPdae9GwOzNFLSQ34sz5LJMS5IF63aNvEbh3IwgrE8a/2PkA==
Received: from pop-os (89.239.213.172.dhcp.fibianet.dk [89.239.213.172])
        by mail.teknik.io with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-ECDSA-AES256-GCM-SHA384 bits=256)
        ; Sat, 10 Oct 2020 10:08:25 -0700
From:   Vasily Utkin <vautkin@teknik.io>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Vasily Utkin <vautkin@teknik.io>
Subject: [PATCH] staging: comedi: ni_mio_common: Fix newline after dereference operator
Date:   Sat, 10 Oct 2020 19:07:22 +0200
Message-Id: <20201010170721.98595-1-vautkin@teknik.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix newline after dereference operator detected by checkpatch.

Signed-off-by: Vasily Utkin <vautkin@teknik.io>
---
 drivers/staging/comedi/drivers/ni_mio_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
index 9266e13f6271..4f80a4991f95 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -723,8 +723,7 @@ static void ni_release_gpct_mite_channel(struct comedi_device *dev,
 
 		ni_set_bitfield(dev, NI_E_DMA_G0_G1_SEL_REG,
 				NI_E_DMA_G0_G1_SEL_MASK(gpct_index), 0);
-		ni_tio_set_mite_channel(&devpriv->
-					counter_dev->counters[gpct_index],
+		ni_tio_set_mite_channel(&devpriv->counter_dev->counters[gpct_index],
 					NULL);
 		mite_release_channel(mite_chan);
 	}
-- 
2.25.1


