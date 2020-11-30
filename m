Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245862C8C61
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgK3SOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgK3SOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:14:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159C8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:13:54 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7so266394pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BlVeiNa/yTJoKE7RHYhXMT0gAubYFxdxrpInP7YeRnI=;
        b=Yo34sV490HVWzsN0G7UHQT9eRIBWQTPG4p/3D3xU8G81YbQ55EWA6OcMXdLmM/HpEc
         O6ZR0AHSp9aDCgOZPnOtvgHHjd3C1UjBaaL8Yc8mb4vljvVekAhdu+Z0WZfzISix9+SC
         4F0sP4HYVX9NfmZLMRBR4dKta68cchumA/seEBAZargbyrCEvdgNLkcZX6PGPtah3upi
         0b62PyRbDPqpFwriS9as0q5PhmxqGBYi48Xn2uK8XaIMKG4muc1aCwo4YCYcVo5EyGig
         PtEPiAWgFPWryi7qAag4B0+z0/WIs1mczyt3R6N13MLlmotR/vEU9nWrGM/a90rwoVq1
         1q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BlVeiNa/yTJoKE7RHYhXMT0gAubYFxdxrpInP7YeRnI=;
        b=Qn+5ZZaIKmsDNaD1szY3YJ+54eOZqocZaTH6QaSbuA4QHHTJieZMmRiMmboI309NTg
         Z0cyRajdVUERXpAYrAmxagoZFAxtiphcIXoUbgKwn58nimf0CSGW1oMnlg4eXa8BVYda
         KDZtN7dwAJ6BaqDbB3+2DHa60fyb3ZPowLiGtgknoMQBR/mB2ewVqKS1MRbchBOL29Ja
         82lbxkuByLEEGQwKSGNRJUWYW4rGbP4Ne0uOFgc6oA88V47bG59sZqHyesZO0ylFLWmS
         dMw05he7xSiq7dkTrMCM++fpWik5gmkOWg6Gblnc9uffnmLJO6+cgObXQJugfcahoNwB
         1wPA==
X-Gm-Message-State: AOAM533HMx1J0M75pU14lcFfelj60DHRiUuWNxGHbxQRapgbIAOIwCBV
        SFagT1VS7aWnYHER3OS1RY2FZg==
X-Google-Smtp-Source: ABdhPJysm1IilmpgXIdB4OQLJCeb9JCWhGHEdo/bWZz7xfh1vuqBfMFN65WV1PePC3XQ/LY9CxNVtw==
X-Received: by 2002:a17:90a:af88:: with SMTP id w8mr66105pjq.152.1606760033430;
        Mon, 30 Nov 2020 10:13:53 -0800 (PST)
Received: from google.com (h208-100-161-3.bendor.broadband.dynamic.tds.net. [208.100.161.3])
        by smtp.gmail.com with ESMTPSA id x23sm16507894pfo.209.2020.11.30.10.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:13:52 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:13:50 -0800
From:   William Mcvicker <willmcvicker@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "J. Avila" <elavila@google.com>, mingo@redhat.com,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Daniel Mentz <danielmentz@google.com>
Subject: Re: Potential Issue in Tracing Ring Buffer
Message-ID: <20201130181350.GA1116146@google.com>
References: <20201124223917.795844-1-elavila@google.com>
 <X79CrSX1rnpnbqPd@kroah.com>
 <20201126132613.7f737afe@oasis.local.home>
 <20201130094846.6b8bc60b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130094846.6b8bc60b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:48:46AM -0500, Steven Rostedt wrote:
> On Thu, 26 Nov 2020 13:26:13 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 26 Nov 2020 06:52:45 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Tue, Nov 24, 2020 at 10:39:17PM +0000, J. Avila wrote:  
> > > > Hello,
> > > > 
> > > > In the ftrace logs we've collected internally, we have found that there are
> > > > situations where time seems to go backwards; this breaks userspace tools which
> > > > expect time to always go forward in these logs. For example, in this snippet
> > > > from a db845c running a 5.10-rc4 kernel[1] (thanks for getting us the trace,
> > > > John!), we see:    
> > > 
> > > Does the patch at:
> > > 	https://lore.kernel.org/r/20201125225654.1618966-1-minchan@kernel.org
> > > 
> > > resolve this issue for you?
> > >   
> > 
> > I think I found the bug. Can you apply this patch and let me know if it
> > fixes the issue for you?
> > 
> > -- Steve
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index dc83b3fa9fe7..bccaf88d3706 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3291,7 +3291,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
> >  			/* Nothing came after this event between C and E */
> >  			info->delta = ts - info->after;
> >  			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
> > -					      info->after, info->ts);
> > +					      info->after, ts);
> >  			info->ts = ts;
> >  		} else {
> >  			/*
> > 
> 
> Can I get a Tested-by from someone on the Google team, so that I can send
> this upstream? It already passed all my internal testing, but I want to
> make sure this is the fix for the issue I reference in the change log.
> 
> -- Steve
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
Hi Steve,

Thanks for the quick turnaround! Daniel and I have both tested your patch and
verified it's working on our end. Feel free to include:

Tested-by: Daniel Mentz <danielmentz@google.com>
Tested-by: Will McVicker <willmcvicker@google.com>

--Will
