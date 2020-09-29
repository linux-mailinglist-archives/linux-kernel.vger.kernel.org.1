Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1927BCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgI2GDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgI2GDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:03:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DAEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=48XgreAjZs4gur0K4ZOCA5DaxMVnkVf7Jp8MpcZsDas=; b=oXuJQuGq0ROHVISt/bjm7XwpEh
        yG1nifrbWvewLtpXqRZ9xyNslwmyidUDLomZWW23JWBNnJAvP6eIetGY6HpbtslVV9oFUmTRnH492
        7h7vO7W1sZ/atG+giK+SI9EcEpbQYGXCgsmL4XSnR+ZbjtLwmu5KeJ/Ix7yXEiFiDpu+mkJf8atJy
        4pT+9vlpeuXzcjNoezx+i0Y6cm69s2ISSTlbkTndF1TyYZ/x/z9cmYxWBtKjDs8jj+kwYacrk8ILP
        4Rqpb+UvBAghohjGOS1gwmSRuFahG2XBHC+chUMcdhvDJq5AdhdDc1x+gjpNddd7uzfIpZaHUHTfj
        RAGa15Qg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN8jD-0001sZ-AE; Tue, 29 Sep 2020 06:03:07 +0000
Date:   Tue, 29 Sep 2020 07:03:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, dwmw2@infradead.org,
        alex.williamson@redhat.com, jean-philippe.brucker@arm.com
Subject: Re: [RFC 2/3] iommu: Account for dma_mask and iommu aperture in IOVA
 reserved regions
Message-ID: <20200929060307.GA6564@infradead.org>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928195037.22654-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928195037.22654-3-eric.auger@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 09:50:36PM +0200, Eric Auger wrote:
> VFIO currently exposes the usable IOVA regions through the
> VFIO_IOMMU_GET_INFO ioctl. However it fails to take into account
> the dma_mask of the devices within the container. The top limit
> currently is defined by the iommu aperture.

Can we take a step back here?  The dma_mask only has a meaning for
the DMA API, and not the iommu API, it should have no relevance here.

More importantly if we are using vfio no dma_mask should be set to
start with.

> +		if (geo.aperture_end < ULLONG_MAX && geo.aperture_end != geo.aperture_start) {

Please avoid pointlessly overlong lines.
