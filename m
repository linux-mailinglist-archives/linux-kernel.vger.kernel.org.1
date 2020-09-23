Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902EC27522F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIWHPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIWHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:15:38 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50260C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:15:38 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Bx8bD3x9czQlWP;
        Wed, 23 Sep 2020 09:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-description:content-type
        :content-type:mime-version:message-id:subject:subject:from:from
        :date:date:received; s=mail20150812; t=1600845332; bh=qxgYe414M1
        Mf29+QzYXDxTcG1W4rIE1cEKTwxc6W0K4=; b=LLtzvvEddB7riBdpUKIpHOPRIV
        zkUzpx8HA6i+GbP5MrhFtHBp8t1T1RgCertzfY9ghfkN/JRXfNvrE2KwmRARxsVM
        NXT7VUD2csvWnSt6Mf30n7PpAm18nYOzotGYNf5MrSdKbflpBbbbRnjyKmFV1rgQ
        3ihd+UHXDj532ElgXMQMzHC7YC9jwPt1p8Z0NVKvGMWXw5hKdDFFzdz/lpUU5zb9
        Uc7mXnLhFmDnOWb7izBoIc/FBz+cMPB6uCf2SnFcsaWHUzSzc9URLKQGCl93+25k
        s/wSmvq3dKogHDBe5+JBiLJ0QfsgjBGy61ewhO5qsfTgytCoyAvxomp0FCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1600845334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yydUcsnfgzvWiA/EogiVtXC0mvVj51s7Z38PO9S8mZ0=;
        b=OhHPul/bUgW/qmBHwWx0aOMDEpMA2GgOJIjdYLGryj97P/R2GqtnZ+rPZjMfGAEYIux6PW
        IU/ZBU2jiLOYAXuepYQbB2U4MvRYbjGECKUPpWxphbUhKEJJVCG7OfrRHHjMMzae6/+5/A
        dtw+y+IFT0hs1R07FZCYa18jz1Nrg9whGTMdsDe4S1b1uEoFG8Gfw+ZSX8r4iOq0eDrUH/
        XcAOQv9QYlACh7XKdNnDIOJ/gzgt95xiAof665ftDkChu7/qxhJUCr5vfRtoGaiKTVSKMa
        7xuxusMTrQIWTQ8OIEJ1LcY01Qnima9PVODRylAQ0AtVsjrVohmVquEvHZX8nA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id YBx3ML6zKiFi; Wed, 23 Sep 2020 09:15:32 +0200 (CEST)
Date:   Wed, 23 Sep 2020 09:15:30 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] net: usb: ax88179_178a fix missing stop entry in belkin
 product
Message-ID: <20200923071530.GA23455@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description:  =?ISO-8859-1?Q?=20=1B?=
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.59 / 15.00 / 15.00
X-Rspamd-Queue-Id: 9241614E4
X-Rspamd-UID: 7f1481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the missing .stop entry in the driver_info of the Belking device.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
 drivers/net/usb/ax88179_178a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index a38e868e44d4..ac7bc436da33 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1823,6 +1823,7 @@ static const struct driver_info belkin_info = {
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
 	.reset	= ax88179_reset,
+	.stop = ax88179_stop,
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
-- 
2.28.0

