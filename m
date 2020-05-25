Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66941E0ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbgEYJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 05:40:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44957 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389504AbgEYJkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:40:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id k5so20015131lji.11;
        Mon, 25 May 2020 02:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XQymZljwfgmEfjEng3R4J0xMW9sd1d0z49n9HaUeJs4=;
        b=HXyABr8jCv2j6ZBru0FUNhK8jzw2m1h6CIy3ROaZuHumVV0QfegMFeE077iJsB4C8l
         9oglIJqfPcGjQGrlQNnNh20mS3iFfeWhaCX8npiqG4pz+eqD9r4QBeEs2+IsxXTYwfcQ
         Bh6lS+bfLDcY4QthT9lMxp+/Fk/pjmokuB1R5c3IKkvR8R3nTPS2WBdamqYu0NtVbIVn
         Rt85kqUMeO2s3PokkTwWZQU3jY801cDHuy73F/7smBpxD+kEZR1tGM7tud4lGyOjivJC
         Frnu42BQt6Zt/kSQ3npmkNjsEaxXkOw+7PCVGoQxY436AaTOXb/VQRqJAjzKHpbwAg5x
         fjTA==
X-Gm-Message-State: AOAM533pqiknQ397ijO2CYiRfBnNawLX/HsC7gs8cdpq2CYU/eCxoz13
        mG/DjPR6ZDTEUtIlQHLpjdo=
X-Google-Smtp-Source: ABdhPJxff8oM9HW2z7UfjW5Q8iGKTQ2Src2MKJdLK16sUt6wIlalvZBtCWFwVV+6T7P/u5Kk4QIm9w==
X-Received: by 2002:a2e:860f:: with SMTP id a15mr12799496lji.197.1590399600074;
        Mon, 25 May 2020 02:40:00 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u4sm2263204lfl.18.2020.05.25.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 02:39:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jd9aJ-0006ar-G5; Mon, 25 May 2020 11:39:51 +0200
Date:   Mon, 25 May 2020 11:39:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matt Jolly <Kangie@footclan.ninja>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: qcserial: Add DW5816e QDL support
Message-ID: <20200525093951.GC5276@localhost>
References: <20200521004358.8949-1-Kangie@footclan.ninja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521004358.8949-1-Kangie@footclan.ninja>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:43:58AM +1000, Matt Jolly wrote:
> Add support for Dell Wireless 5816e Download Mode (AKA boot & hold mode /
> QDL download mode) to drivers/usb/serial/qcserial.c
> 
> This is required to update device firmware.
> 
> Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
> ---
> v2 changes: typo.

Hmm. I'd a call a build breakage a bit more than just a "typo" as it
indicates this patch was never tested at all before being submitted. 

Not good.

> ---
> drivers/usb/serial/qcserial.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
> index ce0401d3137f..d147feae83e6 100644
> --- a/drivers/usb/serial/qcserial.c
> +++ b/drivers/usb/serial/qcserial.c
> @@ -173,6 +173,7 @@ static const struct usb_device_id id_table[] = {
>  	{DEVICE_SWI(0x413c, 0x81b3)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
>  	{DEVICE_SWI(0x413c, 0x81b5)},	/* Dell Wireless 5811e QDL */
>  	{DEVICE_SWI(0x413c, 0x81b6)},	/* Dell Wireless 5811e QDL */
> +	{DEVICE_SWI(0x413c, 0x81cb)},	/* Dell Wireless 5816e QDL */
>  	{DEVICE_SWI(0x413c, 0x81cc)},	/* Dell Wireless 5816e */
>  	{DEVICE_SWI(0x413c, 0x81cf)},   /* Dell Wireless 5819 */
>  	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */

Now applied, though.

Johan
