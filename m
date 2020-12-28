Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25C2E40FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392542AbgL1PB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392591AbgL1PBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2554208D5;
        Mon, 28 Dec 2020 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609167624;
        bh=TbqSh3PsttugZzWTBvvrutqtvAnSYnz4ZADL+W5fc8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lI+RFie+AwGXRUGcVCg34DyxSiywWTGmJbCDOPrDP5vUUpiIcQlsA2HCUo0m4U0kO
         XQBWUcYELkfwLW4h9yePXnT7ad6flrv2/PF3crl10sKdcIXKj9iieS7Hr9sPVDtyNR
         pai6a9dUmOmfZ6bDFJJhqtvoWVZu/RNN4Qa+GLjI=
Date:   Mon, 28 Dec 2020 16:01:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: gadget: u_audio: remove struct uac_req
Message-ID: <X+nzWs3nOrcqu4F2@kroah.com>
References: <20201221173531.215169-1-jbrunet@baylibre.com>
 <20201221173531.215169-4-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221173531.215169-4-jbrunet@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 06:35:30PM +0100, Jerome Brunet wrote:
> 'struct uac_req' purpose is to link 'struct usb_request' to the
> corresponding 'struct uac_rtd_params'. However member req is never
> used. Using the context of the usb request, we can keep track of the
> corresponding 'struct uac_rtd_params' just as well, without allocating
> extra memory.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/usb/gadget/function/u_audio.c | 58 ++++++++++++---------------
>  1 file changed, 26 insertions(+), 32 deletions(-)

This patch doesn't apply, so I can't apply patches 3 or 4 of this series
:(

Can you rebase against my usb-testing branch and resend?

thanks,

greg k-h
