Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880432E196F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 08:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgLWHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 02:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgLWHpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 02:45:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D2C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 23:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E1YUsD2nj+OkFU/in0WWLJXY7M3YefssH3/+iMphZXw=; b=agC1u3ToQ1zPlTVVYpeaRxP5vk
        5VQh9UrNVdKzPrSdAJMTCR2PnwZ59WEO2jeslQ50DQ7IabBtlRl+IuaxE7TauU+pxYs6gHE2RcuIZ
        1U4DpaAS0sEgx2LK3ZdvN/GjVGyVEmq2zjlA+KTvq16MyqVuWNbe0y/uvzhVnz66Do5zk4Lg5THSc
        W6hjSVrigGcUdZiFxiL9CkKFmynHmLsdTTJitENrotxkuPR9x+lvLuu2uN8MIXVqs4g/2MnVK731X
        13kdLohOH7RpR7G3QHQGuZnupe00dUatAtpkBULPqCSPxZOmKdK2KLJhDtYgIJX8ThZqQMNI9Zlde
        YNzcDnHQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krypL-0003sk-Vn; Wed, 23 Dec 2020 07:44:56 +0000
Date:   Wed, 23 Dec 2020 07:44:55 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>, guoweichao@oppo.com,
        linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201223074455.GA14729@infradead.org>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
 <20201222193901.GA1892159@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222193901.GA1892159@xiangao.remote.csb>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 03:39:01AM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Tue, Dec 22, 2020 at 02:22:34PM +0000, Christoph Hellwig wrote:
> > Please do not add new callers of __blockdev_direct_IO and use the modern
> > iomap variant instead.
> 
> We've talked about this topic before. The current status is that iomap
> doesn't support tail-packing inline data yet (Chao once sent out a version),
> and erofs only cares about read intrastructure for now (So we don't think
> more about how to deal with tail-packing inline write path). Plus, the
> original patch was once lack of inline data regression test from gfs2 folks.

So resend Chaos prep patch as part of the series switching parts of
erofs to iomap.  We need to move things off the old infrastructure instead
of adding more users and everyone needs to help a little.
