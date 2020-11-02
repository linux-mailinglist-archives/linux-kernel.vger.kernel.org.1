Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0709F2A2628
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgKBIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:33:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgKBIdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:33:01 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28AD206DC;
        Mon,  2 Nov 2020 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604305981;
        bh=WvvmWso7WNgcAz3bbRDJ64etoP4bPwe3AeQ5XJNYRfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2XvS0t9nohvK7EI5eY5BI9vBR3BNtzNPQbNZ6rG9wf5ILip86/WwOOg6D7qshH/U
         fyWtmHpz/ZC26RemU/oKRZVsRHXZi3mAFg3Ye5+148UDGjnILbfFuSpcA5zU6awUt9
         o8B6o40ZBgvkOGj22e4u0GiRUrPBz/m22TmpVyQk=
Date:   Mon, 2 Nov 2020 09:33:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Kai Ye <yekai13@huawei.com>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangfei.gao@linaro.org
Subject: Re: [PATCH v3 0/2] uacce: fix some coding styles
Message-ID: <20201102083356.GA142100@kroah.com>
References: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
 <5F9FAA08.2000406@hisilicon.com>
 <20201102070937.GA71996@kroah.com>
 <5F9FB789.9090204@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5F9FB789.9090204@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:38:49PM +0800, Zhou Wang wrote:
> On 2020/11/2 15:09, Greg Kroah-Hartman wrote:
> > On Mon, Nov 02, 2020 at 02:41:12PM +0800, Zhou Wang wrote:
> >> On 2020/9/23 18:09, Kai Ye wrote:
> >>> 1. delete some redundant code.
> >>> 2. modify the module author information. "Hisilicon"
> >>> spelling is error.
> >>>
> >>> Changes v2 -> v3:
> >>> 	Two things, splited to two patches.
> >>> Changes v1 -> v2:
> >>> 	deleted extra NULL pointer check in uacce_fops.
> >>>
> >>> Kai Ye (2):
> >>>   uacce: fix some coding styles
> >>>   uacce: modify the module author information.
> >>>
> >>>  drivers/misc/uacce/uacce.c | 13 +------------
> >>>  1 file changed, 1 insertion(+), 12 deletions(-)
> >>>
> >>
> >> Hi Hartman，
> >>
> >> Could you help to take this clean up patch?
> > 
> > I do not see a patch here :(
> 
> I know the reason, Kai Ye did not To you and I also added your
> Email address in this ping :) I have replied patches directly.
> 
> Could you take them?

I need them in a format that I can apply them in, please resend the
whole series properly, so that I do not have to edit them by-hand.

thanks,

greg k-h
