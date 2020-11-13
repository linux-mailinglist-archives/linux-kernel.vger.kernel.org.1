Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEEE2B1B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKMMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:30:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKMMai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:30:38 -0500
Date:   Fri, 13 Nov 2020 13:30:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605270637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTyqBE8w68dfH2s29/tUz+ABFEp9VGyC9iDay3rfrG0=;
        b=fMtG4XYOZyBfU8DRFep6yY/kNxfgyCyUMXjNezCrjBuh4ZYfQLPHw51SDsT9az80v1Bt3k
        ymkRIV4GLEJoDWARNZy89KnOXgh9l8wwZFHWtAD7BpyJpSkAEzzdeQ46BF+2614Um63npd
        niFZYZhks9P1WmDGA+8oS64TcPC1maj+uyQ5LdIauSdyPQ3GTZP7XL+bIqTkILlnrnycVd
        NNW+uB3LcpDmT+5/tsgDKCuODJSNjNr/uYhExdAplTtw5PyK8x7gfH77dr9jxYEWY6vCbn
        QP7L7oL1W/tk1bYRV0tdKV57oR4NfiGpT5kiTnT+YZD3D5zLOf9AnqvM7PYdmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605270637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTyqBE8w68dfH2s29/tUz+ABFEp9VGyC9iDay3rfrG0=;
        b=9Fyu2VKROYAcnlHVan81eIm5akk1sGvlPJTLans35Haf9DxCqJLavAkD1Mh3hv7LZfuv1b
        xzpYTFzwinsBxDAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        tglx@linutronix.de
Subject: Re: [PATCH v4] kcov, usb: only collect coverage from
 __usb_hcd_giveback_urb in softirq
Message-ID: <20201113123035.tjllvijjzd54npsf@linutronix.de>
References: <f3a7a153f0719cb53ec385b16e912798bd3e4cf9.1602856358.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3a7a153f0719cb53ec385b16e912798bd3e4cf9.1602856358.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-16 15:57:45 [+0200], Andrey Konovalov wrote:
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1646,9 +1646,16 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>  
>  	/* pass ownership to the completion handler */
>  	urb->status = status;
> -	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
> +	/*
> +	 * This function can be called in task context inside another remote
> +	 * coverage collection section, but KCOV doesn't support that kind of
> +	 * recursion yet. Only collect coverage in softirq context for now.
> +	 */
> +	if (in_serving_softirq())

Could this in_serving_softirq() usage be replaced, please?  

> +		kcov_remote_start_usb((u64)urb->dev->bus->busnum);
>  	urb->complete(urb);
> -	kcov_remote_stop();
> +	if (in_serving_softirq())
> +		kcov_remote_stop();
>  
>  	usb_anchor_resume_wakeups(anchor);
>  	atomic_dec(&urb->use_count);

Sebastian
