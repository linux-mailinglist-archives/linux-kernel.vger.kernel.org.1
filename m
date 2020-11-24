Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73B2C2407
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbgKXLWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbgKXLWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:22:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EE2C0613D6;
        Tue, 24 Nov 2020 03:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nuWr5GTJh/MjvsEtoKMKb3zOYkiDXCsXpoOiUqjyZko=; b=kkHuprtqF3Jyi/BoVfRQT1orxN
        YkTBUOh6lJYKJKhviXmNE+zVwhMZWU90DTUuuD3MPM3dz9w1IAGpWypITMSwroIJfHpa2u6qvYiBh
        n0kuHznfi8seWQnZ2op22Wq3VJlNkFW8gSwPOjIXc2K539Vmgu2oLSOKAMTNKCdusZzoMtHGgrYbc
        fefGXdH+Sp9zCrfsdYxi9qBR4OFfyg3O7qeEh181MQdyz7MLLGTeLEEdX+X3h/ZuXx5YX54VHSJAx
        L0p8+ad4v2zy+1rUsIg8f6VMocS196/feOZV5p8fTfCiyI65yd7jPThhVW39/+Wek4P0ANs8VqydR
        NfdNnEcg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khWPJ-0006xa-Uh; Tue, 24 Nov 2020 11:22:50 +0000
Date:   Tue, 24 Nov 2020 11:22:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.11] block: optimise for_each_bvec() advance
Message-ID: <20201124112249.GB25573@infradead.org>
References: <60aaa6caab3d061cf7194716c27a10920b5bd7ad.1606212786.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60aaa6caab3d061cf7194716c27a10920b5bd7ad.1606212786.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:21:23AM +0000, Pavel Begunkov wrote:
> Because of how for_each_bvec() works it never advances across multiple
> entries at a time, so bvec_iter_advance() is an overkill. Add
> specialised bvec_iter_advance_single() that is faster. It also handles
> zero-len bvecs, so can kill bvec_iter_skip_zero_bvec().

bvec_iter_advance_single needs a comment describing how it can be
used.  Also can you take a look at the other callers and see who
can be switched over?  If you are not sure ask the relevant maintainers.
