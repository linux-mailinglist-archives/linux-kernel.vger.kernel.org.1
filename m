Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAA1CCB14
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgEJMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 08:30:06 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:53998 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgEJMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:30:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A5222837F24F;
        Sun, 10 May 2020 12:30:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3871:4321:5007:6119:6120:7809:7901:10004:10400:11232:11658:11914:12043:12048:12297:12555:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30003:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: care08_74ee8b8fc775e
X-Filterd-Recvd-Size: 1873
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 May 2020 12:30:03 +0000 (UTC)
Message-ID: <0bb52429f245717698a2600da094a00977859c79.camel@perches.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Remove Piotr Sroka and mark Cadence
 NFC as orphaned
From:   Joe Perches <joe@perches.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org
Date:   Sun, 10 May 2020 05:30:02 -0700
In-Reply-To: <20200510122430.19105-1-miquel.raynal@bootlin.com>
References: <20200510122430.19105-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-10 at 14:24 +0200, Miquel Raynal wrote:
> Piotr's address is bouncing, remove him from MAINTAINERS and mark the
> driver he was maintaining, Cadence's, as orphaned.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f2c83ead00b..fdd6e96a689b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3749,9 +3749,8 @@ F:	Documentation/devicetree/bindings/media/cdns,*.txt
>  F:	drivers/media/platform/cadence/cdns-csi2*
>  
>  CADENCE NAND DRIVER
> -M:	Piotr Sroka <piotrs@cadence.com>
> +S:	Orphan
>  L:	linux-mtd@lists.infradead.org
> -S:	Maintained
>  F:	Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>  F:	drivers/mtd/nand/raw/cadence-nand-controller.c

Please don't change the relative locations.
L should still comes first, then S


