Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86233046C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390893AbhAZRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:20:23 -0500
Received: from verein.lst.de ([213.95.11.211]:46943 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387603AbhAZGjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:39:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1D7468BFE; Tue, 26 Jan 2021 07:38:17 +0100 (CET)
Date:   Tue, 26 Jan 2021 07:38:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] powerpc/xive: remove unnecessary unmap_kernel_range
Message-ID: <20210126063817.GC26674@lst.de>
References: <20210126045404.2492588-1-npiggin@gmail.com> <20210126045404.2492588-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126045404.2492588-4-npiggin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:54:02PM +1000, Nicholas Piggin wrote:
> iounmap will remove ptes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
