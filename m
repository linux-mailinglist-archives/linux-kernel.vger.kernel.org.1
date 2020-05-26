Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A401BAB52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 19:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD0Rbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 13:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgD0Rbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:31:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4464E20775;
        Mon, 27 Apr 2020 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588008696;
        bh=sQuHvJ8hED/DxfS8jREtJCqTkhgs+wdBCB4nmSyo64Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSUAHvjim2B5zkwUH81DpVvb9f5Af9nvOVGON+fWy6Pl3f4f9JKnPNWBguiH6soWT
         M51gp+VtCd++fOceKouXW6MDiUTJpEqgW/2ghM+k06Rh0qcXC8NOwbnXDuHv/+HKb0
         FbXnluTxO5RPPGoGWxT4wjGOADtC/NiVSgAJxzMI=
Date:   Mon, 27 Apr 2020 19:31:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     youngjun <her0gyugyu@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix possibility of NULL pointer dereference.
Message-ID: <20200427173134.GC3936841@kroah.com>
References: <20200427164836.48765-1-her0gyugyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427164836.48765-1-her0gyugyu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:48:36AM -0700, youngjun wrote:
> When dentry is negative, "kernfs_dentry_node" returns NULL.
> In this case, "kernfs_root" dereferences NULL pointer.
> 
> Signed-off-by: youngjun <her0gyugyu@gmail.com>
> ---
>  fs/kernfs/dir.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

And how can this be triggered on a kernfs filesystem?

thanks,

greg k-h
