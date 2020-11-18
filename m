Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7189E2B7D23
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKRL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgKRL7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:59:15 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81582225B;
        Wed, 18 Nov 2020 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605700753;
        bh=bpIaJCuL97BrXNCVsIpB3z8ri1lvvqCDzS5qRClP03I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrCzw2jfI/0p2MfdH8tnjlUIIxeNljgifiqyPVSPFRlivzdvssgQHJoDMwp5sm18A
         R42lLl1L6XSBw3/gGCA/Fl9EyPPHtG7r58+PVn9u/X7GoEMj+eInDS+ym3TXj2w/hi
         Faf5ygibf63uxxmvt2fGMCOZh39UWQfhkAu0ySLQ=
Date:   Wed, 18 Nov 2020 12:59:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 00/11] chrome/platform: cros_ec_typec: Register
 cables, partner altmodes and plug altmodes
Message-ID: <X7UMvw7wnMapkAk8@kroah.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:11:36PM -0800, Prashant Malani wrote:
> This patch series adds support for the following bits of functionality,
> parsing USB Type C Power Delivery information from the Chrome Embedded Controller
> and using the Type C connector class:
> - Register cable objects (including plug type).
> - Register "number of altmodes" attribute for partners.
> - Register altmodes and "number of altmodes" attribute for cable plugs.
> 
> The functionality was earlier part of multiple series ([1], [2], [3]), but
> I've combined it into 1 series and re-ordered the patches to hopefully make
> it easier to peruse. I've maintained the patch Acked-by/Reviewed-by tags where
> they were received.
> 
> Patches 1/11, 2/11, 3/11 introduce the changes needed in the USB subsystem (PD VDO
> header update, sysfs attribute additions) and hence the first three patches
> can go through Greg's tree.

I've taken the first 2 patches in my usb tree now, waiting for Heikki's
response on patch 3 before I touch that.

thanks,

greg k-h
