Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE22268E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgINOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:51:48 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35895 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgINOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:50:42 -0400
Received: from localhost (unknown [103.82.80.9])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9CDBE100007;
        Mon, 14 Sep 2020 14:50:24 +0000 (UTC)
Date:   Mon, 14 Sep 2020 20:20:22 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jungseung Lee <js07.lee@samsung.com>
Subject: Re: [PATCH v2 1/4] mtd: spi-nor: cleanup common code
Message-ID: <20200914145022.rdjfaw5vzk7gzvfy@yadavpratyush.com>
References: <20200911222634.31804-1-michael@walle.cc>
 <20200911222634.31804-2-michael@walle.cc>
 <20200914094046.tccoc54n7e36zzyr@yadavpratyush.com>
 <6d52e1bdbbefc9383904e28bcc1c78a7@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d52e1bdbbefc9383904e28bcc1c78a7@walle.cc>
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/20 01:09PM, Michael Walle wrote:
> Hi Pratyush,
> 
> Am 2020-09-14 11:40, schrieb Pratyush Yadav:
> > Hi Michael,
> > 
> > *sigh* This patch will cause a _lot_ of conflicts with my series [0]. It
> > should hopefully go in the next merge window so maybe you can rebase on
> > top of it? Dunno.
> 
> Could you pick up this patch in some form in your series? It looks like your
> series touches most/some of the functions. The patch just removes code
> repetitions.

I don't want to make any last-minute changes that could end up blocking 
the series. Its been pending for many months now.

> TBH I don't need this patch as I just can implement my new one-byte command
> using the current "if (nor->spimem) {} else {}" pattern.

It is up to you what you want to do about the patch. Maybe you can drop 
it now and send it later when things have settled down? Dunno.

-- 
Regards,
Pratyush Yadav
