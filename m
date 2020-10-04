Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53181282D3F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgJDTYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 15:24:42 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:44353 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgJDTYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:24:42 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 88F07CAFF1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 20:24:40 +0100 (IST)
Received: (qmail 16067 invoked from network); 4 Oct 2020 19:24:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Oct 2020 19:24:40 -0000
Date:   Sun, 4 Oct 2020 20:24:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] mm/vmscan: drop unneeded assignment in kswapd()
Message-ID: <20201004192437.GF3227@techsingularity.net>
References: <20201004125827.17679-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201004125827.17679-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 02:58:27PM +0200, Lukas Bulwahn wrote:
> The refactoring to kswapd() in commit e716f2eb24de ("mm, vmscan: prevent
> kswapd sleeping prematurely due to mismatched classzone_idx") turned an
> assignment to reclaim_order into a dead store, as in all further paths,
> reclaim_order will be assigned again before it is used.
> 
> make clang-analyzer on x86_64 tinyconfig caught my attention with:
> 
>   mm/vmscan.c: warning: Although the value stored to 'reclaim_order' is
>   used in the enclosing expression, the value is never actually read from
>   'reclaim_order' [clang-analyzer-deadcode.DeadStores]
> 
> Compilers will detect this unneeded assignment and optimize this anyway.
> So, the resulting binary is identical before and after this change.
> 
> Simplify the code and remove unneeded assignment to make clang-analyzer
> happy.
> 
> No functional change. No change in binary code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I'm not really keen on this. With the patch, reclaim_order can be passed
uninitialised to kswapd_try_to_sleep. While a sufficiently smart
compiler might be able to optimise how reclaim_order is used, it's not
guaranteed either. Similarly, a change in kswapd_try_to_sleep and its
called functions could rely on reclaim_order being a valid value and
then introduce a subtle bug.

-- 
Mel Gorman
SUSE Labs
