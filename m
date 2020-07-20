Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B891F22559A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 03:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgGTBsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 21:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgGTBsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:48:39 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA982250E;
        Mon, 20 Jul 2020 01:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595209718;
        bh=hRoIi2eCqfbW2de0T3+kDxi6NFvBxXfhMeYbYRAa3no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EulR9DgEueoo2etA22ijlu4EO0SImdmaUpCOHChD0KIYtmGraIws66uSednBuEVAF
         submbq3KXl1Xrq7OAUfJ1W9vInln+mx398/L15Kqk5FG4UTiFfJKQ98d/SMvFbfvhf
         BdkPrA8UebytsFvz9Z9zDDZnEnwUbW2tRX4gtCpM=
Date:   Mon, 20 Jul 2020 09:48:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        rjones@gateworks.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] ARM: dts: imx6qdl-gw: add Gateworks System Controller
 support
Message-ID: <20200720014823.GA11560@dragon>
References: <1592497149-22526-1-git-send-email-tharvey@gateworks.com>
 <1594913755-5661-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594913755-5661-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 08:35:55AM -0700, Tim Harvey wrote:
> Add Gateworks System Controller support to Gateworks Ventana boards:
> - add dt bindings for GSC mfd driver and hwmon driver for ADC's and
>   fan controllers.
> - add dt bindings for gpio-keys driver for push-button and interrupt events
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
