Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8B2E1A04
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgLWIdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgLWIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:33:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50003C0613D3;
        Wed, 23 Dec 2020 00:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nmht9rIQwTxzsuy77xKfhGjrOLRmyTgR3yi4t6gmI/k=; b=K9oJMbitTsEhCA20nYhG3/ommE
        NrRLT9QH8VnYR5Wzd7XBbs3KPux7gVYnTUqr5DhG5IbZ5PtFNh3xA/cUybFrxQpAYl78b9vRi1AOs
        5vHosmJORAkULTptGUWWM8V+PU+JiFAMOpcKaRUgXVg3yj0l3VZ7gUSU7IfoSCS6ANlaoTbOMaPaR
        93BR+vy5WtIwf8Wy1MoYL52Lnyf3FSq4PGqbdaf5BuOuEjNBIIQnYm03hTvo0QW2n2/trykgTvSgr
        TcV4V9IvLbNHWhmj3B6LI4sgFSxccx2ZoPs5zM9mRoAPXqqvrM9rrcgZegPuQF3R4Y0mbwK8jnwNK
        pyO8cMJA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krzZz-0007Hw-8a; Wed, 23 Dec 2020 08:33:07 +0000
Date:   Wed, 23 Dec 2020 08:33:07 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     sh <sh_def@163.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH] blokc/blk-merge: remove the next_bvec label in
 __blk_bios_map_sg()linux-block@vger.kernel.org (open list:BLOCK LAYER)
Message-ID: <20201223083307.GA27350@infradead.org>
References: <20201223043158.GA1502002@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223043158.GA1502002@ubuntu-A520I-AC>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 12:31:58PM +0800, sh wrote:
> remove the next_bvec label in __blk_bios_map_sg(), simplify the logic
> of traversal bvec.

What makes you believe that this simplifies anything?
