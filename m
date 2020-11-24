Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461B72C21F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgKXJmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKXJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:42:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BAinDqvjXXeY26FFo3tJLD7w0kcIj1lX/LqRWKFcxpA=; b=QovCW9fVrlRA63ZTYDa3NpXcvd
        LEsf2t4BoNCrQ8slb1LYNT6tZR/b1BXpJTDB3MUFHGfNrWLff4iV0YWLBDcAJ+RMubIUUqJL/iWZD
        zzcgzZtoFbimQFjRpYW8ZkHtbmwM9Zj9v/4WFqYklOJqldEySG135k0QjIUjxyF4prcaM+8Hzd6w8
        cNE7sjKBEaW6/YjYUQ+2gBxqFj/11MHu+5KHav09ByY5IiKI3EOAdD3AzCVJgDBelbf7KtxaFwx5u
        AL6+h1srPJr1RRF5iQ8B4FCBjDSP/gtz+UEstuWRNRcb4sNkOQVUHz1LmHcIBAodT7kKKJslATlLw
        T9s3N/Vg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUqP-0000QO-OU; Tue, 24 Nov 2020 09:42:41 +0000
Date:   Tue, 24 Nov 2020 09:42:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Kalle Valo <kvalo@codeaurora.org>,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 7/9] ath11k: make relay callbacks const
Message-ID: <20201124094241.GG31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <44e3d65b71025c462948d0c554061dc7b40ab488.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e3d65b71025c462948d0c554061dc7b40ab488.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:27PM +0200, Jani Nikula wrote:
> Now that relay_open() accepts const callbacks, make relay callbacks
> const.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
