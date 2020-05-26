Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8E1C3C40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgEDODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgEDODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:03:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD7EC061A0E;
        Mon,  4 May 2020 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bK0B4AjAiw8HEQFzfeTV0caEn+nTqXTEfS3l1nfwGB4=; b=A6lA6daSe8GZF6vbqqJUbTAnhb
        uUPI5wEnPD3L/wMkNIezQRsteDGupDVFLy1XZ93LnIJW3wCb0yoMBlV5v7CL/AHzmY0QaPpsM9mv8
        bx/6ta7IeMdyMte+HGBdg0nMLZldEq36pSgUIaP5KC89R1Xh6rV9MLcoy11j7Bee5VhrRLu88VJBD
        teNjtZrPXKzAZqbspijjOX5Yz3EZKRXU+gaAauZfTeUdBhJ1QWXXvQeTjy79nRwW0lGCTuOfEYM58
        EtG2bxt9M9NFSjoudnrZgTOyohV2XozrCi6RXpAqFGLCnHg4Ps7Wqs1SnOzNdycflyPULx5HQbXPw
        gGgRf06A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbgj-0002lS-1l; Mon, 04 May 2020 14:03:17 +0000
Date:   Mon, 4 May 2020 07:03:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/4] block/part_stat: use __this_cpu_add() instead of
 access by smp_processor_id()
Message-ID: <20200504140317.GB29020@infradead.org>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
 <158859897252.19836.5614675872684760741.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158859897252.19836.5614675872684760741.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define __part_stat_add(part, field, addnd)				\
> +	(part_stat_get(part, field) += (addnd))

Just open coding part_stat_get for the UP side would seems a little
easier to read.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
