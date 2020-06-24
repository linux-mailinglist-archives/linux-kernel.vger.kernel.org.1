Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436BB207B67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 20:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406054AbgFXSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 14:20:54 -0400
Received: from verein.lst.de ([213.95.11.211]:45518 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406031AbgFXSUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:20:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DE7968B02; Wed, 24 Jun 2020 20:20:51 +0200 (CEST)
Date:   Wed, 24 Jun 2020 20:20:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Call sysctl_head_finish on error
Message-ID: <20200624182051.GA26405@lst.de>
References: <20200624181707.GS21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624181707.GS21350@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:17:07PM +0100, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This error path returned directly instead of calling sysctl_head_finish().

Looks good.  But if you touch this anyway we also need to add the extra
byte to count for the write case (see the memdup_user_nul implementation).
