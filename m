Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98792B6A00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgKQQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:28:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38418 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgKQQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:28:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id r17so24964172ljg.5;
        Tue, 17 Nov 2020 08:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JjQd+tw3c5x0K9ttbX2Yz1ZaogjJI7xLMTz04fJy+b0=;
        b=JZZUS+kDf95siM6ldFfLoo8aoMasmynyITOQlEYouVrMI8cLQA8FxFafPZDdltszMX
         Ml65pwDyOqdyJk/o4ULcv8mXVg/GYmUfQdE0YuPmnbawjPy+GIkfi8k1NunlRn58SfUA
         H5TFNv3cGahMrrEotJc9oEQdyicaY2gXif2k0iu96fY4WyqcrpsuWIokq+galFNAs/VS
         90SKBDncWhlX8DvmBjiZyj54s7EG0O/VmTk9BwRVms5y25zjZifn+j5xwXaWdSQ87eMH
         5J3ADYtTRwAxXImKAR4g5fVLZ6gCQQyw6USKhJmzIPXM4EzRrdwIzt9DdHRI40Tbdppx
         f9pg==
X-Gm-Message-State: AOAM532FQODvQRvx8Ywqi2GG8z3rCgGCDeio6yR3xFbF+hZyUO0VWZvG
        I4Hu6ksm+ftzcMVsyNl847aaZ+WeV6tj5w==
X-Google-Smtp-Source: ABdhPJyFoWuvXpRj42Hi89TfIM5ae+V1n4xj3v6bwEN9q+sJWskrjbJCs5CDQ+cYJXqZ6axKNywE3Q==
X-Received: by 2002:a2e:91d6:: with SMTP id u22mr2169639ljg.206.1605630525941;
        Tue, 17 Nov 2020 08:28:45 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 131sm3195289lfb.248.2020.11.17.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:28:44 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kf3qZ-0003F8-VI; Tue, 17 Nov 2020 17:28:48 +0100
Date:   Tue, 17 Nov 2020 17:28:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] USB: serial: mos7720: defer state restore to a workqueue
Message-ID: <X7P6P018BQSypuP6@localhost>
References: <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
 <20201105082540.GA4085@localhost>
 <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
 <20201113091443.GI4085@localhost>
 <20201114042725.ofs7zbzmxg32tbbi@linux-p48b.lan>
 <X7KyPrY8FDH4C/gm@localhost>
 <20201116223102.eliwt7uh5rkiiq5h@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116223102.eliwt7uh5rkiiq5h@linux-p48b.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 02:31:02PM -0800, Davidlohr Bueso wrote:
> On Mon, 16 Nov 2020, Johan Hovold wrote:
> 
> >On Fri, Nov 13, 2020 at 08:27:25PM -0800, Davidlohr Bueso wrote:
> >> @@ -1883,21 +1724,17 @@ static void mos7720_release(struct usb_serial *serial)
> >>		if (mos_parport->msg_pending)
> >>			wait_for_completion_timeout(&mos_parport->syncmsg_compl,
> >>					    msecs_to_jiffies(MOS_WDR_TIMEOUT));
> >> +		/*
> >> +		 * If delayed work is currently scheduled, wait for it to
> >> +		 * complete. This also implies barriers that ensure the
> >> +		 * below serial clearing is not hoisted above the ->work.
> >> +		 */
> >> +		cancel_work_sync(&mos_parport->work);
> >
> >As I mentioned, this needs to be done *after* deregistering the port or
> >you could theoretically end up with the work item being requeued.
> 
> Hmm sorry yes I forgot to mention this. I was counting on the private_data
> already being null to prevent any new work being actually scheduled, so an
> incoming restore state, for example, would be a nop.

Ah, yes, you're right. 

> >Yes, the same applies for the "synchronous" requests, but that's a
> >preexisting issue.
> 
> Per the above I also assumed sync requests were also safe as is.

Indeed.

> But I can certainly re-order things, how about:

No, that's ok, no need to change this as part of this clean up.

Can you just fix up that irq comment, and I'll apply this? Thanks.

Johan
