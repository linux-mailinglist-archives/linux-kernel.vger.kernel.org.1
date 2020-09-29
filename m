Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536E627BCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgI2GDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgI2GDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:03:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B81C061755;
        Mon, 28 Sep 2020 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=umhdPL6NxAswy3d1Yo9gqBCp/zPMxCtA5CFCZINezSM=; b=As6sEskIZBFiN7i7VwGqT5Y7mW
        FZg5fJoFdgrb9YpW2FU7GSmdFVfJSbGgmb2VW5dHoAyRYDtZCUydKIaW/76Qa6Rn3RgYMA9zmnsqL
        MP3vMDMPei8XoyZvmaD7+HEd+crMlLX7H5Vv1sxJu37QRJ35MOBMyrO+k1Pd2NqTnoIzXz115EP6/
        MnBgJGUBsFNRTwuZ05VkGFKM4X8FKhC0eATFO6yQ2CQjyCLW3Z8ODq0Z1gOUxxYsQP/6GfqMRuqAT
        3H43G4aVnZase0G1tEESp6BrPFwaOqHUM04kS/Dzqi3wlSzi4SpFiLBCeaTvJnt0dpdv+pxS/Oud+
        FBdwi6Ng==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN8jg-0001u5-HH; Tue, 29 Sep 2020 06:03:36 +0000
Date:   Tue, 29 Sep 2020 07:03:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
Subject: Re: [PATCH v3 2/2] iommu/tegra-smmu: Expend mutex protection range
Message-ID: <20200929060336.GB6564@infradead.org>
References: <20200929045247.15596-1-nicoleotsuka@gmail.com>
 <20200929045247.15596-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929045247.15596-3-nicoleotsuka@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 09:52:47PM -0700, Nicolin Chen wrote:
> This is used to protect potential race condition at use_count.
> since probes of client drivers, calling attach_dev(), may run
> concurrently.

Shouldn't this read "expand" instead of "expend"?
