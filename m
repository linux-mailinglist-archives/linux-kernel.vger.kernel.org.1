Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564D727BDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgI2HPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:15:19 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40897 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgI2HPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:15:19 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 17B845C0195;
        Tue, 29 Sep 2020 03:15:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 29 Sep 2020 03:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=PWqFhOK6Bo8sCV0S7SwUBsOgPdt
        O5Cip5iwDuGiZBcI=; b=ojA59IDcgFXwhU4A2Cz0mAeDgebpRkxMtuM2Mw73sHq
        BC/gicDHvgjOIOoOghHgG5WHLu9pzwuJwo8QP7/EYh47cq7oua7CuzWeYL/jiabK
        3kuoNINwSJ50YtrC3x6TEHfx22M0HySUdOlEnD8sckgmbW6yYEFvpYsUTZrPDNok
        zl+hrrQaWlKZ4N+wwPJtTfO0yuZs/FgMWemCrru+geZRA1zirNuPkyBqiqB5XhGK
        n759TJKVWqDwuIVhIzoauSj5xMQlVCznjfiJC15nC9xUJXPc73V+/Db9/JjP9NBi
        brHglPlrigCsFhIlH4ROVW7V7KyNSxDpyRi77mgW7rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PWqFhO
        K6Bo8sCV0S7SwUBsOgPdtO5Cip5iwDuGiZBcI=; b=SeBLVopZenFfd9h3ev1u//
        fiGSTg9thf8LMyuMCLeGLG/oKJWRRNU0XHiK3xAPh7DE2DIXgKWlpZgin6l037Gm
        zk8VlxXA4qxidwvDamVy1UYUSfB5Hx87nj1doMgNH3LEcd+BdzXi69DFDqgxcmpW
        8P7Vbxyv42uhbgFirFi/4iR/eMfCsbZ/M1+uMU5AHvcsErcPL05hoPFo5CtRXb89
        BOzcsbsh7y1OmQkTmEJ0xTN+HgGCv1IUcHW1GF8wA2J7g8fLcgWD+PvgbQlTl4IF
        0rY2Qb8KGt8zuvwcbkYzizufpVoxl8RkJCeaAaDHUya2T9yY/nScV0XE+FRAd5sw
        ==
X-ME-Sender: <xms:Bd9yXyVZuq3x1u98USCbXycY2lane4F6aYK6s_uzc3rc98axKB0WzA>
    <xme:Bd9yX-lOgfBQQgsIXL3hfxDd5BURm4XWq1fGrSwCpyW75ObNDfFVARGX2P3G-RCra
    Hz8l0orqBUfkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdejgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedukeffve
    dtkeduvddvudegueetgfejueehuedtgfehkefftdevieehkedvieejkeenucffohhmrghi
    nhepshhushgvrdgtohhmpdhsvghrvhgvrhhfrghulhhtrdgtohhmpdhlrghunhgthhhprg
    gurdhnvghtpdgtvghnthhoshdrohhrghenucfkphepkeefrdekiedrjeegrdeigeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskh
    hrohgrhhdrtghomh
X-ME-Proxy: <xmx:Bd9yX2ZHIFgMTJgheG_a0wsr40NTdyQin5QQ8sCpURTAmp-ILJZ7uw>
    <xmx:Bd9yX5V2zxAgJV5NbTdAvU0YqtoNhqQ4D6QfXkRg-YWlhQ9zmObi8Q>
    <xmx:Bd9yX8kff1DsVXPbq5OBagSwN_2CQS7zpYkGLVZ2BbJceknYYTg_CQ>
    <xmx:Bt9yXzurjDy2XaSqrgqpWL1KwVGrJL_TarjZ6BAwCJwBo2EzzwuEdw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CB513280060;
        Tue, 29 Sep 2020 03:15:17 -0400 (EDT)
Date:   Tue, 29 Sep 2020 09:15:22 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "ata: sata_mv, avoid trigerrable BUG_ON" has been added to
 the 4.4-stable tree
Message-ID: <20200929071522.GA3700372@kroah.com>
References: <20200927181119.5ACB623A33@mail.kernel.org>
 <20200928123057.GA1116804@kroah.com>
 <167f8a53-6b68-05b8-a632-34df046a0376@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167f8a53-6b68-05b8-a632-34df046a0376@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 08:33:24AM +0200, Jiri Slaby wrote:
> On 28. 09. 20, 14:30, Greg KH wrote:
> >> commit 4b308d858a1a34dae1e38948f2c0497161d9ddd8
> >> Author: Jiri Slaby <jslaby@suse.cz>
> >> Date:   Thu Oct 31 10:59:46 2019 +0100
> >>
> >>     ata: sata_mv, avoid trigerrable BUG_ON
> >>     
> >>     [ Upstream commit e9f691d899188679746eeb96e6cb520459eda9b4 ]
> >>     
> >>     There are several reports that the BUG_ON on unsupported command in
> >>     mv_qc_prep can be triggered under some circumstances:
> >>     https://bugzilla.suse.com/show_bug.cgi?id=1110252
> >>     https://serverfault.com/questions/888897/raid-problems-after-power-outage
> >>     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
> >>     https://bugs.centos.org/view.php?id=14998
> >>     
> >>     Let sata_mv handle the failure gracefully: warn about that incl. the
> >>     failed command number and return an AC_ERR_INVALID error. We can do that
> >>     now thanks to the previous patch.
> >>     
> >>     Remove also the long-standing FIXME.
> >>     
> >>     [v2] use %.2x as commands are defined as hexa.
> >>     
> >>     Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >>     Cc: Jens Axboe <axboe@kernel.dk>
> >>     Cc: linux-ide@vger.kernel.org
> >>     Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >>
> >> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> >> index 729f26322095e..c24bbdb3f76c8 100644
> >> --- a/drivers/ata/sata_mv.c
> >> +++ b/drivers/ata/sata_mv.c
> >> @@ -2113,12 +2113,10 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
> >>  		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
> >>  		 * of which are defined/used by Linux.  If we get here, this
> >>  		 * driver needs work.
> >> -		 *
> >> -		 * FIXME: modify libata to give qc_prep a return value and
> >> -		 * return error here.
> >>  		 */
> >> -		BUG_ON(tf->command);
> >> -		break;
> >> +		ata_port_err(ap, "%s: unsupported command: %.2x\n", __func__,
> >> +				tf->command);
> >> +		return AC_ERR_INVALID;
> >>  	}
> >>  	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
> >>  	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);
> > 
> > This causes a build warning as you can not return a value for a void
> > function :(
> 
> Sure, you need the patch before, i.e. e9f691d899^:
> commit 95364f36701e62dd50eee91e1303187fd1a9f567
> Author: Jiri Slaby <jirislaby@kernel.org>
> Date:   Thu Oct 31 10:59:45 2019 +0100
> 
>     ata: make qc_prep return ata_completion_errors
> 
> 
> 
> And that needs one more patch e9f691d899^^:
> 
> commit 25937580a5065d6fbd92d9c8ebd47145ad80052e
> Author: Jiri Slaby <jirislaby@kernel.org>
> Date:   Thu Oct 31 10:59:44 2019 +0100
> 
>     ata: define AC_ERR_OK

Thanks, that worked!

greg k-h
