Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5A1A35F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgDIOdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 10:33:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56634 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgDIOdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t108aSZwNrLLBTSbxD8GRa59ihUeOfYwdyM3oFc/ymk=; b=yegRnYyS0d6o7FbYu4mfEk7ndZ
        iDEx32RSJY5N+n8TtYqGlRN7WkPP+mAX7DIwPl+nJFE52m+xtOchIwo0CIzlQ/RmS5UVlD39ynfBQ
        UGa4HGYpMu2HG5t0Rt0CrY0dDDZA5IRTtYF1SpVbWuUZuUJd0hPXZXPu29igqxPcix5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jMYEV-001omz-2C; Thu, 09 Apr 2020 16:32:43 +0200
Date:   Thu, 9 Apr 2020 16:32:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Check Point L-50 board
Message-ID: <20200409143243.GK389953@lunn.ch>
References: <20200409070448.3209-1-paweldembicki@gmail.com>
 <20200409070448.3209-2-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409070448.3209-2-paweldembicki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:04:44AM +0200, Pawel Dembicki wrote:
> This patch adds dts for the Check Point L-50 from 600/1100 series
> routers.

Hi Pawel

Looks very good. Just a minor comment:

> +&eth1 {
> +	status = "okay";
> +	ethernet1-port@0 {
> +		speed = <1000>;
> +		duplex = <1>;
> +	};
> +};

This is a non-standard way of doing a fixed link.  But looking at the
driver, that is all it supports. I also don't think it is worth the
effort converting it. Kirkwood is so old we hardly see any new boards
using it.

So:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Since we are in the merge window at the moment, this won't be merged
for a while.

    Andrew
