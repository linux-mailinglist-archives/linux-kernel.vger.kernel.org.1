Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5A232C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgG3HIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 03:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3HIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:08:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77BD22070B;
        Thu, 30 Jul 2020 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596092927;
        bh=is7ibpZH5c70+mTBOL4OZ9tChpg2BoECoi0RvbkELCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3bI5Qr8nSWppsBGUyYc1IHmaJVLyUGRCyfBHjVt9vBRMD3uOFGyNhAR1/sCOa32/
         uyHFHa5S/MXa1WZ5JvTOYiUfALz9KH9txWxxBmYHLmF7o6ULmCZN7MMRACEhtkKQ4B
         ZgmtTV0uZP00mZRuvrSCxGhM9FsnlO1cD7be/oqU=
Date:   Thu, 30 Jul 2020 09:08:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v9 0/4] driver core: add probe error check helper
Message-ID: <20200730070832.GA4045592@kroah.com>
References: <CGME20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981@eucas1p2.samsung.com>
 <20200713144324.23654-1-a.hajda@samsung.com>
 <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:05:03PM +0200, Andrzej Hajda wrote:
> Hi Greg,
> 
> Apparently the patchset has no more comments.
> 
> Could you take the patches to your tree? At least 1st and 2nd.

All now queued up, thanks!

greg k-h
