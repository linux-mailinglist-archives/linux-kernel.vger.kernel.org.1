Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316AA296C80
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461912AbgJWKJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373889AbgJWKJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:09:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E0B20874;
        Fri, 23 Oct 2020 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603447761;
        bh=3CvqND3B/r9FgUnaPVy66ZEPqSWux4dAPas8kYiz8bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLv11VZktS/yepN7/ATAybDmwD5O5mDmMEtyj3UoGqDFMyHwr1PikVaD8wJ+Fd7sZ
         e4wzDoH4XPMS9Tsmhs93kQ6mx1hVTXGpsbEqtOGvSVHsYq6Rxin0s6O0jLN/FtJLYe
         H1uogVz1WViFCttZaViLtbvpyewRgmgNQalXkvCE=
Date:   Fri, 23 Oct 2020 12:09:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     jslaby@suse.cz, jhovold@gmail.com,
        kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
        phone-devel@vger.kernel.org
Subject: Re: gsm muxing for Droid 4
Message-ID: <20201023100956.GA2285537@kroah.com>
References: <20201023095113.GA18590@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023095113.GA18590@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 11:51:14AM +0200, Pavel Machek wrote:
> Hi!
> 
> a579767c1 interferes with gsmmux patches for Droid 4.
> 
> Reverting it gets the stuff to compile again in 5.10-rc0.9.

As Jiri said, we don't support out-of-tree users of apis, you know this.

Please work to get the code you rely on upstream in order to ensure it
stays working.

thanks,

greg k-h
