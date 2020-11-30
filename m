Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7F2C8AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbgK3RSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgK3RSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:18:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E64C0613D4;
        Mon, 30 Nov 2020 09:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s4jJK+5znvzzHztXLjOWVZCVFuhZUwJ1CvNQEbKOU5Y=; b=WTnH0iiDgBUaxbqorB81mzceKu
        xjKU/vksB7Xg5BKiVWKPpxAEDG4qC7sfjOPn9cUWP7LU+xMzMk8OOP6El3rI/ev13NaM6utcJdBN+
        +11q/2ZVKmIfSiqE/nbrrjTwkHUFVQoubolgF8sRtnqYjdE/Gypl07Z05shEODqw0o5moXeqHyCL2
        WfaQ+4KY+5X37w2SNDHnOeyQl4PG4gIAB0prPS72OuZtbOfP4DI3TFFwr0O2jJ40fBY4VdLdWPGsh
        qxuGXB+XIYaDEtACXphFwyz0AXDIBMujVxqPY8eH/pydGkUm18dpwIxafusLHvxtV08RFWjPBDuNj
        4R9WbcKg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjmo8-0003Td-Vj; Mon, 30 Nov 2020 17:17:49 +0000
Date:   Mon, 30 Nov 2020 17:17:48 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] blk-mq: Remove 'running from the wrong CPU' warning
Message-ID: <20201130171748.GC10078@infradead.org>
References: <20201130101921.52754-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130101921.52754-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:19:21AM +0100, Daniel Wagner wrote:
> It's guaranteed that no request is in flight when a hctx is going
> offline. This warning is only triggered when the wq's CPU is hot
> plugged and the blk-mq is not synced up yet.
> 
> As this state is temporary and the request is still processed
> correctly, better remove the warning as this is the fast path.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
