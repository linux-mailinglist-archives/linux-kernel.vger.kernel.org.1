Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728912A6983
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgKDQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:25:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42382 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbgKDQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:25:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id k25so23620545lji.9;
        Wed, 04 Nov 2020 08:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+EfB2mazLpddNSx/VccGpBQ8330DnzhkPloukMDftA=;
        b=EnfM0I7l1tam6OZZBVPC4yPt4xzDACrAb+6CaN/hHMW02Y1kOoGZafJlF8nuZH1Svs
         +h+Vpit8CUBnROfsjQaJxbVfUgY5scx527dqP4FTu7s6BACd1gynjLpMeG9uHGBkpoAE
         7NslVAIGwT90XrsIOJnhLsdF95TtXYAo/X5BeScnrWxPd46Pvdcbh2DNbn02FkcF0s6w
         WV4D7eAVzse9jsa8EGRBdjjuLh+B6105yuCRKpeQWuDLrYkxKMMoY3Bhhw1w1v1pSqrb
         /l8I5oVGM2E27mLV88xCpsSG1PRmHvJApD9phBfJYCLYPdUrKbiAgOsgyxY/28ceUvSP
         b2lA==
X-Gm-Message-State: AOAM532we39Msk2ZzEQjwq7nUgPU6u2EViY7rcNzW60Ar3uqSoKAj2R+
        VMh/4nxXaDPQ0PfEY2tYgzQ=
X-Google-Smtp-Source: ABdhPJyHgvazJ1QqFkibNTyi+hqHRVORG+WigB/uulHqAw36xP07c3dRyY64Mpv/gesAp7PIoqhNjA==
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr10551517lji.326.1604507131728;
        Wed, 04 Nov 2020 08:25:31 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u1sm18084lfk.130.2020.11.04.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:25:30 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kaLbK-00050y-Vo; Wed, 04 Nov 2020 17:25:35 +0100
Date:   Wed, 4 Nov 2020 17:25:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Message-ID: <20201104162534.GY4085@localhost>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104110657.GW4085@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:06:57PM +0100, Johan Hovold wrote:
> On Tue, Nov 03, 2020 at 12:40:14PM -0800, Davidlohr Bueso wrote:
> > On Mon, 02 Nov 2020, Bueso wrote:
> > 
> > >There is
> > >also no need anymore for atomic allocations.
> > 
> > Bleh this is a brain fart - obviously not true as usb_submit_urb() is
> > called under mos_parport->listlock. I'll send a v2 unless you have
> > any objections.
> 
> The conversion looks good to me otherwise; it's not making this parport
> mess any worse than it already is...

Hmm. I took at closer look at the parport code and it seems the current
implementation is already racy but that removing the tasklet is going to
widen that that window.

Those register writes in restore() should be submitted before any
later requests. Perhaps setting a flag and flushing the work in
parport_prologue() could work?

On the other hand, the restore() implementation looks broken in that it
doesn't actually restore the provided state. I'll go fix that up.

Johan
