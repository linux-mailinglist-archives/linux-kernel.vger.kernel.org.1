Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A75286784
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgJGSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJGSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:40:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E3CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:40:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x22so1809802pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xXW7LOkGsdr16DDohWm1S0zfTBlg5Yr0tvbTwZjyTlk=;
        b=Z+pf3UsZNiwu7xHh5ZQ9hZ+01ELjMbt2ed1X/ipL8w/k7hNHtgncWNAVjKR3tsKPXK
         vCdHRxspE/9bKTjmH6JyrvJ8l0A2xMrHq8foZR3ST9oSHzIguMUC7dILekx/k47JGsQH
         Bqmly9MJM+mmsLUmVY58dWE/53egUiOhO/MQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xXW7LOkGsdr16DDohWm1S0zfTBlg5Yr0tvbTwZjyTlk=;
        b=dwnJxD9kbjxA6Uw9C4Z3SrWTrhzvfU7hrOURJL8Mtw3SbFD4+gSiohjI3JWrGLK7Ct
         vKyDyfyY//2PKWF/mEyYZp5lwc0wTYEbZFr+9zUkMShXZdLlqVC0/9npVHtcKtveTD6f
         W6H/Mz44vCiAEpKSxYOOfkT+e9i2Tshnd3g8YsFH+MqTA/s++fLzV6WDJQggncqQBBsL
         1odS8KrnpHAZMODQiynAMPb6fY0u56rMYwBh/tOgQV4zxCI5jRIw61PJqmCzh4rEYza8
         rwaYUNPqlzxsyBZnsJs9r24HmW65LpmbEbSGXIAGMUSM/A6uHXQJvzWdqC3dxE+hRXrb
         g8aQ==
X-Gm-Message-State: AOAM530W9444555sUUT2pE7SO4e2gy7+ayzb1GnbcNnpV2NRr2STqtO4
        bqNiqk/+aSc8hw1PHEvDkOOg9g==
X-Google-Smtp-Source: ABdhPJx/izEb8o0j/KKQex6oJFq4oBwmBu/eZG5unfLyOm1bgO2WRau8jJCJqiM22rH4iSy75gAgpg==
X-Received: by 2002:a17:90b:e87:: with SMTP id fv7mr3817625pjb.187.1602096038809;
        Wed, 07 Oct 2020 11:40:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r6sm3889904pfq.11.2020.10.07.11.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:40:37 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:40:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     WeiXiong Liao <gmpy.liaowx@gmail.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <202010071130.7EA00291@keescook>
References: <20201006155220.GA11668@lst.de>
 <202010070007.8FF59EC42@keescook>
 <20201007075537.GA12531@lst.de>
 <20201007083715.GA15695@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007083715.GA15695@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:37:15AM +0200, Christoph Hellwig wrote:
> Looking at this more:  in addition to the block code being totally
> broken, there is really no point in mtdpstore even using this code.
> It does nothing but minimal parameter validation to just pass it
> on to the pstore zone interface.  IMHO writing the mtd code directly
> to the zone interface makes a whole lot more sense even if we grow
> a non-broken block backend at some point.  Something like this:

I really don't like this, sorry. I'm using the pstore/blk bits myself
already, and I don't want that removed. Additionally I really don't want
the structures open-coded in the MTD driver. The whole point was to
encapsulate it. I've spent a lot of time clawing pstore back from the
brink of open-coded argument and member explosion. :)

I'm fine to drop the exported register_pstore_blk() API until someone
actually uses it, but I want to keep pstore/blk itself and the existing
separation between pstore backing devices and pstore storage logic so
that configuration happens at the storage level, not the backing device
level. My intent, for example, is to migrate ramoops to pstore/zone,
etc, and remove all the ramoops-specific configuration which is common
to pstore/zone.

-- 
Kees Cook
