Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB79281435
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbgJBNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387917AbgJBNjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:39:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5C2206E3;
        Fri,  2 Oct 2020 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601645992;
        bh=nL+iyMxh4lxpqlCbP+LYX/IYDXc+IZloJMdDaMZimqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g058U7cf5stKLDERoxQLSh2wO2P4U7PMYu2IvV7Bx9k2HVgS/MCM7NOC775KSejE2
         nLu+lnp3HiplPVyKYkPZajyLU/ok0mXl2ecrUk3KaGMNy17rdfjF+Wfsu5inxB4i+I
         YGdbNdkeVw9UhynjpBx9Ozp4k0e3jrlMRLzFahG8=
Date:   Fri, 2 Oct 2020 15:39:52 +0200
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
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v9 02/15] usb: typec: tcpci: Add set_vbus tcpci callback
Message-ID: <20201002133952.GA3411859@kroah.com>
References: <20200929024004.244992-1-badhri@google.com>
 <20200929024004.244992-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929024004.244992-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 07:39:51PM -0700, Badhri Jagan Sridharan wrote:
> set_vbus callback allows TCPC which are TCPCI based, however,
> does not support turning on sink and source mode through
> Command.SinkVbus and Command.SourceVbusDefaultVoltage.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This patch breaks the build, are you sure you tested it?

Can you respin it against my latest tree so that I can take the patches
that have been reviewed?

thanks,

greg k-h
