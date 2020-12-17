Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173C22DCAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 03:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgLQCX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 21:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgLQCX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 21:23:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B62BC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 18:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8uHs/UhveALE70R5Z9Kg2unr079LnQrGmTT2HTgImw8=; b=FifsAiB3tLiNJPag7q9n8RFM5/
        pk9gX7tAuQJSETnc6fT6mFCRtrmN3ucHavM6Xn8K8jvyvhnvox/5tUNajqntYzSL73VRjnutHSRRk
        dg0m/5QJ/CJcdVCoEACAjAX3L9w7x9cRok3++Zkax/N3DQyOXMOpcTvBbBge9izlvqW24uQ44vqfr
        vpuHGZ3P7SpVuUwaPvWYf7AeNS8XyAOn56x/x3kdr+t425vgJ7xisdFmaqVU2J/TG5SNkqDKR6v8/
        jx9NgNK9WY7uHm/XaZ0DfFvzk8y0+YmPCU6UFT3tq1q1fdx+IDleU30BRZ+07RmdqXv6xHstJJrwM
        WhSosgcw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpiwc-0007Ne-NI; Thu, 17 Dec 2020 02:23:06 +0000
Date:   Thu, 17 Dec 2020 02:23:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiangyang Yu <yuxiangyang4@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Fix warning: no previous prototype
Message-ID: <20201217022306.GB15600@casper.infradead.org>
References: <20201217020311.491799-1-yuxiangyang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217020311.491799-1-yuxiangyang4@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:03:11AM +0800, Xiangyang Yu wrote:
> Fixed the warning when building with warnings enabled (W=1),
> This function is only used in filemap.c, so mark this function
> with 'static'.

Good grief, no.  Look at the git history before proposing a patch.
