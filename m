Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D42C21F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgKXJnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbgKXJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:43:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F93C0613D6;
        Tue, 24 Nov 2020 01:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M/iBLJL/EG5AgOHD7behYTBNDQkWYbGk8/XLqfCBQpc=; b=ZWy/rWekEoc/XtfyySU5aZH3J0
        Krzj7EjERitAmRkbozaSIaWZ9lY1bH8N/dvz6gSzYUo7HJUedIKRAM8RWGeJeX0UwZHPzTfx0AasE
        4QDj7Pg62EbANHgDbMrY/M9BbVARJzB6RTUWA0u5uuEVQv9/l4eOBqJ+iOx32TXZkXwz8mPNKODTy
        jR85yOpj4EBh+qFIL617dqd/PiV5S960MjELfXUnMimhT/JsAfYmiLmm5sqOb0uUAPZqF0CARUpY1
        NKx2Icsy9uqPXzF2qN8PJtUsWEYToJ5JOSio1aQeuHJUunm6jbKdxizTMdBX2U1ggAIFAON3vY4Iv
        tI+0ZbIg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUqr-0000SN-4t; Tue, 24 Nov 2020 09:43:09 +0000
Date:   Tue, 24 Nov 2020 09:43:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] blktrace: make relay callbacks const
Message-ID: <20201124094309.GI31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <7ff5ce0b735901eb4f10e13da2704f1d8c4a2507.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff5ce0b735901eb4f10e13da2704f1d8c4a2507.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:29PM +0200, Jani Nikula wrote:
> Now that relay_open() accepts const callbacks, make relay callbacks
> const.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
