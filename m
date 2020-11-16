Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B042B3DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgKPHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgKPHqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:46:02 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63F92225E;
        Mon, 16 Nov 2020 07:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605512761;
        bh=fudZEZzC9a0LKol7stpMLlrGRe4KporUeem6OysK/i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQn7drBeQbxJfK3Qfmz6n31/F1ZsJGPiIehminca4qJt+LfIeap4BAl7F1eLygLJV
         JkgyKljX5wrqeQRKvCzgp874XdB5mbJ9of67TotVXIM5sXWV3dwDc7GDICe8Lf73fJ
         bkRiMJhPfTRBs0vPVoEvpVbXZo+IPEIRNbEt/POM=
Date:   Mon, 16 Nov 2020 09:45:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH v2] mm: memblock: add more debug logs
Message-ID: <20201116074555.GA4758@kernel.org>
References: <1605501844-22390-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605501844-22390-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:14:04AM +0530, Faiyaz Mohammed wrote:
> It is useful to know the exact caller of memblock_phys_alloc_range() to
> track early memory reservations during development.
> 
> Currently, when memblock debugging is enabled, the allocations done with
> memblock_phys_alloc_range() are only reported at memblock_reserve():
> 
> [    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188
> 
> Add memblock_dbg() to memblock_phys_alloc_range() to get details about
> its usage.
> 
> For example:
> 
> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 early_pgtable_alloc+0x24/0x178
> [    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>

Applied, thanks!

