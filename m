Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6F2797A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgIZHvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:51:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EA7C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MM0dvDjRIhRe8k2r6zlYe7BBprPmXrQkHpDnTcVXig=; b=qqZ18e/umVgBr1imArTeOkBtBH
        gHOM4ztxsDvJEJwzD5q2hTjTRcrd01us+Bc7mExhfw5+ZQHRJ53mz4dcWY4XolNoR9ng+UAEyoSWB
        UVviCBrSk7SwGj5PdMyJoJS7RnrifAze1P8Hs7UB9UOkbD+cRMw4qgdYUY6IDNEuy+GtyjRT0aJeF
        9BeXMVSzo+5U55OIlVSdzYU4J6BhJDJ0k6GdycjmEByYRzT8L4ViR+OFASHi0vm8+ajWidWTY3hYn
        qlFiwcik0wRvEzbQIC5Yzun3Ys17uKkRSlG39uYLoZdgvIThHnN0e5jVHArWeXqjhUh51uHYEbNqz
        WOWjnTMw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4zM-00066B-17; Sat, 26 Sep 2020 07:51:24 +0000
Date:   Sat, 26 Sep 2020 08:51:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Message-ID: <20200926075123.GB18592@infradead.org>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-5-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925072630.8157-5-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:26:29PM +0800, Sherry Sun wrote:
> Set VIRTIO_F_ACCESS_PLATFORM feature for nocoherent platform, since
> it needs the DMA API for virtio.

Given that VOP is a plug-in PCIe card VIRTIO_F_ACCESS_PLATFORM must
always be set, as the DMA mapping details are not something the
virtio implementation decides on, but the host PCIe/iommu
implementation.
