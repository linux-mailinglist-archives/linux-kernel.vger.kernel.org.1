Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF971DCA58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgEUJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 05:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgEUJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:42:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E0820721;
        Thu, 21 May 2020 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590054169;
        bh=HLNBPlMIwcyPLxoXQ3ROr7zGCgI47fgKzS7fsLAAHnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAO8ol+vUu00FCzxprbBF8gkgEhqxuQb/PPWFKSvajF9lFxezKDlFTvKujh3Sq06J
         tltLMIywU2yZlJLJqAu5nz1nJR5GDyQt5j6gPilCVbsA7iRCJ6oErk9ZKJqJ/E+7+7
         DEHf5hm7RHianqFiuncmVk8tLeBE33e+nBV6EW0U=
Date:   Thu, 21 May 2020 11:42:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/4] driver core: Add device link related sysfs files
Message-ID: <20200521094247.GA2861894@kroah.com>
References: <20200520034824.79049-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520034824.79049-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 08:48:20PM -0700, Saravana Kannan wrote:
> With fw_devlink and with sync_state() callback features, there's a lot
> of device/device link related information that's not available in sysfs.
> 
> Exposing these details to user space can be very useful in understanding
> suspend/resume issues, runtime pm issues, probing issues, figuring out
> the modules that'd be needed for first stage init, etc. In fact, an
> earlier verion of this series was very helpful in debugging and
> validating the recent memory leak fix[1].
> 
> This series combines combines a bunch of patches I've sent before.
> 
> I'm aware that I haven't added documentation for patch 1/2. I'm waiting
> on review to make sure the file location, name and values don't change
> before I add the documentation.

You mean patch 2/4, right?

> This series is based on driver-core-next and [1] cherry-picked on top of
> it.

I've taken patch 1 now, as it was easy to review :)

I'll wait for the next series with the documentation update before going
further.

thanks,

greg k-h
