Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8AE22C66F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGXN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgGXN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:28:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEC82065F;
        Fri, 24 Jul 2020 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595597314;
        bh=aVUlwaFSPbv2FOLkmLAuTXyO51kUIwT97MB3MVPw4m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNxwEYnSSTcZNbJ28anpaf133BCtSSNL5BVKFETSxWIjX67dvkoe00WB9jPpmI3In
         o9UPsvYM4jDGPJ/TTeKqcjUFwTovwr8HzUJVcE3RRdfVggcBFQHc0Cs8TF2FqOgavZ
         HlPQZPvOMFNa3dvUVimS1J+e0GXQ/FOB/OdZvp8E=
Date:   Fri, 24 Jul 2020 15:28:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Michael Straube <straube.linux@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8188eu: rtw_mlme: Fix uninitialized variable
 authmode
Message-ID: <20200724132836.GC316746@kroah.com>
References: <20200724122957.30411-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724122957.30411-1-dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:29:55PM +0800, Dinghao Liu wrote:
> The variable authmode will keep uninitialized if neither if
> statements used to initialize this variable are not triggered.
> Then authmode may contain a garbage value and influence the
> execution flow of this function.
> 
> Fix this by initializing it to zero.

That does not fix anything, you just now are potentially setting a value
you really do not have.

Are you sure that this variable really will never be set?  If so, please
fix it up with a "real" value that the code can handle properly.

thanks,

greg k-h
