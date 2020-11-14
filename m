Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84002B2CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 11:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKNKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 05:21:39 -0500
Received: from verein.lst.de ([213.95.11.211]:50018 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgKNKVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:21:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AC5968AFE; Sat, 14 Nov 2020 11:21:33 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:21:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 13/16] mm: Pass pvec directly to find_get_entries
Message-ID: <20201114102133.GN19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-14-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:38PM +0000, Matthew Wilcox (Oracle) wrote:
> +	pvec->nr = ret;
>  	return ret;

Do we need to return the number of found entries in addition to storing
it in the pagevec?
