Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DAE2DC331
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgLPPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:35:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:60048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgLPPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:35:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5AFFAD6B;
        Wed, 16 Dec 2020 15:35:00 +0000 (UTC)
Date:   Wed, 16 Dec 2020 16:35:00 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] blk-mq: Remove 'running from the wrong CPU' warning
Message-ID: <20201216153500.nevzjajj3wi7xio3@beryllium.lan>
References: <20201130101921.52754-1-dwagner@suse.de>
 <20201130171748.GC10078@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130171748.GC10078@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:17:48PM +0000, Christoph Hellwig wrote:
> On Mon, Nov 30, 2020 at 11:19:21AM +0100, Daniel Wagner wrote:
> > It's guaranteed that no request is in flight when a hctx is going
> > offline. This warning is only triggered when the wq's CPU is hot
> > plugged and the blk-mq is not synced up yet.
> > 
> > As this state is temporary and the request is still processed
> > correctly, better remove the warning as this is the fast path.
> > 
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, any chance you queue this one up?

Thanks,
Daniel
