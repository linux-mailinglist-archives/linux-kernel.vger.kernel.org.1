Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A14E1DDF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 07:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgEVFM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 01:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgEVFM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:12:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60ED12073B;
        Fri, 22 May 2020 05:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590124347;
        bh=1myIi6xkFqACQc78M6WFK0BeJ3iGiKTaCetZxVdCThw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bs+k3U0gaQbXD7G6JQqviI8GenKhZKi7klUYc32HTPUgf4tnpeP6s3wR++nzuYa52
         HuBZOWJzIaq9r6yYQk2JVwcY2I7VcjwUX6LBrLRKQpND6DMrtTpY02EXiP4FuYpWJv
         lJddfxmWfDueS5qlsSStsZdIPrKLuYyBoVGBeI7k=
Date:   Fri, 22 May 2020 07:12:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] usb: musb: Fix runtime PM imbalance on error
Message-ID: <20200522051222.GA523130@kroah.com>
References: <20200522025902.11516-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522025902.11516-1-dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 10:59:02AM +0800, Dinghao Liu wrote:
> When copy_from_user() returns an error code, there
> is a runtime PM usage counter imbalance.
> 
> Fix this by moving copy_from_user() to the beginning
> of this function.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/usb/musb/musb_debugfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

What changed from v1?  Always show that below the --- line as the
documentation says to.

thanks,

greg k-h
