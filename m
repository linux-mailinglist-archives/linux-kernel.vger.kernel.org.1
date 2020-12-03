Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363FE2CDA07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgLCPVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:21:35 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42279 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbgLCPVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:21:34 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 67EF15C0078;
        Thu,  3 Dec 2020 10:20:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Dec 2020 10:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=eRauayqR7l9HdVQ2N0t8YYvQDNA
        34Xqn4lVsuCMTxQg=; b=K80qDKiFuTzD2XY7tAh1XeR+HfgHBKbTML5YQmaiqYX
        Onaae3RVk1SgVeozAnUoX6koWjPwcM7mDjREhA0aDPb9A9iXfDVpO5akUrPqvFc7
        KhSFx8Tg6lusmdRCDRoWNlpw3kCSGBRvo5L5Juzj5drEgz1TYCz+n34cw4pauNKn
        /7ZZwb7n/VNGs6rq+ZlrdO5x3UXxIAO2DpbnSgNlWlJXFKDd1d2358cAP6TJGCkv
        IUW0/y5nvlBT1ZDr8g8i3/NuxMcgoo2nM4lWI/XoVxHuKYB0+M7CFgDB2nlEwcuG
        zYaTM2hPbHQnrQQMcOoSnrOFMvlAAJjYjx7MA5fzBag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eRauay
        qR7l9HdVQ2N0t8YYvQDNA34Xqn4lVsuCMTxQg=; b=rE/V9r3hxfyUPapwGq3DWn
        Y5chobRDzVyiDrYVPIkLye5znvqT+tiWIXe3EzzxlM+pFjQ+wxhQoyxAGGAfZviZ
        uHm0tpG5KbSF5be7UT8rv0Hj7kh8y62BodJb9oSfq/nnf5i2sWocdbDCAmFptU3b
        he1vALc0y23Yb7uV5VGVkMG6+w6+4Gfcr3PMpnKIvz0mAWOKDRY3v/O9diYGJpbw
        jiHO+yMp0P+cc/fDhTe3lroMiXDfI2t9OSQ38Z3pym04r92N/qNMVx5wo9LWHqg+
        7MGTcqad54EGpMNxeCxo4Gqgj0G3bNDjYH0trhTAlgPMqSltjanXJWsPfpP34+tg
        ==
X-ME-Sender: <xms:OwLJX5AWVUl5fu449ONwUxUfEdTcYUHr1utHnoifX4OCtITHZfrcFA>
    <xme:OwLJX3gXNqCGz76bH0bZC0V-E164F7U2BFguMuDUXVPs_tgKNdCx3gu723kY-veWX
    dfiqOBB-Glz6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeiiedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:OwLJX0kmHnpIaZ267cEQRyW25E7cz0sCXm2vaCWtVo6U7NbqHPk3Jg>
    <xmx:OwLJXzxPa_Ozv4xkPXey2Cl5LwYG-7WiZPDntMrbEGD5c-XbOsXEXA>
    <xmx:OwLJX-RodF0n1KVZpxPbV111ppp19IqjPjQ0o4vWyxAR9nwLDyWq3w>
    <xmx:PALJX5cu5toWUo1i9oRnEqSHUJIZ7FJx8SuL70VFGkueK6VG4l0RDA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8B671240057;
        Thu,  3 Dec 2020 10:20:27 -0500 (EST)
Date:   Thu, 3 Dec 2020 16:21:36 +0100
From:   Greg KH <greg@kroah.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v2] drivers: usb: storage: prefer pr_*() macros over bare
 printk()
Message-ID: <X8kCgO+2hAgkUqL8@kroah.com>
References: <20201203141634.28850-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203141634.28850-1-info@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:16:34PM +0100, Enrico Weigelt, metux IT consult wrote:
> pr_*() printing helpers are preferred over using bare printk().
> 
> changes v2: fixed ugly typo

Don't put that in the changelog, it goes below the --- line, as is
documented.



> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/usb/storage/alauda.c     | 23 ++++++++------------
>  drivers/usb/storage/ene_ub6250.c | 20 ++++++++---------
>  drivers/usb/storage/freecom.c    |  2 +-
>  drivers/usb/storage/sddr09.c     | 46 +++++++++++++++++-----------------------
>  drivers/usb/storage/sddr55.c     |  7 +++---
>  5 files changed, 43 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 20b857e97e60..5806f1bee471 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -622,9 +622,8 @@ static int alauda_read_map(struct us_data *us, unsigned int zone)
>  
>  		/* check even parity */
>  		if (parity[data[6] ^ data[7]]) {
> -			printk(KERN_WARNING
> -			       "alauda_read_map: Bad parity in LBA for block %d"
> -			       " (%02X %02X)\n", i, data[6], data[7]);
> +			pr_warn("alauda_read_map: Bad parity in LBA for block %d"
> +				" (%02X %02X)\n", i, data[6], data[7]);

Please use dev_warn() and friends instead.  This is a driver, it has a
device, it should never use "raw" printk, or pr_* calls.

thanks,

greg k-h
