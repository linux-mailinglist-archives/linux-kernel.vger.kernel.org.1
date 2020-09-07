Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DF425F4EA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIGIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 04:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgIGIVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:21:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9CA208C7;
        Mon,  7 Sep 2020 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599466859;
        bh=32I5OIGx9oAoZOUqROJ02VPGvQhe/oRvKZlgkysMhaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvZ+bSf1fWZqBsew9aXeAm+300irl3fKKNv7+zIL195QiCUqMQT+Ce/kiW3i/YqGz
         sibz8gBNasj0qk4Mcz+8Bj450bjnXrpniHK4whXWNvLdJxpiV+ydYiYx282xOj0Gug
         7roElWOAfbdCkBNigqaQA7bMt64Pg5xUqf8E9A8E=
Date:   Mon, 7 Sep 2020 10:21:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] /dev/zero: also implement ->read
Message-ID: <20200907082114.GA714195@kroah.com>
References: <20200907075143.2023440-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907075143.2023440-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:51:43AM +0200, Christoph Hellwig wrote:
> Christophe reported a major speedup due to avoiding the iov_iter
> overhead, so just add this trivial function.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> 
> Changes since v1:
>  - fix the Suggested-by: tag
>  - report the actually read bytes in case of a partial clear_user
>  - remove an impossible to hit conditional
> 
>  drivers/char/mem.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

I already merged your v1 into my tree, do you want me to revert that and
then add this, or can you send me the diff to apply instead?  I can't
rebase my public trees.

thanks,

greg k-h
