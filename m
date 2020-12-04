Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55D2CEAAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgLDJSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:18:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45283 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgLDJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:17:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id z21so6689576lfe.12;
        Fri, 04 Dec 2020 01:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DvTH9kb37VfSAtxGxwWNQeRzIJPwiKTMeqWGeeShIM=;
        b=WMU0sMeTV3vksP0ocnktVnmA6TEBmjHuN9gZ3f9m1B8EFxQIRadxy10Boes/7ubiUN
         nP+7GwNEOZAxrrK/83v3rLNyYE83TpaKXSrtd4Q0qy+SakK6oe8DD/7i53ruHJQfYIMs
         nFNk3cu6SctQPsliC8ulAtkyQgyEboQuZXmEsuUZuUi+VJtgs9tKftCycDxhKtkkjy5b
         T+UXr/PwCB7MeN/sUNcUnyT8XOO8gBt0XOkrt/yRIZMFkKTloKPN9tt8qS9KzMIqdTJA
         iMWDFqoLYyKf20bPLJiiUv6/h2I+ya28GBTLedLRrgsyy2qhG31345J2OUXa/yhov4dh
         EsWw==
X-Gm-Message-State: AOAM530F1EDFNKWyaGlCu6xXBsX8lUkxRknB7uSKrcaQLAXDwdGURYg8
        HMD0Lb2XiV12LHzkuof6Thk=
X-Google-Smtp-Source: ABdhPJxIXYF0h9ZtqqkU+6Q4CJsvoP2Z4JA+Fa9GXp3ES7zq7Y/8cF9Kd7ny90KxbWgomirCYhyiTg==
X-Received: by 2002:a05:6512:709:: with SMTP id b9mr2747409lfs.188.1607073431912;
        Fri, 04 Dec 2020 01:17:11 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id w16sm1439195lfq.285.2020.12.04.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:17:11 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7Dk-0005KY-VZ; Fri, 04 Dec 2020 10:17:45 +0100
Date:   Fri, 4 Dec 2020 10:17:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 02/15] usb: serial: belkin_sa: use usb_control_msg_send()
Message-ID: <X8n+uO2nYzRcxaLk@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-3-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-3-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:50PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_send() nicely wraps usb_control_msg() with
> proper error check. Hence use the wrapper instead of calling
> usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/belkin_sa.c | 35 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
> index 9bb123ab9bc9..a5ff55f48303 100644
> --- a/drivers/usb/serial/belkin_sa.c
> +++ b/drivers/usb/serial/belkin_sa.c
> @@ -105,9 +105,10 @@ struct belkin_sa_private {
>  #define WDR_TIMEOUT 5000 /* default urb timeout */
>  
>  /* assumes that struct usb_serial *serial is available */
> -#define BSA_USB_CMD(c, v) usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0), \
> -					    (c), BELKIN_SA_SET_REQUEST_TYPE, \
> -					    (v), 0, NULL, 0, WDR_TIMEOUT)
> +#define BSA_USB_CMD(c, v) usb_control_msg_send(serial->dev, 0, (c), \
> +					       BELKIN_SA_SET_REQUEST_TYPE, \
> +					       (v), 0, NULL, 0, WDR_TIMEOUT, \
> +					       GFP_KERNEL)

Also here there's no data stage so there no point in using the new
helpers.

Please drop this one as well.

Johan
