Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77961A25BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgDHPnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:43:06 -0400
Received: from verein.lst.de ([213.95.11.211]:42937 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgDHPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:43:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2262D68C4E; Wed,  8 Apr 2020 17:43:04 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:43:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Message-ID: <20200408154303.GB28676@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408135240.6528-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408135240.6528-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:52:40PM +0800, Hillf Danton wrote:
> 
> On Wed,  8 Apr 2020 13:59:15 +0200 Christoph Hellwig wrote:
> > 
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -474,7 +474,7 @@ _xfs_buf_map_pages(
> >  		nofs_flag = memalloc_nofs_save();
> >  		do {
> >  			bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
> > -						-1, PAGE_KERNEL);
> > +						-1);
> s/-1/NUMA_NO_NODE/

Not really relevant to this series, but otherwise agreed.
