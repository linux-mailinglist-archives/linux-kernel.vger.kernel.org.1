Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53F275048
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIWF37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:29:59 -0400
Received: from verein.lst.de ([213.95.11.211]:47222 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgIWF36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:29:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D2C167373; Wed, 23 Sep 2020 07:29:56 +0200 (CEST)
Date:   Wed, 23 Sep 2020 07:29:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Message-ID: <20200923052956.GA15063@lst.de>
References: <20200922062517.30031-1-tian.xianting@h3c.com> <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com> <20200922145842.GB28420@lst.de> <5099986543624f9fbbeb26c2173934ba@h3c.com> <20200922154105.GA31758@lst.de> <53ae0341e62346f985ca289c6325078d@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ae0341e62346f985ca289c6325078d@h3c.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:47:40PM +0000, Tianxianting wrote:
> Finally, it applied:)
> Thanks again for all your kindly guides to me.

Thanks a lot for the patch!
