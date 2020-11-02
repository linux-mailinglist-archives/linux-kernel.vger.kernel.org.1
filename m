Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194DA2A3761
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgKBX62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgKBX61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:58:27 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04ECC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 15:58:27 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id c25so3789147ooe.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 15:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sxJe+3z06Di6CVsGeFvUBp5UqAuXz7uQn61OkTGFrlM=;
        b=T7vpCAOkiVFKhKnPw+LMZNkU0YM0ieglut5Uo7zd7fWte6lLpPCqY9BmuCGgHbgOnm
         B8FQgjniFsP/NjWU5tkoyc86r66Po46QpHiLsRGWAuG5MFMUcrgV9oc2yimuzhz73ZQT
         I+gShJ84eavvtAoRN6o22a5Ky3fw4QIofontIYOrRWGjLImaNmaUqkaNRprkSSn+iQdG
         OSFnsKpsZsKKyPVHEgwklITVKLfrPp89zHMCXCp6Le/9p5IK98C0cKLUImSn71IsrQSH
         4nulstt1CPqfyI7vaPLIW7eitJISh1ENj+D5+IxooXj05ZmhTf8BAMpkLEAGJ/06Xdla
         zBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxJe+3z06Di6CVsGeFvUBp5UqAuXz7uQn61OkTGFrlM=;
        b=mXgtsL2GnVCUmnwHhwvQl03gnrX+nhRKia6GYBYKrevN7Vg4dNv4Vb7dYnHRqywpci
         tZRZzXgodIjYjcx/2uhm7HHkkDy7qWtkNKY2IOdjMST/FEoPbrS8TdjksVLUNbx8iRHf
         3UWpajl49Uenm66+ic8R0Vxev/HvDH5xAIxn9kwe9D0hnSZhWUDYq3Wb0rO8W2ltodB/
         rVjOREa+e6VmOeFjXtix6WWrt4pK3McKj8Q7XKoC6rOcoAOmpU1w6AufzNdVzSfqLk6T
         +dIIQrOk+yythsbjy3ijdpsbcUTv1Vw9R7AQeyHcFZb3F5e8qkYgPB2qr2y6qoFqnXkL
         douA==
X-Gm-Message-State: AOAM53366POqXwW5Kw7vP8vQqtpVo5RS4yCGDDWB29+xP35gw316AbDg
        gm/9ZFuzOEE18seBVRK9CrzYqw==
X-Google-Smtp-Source: ABdhPJyBAbhusE/blt380mqgPMNqmbDxqYGfgKj9mPsr6sAr0Or8zvEBA22gY8Bp4XXEPqHBp1pI2A==
X-Received: by 2002:a4a:1e43:: with SMTP id 64mr13674813ooq.57.1604361507125;
        Mon, 02 Nov 2020 15:58:27 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 85sm2674531oie.30.2020.11.02.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:58:26 -0800 (PST)
Date:   Mon, 2 Nov 2020 17:58:24 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v2 1/2] hwspinlock: sprd: fixed warning of unused
 variable 'sprd_hwspinlock_of_match'
Message-ID: <20201102235824.GB223412@builder.lan>
References: <20201030034654.15775-1-zhang.lyra@gmail.com>
 <20201030034654.15775-2-zhang.lyra@gmail.com>
 <CADBw62oQj+K_-nyoZyMJSQ6VaqcNHbX9gbyLEzV9+Od1cVmC5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62oQj+K_-nyoZyMJSQ6VaqcNHbX9gbyLEzV9+Od1cVmC5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Nov 17:34 CST 2020, Baolin Wang wrote:

> On Friday, October 30, 2020, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > The macro function of_match_ptr() is NULL if CONFIG_OF is not set, then
> > Clang compiler would complain the of_device_id variable is unused.
> >
> > But using of_match_ptr() is space saving, for this case, the unused
> structure
> > 'sprd_hwspinlock_of_match' would be not built into symbol table if
> CONFIG_OF
> > is not set, probably depends on the compiler though.
> >
> > So adding __maybe_unsed seems a good approach to fix this warning.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: d8c8bbbb1aba ("hwspinlock: sprd: Add hardware spinlock driver")
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> 
> I'd like to remove this wrapper, and just depend on the CONFIG_OF. But I
> have no objection for this patch.  So
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
> 

As noted on the first line of the probe function, this driver isn't
going to do anything when CONFIG_OF is disabled - and I don't think we
should worry too much about space savings during COMPILE_TEST.

So I would prefer that we simply drop the of_match_ptr()

But I believe that's what you're saying as well Baolin?

Regards,
Bjorn

> 
> >  drivers/hwspinlock/sprd_hwspinlock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwspinlock/sprd_hwspinlock.c
> b/drivers/hwspinlock/sprd_hwspinlock.c
> > index 36dc8038bbb4..4c63e2546064 100644
> > --- a/drivers/hwspinlock/sprd_hwspinlock.c
> > +++ b/drivers/hwspinlock/sprd_hwspinlock.c
> > @@ -138,7 +138,7 @@ static int sprd_hwspinlock_probe(struct
> platform_device *pdev)
> >                                          SPRD_HWLOCKS_NUM);
> >  }
> >
> > -static const struct of_device_id sprd_hwspinlock_of_match[] = {
> > +static const __maybe_unused struct of_device_id
> sprd_hwspinlock_of_match[] = {
> >         { .compatible = "sprd,hwspinlock-r3p0", },
> >         { /* sentinel */ }
> >  };
> > --
> > 2.20.1
> >
> >
> 
> -- 
> Baolin Wang
