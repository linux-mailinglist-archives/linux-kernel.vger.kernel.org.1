Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185E628F053
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgJOKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgJOKrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:47:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1F322249;
        Thu, 15 Oct 2020 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602758821;
        bh=JORSMXuLZECMsQ20vdk1LTRYQd21BOsebzWiUTtOOx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqe5eNssYqdesVBxC1vNpS4kTT0TwoLRgtYpAYyDF5tH6FsYiCrVMv44mysAMrqvf
         YoppYES+Lqz6O6phiUoRGlCygxdHQ95C5HLb6NLbn5+bJwr9wmR+7I+s1X3WsWcm9D
         s1ThlWiuTseLmF7J7/ST0l+yazhfrXIUm3YUgryg=
Date:   Thu, 15 Oct 2020 11:46:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atomics.tbl: Remove executable permission bits
Message-ID: <20201015104656.GC5064@willie-the-truck>
References: <03974c13efba564224284cf3fe87fe955dbfa27f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03974c13efba564224284cf3fe87fe955dbfa27f.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:34:06PM -0700, Joe Perches wrote:
> commit 4d8e5cd233db ("locking/atomics: Fix scripts/atomic/ script permissions")
> set all files in this directory executable.
> 
> But this file is an input to those scripts and does not need to be executable.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/atomic/atomics.tbl | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
> old mode 100755
> new mode 100644

Acked-by: Will Deacon <will@kernel.org>

Will
