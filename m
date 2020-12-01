Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0697F2CA9D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392130AbgLARgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388186AbgLARgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:36:23 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0668C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:35:42 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id dm12so1215895qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fXCXRafZkadpk0T/XI7iRocLtgPNAqfe0eiccIiMAsY=;
        b=Cya/igb/I3zvXjCbhNpsZ5oYzHJqIUd7twy5zfEO8IXo/wy73MkvVduZ4JG6JGD3V1
         BfMTcCTHi61impNIqglzBJ+97Ywitt+fvShvVqEmjnynVjclts6PCkbzOGIwwORrmJI8
         sDGomt6c3bCkVQHqxoRPIjYj5rKeFszyUBUAKmT+dVgCo6/qvZdh4KiOMRUzrm9ZxxcM
         4NUVQMikacDyG0a6z24OiDtXnzPjWhGilONn/lZeaYYqvQZMVr9TvtR23NHIa5Yj00IQ
         gntZXwWjlUy4GjXLV7PufglKHCmo6O0ts2pmLCY6Xfwizxj/R/T6OHef7hZWVXL8SoBC
         KOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fXCXRafZkadpk0T/XI7iRocLtgPNAqfe0eiccIiMAsY=;
        b=V0hwvi9V27d/1Zn8a6HeIJSAudRIBHSnJSadc3C5xwVS1haV1+DOZXFu9BfvXjQ5lB
         fOgZpzBeiC24QS0O2mUtyW4A8q2XRRLZuE9hozjYGcvuM2bNaXhbHDrwPp+bxAlLflYw
         oLQooSYmjbXDo74jFM04P5ZJKDns/NIWNfUVBjtcrxWjUxqM3D5MCLes1zFkbTmhxH7I
         vysA4Zc0lzSYj1OPP3CFKFabxwNOSocGOnsy8E9bl1Dwwe/ezVJW8HNVaup5d4ZtT7WR
         GB/LdDRqeBVGpSvww5Y+jkerPENvqpSu5KDNMCeyPqXI6iGvjp3e1/auLoBYQm1zeecj
         +89w==
X-Gm-Message-State: AOAM5332wj88yFlKilhGEpgbxcQIcQcvWUrLPZqe3uKEyYICF0jfjviY
        S6sLHwtJLEzn6plIFFnOMjQKJ8Zx4fozUA==
X-Google-Smtp-Source: ABdhPJxUDofc/K2+SXpKMvUIfKLVNj9r153H9CUqc88ztNh3gmNKMuRErtKLudOEP2Ll2eeUYGW/ng==
X-Received: by 2002:a0c:fa83:: with SMTP id o3mr4431154qvn.30.1606844142209;
        Tue, 01 Dec 2020 09:35:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w31sm302561qth.60.2020.12.01.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 09:35:41 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kk9Yy-004VFE-Jg; Tue, 01 Dec 2020 13:35:40 -0400
Date:   Tue, 1 Dec 2020 13:35:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201201173540.GH5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201171420.GN1900232@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 06:14:20PM +0100, Miroslav Lichvar wrote:
> On Tue, Dec 01, 2020 at 12:12:24PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 01, 2020 at 03:38:35PM +0100, Miroslav Lichvar wrote:
> > > +	unsigned long time_set_nsec_fuzz;
> > > +	static unsigned int attempt;
> > 
> > Adding a static value instide a static inline should not be done
> 
> Well, grepping through the other header files in include/linux, this
> would not be the first case.

Nevertheless, it should be avoided and has surprising behaviors.
 
> > I'm not sure using a static like this is the best idea anyhow, if you
> > want something like this it should be per-rtc, not global
>
> If there are multiple RTCs, are they all updated in this 11-minute
> sync?

Yes, but they have different offsets and thus different timers,
IIRC. Though only one gets to be the CONFIG_RTC_SYSTOHC_DEVICE

If you are going to put some static it is clearer to put it along side
the sync_rtc_clock()

> I found no good explanation. It seems to depend on what system is
> doing, if it's idle, etc. I suspect it's a property of the workqueues
> that they cannot generally guarantee the jobs to run exactly on time.
> I tried switching to the non-power-efficient and high priority
> workqueues and it didn't seem to make a big difference.

When I wrote it originally the workqueues got increasingly inaccurate
the longer the duration, so it does a very short sleep to get back on
track.

If you are missing that time target it must be constantly scheduling
new delayed work and none of it hits the target for long, long time
periods? This seems like a more fundamental problem someplace else in
the kernel.

Jason
