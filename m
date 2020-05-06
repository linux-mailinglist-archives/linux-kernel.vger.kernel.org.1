Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A981C708F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgEFMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 08:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgEFMoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:44:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BBE206D5;
        Wed,  6 May 2020 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588769050;
        bh=+gcTcBT0NPIx2nr2eSmROSlsvJsG9S9rJhJoXYKKGNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYr8UHTxSEsUWMcnhr8FLGjnrE/kAOk5eKtOlRros9ROhSCclYNEJO2NihQ7K4iJH
         rNXtw2zF0gtenWp9Tzes5GLDZ2bYL/UbYmC5ault4szvPBW46i+Rd+oPg3WDvs4u9P
         31lR507adE2cPfMKZFHQlrAWPZzfBtFgKF41cHwM=
Date:   Wed, 6 May 2020 14:44:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     youngjun <her0gyugyu@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: kernfs: fix possible null pointer dereferences
Message-ID: <20200506124407.GA3142038@kroah.com>
References: <20200430112046.53721-1-her0gyugyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430112046.53721-1-her0gyugyu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:20:46AM -0700, youngjun wrote:
> kernfs_path_from_node_locked checks buf is NULL.
> But, two cases below are not covered.
> 
> if(!kn_to)			<--- case1 (buf can be NULL)
> 	return strlcpy(buf, "(null)", buflen);
> 
> if(kn_from == kn_to)		<--- case2 (buf can be NULL)
> 	return strlcpy(buf, "/", buflen);
> 
> if (!buf)			<--- checked here.
> 	return -EINVAL;
> 
> buf NULL case needs to be checked first.
> 
> Signed-off-by: youngjun <her0gyugyu@gmail.com>
> ---
>  fs/kernfs/dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I have 3 patches here from you, with the same subject lines, yet they do
different things.

I'm dropping them all, can you please resend a patch series of the
remaining patches you wish us to review for kernfs?

thanks,

greg k-h
