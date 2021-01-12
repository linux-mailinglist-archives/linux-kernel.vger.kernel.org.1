Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3612F31CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbhALNcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbhALNcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:32:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E007420658;
        Tue, 12 Jan 2021 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610458292;
        bh=5o+aCPCpSqiGz9xluKpWXFyYXmEnp0O1fms7e2UXETc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7/EVKPNCZ1LzKjnpjT/VRpS9FLH0jM4794vNFpCN7ps474vBiGr5WJ4a1khw4gyf
         whyE83kdlrMcBBjwRyTUTp/D/U8zB8RoXAyVXF6V9ddvBY2emS5glhlvMpV2S6cTr1
         U4+qnQN0EjqL3LF+K0hCjnAs+RfngmdqXe39q4IXi2pG91NK+Nq4kbM2UzGWkDre9f
         2xORrriSyGP0qcdFhWDiDJVokVEXl/k8xUu8lYfV78ZXXQ8jDaJ70Q973J3oXPvSRT
         GZZdVAZmbGzdGAThd1Zsj3+jbrRpGgTsGHaBFUqSkvL/wpmwE/4pIsGGvYDqMXAqhz
         89aDhku5QthOA==
Date:   Tue, 12 Jan 2021 13:31:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rtmutex: remove useless parameter for
 rt_mutex_proxy_unlock
Message-ID: <20210112133127.GB9087@willie-the-truck>
References: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
 <1605257895-5536-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605257895-5536-3-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:58:12PM +0800, Alex Shi wrote:
> The parameter 'proxy_owner' isn't used, so could be removed.

Looks like the last user of this was removed in fffa954fb528 ("futex: Remove
rt_mutex_deadlock_account_*()").

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Peter Zijlstra <peterz@infradead.org> 
> Cc: Darren Hart <dvhart@infradead.org> 
> Cc: Will Deacon <will@kernel.org> 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  kernel/futex.c                  | 2 +-
>  kernel/locking/rtmutex.c        | 3 +--
>  kernel/locking/rtmutex_common.h | 3 +--
>  3 files changed, 3 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
