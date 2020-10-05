Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69A2831E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJEI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEI0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:26:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236292075A;
        Mon,  5 Oct 2020 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601886369;
        bh=Q6bpCS8F8w3+QNHcxdWg85Or0V7pIwMQIPCDJNBV7lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/c78Y7czRAZyZy0mdVpMcZVDpYjyq43EGMX4cfoLBxJmLojzgWfrPBRVTmuxIU9k
         +fmJWSf4jr0B7Po/SEulFcUG/8LAv7SeDHd9yAjGdiUbQu6U8GoZs+qekziEA9gLOe
         +BOIZh2q9HYC9drlfc9kJ9c7Qp5sh2OISbfAqxZ8=
Date:   Mon, 5 Oct 2020 09:26:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf: arm-cmn: fix less than zero check on
 unsigned dtc->irq
Message-ID: <20201005082603.GA23480@willie-the-truck>
References: <20201002154800.92607-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002154800.92607-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 04:48:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the failure check on dtc->irq is always false because
> dtc->irq is an unsigned int. Fix this by using a temporary signed
> int for the less than zero error check.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/perf/arm-cmn.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Cheers, but Gustavo beat you to it and I had a crack at a different fix
which should now be in -next:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=d9ef632fab9ba81b708763bcbcfdbea9a55c95d2

Will
