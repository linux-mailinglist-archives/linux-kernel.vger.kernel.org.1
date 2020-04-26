Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9071B91FD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDZRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 13:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgDZRJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:09:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4176206DD;
        Sun, 26 Apr 2020 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587920984;
        bh=UHrg/J2cxdPByDoPiEdO6DywDlmdo4sc4NT4RYOmL4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgGoaN0Bx77f5SCJl5gyCBMFUwbjy+8eg2cs6gmPdS3D1JEoD6vJmw2aKkx+sEUA6
         3sVfn3mkqeNaSouNVjY5dt27xOpHTYBgtJ7NoGZONLaQHc+LfPmHaJekAH/X1xNUYm
         RK2B4Mbya38eOVL8Ec30YqeRY8U3CBXijcvTcloE=
Date:   Sun, 26 Apr 2020 19:09:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] include/linux: delete duplicated kernel.h in
 nodemask.h
Message-ID: <20200426170942.GB2139089@kroah.com>
References: <20200426154230.xwglw6k5c3kwyco5@debian.debian-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426154230.xwglw6k5c3kwyco5@debian.debian-2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:42:35PM +0800, Bo YU wrote:
> In nodemask.h, it includes bitmap.h which has included kernel.h,
> so delete kernel.h from nodemask file.
> 
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
> BTW, I do not get maintainer of the get_maintainer file, so i do
> not know who can accept the patch if it is right.
> ---
> include/linux/nodemask.h | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 27e7fa36f707..980b48e05d05 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -46,7 +46,7 @@
>  * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
>  * int next_node_in(node, mask)		Next node past 'node', or wrap to first,
>  *					or MAX_NUMNODES
> - * int first_unset_node(mask)		First node not set in mask, or
> + * int first_unset_node(mask)		First node not set in mask, or
>  *					MAX_NUMNODES
>  *
>  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set

That change is not described above :(

