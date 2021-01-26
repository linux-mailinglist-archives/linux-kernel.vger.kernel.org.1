Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDBA303CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404964AbhAZLJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:09:21 -0500
Received: from verein.lst.de ([213.95.11.211]:46956 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhAZGju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:39:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D544F68B02; Tue, 26 Jan 2021 07:39:08 +0100 (CET)
Date:   Tue, 26 Jan 2021 07:39:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] mm/vmalloc: improve allocation failure error
 messages
Message-ID: <20210126063908.GE26674@lst.de>
References: <20210126045404.2492588-1-npiggin@gmail.com> <20210126045404.2492588-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126045404.2492588-6-npiggin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:54:04PM +1000, Nicholas Piggin wrote:
> There are several reasons why a vmalloc can fail, virtual space
> exhausted, page array allocation failure, page allocation failure,
> and kernel page table allocation failure.
> 
> Add distinct warning messages for the main causes of failure, with
> some added information like page order or allocation size where
> applicable.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
