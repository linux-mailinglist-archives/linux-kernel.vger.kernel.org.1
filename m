Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074182A949B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKFKow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFKov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:44:51 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2671720702;
        Fri,  6 Nov 2020 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604659489;
        bh=ougvJFEDJnn7GLjb5Wkwg0aE2d1u72Yu7Du/d+yLTRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XB76eSCDBGX+2Tn28LKNoYpLWsv+KlUQgiXx3ngs0/THLwx772RPL53GyLh7II/mP
         AF7HphcZKc1/lhlFmJUiDKixR4a9xL//MDINdwZ1awBkwRtQuOUzKjGJvPGOltMZUv
         mugVcZ1eyufLjHooCAKIIh4fg/3vs7sF3Ng42fGQ=
Date:   Fri, 6 Nov 2020 11:45:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        USB <linux-usb@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 01/10] dt-bindings: usb: Maxim type-c controller
 device tree binding document
Message-ID: <20201106104536.GB2785199@kroah.com>
References: <20201029063138.1429760-1-badhri@google.com>
 <20201029063138.1429760-2-badhri@google.com>
 <20201029153351.GA1911637@bogus>
 <CAPTae5L8bnv1S6dK0XkPiF7aha88ed5vfaiw5HAdtvu7TQMD5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5L8bnv1S6dK0XkPiF7aha88ed5vfaiw5HAdtvu7TQMD5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:01:52PM -0700, Badhri Jagan Sridharan wrote:
> Hi Rob,
> 
> The error seems to be because the following patch
> 5ed132db5ad4 dt-bindings: connector: Add property to set initial
> current cap for FRS
> is in usb-next but not in the rc1 branch yet. To make the bot
> recognize that this is a
> dependency, Is it suffice to mention the following in the commit description?
> This patch depends on patch "dt-bindings: connector: Add property to
> set initial current cap for FRS".
> Or is there something else that I should do ?

This should all be in linux-next, Rob, is that ok?

thanks,

greg k-h
