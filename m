Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B973D1F1336
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgFHHJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgFHHJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:09:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADBFC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=riTlVvjTBVFVzOBQ14vr3osfjEjXKYJJb4irFAZraug=; b=mrrf00JD+nWPYE2DUp6aInWaGN
        a0TxqMgzuk/LZrKik9Im/aZcH6eN6HqEQ6SXpJb1qToyKWPK/mAAx6+qceEklRjCStr6sT9NR15iC
        G7zApsVtqHeNiJLCkNz/l/f3NxMiEJWdWykEdvN17+3WrJmZ37+O4628h8PIkyaTbI6dyc4WpeS7w
        /CvBKq3CoXFkMGqT8kq6RGDfyyGSqG9B735Rq17SHasqFOmkkWHaOJJgPzhNxGk2HMBsdqDvWOL8X
        KixbEX6rwCAMRY9fmWt8XRMo5f6s2AsghXmBgqFVATH/dejo6gIXS5Uuonc7MSsGYPgNwsGeoeC2q
        1wRSFvkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiBuY-0003VP-6I; Mon, 08 Jun 2020 07:09:34 +0000
Date:   Mon, 8 Jun 2020 00:09:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 09/11] swiotlb-xen: rename xen_phys_to_bus to
 xen_phys_to_dma and xen_bus_to_phys to xen_dma_to_phys
Message-ID: <20200608070934.GE15742@infradead.org>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-9-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603222247.11681-9-sstabellini@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:22:45PM -0700, Stefano Stabellini wrote:
> so that their names can better describe their behavior.
> 
> No functional changes.

I think this should go with the actual change, and adding the
parameters.  Touching this function piecemail in three patches for
what really is a single logical change is rather strange.
