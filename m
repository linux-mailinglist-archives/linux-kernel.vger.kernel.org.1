Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D35D26D6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIQIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:34:50 -0400
Received: from verein.lst.de ([213.95.11.211]:55321 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgIQIej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:34:39 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:34:39 EDT
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA02367357; Thu, 17 Sep 2020 10:26:51 +0200 (CEST)
Date:   Thu, 17 Sep 2020 10:26:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200917082651.GA4595@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916153605.5253-1-ztong0001@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:36:05AM -0400, Tong Zhang wrote:
> if a nvme controller is not responding during probing, a use-after-free
> condition could happen

This now leaks the queue for the regular teardown path.
