Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762E42CFC6C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgLESTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgLERzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:55:07 -0500
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Dec 2020 09:53:47 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4242DC0613D1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 09:53:47 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8B19D28005309;
        Sat,  5 Dec 2020 18:41:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 84F3590A8; Sat,  5 Dec 2020 18:42:07 +0100 (CET)
Date:   Sat, 5 Dec 2020 18:42:07 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     yangerkun <yangerkun@huawei.com>, sashal@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, chenwenyong2@huawei.com,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: Patch "spi: Fix controller unregister order" has been added to
 the 4.4-stable tree
Message-ID: <20201205174207.GA4028@wunner.de>
References: <20200616015646.AC54E2074D@mail.kernel.org>
 <8c7683cc-ca73-6883-8e45-613de68fa665@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7683cc-ca73-6883-8e45-613de68fa665@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 04:41:09PM +0800, yangerkun wrote:
> ?? 2020/6/16 9:56, Sasha Levin ????:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      spi: Fix controller unregister order
> > 
> > to the 4.4-stable tree which can be found at:
[...]
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1922,11 +1922,12 @@ void spi_unregister_master(struct spi_master *master)
> >   			dev_err(&master->dev, "queue remove failed\n");
> >   	}
> > +	device_for_each_child(&master->dev, NULL, __unregister);
> > +
> 
> This is a wrong patch. We should move this line before
> spi_destroy_queue, but we didn't. 4.9 stable exists this
> problem too.

Hi Sasha, Hi Greg,

below please find a patch for the 4.9-stable tree to fix the backporting
issue reported above.

Thanks!

-- >8 --
Subject: [PATCH] spi: Fix controller unregister order harder

Commit c7e41e1caa71 sought to backport upstream commit 84855678add8 to
the 4.9-stable tree but erroneously inserted a line at the wrong place.
Fix it.

Fixes: c7e41e1caa71 ("spi: Fix controller unregister order")
Reported-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c7c9ca3178ad..e0632ee1723b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2070,13 +2070,13 @@ static int __unregister(struct device *dev, void *null)
  */
 void spi_unregister_master(struct spi_master *master)
 {
+	device_for_each_child(&master->dev, NULL, __unregister);
+
 	if (master->queued) {
 		if (spi_destroy_queue(master))
 			dev_err(&master->dev, "queue remove failed\n");
 	}
 
-	device_for_each_child(&master->dev, NULL, __unregister);
-
 	mutex_lock(&board_lock);
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
-- 
2.29.2

