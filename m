Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00CB25DA63
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgIDNsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 09:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730212AbgIDNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A15F2078E;
        Fri,  4 Sep 2020 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599226661;
        bh=pM3S1MrLDgxr104HS1EiOao8hUpIKJ+xLNu70rNDZ4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5YhjmlfONEW+0oM0PU7iT2RQQ/O0HgsobSnWJotCpmKCHu8ihA+BysrVWSjDJSGi
         2FIIwYnC+katYJvnZakhX3/tuHEpncjwR/D38szuzqtAIDaqtjIKhNtbKxo2HPv3gf
         Wz+MTZJbAOsFkANYFcPSyq0h2mglcioAr2CgwTP8=
Date:   Fri, 4 Sep 2020 15:38:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: gdm724x: gdm_tty: replaced macro with a
 function
Message-ID: <20200904133803.GA3165130@kroah.com>
References: <20200902161627.64686-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902161627.64686-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:16:27PM +0200, Antoni Przybylik wrote:
> Changed return type to bool and removed inline specifier. Also added
>  static specifier.
> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent 2 patches with the identical subject line, yet they did
different things :(

Please fix them both up and resend.

thanks,

greg k-h
