Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEEC302858
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbhAYRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:00:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:46948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbhAYQ6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:58:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37825AD4E;
        Mon, 25 Jan 2021 16:58:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 98B781E14B4; Mon, 25 Jan 2021 17:58:09 +0100 (CET)
Date:   Mon, 25 Jan 2021 17:58:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: release buffer head before return
Message-ID: <20210125165809.GK1175@quack2.suse.cz>
References: <20210118120455.118955-1-bianpan2016@163.com>
 <20210118144123.GC19606@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118144123.GC19606@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-01-21 15:41:23, Jan Kara wrote:
> On Mon 18-01-21 04:04:55, Pan Bian wrote:
> > Release the buffer header before returning error code.
> > 
> > Fixes: 2deb1acc653c ("isofs: fix access to unallocated memory when reading corrupted filesystem")
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> OK, good spotting. But the other hunk in commit 2deb1acc653c seems to have
> the same problem so we might fix it as well when we are at it?

OK, I did this myself and picked the patch to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
