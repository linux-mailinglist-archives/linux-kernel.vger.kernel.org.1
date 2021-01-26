Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621D7303B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405018AbhAZLJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:09:35 -0500
Received: from verein.lst.de ([213.95.11.211]:46951 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388811AbhAZGjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:39:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 777A368C4E; Tue, 26 Jan 2021 07:38:51 +0100 (CET)
Date:   Tue, 26 Jan 2021 07:38:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] mm/vmalloc: remove unmap_kernel_range
Message-ID: <20210126063851.GD26674@lst.de>
References: <20210126045404.2492588-1-npiggin@gmail.com> <20210126045404.2492588-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126045404.2492588-5-npiggin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:54:03PM +1000, Nicholas Piggin wrote:
> This is a shim around vunmap_range, get rid of it.
> 
> Move the main API comment from the _noflush variant to the normal
> variant, and make _noflush internal to mm/.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
