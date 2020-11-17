Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9163F2B5982
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 07:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKQGAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 01:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKQGAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:00:23 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CFBA2463D;
        Tue, 17 Nov 2020 06:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605592822;
        bh=kMZHHDjUySEDPq//3kNlI7T93WIhbBIN2atyzZGyvCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zysQwQBimXuItd8u21k5FOxtsiJdZS6mXAmejoNwT5Wt2xa9l2WtL58E1moVM+7so
         wnxOxR0fjfe4YQggrNyjidRkxuavJ4clgCEY7YfqcAa2KGkOVafalFgMeyc8UHV5SQ
         iIG0oqnfs0rehyB6cesSVFlFL4LiEyWUDvI6NBnM=
Date:   Tue, 17 Nov 2020 07:01:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emmanouil Perselis <perselis.e@gmail.com>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org, vaibhav.sr@gmail.com,
        linux-kernel@vger.kernel.org, johan@kernel.org,
        mgreer@animalcreek.com, greybus-dev@lists.linaro.org
Subject: Re: [PATCH] Fix warning for static const char * array in
 audio_manager_module.c
Message-ID: <X7NnJqKKvK1JfEHG@kroah.com>
References: <66314332-e66d-9b34-52f9-ae005df2be15@ieee.org>
 <20201116204322.2122-1-perselis.e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116204322.2122-1-perselis.e@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 09:43:23PM +0100, Emmanouil Perselis wrote:
> On 11/15/20 9:17 AM, Greg Kroah-Hartman wrote:
> > On Sun, Nov 15, 2020 at 03:53:16PM +0100, Emmanouil Perselis wrote:
> >> This patch fixes the warning "static const char * array should
> >> probably be static const char * const" in
> >> drivers/staging/greybus/audio_manager_module.c
> 
> >> I think Greg's patch bot is telling you that you need
> >> to carbon-copy the mailing list on your patch submission,
> >> not just address it to the maintainers.
> 
> Added addresses to carbon copy.

Do you think this is the correct way to submit a patch that doesn't have
to be hand-edited in order to apply it?

Please make it match other submitted patches, but most importantly,
actually test-build your changes to ensure that they are correct.

thanks,

greg k-h
