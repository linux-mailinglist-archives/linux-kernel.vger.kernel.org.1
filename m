Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B81C3C42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 16:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgEDODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 10:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEDODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:03:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CEEC061A0E;
        Mon,  4 May 2020 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BNTDUN9kLbKUmKwvQuEEQ2ffim4WJcPSkh5y0KJN3yw=; b=NMQD/JfLlJbXsJfnGpLkTezoR2
        LJUhFmjtzVUw9Be5OIb1Pxu7jaoIU1XxJpRb8AB/AoGGghgAOdul4i0XTUdjzczn1Fsi84OVA4b/u
        br94k7CtLj7YpNRU9QYLeq2dIthugbEckcr5Qax48qPLsxdjpWYaIL0zapD0geu9x23KzN0Bgab7z
        BjXl9/2BCa2e4r15hhS2IGfLo7e8ARIZ72zZK82J+k0vPNZh49ysVUvX5cg666rQ5nB0+1ZecADSt
        fH1ozs2k6IBb5+Cy3EvQUi1kgSAQ4mivP32PrclvI1nAg5Fnjfs4cZct+bo2YVOhR3LYvfU5Wl+lL
        nh6KmV4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbh9-0002oY-M6; Mon, 04 May 2020 14:03:43 +0000
Date:   Mon, 4 May 2020 07:03:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] block/part_stat: account merge of two requests
Message-ID: <20200504140343.GC29020@infradead.org>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
 <158859904278.19926.1357797452754171976.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158859904278.19926.1357797452754171976.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 04:30:52PM +0300, Konstantin Khlebnikov wrote:
> Also rename blk_account_io_merge() into blk_account_io_merge_request() to
> distinguish it from merging request and bio.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
