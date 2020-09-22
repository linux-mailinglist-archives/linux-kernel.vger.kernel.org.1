Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116E62744DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:58:45 -0400
Received: from verein.lst.de ([213.95.11.211]:45015 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgIVO6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:58:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 18C7F67373; Tue, 22 Sep 2020 16:58:43 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:58:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Xianting Tian <tian.xianting@h3c.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Message-ID: <20200922145842.GB28420@lst.de>
References: <20200922062517.30031-1-tian.xianting@h3c.com> <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:57:05AM -0700, Keith Busch wrote:
> The commit subject is a too long. We should really try to keep these to
> 50 characters or less.
> 
>   nvme-pci: fix NULL req in completion handler
> 
> Otherwise, looks fine.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Yes.  I was about to apply it with a similar edit, but I'll take yours
happily.
