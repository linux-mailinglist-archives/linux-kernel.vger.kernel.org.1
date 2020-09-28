Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDC527ADEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgI1MgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:36:23 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35755 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgI1MgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:36:23 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 08:36:23 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D245AC27;
        Mon, 28 Sep 2020 08:30:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Sep 2020 08:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/FWNIPnwvXFhTsEv9VhAdMMkuUK
        o0EmUrAYt5RkWueU=; b=IzEvBBVg8x+bJdmmAGQ0OS7nXXOVM53qeOazF/Jsf8m
        JGG7XOnj39hYE+q0RBA6wltchLKL0RMTlAzABBOYBYPEy8x9Pv1kPoFENQBCAwxB
        oVZ55KrFrnBwJ3m+vt5Uuyxj6Aa869B0/RGhLy/fDUuiZ+Qg70x/R68K/ROyTXlZ
        wdH5LuzN7z9n/Q1LZ/HmBQnBVa0xpMShu3NSoXpzCexNyfRlybtKXJJzNK3BQPeR
        EpOmhscu8i5M/x6hln14nIAPA71/a09Cbh7ul+Y33MwR/OSTXaqz7NbhAWh4FllS
        5mCMwgybKvm45HFuWV9pFT1NsNEeZgFm3E+A+DNoA/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/FWNIP
        nwvXFhTsEv9VhAdMMkuUKo0EmUrAYt5RkWueU=; b=qaufDhKipKmVmfLGN6rJmN
        2ongMzrupmPay8ruskaukKoeWa4jXUUm90SjH8Ye7yNdj04udNswAu7K5KGzcS38
        TWltDEgh1HLqUiBVj40wt7gd98W3s22r/oRInnsdFJFGmfj3lQqz695RBsUcQPz6
        2L+zonHliXEDXN/Fe2fGrKxhmLeYJOZqYeibU/WaXfUZgTgEii1l9YkVqbFOQ84l
        aNkzBurEA5C6wgUXxCo4uGpfA/oUIjTkAuqHjrXkq2Vv1B3CaUClAw7lYNxzYeRK
        Wlt059PfgATGLdIgIGNRTb3Uf1Gn57qCO6t5pvpSRyGZsK/aIc7nCOz+pbbfHPYg
        ==
X-ME-Sender: <xms:eddxXy_jnJXDxpz1ZSWPg5Kz-cQCRwKGMZBZWIlAv8E2_Rzn8pzmQQ>
    <xme:eddxXysRMyG4uJ41wzjEnBPttzV1lsdNqR7xj_pFLwLEt56zVY8b_vkWWKUpOgN6v
    tSFWnHPEIOS0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeeuffejudeutdeluedtledvgefgueevjeefkedvudfhlefhfe
    dvgeefgfeijeejgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsuhhsvgdrtgho
    mhdpshgvrhhvvghrfhgruhhlthdrtghomhdplhgruhhntghhphgrugdrnhgvthdptggvnh
    htohhsrdhorhhgnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:eddxX4BJLxlk9Qd-CMCCluSTYrh7zcpjMpCzQZbySl85V-rTFfZvZQ>
    <xmx:eddxX6e3DjwOlvZ0MfhIF-SVC3Gef5cogmxPhSzwe3UtT545sHtWWQ>
    <xmx:eddxX3MAfCe6jphF7wzP2pql_e_6MgssMmR2ewTCgCh6PGEmErF95A>
    <xmx:eddxX5UWjOVnCMbsIbsFIlLdfJh2BlaTlnYUwIxn1E8k-tuKxNoBOQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD0DE306467D;
        Mon, 28 Sep 2020 08:30:48 -0400 (EDT)
Date:   Mon, 28 Sep 2020 14:30:57 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     jslaby@suse.cz, stable-commits@vger.kernel.org
Subject: Re: Patch "ata: sata_mv, avoid trigerrable BUG_ON" has been added to
 the 4.4-stable tree
Message-ID: <20200928123057.GA1116804@kroah.com>
References: <20200927181119.5ACB623A33@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927181119.5ACB623A33@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 02:11:18PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     ata: sata_mv, avoid trigerrable BUG_ON
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ata-sata_mv-avoid-trigerrable-bug_on.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 4b308d858a1a34dae1e38948f2c0497161d9ddd8
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Thu Oct 31 10:59:46 2019 +0100
> 
>     ata: sata_mv, avoid trigerrable BUG_ON
>     
>     [ Upstream commit e9f691d899188679746eeb96e6cb520459eda9b4 ]
>     
>     There are several reports that the BUG_ON on unsupported command in
>     mv_qc_prep can be triggered under some circumstances:
>     https://bugzilla.suse.com/show_bug.cgi?id=1110252
>     https://serverfault.com/questions/888897/raid-problems-after-power-outage
>     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
>     https://bugs.centos.org/view.php?id=14998
>     
>     Let sata_mv handle the failure gracefully: warn about that incl. the
>     failed command number and return an AC_ERR_INVALID error. We can do that
>     now thanks to the previous patch.
>     
>     Remove also the long-standing FIXME.
>     
>     [v2] use %.2x as commands are defined as hexa.
>     
>     Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>     Cc: Jens Axboe <axboe@kernel.dk>
>     Cc: linux-ide@vger.kernel.org
>     Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 729f26322095e..c24bbdb3f76c8 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2113,12 +2113,10 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
>  		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
>  		 * of which are defined/used by Linux.  If we get here, this
>  		 * driver needs work.
> -		 *
> -		 * FIXME: modify libata to give qc_prep a return value and
> -		 * return error here.
>  		 */
> -		BUG_ON(tf->command);
> -		break;
> +		ata_port_err(ap, "%s: unsupported command: %.2x\n", __func__,
> +				tf->command);
> +		return AC_ERR_INVALID;
>  	}
>  	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
>  	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);

This causes a build warning as you can not return a value for a void
function :(

I'll drop it from the 4.4 queue now, thanks,

greg k-h
