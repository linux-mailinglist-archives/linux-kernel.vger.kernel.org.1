Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660322786F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgIYMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgIYMVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:21:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5E4B21D7A;
        Fri, 25 Sep 2020 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601036461;
        bh=Yzqiewa+QRMYKlCEeSmwhKHrtfdSyQChiuf2bhrHi4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZVAxip72/uTvul8Cxjto55o2jFfta5IzLKgjCoMwICr1IgQsuJ0J2SgY3qtqcnuF
         8hO7GNsoIUHEwqIqLgSqagE4LZQVoyaOVrcgFy/4+m1rpl+fd+6q5qbYtAZIlPrTDi
         OKJ/drVq2tYxBRVc33p2DcSxrh21b7f0POmIT8FI=
Date:   Fri, 25 Sep 2020 14:21:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Li Heng <liheng40@huawei.com>, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: Remove set but not used variable
Message-ID: <20200925122115.GD2680110@kroah.com>
References: <1600956767-10427-1-git-send-email-liheng40@huawei.com>
 <fe671faa-9975-be20-22f5-31a97e3c8859@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe671faa-9975-be20-22f5-31a97e3c8859@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 07:33:59AM -0700, Guenter Roeck wrote:
> On 9/24/20 7:12 AM, Li Heng wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > drivers/usb/typec/tcpm/tcpm.c:1620:39: warning:
> > ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Li Heng <liheng40@huawei.com>
> 
> I thought there was a patch series underway which started using it,
> but maybe my memory defeats me. Either case, it doesn't make much sense
> to remove the ops variable without removing the associated functions
> as well.

I agree, if this isn't needed, then the functions here should also be
removed in the same patch.

thanks,

greg k-h
