Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837C62AB435
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgKIJ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKIJ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:59:26 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2375120789;
        Mon,  9 Nov 2020 09:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604915965;
        bh=B9q26AWijg5yv/Bj2lex5vHH5B6Fye51KEVbiswR8+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbTDKWFTYmb9Qz8BS2fizsImus8lD+OuAelFASXqm8sUKqF4RRnJ/9mdlsreBCBV8
         2KDI5XgjUN6VG1sPcQHarCmQ8Z5kz41Cz6MwaqWbrAzz0TAVM3SuHOkI94HyXz46Q4
         QYg62GOPv5JhN8mh5trugK+Hr9EnoiRH3hxrP7cg=
Date:   Mon, 9 Nov 2020 11:00:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     pizhenwei@bytedance.com, stable-commits@vger.kernel.org
Subject: Re: Patch "nvme-rdma: handle unexpected nvme completion data length"
 has been added to the 4.9-stable tree
Message-ID: <20201109100025.GA1003283@kroah.com>
References: <20201108231636.B9304206DC@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108231636.B9304206DC@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 06:16:35PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     nvme-rdma: handle unexpected nvme completion data length
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      nvme-rdma-handle-unexpected-nvme-completion-data-len.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This adds a build warning to the tree, so I've dropped it from 4.9,
4.14, and 4.19 trees.

thanks,

greg k-h
