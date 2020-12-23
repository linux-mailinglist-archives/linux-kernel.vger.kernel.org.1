Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7012E19A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgLWIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:08:07 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47715 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727622AbgLWIIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:08:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DAA5E5C00E5;
        Wed, 23 Dec 2020 03:07:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 23 Dec 2020 03:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9JJi8AtWAjqL/D6wWY41kdtAHDy
        ODpb7iEOj0dFjiug=; b=At2lNwVI6iBE9+gWeehiWQ9nR7Kslps1U36PlLryzK9
        JI2XETPPxLcDwIONQqUGUFoLCTxhjV5aDcCQxipqJI1wiPfNE7wEw/sfbWKrLTj/
        scRbj2COi0UHvz4/izUH2Uva+ONnMtySajOLErxDRQ+6sy6Q+daI2YGHhamODzIn
        KQ/cti60IlPSy+CNA3bzsZjRNbXjjNbvrL60v43m2cc2591jwtWAh7f7uJpKtKbs
        2awvJJPCW8yEmYH3cL7FK18wvMGXQjsr5nKjTzs3hmEjeC5CfnlRd2CA+2mwmkt6
        XUe/bOV4dimmsG/M5uSLhdDv1Do1ZKKaQeVxjGhcUxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9JJi8A
        tWAjqL/D6wWY41kdtAHDyODpb7iEOj0dFjiug=; b=iqKzd8FNTe4oG7Ev3mQ8UX
        uCl8zBedT1vrdNYi1AWPJ6WjXLLdqbIBwO0AoD/XRAMaKb/DLVJA0N24Z9B1aYxm
        sAGX/UGFciit/xlM2ci2vKScbaj7w0kODv9a9r+Yg4k5lPQsSNc+Cdk/+zSCbsXQ
        s6UxKPeay6PyLckExhS1pGPWoJBTMLe/TYqCjRWf4l9I905WtaJiO3eCGcyQLdCf
        hzCMnFhY20M3Z+kGb9H3f0zy7a489etJR1owvZsKNKnN2glYDKbunYgFrgBUOgtx
        4sEq2W+wtjOV+x5mF55D8pssvkycXpY6EQyoSgKdZezGbvnuto9cXXuS4dryQYLw
        ==
X-ME-Sender: <xms:ovriX3g20L_TnsAHsqeyWZ7RqMHuSnpnT0Wb-hDPCf4ETHOXvuKq5Q>
    <xme:ovriX0AdLUsYQNRGlZ1rZrNAf0VssA_03c2SriozMZVOEmonpUrf0W6ldRy1rawtd
    4DU6ryhwc_tBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:ovriX3FM3fi0a3zd-cimvYdbtfWnmk-NVMnOKMQBG-uBYCGRq_l4PA>
    <xmx:ovriX0R-9oPNqBUOW64vfdeIxprAQY0mD4nxmqtZB1Fa_J87FB3vrw>
    <xmx:ovriX0yfWECXG36ytwgx4E0dp4U_e5_RXUwBIJxvzo-p1gTbKTUc7w>
    <xmx:pPriX__JI020KZ_Zcq1LtMoHKbWyUlNumAXzqEeNYptjRUrboSw62g>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8949D108005C;
        Wed, 23 Dec 2020 03:06:58 -0500 (EST)
Date:   Wed, 23 Dec 2020 09:06:56 +0100
From:   Greg KH <greg@kroah.com>
To:     chensong <chensong_2000@189.cn>
Cc:     linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, chensong@tj.kylinos.cn
Subject: Re: [PATCH] staging: comedi: correct spelling mistakes of I/O port
 base address
Message-ID: <X+L6oCXQJNr+Qf8X@kroah.com>
References: <1608690383-30917-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608690383-30917-1-git-send-email-chensong_2000@189.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:26:23AM +0800, chensong wrote:
> "base" was double input in comment line "I/O port base
> address", remove one of them.
> 
> Signed-off-by: chensong <chensong_2000@189.cn>
> ---
>  drivers/staging/comedi/drivers/dt2815.c | 2 +-
>  drivers/staging/comedi/drivers/dt2817.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dt2815.c b/drivers/staging/comedi/drivers/dt2815.c
> index 5906f32..2be2406 100644
> --- a/drivers/staging/comedi/drivers/dt2815.c
> +++ b/drivers/staging/comedi/drivers/dt2815.c
> @@ -17,7 +17,7 @@
>   * contrary, please update.
>   *
>   * Configuration options:
> - * [0] - I/O port base base address
> + * [0] - I/O port base address
>   * [1] - IRQ (unused)
>   * [2] - Voltage unipolar/bipolar configuration
>   *	0 == unipolar 5V  (0V -- +5V)
> diff --git a/drivers/staging/comedi/drivers/dt2817.c b/drivers/staging/comedi/drivers/dt2817.c
> index 7c1463e..a173394 100644
> --- a/drivers/staging/comedi/drivers/dt2817.c
> +++ b/drivers/staging/comedi/drivers/dt2817.c
> @@ -21,7 +21,7 @@
>   * with 32 channels, configurable in groups of 8.
>   *
>   * Configuration options:
> - * [0] - I/O port base base address
> + * [0] - I/O port base address

I think the original is correct here.

thanks,

greg k-h
