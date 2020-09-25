Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5537F278758
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgIYMhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:37:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C309620715;
        Fri, 25 Sep 2020 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601037432;
        bh=e5cThzxwul5iDJF1kHr73SySZaVcdJG4ZS7hA63AKwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UufVGlD25hzWeLSI6oDvf8ffi6VOSTmN30K0xlNwZuI0HmcHxgDgRlu/DuBFXnYVH
         /95fL+v3U7/6SFMfzy6ddJ2zDmjk7YJcfprGAZQ08bLSOJTpNIeD/l//wDzIGqQ4ND
         0plx+1JF7cC3GgBkgSIKMq8uGm1nM6hS4YYVgICk=
Date:   Fri, 25 Sep 2020 14:37:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs second pull request for kernel 5.10-rc1
Message-ID: <20200925123715.GA2724650@kroah.com>
References: <20200925115447.GA2256@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925115447.GA2256@ogabbay-VM.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 02:54:47PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs second pull request for the merge window of kernel 5.10.
> It contains an important fix to our ASIC reset flow and a few other minor
> changes. Details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 9eb29f2ed95edda511ce28651b1d7cdef3614c12:
> 
>   Merge tag 'icc-5.10-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next (2020-09-24 15:15:11 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-09-25

Pulled and pushed out, thanks.

greg k-h
