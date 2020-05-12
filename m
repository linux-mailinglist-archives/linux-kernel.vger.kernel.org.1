Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5781CFA49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgELQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:14:13 -0400
Received: from verein.lst.de ([213.95.11.211]:42018 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgELQON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:14:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9157D68C65; Tue, 12 May 2020 18:14:11 +0200 (CEST)
Date:   Tue, 12 May 2020 18:14:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nvmet: replace kstrndup() with kmemdup_nul()
Message-ID: <20200512161411.GC6049@lst.de>
References: <20200508115906.165223-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508115906.165223-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:59:06PM +0800, Chen Zhou wrote:
> It is more efficient to use kmemdup_nul() if the size is known exactly.
> 
> The doc in kernel:
> "Note: Use kmemdup_nul() instead if the size is known exactly."
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Thanks,

applied to nvme-5.8.
