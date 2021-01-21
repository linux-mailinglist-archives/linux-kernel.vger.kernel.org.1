Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885832FE38F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbhAUHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:13:07 -0500
Received: from verein.lst.de ([213.95.11.211]:59095 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbhAUHJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:09:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A8DE67357; Thu, 21 Jan 2021 08:08:35 +0100 (CET)
Date:   Thu, 21 Jan 2021 08:08:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     akpm@linux-foundation.org, hch@lst.de, dja@axtens.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Separate put pages and flush VM flags
Message-ID: <20210121070835.GA23327@lst.de>
References: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:41:18PM -0800, Rick Edgecombe wrote:
> When VM_MAP_PUT_PAGES was added, it was defined with the same value as
> VM_FLUSH_RESET_PERMS. This doesn't seem like it will cause any big
> functional problems other than some excess flushing for VM_MAP_PUT_PAGES
> allocations.
> 
> Redefine VM_MAP_PUT_PAGES to have its own value. Also, move the comment
> and remove whitespace for VM_KASAN such that the flags lower down are less
> likely to be missed in the future.
> 
> Fixes: b944afc9d64d ("mm: add a VM_MAP_PUT_PAGES flag for vmap")
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Ooops.  Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
