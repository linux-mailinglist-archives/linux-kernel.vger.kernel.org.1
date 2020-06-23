Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F252050EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbgFWLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:40:22 -0400
Received: from verein.lst.de ([213.95.11.211]:38965 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732332AbgFWLkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:40:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0B8668AEF; Tue, 23 Jun 2020 13:40:18 +0200 (CEST)
Date:   Tue, 23 Jun 2020 13:40:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] mm: fix migrate_vma_setup() src_owner and
 normal pages
Message-ID: <20200623114018.GA17496@lst.de>
References: <20200622222008.9971-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622222008.9971-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:20:08PM -0700, Ralph Campbell wrote:
> The caller of migrate_vma_setup() does not know what type of page is
> stored in the CPU's page tables. Pages within the specified range are
> free to be swapped out, migrated, or freed until after migrate_vma_setup()
> returns. The caller needs to set struct migrate_vma.src_owner in case a
> page is a ZONE device private page that the device owns and might want to
> migrate. However, the current code skips normal anonymous pages if
> src_owner is set, thus preventing those pages from being migrated.
> Remove the src_owner check for normal pages since src_owner only applies
> to device private pages and allow a range of normal and device private
> pages to be migrated.

src_owner being set means we want to migrate from device private
memory to normal host DRAM.  What kind of problem do you see of
not touching already present pages in that path?
