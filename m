Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30127A73C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1GJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1GJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:09:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83928C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Pc31Fv12tc6sKlB32+4VLUicd8Kys3Yi96EmJx4ZVw=; b=KtFsoMZVzI2hLn0kVqj841Zljv
        KdeaaWf3HTJMLJ7W5NKm2PhNVFRZgvv2JC+VbGnCZNWsjkTSkqe2GmXMHwkaGMnz3JAldfxKTc1qq
        XMYisiiSxnaLJGZebR/heqLjlcHZH+Mufiqn+O6LKSO/x8wHtmU3fYRwK8wppekNAg9x1flncjxvg
        l44pVJ+j4quoNKMiyGPiOxbTgjYoTdKwQEAzfzZybld0vPFdJlC+o8gSr4JBUPuoNe+CpYrcnNqiP
        GfqIBjEJFwq3zhwPXXNHonZCG6ZOmPICt3hOMGu6Q/kYS5fOhKyDYxtJqcQ51ps+fL/RBphRs5mny
        a5kRlxFw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMmLQ-0002UV-Fl; Mon, 28 Sep 2020 06:09:04 +0000
Date:   Mon, 28 Sep 2020 07:09:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "huang.zijiang@zte.com.cn" <huang.zijiang@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Message-ID: <20200928060904.GA9387@infradead.org>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-2-sherry.sun@nxp.com>
 <20200926075015.GA18592@infradead.org>
 <VI1PR04MB4960DC1E64D65634FE76C7AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960DC1E64D65634FE76C7AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 07:58:29AM +0000, Sherry Sun wrote:
> Thanks for your reply.
> Can you explain why we cannot use the API and header above in drivers?
> And do you know if there are any APIs that could replace this to check the device hardware dma coherent support?

If your treat the memory as if it is coherent with device access you
should always use dma_alloc_coherent.  The whole point of the DMA API
is to abstract such differences away.

> > 
> > > +			vdev->vvr[i].vrh.vring.used =
> > > +				(void __force *)vpdev->hw_ops->remap(
> > 
> > And you must not use __force casts without a comment explanation why
> > they are safe.
> 
> Here is the original code, I moved the original code into the if() without change it.
> But I think  this is because vpdev->hw_ops->remap() return type is void __iomem *, but vring.used need type void *. 
> Maybe this is a workaround for Intel MIC platform, as it reassigns the used ring on the EP side.

Well, we'll need to figure out what is going on here, and blind casts to
and from __iomem are dangerous.
