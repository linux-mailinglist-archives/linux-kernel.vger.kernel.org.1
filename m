Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF1299166
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784388AbgJZPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772941AbgJZPs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:48:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7271522400;
        Mon, 26 Oct 2020 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603727338;
        bh=OMDnRVyqeqya2FcyT7Y18foNdJxrRexGZ+fZos5IcJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/jCFI8HGE7ZDfVTii+WZfTLte+u7e2vD1HoIuV3ixu9k3UAOthoWV3a8JTcN0rWy
         GLOeIOrTiCM7K+M5RcIUgSNiQe2+CKRmDCWbMFF/Mw+y7PNz0DYo+jhr5kmHj13fiF
         xA9F2WKdOybDx+C2nOtwxRJA2yvt2zCTVsAONNeI=
Date:   Mon, 26 Oct 2020 16:49:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     jgg@nvidia.com, stable-commits@vger.kernel.org
Subject: Re: Patch "RDMA/efa: Use ib_umem_num_dma_pages()" has been added to
 the 5.4-stable tree
Message-ID: <20201026154925.GA857002@kroah.com>
References: <20201026053928.23F9520678@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026053928.23F9520678@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:39:27AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     RDMA/efa: Use ib_umem_num_dma_pages()
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      rdma-efa-use-ib_umem_num_dma_pages.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Breaks the build, so I'm dropping it :(
