Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070B61A2F06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 08:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIGJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 02:09:14 -0400
Received: from verein.lst.de ([213.95.11.211]:45272 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgDIGJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:09:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C1FD68C4E; Thu,  9 Apr 2020 08:09:12 +0200 (CEST)
Date:   Thu, 9 Apr 2020 08:09:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/28] mm: remove vmalloc_user_node_flags
Message-ID: <20200409060911.GA30101@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200409040645.14400-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409040645.14400-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:06:45PM +0800, Hillf Danton wrote:
> > -	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
> > +	const gfp_t gfp = __GFP_NOWARN | __GFP_ZERO;

> > +
> > +	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
> > +			gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL, PAGE_KERNEL,
> 
> Dunno if __GFP_ZERO needs to be added to match the current 
> vmalloc_user_node_flags().

__GFP_ZERO is already included in "gfp".
