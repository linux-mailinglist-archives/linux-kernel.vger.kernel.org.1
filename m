Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE522722B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIULhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgIULhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:37:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7DF20BED;
        Mon, 21 Sep 2020 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600688256;
        bh=9AdHOOiwkBvVaWNKqDxReKJzBIpM2azxE/0lbd7Zlkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guM7Bz418LoW1F/aqJ4PoUN2dkgYQmGqL30duJ3BVAx97cvEPF5hf6cwANj0Flb4X
         PGV9kkUPC1Xydm0WDxpTxNwVcJJwFF+MDvcNA+l5f7Y7ny100jcAqvXQaVqz29n431
         xwPUC+ZWrY7tcgZkwybz0XtY2bg2C4yF0kLz8Y0Q=
Date:   Mon, 21 Sep 2020 13:38:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     stern@rowland.harvard.edu, kai.heng.feng@canonical.com,
        johan@kernel.org, tomasz@meresinski.eu, jonathan@jdcox.net,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: simplify quirk handling.
Message-ID: <20200921113800.GA26212@kroah.com>
References: <20200921113039.GA19862@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921113039.GA19862@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 01:30:39PM +0200, Pavel Machek wrote:
> Simplify quirk handling.

In what way?

Please be more descriptive in your changelog and resend.

thanks,

greg k-h
