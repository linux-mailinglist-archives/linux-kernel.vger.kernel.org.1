Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FE27AE0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1MlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:41:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38751 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgI1MlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:41:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4B38AE1D;
        Mon, 28 Sep 2020 08:33:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Sep 2020 08:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=aKbOhNy9O2gXF53DyoY1hssn0Et
        zT/U677Ue5Zp2lUw=; b=fhtQRRd394LH2wCT02PYVBpKo5fQ5GAt1naEWo3fxrr
        R/nykLWc4Yck9K5GiHUgiRCGYV5fgwwT3FvmrO4pT0MjtZZohJiJMwo/D0foKFMd
        GiUqDCsdLg/OoWzcQwPlSQBXIkUKyAywjSDinZGJ9Iuc0knPsBbpwuXZt5IWj+Pp
        gzfk3Kfu38LHKVBRlsKNs/uLHoGTcncPCEGZ99vDwx3NlI5D8WRArWNf8hD0CQ43
        bgTtwaAkUQstDDTk2VXdVohrr2B+8WwqTELfCBkVQta/+74QcFgehX4+v6Ud/RPk
        cDH3FK9igyV3Yvk8wy9i/7C9i3SjWpAXT1Cpo/7rA1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aKbOhN
        y9O2gXF53DyoY1hssn0EtzT/U677Ue5Zp2lUw=; b=M11zvvl28t+SWegiG9mZ+0
        3J9Yf2yVgzQeRplml/P35qAPPXu4agWRsdTHD+E3pkDMCG6uNga7m4+h8RN3a+HN
        waJxqnmQitwA+F8cvB6yEgFm7iG8p0UfhBrSf9LHfOxPGjzR2+mMdxt+d9a5LLCf
        mz3Gutrtk8qYZdwkms2a/363qPiSYUrFjvnyaFdkZvr0vho3I3NCYab9Nt3wqFG2
        /7lCnm6p9S1s/UYSescTcmr2tp9uYpyZjxHAAaKGPy494Jrwou8Im2ZzQUc+3Wxt
        19lDPYGBBlckf272LQUY3Zh1h+zB4+gyVXUtPb1zQpbECJuWr2eqa8w/OoMm2QKQ
        ==
X-ME-Sender: <xms:G9hxX-F9iKnIsVNn1Wt3HPmUYUM9IKTBtD2Z6cw_bpjNWgvFwUz2Xg>
    <xme:G9hxX_Xal0HbY64U6uM-KrJXOUoNccpKYhXhIc1Dm3YxLj3axDvn73eXFXWfHHUkN
    GQgU6JkKq3nUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeeuffejudeutdeluedtledvgefgueevjeefkedvudfhlefhfe
    dvgeefgfeijeejgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsuhhsvgdrtgho
    mhdpshgvrhhvvghrfhgruhhlthdrtghomhdplhgruhhntghhphgrugdrnhgvthdptggvnh
    htohhsrdhorhhgnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:G9hxX4KwnKM1T3nAkOAoZOkD-ATPfkaTNpO3kOCCmRh8h4B6lS7YmA>
    <xmx:G9hxX4FfBykk6x69Wi6O3dBhGd2MROlhCpIHCQMw1SDBy8VvASOabw>
    <xmx:G9hxX0VUIT10QCix63xdUgkHYy7QNehQ95jpfdm9XR74nbI29xDkZQ>
    <xmx:G9hxX9eb6tG5SXpUsd8B1X9YiC8H8FWjMY-F-4RGQplvDNLMBn5luA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 349B53064682;
        Mon, 28 Sep 2020 08:33:31 -0400 (EDT)
Date:   Mon, 28 Sep 2020 14:33:40 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     jslaby@suse.cz, stable-commits@vger.kernel.org
Subject: Re: Patch "ata: sata_mv, avoid trigerrable BUG_ON" has been added to
 the 4.4-stable tree
Message-ID: <20200928123340.GB1116804@kroah.com>
References: <20200927181119.5ACB623A33@mail.kernel.org>
 <20200928123057.GA1116804@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928123057.GA1116804@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 02:30:57PM +0200, Greg KH wrote:
> On Sun, Sep 27, 2020 at 02:11:18PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     ata: sata_mv, avoid trigerrable BUG_ON
> > 
> > to the 4.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      ata-sata_mv-avoid-trigerrable-bug_on.patch
> > and it can be found in the queue-4.4 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 4b308d858a1a34dae1e38948f2c0497161d9ddd8
> > Author: Jiri Slaby <jslaby@suse.cz>
> > Date:   Thu Oct 31 10:59:46 2019 +0100
> > 
> >     ata: sata_mv, avoid trigerrable BUG_ON
> >     
> >     [ Upstream commit e9f691d899188679746eeb96e6cb520459eda9b4 ]
> >     
> >     There are several reports that the BUG_ON on unsupported command in
> >     mv_qc_prep can be triggered under some circumstances:
> >     https://bugzilla.suse.com/show_bug.cgi?id=1110252
> >     https://serverfault.com/questions/888897/raid-problems-after-power-outage
> >     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
> >     https://bugs.centos.org/view.php?id=14998
> >     
> >     Let sata_mv handle the failure gracefully: warn about that incl. the
> >     failed command number and return an AC_ERR_INVALID error. We can do that
> >     now thanks to the previous patch.
> >     
> >     Remove also the long-standing FIXME.
> >     
> >     [v2] use %.2x as commands are defined as hexa.
> >     
> >     Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >     Cc: Jens Axboe <axboe@kernel.dk>
> >     Cc: linux-ide@vger.kernel.org
> >     Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 729f26322095e..c24bbdb3f76c8 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -2113,12 +2113,10 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
> >  		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
> >  		 * of which are defined/used by Linux.  If we get here, this
> >  		 * driver needs work.
> > -		 *
> > -		 * FIXME: modify libata to give qc_prep a return value and
> > -		 * return error here.
> >  		 */
> > -		BUG_ON(tf->command);
> > -		break;
> > +		ata_port_err(ap, "%s: unsupported command: %.2x\n", __func__,
> > +				tf->command);
> > +		return AC_ERR_INVALID;
> >  	}
> >  	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
> >  	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);
> 
> This causes a build warning as you can not return a value for a void
> function :(
> 
> I'll drop it from the 4.4 queue now, thanks,

Also dropped from 4.9, 4.14, 4.19, and 5.4 queues for the same issue.

thanks,

greg k-h
