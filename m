Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFA2957ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507964AbgJVFas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502837AbgJVFar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:30:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D12B2225F;
        Thu, 22 Oct 2020 05:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603344647;
        bh=amW+6lfXyJyw/9oZKO0tKC5WhhdatUs4PbaGnFParYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnPZmf7Ijg0hWomz8qw67H/lZVlzYrn1aBPlSxcrldNjuJeM/yFOxL3l9xC8spcYY
         k1LzudJJFzeqBRtwsSu8hnShRbnKCKENpNHaqPUOGP5fExVrQuLj6wiFPLZSIRqB+W
         JWR3y+mT5zPRI+3Xw678EaeMtLXbYeWLixYL0miE=
Date:   Thu, 22 Oct 2020 07:30:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201022053041.GA6523@kroah.com>
References: <20201021211802.774854-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021211802.774854-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:18:02PM -0700, Prashant Malani wrote:
> A PD-capable device can return up to 3 Product Type VDOs as part of its
> DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
> 6.4.4.3.1). Add a sysfs attribute to expose these to userspace.

You forgot to add the proper Documentation/ABI/ file at the same time,
which makes this patch impossible to review properly and able to be
applied :(

Please fix.

thanks,

greg k-h
