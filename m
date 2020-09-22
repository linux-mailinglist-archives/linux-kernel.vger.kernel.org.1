Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01EC273CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIVH4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIVH4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:56:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB4D239A1;
        Tue, 22 Sep 2020 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600761363;
        bh=e8uyanv5QamZvHhEIRb+/GaChkLBDot++bgyhunyOuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMxC6Q8c4bLB99PsBz13WD7bURR/xwpfC+Lj2+q1a1CRXUIK4P8IO1uLV/IROCNf6
         cROZbqFmOSSgVXRjtnzjILFdvBgbcRPh/f3kKLc+JoNBAz2ARdgRQDXfleNt42iAWU
         fblGWrrOyz9Gl6QB0PD2Nu7/PWL+zYVZHpm5K2cU=
Date:   Tue, 22 Sep 2020 09:52:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Browning <jamesbrowning137@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] staging: comedi: comedi.h: Fixed typos in comments
Message-ID: <20200922075224.GA1789797@kroah.com>
References: <20200921053018.64095-1-jamesbrowning137@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921053018.64095-1-jamesbrowning137@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 10:30:00PM -0700, James Browning wrote:
> Removed repeated words "the" and "in"
> 
> Signed-off-by: James Browning <jamesbrowning137@gmail.com>
> ---
>  drivers/staging/comedi/comedi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What tree did you make this against?  It's already in my development
tree and in linux-next, so I can't apply this again :(

thanks,

greg k-h
