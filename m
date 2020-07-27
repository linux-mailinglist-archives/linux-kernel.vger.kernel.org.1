Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B589B22E538
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 07:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgG0FWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 01:22:54 -0400
Received: from verein.lst.de ([213.95.11.211]:41964 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgG0FWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:22:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6EA4D68B05; Mon, 27 Jul 2020 07:22:52 +0200 (CEST)
Date:   Mon, 27 Jul 2020 07:22:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kernel.h: Remove duplicate include of asm/div64.h
Message-ID: <20200727052252.GA949@lst.de>
References: <20200727034852.2813453-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727034852.2813453-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:48:52PM -0400, Arvind Sankar wrote:
> This seems to have been added inadvertently in commit
>   72deb455b5ec ("block: remove CONFIG_LBDAF")
> 
> Fixes: 72deb455b5ec ("block: remove CONFIG_LBDAF")
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Christoph Hellwig <hch@lst.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
