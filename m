Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A948B245F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 10:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHQIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgHQIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:21:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753CDC061389;
        Mon, 17 Aug 2020 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Te7ybJvVG4iKO2ohYmX5Pvjiv68xvlZXMI+4wj+EaTc=; b=FAo9+ki050pf10fKywl/9gNJTQ
        x3y7tfPplgYWFFVugPLMoL5EzDHxr4EIGIzwq0+sVb9xkIoFbW/Dy8i19EWmeSauFXVEqJZ0iig4X
        7j5bYgCeagxq+CZZXNne2N0BZ1rJvU13gLxL1QoQtSeh5E/Bi6LenRtmHeNLlaaM/FonoTQli8aAt
        A4AcTxuiJ9FF533W0MJS5nb/d8gaIUDbMkHvtr24MIgkR07xPqnjT4vDfjPs2Hcg5C/dtsSPOi8s0
        Pl35tiScHmFYsOi9YYzLz08XY9rW0gthZ0/uCbyUa9PWCsdkLsRbo29PpH3z5Jfl9cX9JBdLVxj1I
        6BkVrfeg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7aOB-0004Z2-0d; Mon, 17 Aug 2020 08:21:07 +0000
Date:   Mon, 17 Aug 2020 09:21:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        Chenfeng <puck.chen@hisilicon.com>, devel@driverdev.osuosl.org,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200817082106.GA16296@infradead.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:49:59AM +0200, Mauro Carvalho Chehab wrote:
> Add a driver for the Kirin 960/970 iommu.
> 
> As on the past series, this starts from the original 4.9 driver from
> the 96boards tree:
> 
> 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> 
> The remaining patches add SPDX headers and make it build and run with
> the upstream Kernel.

Please don't add iommu drivers to staging, and just work with the
maintainers to properly clean it up.

I also don't think adding a totally out of date not compiling version
is a good idea.  Please do a proper rollup, and if required (probably
not in this case), split it into useful chunks.
