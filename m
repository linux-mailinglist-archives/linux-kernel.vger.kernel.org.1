Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216B2D50F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgLJChF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgLJChF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:37:05 -0500
Date:   Wed, 9 Dec 2020 18:36:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607567785;
        bh=XvfNSBjtRQDwTQaWQYMVMSpT8H8nutp1mjAcQR7vP6Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z9i631HDe1R5jmoeOhXA3++25nKEC+BRYA5F0FDi7zEdV8m6hVveolSt2t+AYiDeb
         BrIfrbaAFU1attLpFoEnDkLbBp9A5TZCZpr0T6wTmAKOx7vq23trf36rOisG3LCu4g
         Iiw2tgeTCsbq69cGwJD84zvIoGWxj+a2L59ElcS4=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Zheng Zengkai <zhengzengkai@huawei.com>
Subject: Re: [PATCH -next] fs/ntfs: fix set but not used variable
 'log_page_mask'
Message-Id: <20201209183623.b26e90de3d0aa92a72010ff0@linux-foundation.org>
In-Reply-To: <94ED375C-C57C-464B-A1CA-BFB1EEF71BB2@tuxera.com>
References: <20200312041353.19877-1-zhengzengkai@huawei.com>
        <94ED375C-C57C-464B-A1CA-BFB1EEF71BB2@tuxera.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 08:24:02 +0000 Anton Altaparmakov <anton@tuxera.com> wrote:

> Can you please apply this?
>
> ...
>
> > --- a/fs/ntfs/logfile.c
> > +++ b/fs/ntfs/logfile.c
> > @@ -507,7 +507,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
> > 	 * optimize log_page_size and log_page_bits into constants.
> > 	 */
> > 	log_page_bits = ntfs_ffs(log_page_size) - 1;
> > -	size &= ~(s64)(log_page_size - 1);
> > +	size &= ~(s64)(log_page_mask);
> > 	/*
> > 	 * Ensure the log file is big enough to store at least the two restart
> > 	 * pages and the minimum number of log record pages.

https://lore.kernel.org/lkml/1604821092-54631-1-git-send-email-alex.shi@linux.alibaba.com/
addressed this?

