Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513E22D5F97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391138AbgLJP0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:26:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388345AbgLJP0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:26:41 -0500
Date:   Thu, 10 Dec 2020 16:27:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607613956;
        bh=Z87RQdqpy2XtyEFtnNHNmScMTk7xWEhPFNzRQfi59Jo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfG1OQ67vXUAmcflpmV23jyB4Qbk4DTURf90ZMX6/7z+rNOuwKBE24AZ4XzdGHnx0
         qmDf3LVQzoBtFGkhP7HDuWwBwVUGitDu0eqgq+mjxprfM3YhbdqClOTSAkr2Xu+YBT
         CgPeCp5QtmCASkGbHxdbkhUETbxA+5o9i1cBPBwU=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yanjun Zhang <zhang.yanjuna@h3c.com>
Cc:     jirislaby@kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts: update the function comments about pty driver
Message-ID: <X9I+TtS6dq1c33ZX@kroah.com>
References: <20201209093405.28482-1-zhang.yanjuna@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209093405.28482-1-zhang.yanjuna@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 05:34:05PM +0800, Yanjun Zhang wrote:
> Update the function comments to match the code modified by 
> commit 8ead9dd54716 ("devpts: more pty driver interface cleanups")
> 
> Signed-off-by: Yanjun Zhang <zhang.yanjuna@h3c.com>
> ---
>  drivers/tty/pty.c    |  2 ++
>  drivers/tty/tty_io.c |  1 +
>  fs/devpts/inode.c    | 15 +++++++--------
>  3 files changed, 10 insertions(+), 8 deletions(-)

This patch fails to apply to the tree :(

