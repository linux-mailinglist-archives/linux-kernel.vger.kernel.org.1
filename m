Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660D32E9234
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbhADI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:56:42 -0500
Received: from verein.lst.de ([213.95.11.211]:56925 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADI4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:56:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87CFD68AFE; Mon,  4 Jan 2021 09:55:59 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:55:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] block: set .bi_max_vecs as actual allocated vector
 number
Message-ID: <20210104085559.GC28949@lst.de>
References: <20201230003255.3450874-1-ming.lei@redhat.com> <20201230003255.3450874-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230003255.3450874-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 08:32:53AM +0800, Ming Lei wrote:
> bvec_alloc() may allocate more bio vectors than requested, so set .bi_max_vecs as
> actual allocated vector number, instead of the requested number. This way can help
> fs build bigger bio because new bio often won't be allocated until the current one
> becomes full.

Overly long lines above.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
