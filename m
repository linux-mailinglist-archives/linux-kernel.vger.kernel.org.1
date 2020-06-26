Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D51020AB61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 06:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFZEeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 00:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgFZEeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:34:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602FC2075D;
        Fri, 26 Jun 2020 04:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593146041;
        bh=svauuLOObuPPRRg/SNwuiGDY0wtaQA/mHRhvgoFOKLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yje6TbSdOU9d3eYg1RxErX/cH/mrH1Xn5Qm/upujSxgmAUUTznxihaMEj6H4Ppzh3
         iQ64GQMpErQJgW5XFLC5zOql6GAMEf6nvDrEY7MqjAWyQg76d2Nbhmu7U9T4FA1k24
         h4Da8/XcXwLO98lMmxJcbEs7VmnMr5lf9H/z244Y=
Date:   Fri, 26 Jun 2020 06:33:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
Message-ID: <20200626043358.GB175080@kroah.com>
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
 <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:06:03PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> > tag.
> 
> Is there any? Last time IIRC Greg told me that in the kernel the old
> and new variants are okay.

They are just fine, leave it alone, the in-kernel LICENSES/ files show
the valid SPDX tags that the kernel allows at this point in time.

This is not worth the churn at all, once we get to complete coverage of
all kernel files, then you can worry about trivial things like this.

thanks,

greg k-h
