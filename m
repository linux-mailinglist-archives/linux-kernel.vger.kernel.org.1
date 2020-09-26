Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A72797A2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgIZHud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 03:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:50:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F54C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u2RBFaNPlC+nH6XD6Q8imYT55sjJ2cLvFIdRw24Ata4=; b=H78Pl7mkllpTfZiJfeA96Q2u5d
        semQXHwGyPwGU4OyCq+EJuni+vM8Joeb+Ala2pNVCHKYA7ggeFfEUEoFw0TnUDr/0I3gT9cWGeglF
        K9t2PfolbVRf9NwT9EIqYws7CbNhCit77A4+PrR7trX57EYRjiVBRxXns3pVBUR8GNBQgZ4YGOjCg
        i6IX4GoXrdHQlxEG7xi4fuu4AlvIRFovd0VmJrWnLGaFuItbIobTgVJq8HIVO6/PaOLjhU/hDExs1
        Smc+fLhYwlQzinY+GBVNU0KoEXQnHWuZ/SAIQwAZL5aXYM21umTqKd5cLt/b2bXF6j5bz6fDc9JAN
        hD926JbQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4yF-00063E-Pg; Sat, 26 Sep 2020 07:50:15 +0000
Date:   Sat, 26 Sep 2020 08:50:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Message-ID: <20200926075015.GA18592@infradead.org>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925072630.8157-2-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/dma-noncoherent.h>

This header must not be included in drivers.

>  
> +		if (dev_is_dma_coherent(vop_dev(vdev)))

And this API must not be used in drivers either.

> +			vdev->vvr[i].vrh.vring.used =
> +				(void __force *)vpdev->hw_ops->remap(

And you must not use __force casts without a comment explanation why
they are safe.
