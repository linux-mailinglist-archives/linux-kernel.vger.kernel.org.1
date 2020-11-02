Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674702A2506
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgKBHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgKBHJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:09:41 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BED20870;
        Mon,  2 Nov 2020 07:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604300981;
        bh=Gk0gjWwJhvxvJn0ECrdwSnYJ07UjyQu0K66KRfc9/L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdPzUiOPDSHc53ZeMLBF0AXOfgBi/cLXc3saXkGiwTIpD7AXjKZjN7Lb3/vfMlYpD
         tzCBi64LHuiKe9PtJArCWtOQqf9lF3EQPzGN6OHUd4w+2UPdgBD/jfLfLgCdtg1cfm
         CODpjMqPuio63qlhj+xkU+bnzUXyHEj/o+I2uYvg=
Date:   Mon, 2 Nov 2020 08:09:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Kai Ye <yekai13@huawei.com>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangfei.gao@linaro.org
Subject: Re: [PATCH v3 0/2] uacce: fix some coding styles
Message-ID: <20201102070937.GA71996@kroah.com>
References: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
 <5F9FAA08.2000406@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5F9FAA08.2000406@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:41:12PM +0800, Zhou Wang wrote:
> On 2020/9/23 18:09, Kai Ye wrote:
> > 1. delete some redundant code.
> > 2. modify the module author information. "Hisilicon"
> > spelling is error.
> > 
> > Changes v2 -> v3:
> > 	Two things, splited to two patches.
> > Changes v1 -> v2:
> > 	deleted extra NULL pointer check in uacce_fops.
> > 
> > Kai Ye (2):
> >   uacce: fix some coding styles
> >   uacce: modify the module author information.
> > 
> >  drivers/misc/uacce/uacce.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> 
> Hi Hartman，
> 
> Could you help to take this clean up patch?

I do not see a patch here :(

If I have missed something, please resend it.

thanks,

greg k-h
