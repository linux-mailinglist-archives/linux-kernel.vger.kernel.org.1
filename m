Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8525DBD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgIDOd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730570AbgIDOdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:33:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97ED8206D4;
        Fri,  4 Sep 2020 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599230013;
        bh=FHJqC3D/q48MLQ3HRGqKHGyvwW/vPxlNJ/p/il47Hxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Q59EDyrlwOKP/Lv7shUiKD3DG0Z/aX2eG11LlyzzBWvfl3wskepUl3gDXlW+CKcf
         naPYGdny3vU6acYu1CSVDPje+/FvGy+bTlv+NldEkyY0qsA5SNEyLcmDPqmT3G0v93
         3436aiX8puywmmMC9g07vEKb38uZBClN4V0YeyFY=
Date:   Fri, 4 Sep 2020 16:33:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "usb: dwc3: meson-g12a: fix shared reset control
 use"
Message-ID: <20200904143354.GA3197700@kroah.com>
References: <20200827144810.26657-1-aouledameur@baylibre.com>
 <4e7c19de-f276-7b2a-695a-ef83c1477d19@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7c19de-f276-7b2a-695a-ef83c1477d19@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:57:42AM +0200, Neil Armstrong wrote:
> Hi Felipe, Greg,
> 
> Is it possible to apply this ? USB is broken on 5.8 stable and 5.9-rc on multiple GXL/GXM boards.

Yes, will queue it up now, thanks.

greg k-h
