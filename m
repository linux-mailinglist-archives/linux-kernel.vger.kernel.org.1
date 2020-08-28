Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894FA255639
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgH1IR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 04:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgH1IRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:17:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8CA20776;
        Fri, 28 Aug 2020 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598602672;
        bh=cdtmtPHYp3CjYJpBnBlTuVx703gKMayPV6/ZC2Y40Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOr5x5dQ3VWc307vlfnfgGfQ4Ukqbm0MmUaZnTT+tm++6oFqFGoSg6PxfzogiLZ55
         1Fea0UxYPqEBsOi8mdC7Ne+VecgN2NmSzmVe5jCi1JOi7sWNhMkE6CB/4Kg2bfgbtx
         1yjZvCC9Sq/QDN6OJXfGwR169s2HvgPFMvnFvtYA=
Date:   Fri, 28 Aug 2020 10:18:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: Re: [PATCH v10 5/5] drivers/tty/serial: add LiteUART driver
Message-ID: <20200828081804.GB1007729@kroah.com>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
 <20200812143324.2394375-5-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812143324.2394375-5-mholenko@antmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:35:00PM +0200, Mateusz Holenko wrote:
> From: Filip Kokosinski <fkokosinski@antmicro.com>
> 
> This commit adds driver for the FPGA-based LiteUART serial controller
> from LiteX SoC builder.
> 
> The current implementation supports LiteUART configured
> for 32 bit data width and 8 bit CSR bus width.
> 
> It does not support IRQ.
> 
> Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
