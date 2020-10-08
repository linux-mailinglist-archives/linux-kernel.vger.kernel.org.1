Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2110286FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgJHHpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgJHHpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:45:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9A02184D;
        Thu,  8 Oct 2020 07:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602143116;
        bh=Cht0AAlXCeqIAyO4xP3T6BPPZYtciZXHc+YFx0n8WOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmjRIAUMIbprCKDN16qg6QaLwl/mO/PO7bjszExYHGwtlHqYqTYrRSmDShDARFHqG
         DS3QtwSKpXbR2ip8bgE1yv4UVQa3d5qYNYgvdzNkv0xftq6AORoj8GYXrzIs8tKqI1
         7Pi41pzPk0jAs6j/xw7QhnHtfwICvzIVTAFvafn0=
Date:   Thu, 8 Oct 2020 09:46:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v10 00/15] TCPM support for FRS and AutoDischarge
 Disconnect
Message-ID: <20201008074600.GA247486@kroah.com>
References: <20201008061556.1402293-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:15:41PM -0700, Badhri Jagan Sridharan wrote:
> Hi,
> 
> Made two changes:
> 
> 1. Added "additionalProperties: false" as suggested by Rob Herring in
> https://lore.kernel.org/linux-usb/20201005144618.GA154206@bogus/
> 
> 2. Removed FRS dts binding constants to address Rob Herring's comment in
> https://lore.kernel.org/linux-usb/20201006182940.GA2574941@bogus/

That worked better.  I've applied the patches that Heikki had reviewed
to my usb-testing branch now.

thanks,

greg k-h
