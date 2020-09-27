Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF43227A0F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI0Mfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 08:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgI0Mf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:35:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E6823718;
        Sun, 27 Sep 2020 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601210128;
        bh=b6UD0XP4ofa1a5K099D1qbNVwKtfyceLcCjRSKg1f08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOwxXS8nSeH/0MRWdID6ideHA5BK4Y5MUsNipfqaiLDPaIpI5ET7mxOwOM5QSeYcb
         yeHJF0nP0G//ei/TRP+/VIfDo4ntwWBltCkIarHO5t8z5MPgL/YGhoD2NC+Uitr2r3
         TZjfw4GN98TiKvkU2nSAOq2jwI4OMG8SvC0EbtsI=
Date:   Sun, 27 Sep 2020 14:35:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH -next] binder: simplify the return expression of
 binder_mmap
Message-ID: <20200927123538.GA292831@kroah.com>
References: <20200921080830.vrki7dcm64l46ppb@wittgenstein>
 <20200921114734.3272769-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921114734.3272769-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 07:47:34PM +0800, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/android/binder.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Is this a v2 patch?

If so, please properly label it and say what changed from the v1 version
below the --- line.

Please fix up and resend a v3.

thanks,

greg k-h
