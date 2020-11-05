Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B322A792A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgKEIZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:25:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41060 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:25:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id p15so636520ljj.8;
        Thu, 05 Nov 2020 00:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ain3gng+tyhVNHLNuknbnfu4ui30IIf5sYIECi8yy8k=;
        b=l+iag1Dn6afPJEZP0foFnX4mR45OhmUmETKb7gRPtw2r32GoBO4+vm522UIVjZHuVo
         e44s8yEWQY4m/Wb9qxj10XBH8kJAQoxjILmnGJtIe9S3oT3qco4P8s/Z/Qk4P8EbFE79
         hI/EAn9ICLBzhvCaGq9XZkLCPGEKw9WFTMhWLOj76KBON4tkqTqZQfmBz5eE+/bqWZoB
         grscl+1HTGEM1fYgyWk0nQXmCrGejkE2TPeCdAwSoEclvptg6PT7vMfUib9I7uidKumN
         GU/p9/aei8Ycq0sEqAgJ5f7kIz8mWf4kvjafkdSUL18ncByLoCtDuVsAF6pKju6c0AFB
         dOGw==
X-Gm-Message-State: AOAM5336nDUvFgULRx/orXSyAmFsa082bHDvqj9WXuaYwrPQsfYJGget
        4Qg6uHCLJEdnsuuRfMu3uNQ=
X-Google-Smtp-Source: ABdhPJwWQ+e6VFM217MSlVWkWBDWax6l3MPGXynbC0p4Iv0KA9VQCiTnv9HtDKAeK9MQy/vBFLe2gw==
X-Received: by 2002:a2e:b532:: with SMTP id z18mr477696ljm.449.1604564736916;
        Thu, 05 Nov 2020 00:25:36 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id g20sm83194ljn.134.2020.11.05.00.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:25:36 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kaaaS-0001pB-BO; Thu, 05 Nov 2020 09:25:41 +0100
Date:   Thu, 5 Nov 2020 09:25:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Message-ID: <20201105082540.GA4085@localhost>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105001307.lelve65nif344cfs@linux-p48b.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:13:07PM -0800, Davidlohr Bueso wrote:
> On Wed, 04 Nov 2020, Johan Hovold wrote:
> 
> >Hmm. I took at closer look at the parport code and it seems the current
> >implementation is already racy but that removing the tasklet is going to
> >widen that that window.
> >
> >Those register writes in restore() should be submitted before any
> >later requests. Perhaps setting a flag and flushing the work in
> >parport_prologue() could work?
> 
> Ah, I see and agree. Considering work is only deferred from restore_state()
> I don't even think we need a flag, no? We can let parport_prologue()
> just flush_work() unconditionally (right before taking the disc_mutex)
> which for the most part will be idle anyway. The flush_work() also becomes
> saner now that we'll stop rescheduling work in send_deferred_urbs().

A flag isn't strictly needed, no, but it could be used to avoid some of
the flush_work() overhead for every parport callback. The restore-state
work will typically only be queued once.
 
> Also, but not strictly related to this. What do you think of deferring all
> work in write_parport_reg_nonblock() unconditionally? I'd like to avoid
> that mutex_trylock() because eventually I'll be re-adding a warn in the
> locking code, but that would also simplify the code done here in the
> nonblocking irq write. I'm not at all familiar with parport, but I would
> think that restore_state context would not care.

Sounds good to me. As long as the state is restored before submitting
further requests we should be fine. That would even allow getting rid of
write_parport_reg_nonblock() as you can restore the state using
synchronous calls from the worker thread. Should simplify things quite a
bit.

> >On the other hand, the restore() implementation looks broken in that it
> >doesn't actually restore the provided state. I'll go fix that up.
> 
> How did this thing ever work?

The shadow registers are initialised at probe so as long as you don't
switch to a different parallel-port driver without disconnecting the
mos7715 in between it works.

Johan
