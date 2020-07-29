Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7B232213
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgG2QCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 12:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:02:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF87A206D8;
        Wed, 29 Jul 2020 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596038567;
        bh=LqQvmwMfqSOD3tms/ujMxK4IhqLryiypuOzrZpQdx7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I09Titq3MJvKc8tnz/ZFJPF8YJfKt8DKNyrx1WI3aJ0dBTkulDEIaHqTcydbLXidI
         RRLR7jfoa5FBJ2rsDzb8lfAqeDluOMB6gPK5+fwdAPjJjOArIpRG7KBhHAXqB42zzc
         r6i7rHiJv1R8xfqvLoDnZARy28cKtgf9kUTMaP6Q=
Date:   Wed, 29 Jul 2020 18:02:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] habanalabs: make some functions static
Message-ID: <20200729160236.GA3643779@kroah.com>
References: <20200729155925.34131-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729155925.34131-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 11:59:25PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/misc/habanalabs/gaudi/gaudi.c:6275:5: warning:
>  symbol 'gaudi_ctx_init' was not declared. Should it be static?
> drivers/misc/habanalabs/goya/goya.c:5228:5: warning:
>  symbol 'goya_ctx_init' was not declared. Should it be static?
> 
> Those functions are not used outside of source file, so this
> commit marks them static.
> 
> Fixes: a04b7cd97eef ("habanalabs: create internal CB pool")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

0-day already sent this patch in earlier today, sorry.

greg k-h
