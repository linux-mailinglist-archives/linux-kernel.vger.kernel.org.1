Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0922EE688
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAGUE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbhAGUE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:04:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 911B6233F6;
        Thu,  7 Jan 2021 20:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610049859;
        bh=k6MeESPQHWsaUNptevG0GHmDrUuFq1OLKqaK3nKkK1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsQhkf7O7aIZveSUDVWOWn9yNcOdvQ7H2H6ltc0N7bBZBe5oHaFQlkg1LwkSFgWZc
         jai74Fsb6x22q5tvTK9EdQQmXy8Oa2KrfAP+PHeWzQeEs3W3u5sbIH2M5noEJ2fu02
         hMrzE4nNdTiOmNhNjZPpl9uEAUGJ4weYa5deC8HE=
Date:   Thu, 7 Jan 2021 21:05:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
Message-ID: <X/dpkgTnUk+inKHK@kroah.com>
References: <20201218031703.3053753-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 07:16:58PM -0800, Saravana Kannan wrote:
> As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
> be broken using logic was one of the last remaining reasons
> fw_devlink=on couldn't be set by default.
> 
> This series changes fw_devlink so that when a cyclic dependency is found
> in firmware, the links between those devices fallback to permissive mode
> behavior. This way, the rest of the system still benefits from
> fw_devlink, but the ambiguous cases fallback to permissive mode.
> 
> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> only for systems with device tree firmware):
> * Significantly cuts down deferred probes.
> * Device probe is effectively attempted in graph order.
> * Makes it much easier to load drivers as modules without having to
>   worry about functional dependencies between modules (depmod is still
>   needed for symbol dependencies).
> 
> Greg/Rafael,
> 
> Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
> see some issues due to device drivers that aren't following best
> practices (they don't expose the device to driver core). Want to
> identify those early on and try to have them fixed before 5.11 release.
> See [1] for an example of such a case.

Now queued up in my tree, will show up in linux-next in a few days,
let's see what breaks!  :)

And it is scheduled for 5.12-rc1, not 5.11, sorry.

thanks,

greg k-h
