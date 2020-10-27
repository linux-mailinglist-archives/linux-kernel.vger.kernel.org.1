Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D920B29AA74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422264AbgJ0LWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438680AbgJ0LWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:22:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9138C22265;
        Tue, 27 Oct 2020 11:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603797729;
        bh=keEF1atJGqkxzQS1pRxnbXeyCt012WhNm5pF5TvhsVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+8yTyTgSvrWzQJlBd4p2EelGPxG9SlppibKiPGf6j/gWtX4+MfWH0kodO5S5XxLx
         2odmoek3kRu/Qqji/Bflm3Iv32yM5x5UH8YtmQJeS3Ij0bFzJ16VJu95sMnNAgCevX
         CsIBWe4uUjVBCO0yAP+BmR1uIqtiycAO5pox8yKA=
Date:   Tue, 27 Oct 2020 12:23:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e, rtl8192u: use correct notation to
 define pointer
Message-ID: <20201027112303.GA405023@kroah.com>
References: <20201026121435.GA782465@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026121435.GA782465@LEGION>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:14:35PM +0500, Muhammad Usama Anjum wrote:
> Use pointer notation instead of using array notation as info_element is
> a pointer not array.
> 
> Warnings from sparse:
> drivers/staging/rtl8192u/ieee80211/ieee80211.h:1013:51: warning: array of flexible structures
> drivers/staging/rtl8192u/ieee80211/ieee80211.h:985:51: warning: array of flexible structures
> drivers/staging/rtl8192u/ieee80211/ieee80211.h:963:51: warning: array of flexible structures
> drivers/staging/rtl8192u/ieee80211/ieee80211.h:996:51: warning: array of flexible structures
> drivers/staging/rtl8192u/ieee80211/ieee80211.h:974:51: warning: array of flexible structures
> 
> drivers/staging/rtl8192e/rtllib.h:832:48: warning: array of flexible structures
> drivers/staging/rtl8192e/rtllib.h:851:48: warning: array of flexible structures
> drivers/staging/rtl8192e/rtllib.h:805:48: warning: array of flexible structures
> drivers/staging/rtl8192e/rtllib.h:843:48: warning: array of flexible structures
> drivers/staging/rtl8192e/rtllib.h:821:48: warning: array of flexible structures
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib.h              | 10 +++++-----
>  drivers/staging/rtl8192u/ieee80211/ieee80211.h | 12 ++++++------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index b84f00b8d18b..1dab9c3d08a8 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -802,7 +802,7 @@ struct rtllib_authentication {
>  	__le16 transaction;
>  	__le16 status;
>  	/*challenge*/
> -	struct rtllib_info_element info_element[];
> +	struct rtllib_info_element *info_element;
>  } __packed;

Are you sure these changes are correct?  This isn't just a list of
structures after this at the end of the structure?

Please look at commit 5979afa2c4d1 ("staging: Replace zero-length array
with flexible-array member") which made most of these flexible arrays.

This is not a pointer, it really is an array, I think sparse is really
wrong here, be careful.

thanks,

greg k-h
