Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2280A27E842
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgI3MK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgI3MK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:10:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD85206B7;
        Wed, 30 Sep 2020 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467856;
        bh=6S8w3/dR+DtjyosgRVlanSKikC5vLhD5x2kP86xGkUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kfv/VbF9zL+Z4gjc+e+hvyi7k55/ly6vk+hQbcKgPff/MMp3fUsaEfZ46w8GNiKxB
         uxR3h/76ppj2h0zLh6NBfyczkFfFKSWPcq4xdOMG7Gc+KnJY5oAnHK0XAyuAUwFrUd
         WTrH4UxTlhIWOsubzuLwMU2Zn7SIVAhEfY9Zearo=
Date:   Wed, 30 Sep 2020 14:11:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rafael@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930121100.GA1616135@kroah.com>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
 <20200930115915.GB1611809@kroah.com>
 <20200930120849.GG4974@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930120849.GG4974@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:08:49PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 01:59:15PM +0200, Greg KH wrote:
> > On Fri, Sep 25, 2020 at 05:48:55PM +0100, Srinivas Kandagatla wrote:
> 
> > > +int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *regmap,
> > > +				 struct regmap_field **field,
> > > +				 struct reg_field *reg_field, int num_fields);
> > > +void devm_regmap_field_bulk_free(struct device *dev,
> > > +				 struct regmap_field *field);
> > > +
> > 
> > You only have a patch that uses these last two functions, so why add all
> > 4?  We don't add infrastructure to the kernel without users.
> 
> We have managed versions of the other regmap allocation functions, it
> makes sense for consistency to have managed versions of these too.  I
> think there's a meaningful difference between a simple and expected
> wrapper like these and infrastructure which hasn't been proved out by
> users.

Ok, do you think these are really needed?

A review would be nice :)

thanks,

greg k-h
