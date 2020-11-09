Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC32AB376
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgKIJWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:22:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:46834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbgKIJWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:22:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604913744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LbvQ6EGRcjc+nWt0Yl43V5fnXQ1+qx1LE+fiYxqpRo=;
        b=Vz0Quq7qpPRoVcynQQslyihvuJgkS6c4ZNbpycKoARnm0YxeYKLVRzRkrgsXJEECMUS13D
        pS4aez44X7rYd1xY+8bq3Iezvnbf7KC9T1JeNGzzZ+DFvyBlzYYml80dE1w+9jO2XhjR2S
        e5sdk5MhJv8EkZqs1CB5IpLdkiWslic=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F26A5AC1F;
        Mon,  9 Nov 2020 09:22:23 +0000 (UTC)
Message-ID: <574f338f6f0b81fe1e4109f74c6dfcb45aca0d53.camel@suse.com>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
From:   Oliver Neukum <oneukum@suse.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Date:   Mon, 09 Nov 2020 10:22:16 +0100
In-Reply-To: <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
References: <20201102211450.5722-1-dave@stgolabs.net>
         <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
         <20201104110657.GW4085@localhost> <20201104162534.GY4085@localhost>
         <20201105001307.lelve65nif344cfs@linux-p48b.lan>
         <20201105082540.GA4085@localhost>
         <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 05.11.2020, 22:17 -0800 schrieb Davidlohr Bueso:
> @@ -1888,16 +1732,8 @@ static void mos7720_release(struct usb_serial *serial)
>                 usb_set_serial_data(serial, NULL);
>                 mos_parport->serial = NULL;
> 
> -               /* if tasklet currently scheduled, wait for it to complete */
> -               tasklet_kill(&mos_parport->urb_tasklet);
> -
> -               /* unlink any urbs sent by the tasklet  */
> -               spin_lock_irqsave(&mos_parport->listlock, flags);
> -               list_for_each_entry(urbtrack,
> -                                   &mos_parport->active_urbs,
> -                                   urblist_entry)
> -                       usb_unlink_urb(urbtrack->urb);
> -               spin_unlock_irqrestore(&mos_parport->listlock, flags);
> +               /* if work is currently scheduled, wait for it to complete */
> +               cancel_work_sync(&mos_parport->work);
>                 parport_del_port(mos_parport->pp);
> 
>                 kref_put(&mos_parport->ref_count, destroy_mos_parport);

Hi,

do you really want to cancel as opposed to wait for work in release()?

	Regards
		Oliver


