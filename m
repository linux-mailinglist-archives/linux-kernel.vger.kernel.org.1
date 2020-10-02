Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6628143F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgJBNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgJBNkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:40:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 754BE206E3;
        Fri,  2 Oct 2020 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601646042;
        bh=yjK6TcIFC7WXaFANQVFI2LqqnRBV+qGWxHefP5P1k28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEQLbL7il6w6SFWs1Lh7cQmKfz1YUU/mHZU/kIAUWD6g4uHjK/z+lzJtnsHcEfOQ1
         fdfhrMbM+lylNr1Q+epNw9pohNlEWEYjR1pTUL6i6GY8rtKXHEmxoxZ1ePmarptrYZ
         CCSOoaduARDb67RMu3tstCOoDYuNc9N52VkFkuqo=
Date:   Fri, 2 Oct 2020 15:40:41 +0200
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
Message-ID: <20201002134041.GA3412330@kroah.com>
References: <20200929024004.244992-1-badhri@google.com>
 <20200929024004.244992-3-badhri@google.com>
 <20201002133952.GA3411859@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002133952.GA3411859@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:39:52PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 28, 2020 at 07:39:51PM -0700, Badhri Jagan Sridharan wrote:
> > set_vbus callback allows TCPC which are TCPCI based, however,
> > does not support turning on sink and source mode through
> > Command.SinkVbus and Command.SourceVbusDefaultVoltage.
> > 
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This patch breaks the build, are you sure you tested it?

Sorry, not this patch, patch 4:

drivers/usb/typec/tcpm/tcpci.c: In function ‘tcpci_register_port’:
drivers/usb/typec/tcpm/tcpci.c:630:13: error: ‘struct tcpc_dev’ has no member named ‘enable_frs’
  630 |  tcpci->tcpc.enable_frs = tcpci_enable_frs;
      |             ^


thanks,

greg k-h
