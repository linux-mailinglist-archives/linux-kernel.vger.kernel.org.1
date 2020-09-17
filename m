Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6170C26DFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgIQP3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:29:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56759 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbgIQP1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:27:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 928576736F; Thu, 17 Sep 2020 17:26:34 +0200 (CEST)
Date:   Thu, 17 Sep 2020 17:26:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200917152633.GA521@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com> <20200917082651.GA4595@lst.de> <CAA5qM4B=KcDK=SmduJt3am=gL1miNKoKuEZWRqft1f-kG03fEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4B=KcDK=SmduJt3am=gL1miNKoKuEZWRqft1f-kG03fEA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:24:59AM -0400, Tong Zhang wrote:
> Hmm.. OK. Any suggestions on how to fix this?

Yes, we'll need to make sure the block layer doesn't double put
for a not fully setup disk/queue.  It has been on my todo list for
a while, I'll plan to get back to in the next days.
