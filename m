Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB69F27E886
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgI3M1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbgI3M1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:27:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3912071E;
        Wed, 30 Sep 2020 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601468835;
        bh=ze7XtQIWV0+tf75Dx8DzOueUECeACm+2itAr1txzyZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GJgoQAKa2drG9T/F0LXfBsgp+bvg+znegj47U/Nx01PqgdkozUG9l3at9oHDQQ7W
         GDtm7c6za2x1hZyaGwvu9sUa1k+hr+s+blP9cX9aNLMWy1t736sGKn0orurfbrWNgE
         Kwz8Yo/fZKfT+zXjb0BOh9SRpJu0m8rwchXsvBFU=
Date:   Wed, 30 Sep 2020 14:27:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rafael@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930122719.GA1618571@kroah.com>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
 <20200930115915.GB1611809@kroah.com>
 <20200930120849.GG4974@sirena.org.uk>
 <20200930121100.GA1616135@kroah.com>
 <20200930121552.GH4974@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930121552.GH4974@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:15:52PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 02:11:00PM +0200, Greg KH wrote:
> > On Wed, Sep 30, 2020 at 01:08:49PM +0100, Mark Brown wrote:
> 
> > > We have managed versions of the other regmap allocation functions, it
> > > makes sense for consistency to have managed versions of these too.  I
> > > think there's a meaningful difference between a simple and expected
> > > wrapper like these and infrastructure which hasn't been proved out by
> > > users.
> 
> > Ok, do you think these are really needed?
> 
> > A review would be nice :)
> 
> I applied this patch the other day - ea470b82f205fc in -next.

Great, sorry for the noise.

greg k-h
