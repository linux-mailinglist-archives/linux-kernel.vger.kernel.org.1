Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F432689BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:09:39 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36911 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgINLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:09:38 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CC4EA22F53;
        Mon, 14 Sep 2020 13:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600081776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yszHbgqX450NR05oYbyE31jOQW/bTnQLlOfg2qjJEo0=;
        b=ozlgJ5BdDpbabKUGdD25b0kKp+8wyFP/TZ6OkHrMwCyVFvIUAxHxHH1hTOmM0+ZAMaJAf2
        t7wa8Xq0Mc93xdcvqfKtENYJ1uVrfJb0QZOO10ufjLcmDusfLlIsvrY9oEKezzCSDGd5mP
        nrjh0WHu/aJ5vBzeiYZPhYNYyEtdtzQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 13:09:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jungseung Lee <js07.lee@samsung.com>
Subject: Re: [PATCH v2 1/4] mtd: spi-nor: cleanup common code
In-Reply-To: <20200914094046.tccoc54n7e36zzyr@yadavpratyush.com>
References: <20200911222634.31804-1-michael@walle.cc>
 <20200911222634.31804-2-michael@walle.cc>
 <20200914094046.tccoc54n7e36zzyr@yadavpratyush.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <6d52e1bdbbefc9383904e28bcc1c78a7@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Am 2020-09-14 11:40, schrieb Pratyush Yadav:
> Hi Michael,
> 
> *sigh* This patch will cause a _lot_ of conflicts with my series [0]. 
> It
> should hopefully go in the next merge window so maybe you can rebase on
> top of it? Dunno.

Could you pick up this patch in some form in your series? It looks like 
your
series touches most/some of the functions. The patch just removes code
repetitions.
TBH I don't need this patch as I just can implement my new one-byte 
command
using the current "if (nor->spimem) {} else {}" pattern.

-michael
