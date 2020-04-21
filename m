Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB71B2527
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgDULd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 07:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDULd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:33:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F2C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yNJ/QJc8XHgJr/R5jKJcnRf3U73GYXUc4W2dWj5+6Go=; b=hL1FZmTaJEJm0pTUR+S/zg1zjX
        xjDayfSFX6+W0vOmfMBmxxPmIeNGGsK8o1DD5eeefMCpivobhGPAiFJZZ/B0PAAxH+ryuUV/HmD9D
        CaFn39Ku/lCb026mSkWMhWGks+cfQn+GtzN3SXaE2+hDyiqoib9d8fqj4QYgasV9kcrUvXNY+6DLl
        XWd2ornZFs1Co01ekviBTx87s2rsVY08igERWZeGcWIo78HF21k01xmUtl5Fyx+Ah96rrqJDXbNJp
        U5WdMawH5AQJNFtyIOAmrOCeWU2Ts6EfzHHKI34CPGZbqyh0v/Vi0NsIJgaUsj/UgbrhIVHYv/sK/
        OGPHDhUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQr9b-0005rA-DC; Tue, 21 Apr 2020 11:33:27 +0000
Date:   Tue, 21 Apr 2020 04:33:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: block: remove unused header
Message-ID: <20200421113327.GA21053@infradead.org>
References: <6AA21C22F0A5DA478922644AD2EC308C73C546B1@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C73C546B1@SHSMSX101.ccr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:48:46AM +0000, Ma, Jianpeng wrote:
> >From 95218bc1d79f2bcbdd8819be26efa698868a34ca Mon Sep 17 00:00:00 2001
> From: Jianpeng Ma <jianpeng.ma@intel.com>
> Date: Tue, 21 Apr 2020 01:15:24 -0400
> Subject: [PATCH] block: remove unused header.
> 
> Dax related code already removed from this file.
> 
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>

Except for the mangled patch format this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you resend it with proper patch headers?
