Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9014B2FBB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbhASPba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390099AbhASPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:30:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45587C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qN5w7+5mI1ro4bld5PO3eX1ssRp5DBRYLgSIAZw6YTg=; b=sVTpXquCMX/7Pn2sWrNH+72X43
        US6K5TEuXzMbenqwGZ4BKzkVBh4nDwBVL0tlw/C4Ikwwf3Fwk2gDWxyUXBrQ9rSbcv4mvGe2bEubg
        Tz07XFsDCcOwcPNURjBr4G92j4oQiUXZX5aDP9F1Yk3L62L3BNG8FPgDl+wnrtIJXae6U3EEB/hnZ
        1NTqIRnzHqyT79yQCoVCxHHwEbIoGa4T1Y4vBn8vP+GNHJpc18Ibyo6/JifkbVX9hSShMK2TRWLAC
        CJaJY9wO9nlWs/bUOO/2CsM8CxXaUbpD9mV86f590jWVRyThVrbDaqc/TnR9YbBNjbMVeazFgUnwX
        iPc1Z8fw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1swt-00EUnW-Kc; Tue, 19 Jan 2021 15:29:42 +0000
Date:   Tue, 19 Jan 2021 15:29:39 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: Re: [PATCH 2/2 v2] iommu: use the __iommu_attach_device() directly
 for deferred attach
Message-ID: <20210119152939.GB3453587@infradead.org>
References: <20210119111616.12761-1-lijiang@redhat.com>
 <20210119111616.12761-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119111616.12761-3-lijiang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int iommu_do_deferred_attach(struct device *dev,
> +			     struct iommu_domain *domain)

I'd remove the "do_" from the name, it doesn't really add any value.

> +{
> +	const struct iommu_ops *ops = domain->ops;
> +
> +	if (unlikely(ops->is_attach_deferred &&
> +		     ops->is_attach_deferred(domain, dev)))
> +		return __iommu_attach_device(domain, dev);
> +
> +	return 0;

Now that everyting is under the static key we don't really need to
bother with the unlikely micro optimization, do we?

> +extern int iommu_do_deferred_attach(struct device *dev,
> +				    struct iommu_domain *domain);

No need for the extern.
