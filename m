Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0F2E199E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgLWIHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:07:15 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53451 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727622AbgLWIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:07:15 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ACBAA5C003A;
        Wed, 23 Dec 2020 03:06:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 23 Dec 2020 03:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=rAwOeL+AhvlZ/7XUvtxa48qIOW2
        flZc7fKC5JoxL+zM=; b=NWC3unSQ6QkD+iiBoNT6/w855A3+0W7X8HdSsj8VqoE
        BcD8KZ9NCc/M5PJBeKi5O5SXbNNEMr6LvJmWz1GkCFw4NjmfMKldMTjFNI7+9mHe
        hymE+Yd+Y8iZPQw5qT0H9vlmPCSe84cMHy8RDyRqnRvY1NhQmKMZX17i0QWazIW/
        c/f5imHAwanRDlYsKdu3NJbizozN8zAmDRuccLixR4739+9QFHB+ScNHDcFyZM6M
        a7PlzT9UFd6yLqeOP2cCzWuNRBb+c3DHrdO03/p92+ViSddm38zW/RNxxqwIJA0i
        N6f6lUtVJs+Jsb2PNjWA0VL7gXV4LsJsoij8xmKEUUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rAwOeL
        +AhvlZ/7XUvtxa48qIOW2flZc7fKC5JoxL+zM=; b=WjBElTnzQaCCdjhFWrTh3p
        cAvpNyEUbRmH3myNxmS/+ncd/VkO6AkeccllBBxT5qxo/z8vPjN3RmY+xX+PnDlN
        Sz5ZS3vu70i2P+kYxCzbia+9/VGuSukwVKpvm0v+55FMdqPi039cJOfQVYdRv1sG
        GTeowHAc/JZD6mgMRqV3gjyL36jMD01Gis54l/CQm6ihX/Qc5y5LXyyJwPhiSAms
        95UgWbn4gGUBkNWkEj8iDooOOVUjyuMOoSObR9v9tJVOhN21T4kT6ez61OdDBNrC
        gQT4UPHwxf8hXyvUoe00qbaWr7GJ3xXNbJKWc3rWLGBQaUdcyT8aOGx5e8vsTY9Q
        ==
X-ME-Sender: <xms:bfriX_ObLzT4QuEBZMPU5g7yLBE0EyAamSLCCJ_1z3QWpRNtwhkfkA>
    <xme:bfriX5_UW8QrHL36RqPGVquJqDv6AwoLZBllmNpQmcOaCPIKNZowrNPmMSjFLd4Qu
    k2MWi7LAvmBJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:bfriX-S5FPiuuYYYZ8onF-FWtEZ9Mobqzk-2CSGqZ9Vu9XC800qpuQ>
    <xmx:bfriXztq6ZqPZyOvoWo2jeOtzlMvvQ7ASDTCUlTJ51bFigNMvynhOg>
    <xmx:bfriX3cBe__BMCq4gz9ilep9vzEmpWDcqSBIkreOWClELhxwGYVVlA>
    <xmx:cPriX4omwjDEFUh1EAFFOhI9wtbowMQQqweTB41XdjNnmUgkH3Otlg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4C1BB240057;
        Wed, 23 Dec 2020 03:06:05 -0500 (EST)
Date:   Wed, 23 Dec 2020 09:06:03 +0100
From:   Greg KH <greg@kroah.com>
To:     chensong <chensong_2000@189.cn>
Cc:     linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, chensong@tj.kylinos.cn
Subject: Re: [PATCH] staging: comedi: remove warnings of comedi_lrange
Message-ID: <X+L6a+8C7xE39vJj@kroah.com>
References: <1608690263-29411-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608690263-29411-1-git-send-email-chensong_2000@189.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:24:23AM +0800, chensong wrote:
> Checkpatch.pl reports "warning: struct comedi_lrange should
> normally be const" in some places, which are supposed to
> be removed.
> 
> Signed-off-by: chensong <chensong_2000@189.cn>
> ---
>  drivers/staging/comedi/drivers/das16.c   | 4 ++--
>  drivers/staging/comedi/drivers/jr3_pci.c | 4 ++--
>  drivers/staging/comedi/drivers/ni_670x.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/das16.c b/drivers/staging/comedi/drivers/das16.c
> index 4ac2622..40bfd84 100644
> --- a/drivers/staging/comedi/drivers/das16.c
> +++ b/drivers/staging/comedi/drivers/das16.c
> @@ -958,7 +958,7 @@ static const struct comedi_lrange *das16_ai_range(struct comedi_device *dev,
>  
>  	/* get any user-defined input range */
>  	if (pg_type == das16_pg_none && (min || max)) {
> -		struct comedi_lrange *lrange;
> +		const struct comedi_lrange *lrange;
>  		struct comedi_krange *krange;
>  
>  		/* allocate single-range range table */
> @@ -992,7 +992,7 @@ static const struct comedi_lrange *das16_ao_range(struct comedi_device *dev,
>  
>  	/* get any user-defined output range */
>  	if (min || max) {
> -		struct comedi_lrange *lrange;
> +		const struct comedi_lrange *lrange;
>  		struct comedi_krange *krange;
>  
>  		/* allocate single-range range table */
> diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
> index 7a02c4f..c35db0b 100644
> --- a/drivers/staging/comedi/drivers/jr3_pci.c
> +++ b/drivers/staging/comedi/drivers/jr3_pci.c
> @@ -91,8 +91,8 @@ struct jr3_pci_dev_private {
>  };
>  
>  union jr3_pci_single_range {
> -	struct comedi_lrange l;
> -	char _reserved[offsetof(struct comedi_lrange, range[1])];
> +	const struct comedi_lrange l;
> +	char _reserved[offsetof(const struct comedi_lrange, range[1])];
>  };
>  
>  enum jr3_pci_poll_state {
> diff --git a/drivers/staging/comedi/drivers/ni_670x.c b/drivers/staging/comedi/drivers/ni_670x.c
> index c197e47..66485ec 100644
> --- a/drivers/staging/comedi/drivers/ni_670x.c
> +++ b/drivers/staging/comedi/drivers/ni_670x.c
> @@ -200,7 +200,7 @@ static int ni_670x_auto_attach(struct comedi_device *dev,
>  		const struct comedi_lrange **range_table_list;
>  
>  		range_table_list = kmalloc_array(32,
> -						 sizeof(struct comedi_lrange *),
> +						 sizeof(const struct comedi_lrange *),
>  						 GFP_KERNEL);
>  		if (!range_table_list)
>  			return -ENOMEM;
> -- 
> 2.7.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
