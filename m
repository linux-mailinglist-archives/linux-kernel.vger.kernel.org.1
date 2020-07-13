Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6AE21D68F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgGMNPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 09:15:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgGMNPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:15:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3B45B58E;
        Mon, 13 Jul 2020 13:15:11 +0000 (UTC)
Date:   Mon, 13 Jul 2020 15:15:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Bruno Meneguele <bmeneg@redhat.com>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, Jason@zx2c4.com
Subject: Re: [PATCH v2] doc:kmsg: explictly state the return value in case of
 SEEK_CUR
Message-ID: <20200713131509.GC20226@alley>
References: <20200710174423.10480-1-bmeneg@redhat.com>
 <20200713022558.GC491026@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713022558.GC491026@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-07-13 11:25:58, Sergey Senozhatsky wrote:
> On (20/07/10 14:44), Bruno Meneguele wrote:
> > The commit 625d3449788f ("Revert "kernel/printk: add kmsg SEEK_CUR
> > handling"") reverted a change done to the return value in case a SEEK_CUR
> > operation was performed for kmsg buffer based on the fact that different
> > userspace apps were handling the new return value (-ESPIPE) in different
> > ways, breaking them.
> > 
> > At the same time -ESPIPE was the wrong decision because kmsg /does support/
> > seek() but doesn't follow the "normal" behavior userspace is used to.
> > Because of that and also considering the time -EINVAL has been used, it was
> > decided to keep this way to avoid more userspace breakage.
> > 
> > This patch adds an official statement to the kmsg documentation pointing to
> > the current return value for SEEK_CUR, -EINVAL, thus userspace libraries
> > and apps can refer to it for a definitive guide on what to expect.
> > 
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> 
> Looks good to me,
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch is committed in printk/linux.git, branch for-5.9.

Thanks for v2.

Best Regards,
Petr
