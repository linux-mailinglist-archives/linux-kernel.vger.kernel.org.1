Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA52ECC1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhAGJAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbhAGJAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:00:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E7462313B;
        Thu,  7 Jan 2021 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610009972;
        bh=EwIKCvsMKChhHcgTuEGb2I6wpIWvY8o7DoF8pXj3NTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cA+GBz+rlEYSgGiJl/tW4YzY0cOxd5EbvO0G/D+ARvchcc2rIBh+RMFWklH2kYZbA
         4F/wu4v7gB9uLTsFl98MPhrezf1i25ar4XUainY7rlzadhZ9fDdppemJa3FqtE4xqY
         SWtcCCtg8Z9mF56eXk/YAyvIQi6T/S+FtJg4KTMg=
Date:   Thu, 7 Jan 2021 10:00:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Fix device link device name collision
Message-ID: <X/bNxMPWKq2nbqS4@kroah.com>
References: <20210106232641.459081-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106232641.459081-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:26:41PM -0800, Saravana Kannan wrote:
> The device link device's name was of the form:
> <supplier-dev-name>--<consumer-dev-name>
> 
> This can cause name collision as reported here [1] as device names are
> not globally unique. Since device names have to be unique within the
> bus/class, add the bus/class name as a prefix to the device names used to
> construct the device link device name.
> 
> So the devuce link device's name will be of the form:
> <supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name><consumer-dev-name>

Minor nit, you forgot a ':' in the consumer side of the link here.  The
code is correct.

> 
> [1] - https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> 
> Michael,
> 
> Can you please test this? This should fix your issue.
> 
> Having said that, do you have some local DT changes when you are testing
> this? Because it's not obvious from the DT in upstream what dependency
> is even being derived from the firmware. I don't see any dependency in
> upstream DT files between mdio_bus/0000:00:00.1 and
> pci0000:00/0000:00:00.1

That looks really odd, why is the mdio bus using the same names as the
pci bus?

But anyway, your dev_bus_name() change here looks good, I'll take that
as a separate patch no matter what happens here :)

thanks,

greg k-h
