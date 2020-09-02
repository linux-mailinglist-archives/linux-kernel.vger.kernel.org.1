Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA97F25ACDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgIBOVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 10:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIBOJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:09:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9CC2078E;
        Wed,  2 Sep 2020 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599055775;
        bh=gM9T3vWDXP+R8rA9KXPhmDwJIIC+hPMMGQ6hZ5o8Ui8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0BnISZH8FpmdrWOwzjHoRStWKDv4AA9A++fzHBjKhNv18807g3uusiJeoMNKQym3J
         aANb53n4A5ZzhOj8pX8kOwQawqHjR3Ky0y0Tx9uFTjUs5Ze3ogq6ZSPSg15x2oq/ep
         gOHSkPNqUBUs+57a+6ZMCjWAEmYnyu6zZDSvJWEI=
Date:   Wed, 2 Sep 2020 16:10:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with a function
Message-ID: <20200902141000.GA2020271@kroah.com>
References: <20200902132419.61220-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902132419.61220-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:24:19PM +0200, Antoni Przybylik wrote:
> This approach is more elegant and prevents some problems related to
> macros such as operator precedence in expanded expression.
> -------------------------------------------------------------------
> Changed return type to bool and removed inline sepcifier.

What is this here for?

Please read the documentation for how to properly version patches, it
should be in the submitting patches file somewhere...

thanks,

greg k-h
