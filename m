Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74C52E1D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgLWOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbgLWOSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:18:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C7D123159;
        Wed, 23 Dec 2020 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608733047;
        bh=KbpO1F0hOo1WD53ODuHgeuiufcJnqdQBqUPRnCSPzv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/JHK7B/vuULH9Af/X94IYnajoshkHA4zz7DqIpIfk9/u/a6wKaPirSOcp6yL8ugG
         VZIFZsee0W0Q99/toI8BLUw/4nB9Xs/0bRGX6/S0f4bcCgSZvXidTbJGGCjbMirMnn
         2YNup0PpBrwLYhCLke1uT7YJjwJzIZ3uuFojbQoE=
Date:   Wed, 23 Dec 2020 15:18:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: most: use DEFINE_MUTEX (and mutex_init()
 had been too late)
Message-ID: <X+NRvs+FdjB9W9Z8@kroah.com>
References: <20201223141138.32456-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223141138.32456-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:11:38PM +0800, Zheng Yongjun wrote:
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/staging/most/net/net.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Again, no changelog text?

And why are you not cc:ing the developers and maintainers of the code
you are sending patches out for?  Please always use
scripts/get_maintainer.pl.

greg k-h
