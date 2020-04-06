Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05419F666
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 15:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgDFNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 09:05:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58059 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgDFNFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:05:37 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48wrPV2nPkz9sSJ; Mon,  6 Apr 2020 23:05:34 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 60083063b755e29685902609e024ecd0c4a1a7d9
In-Reply-To: <20200213083804.24315-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/time: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Message-Id: <48wrPV2nPkz9sSJ@ozlabs.org>
Date:   Mon,  6 Apr 2020 23:05:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-13 at 08:38:04 UTC, Geert Uytterhoeven wrote:
> The PowerPC time code is not a clock provider, and just needs to call
> of_clk_init().
> 
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> 
> Remove the #ifdef protecting the of_clk_init() call, as a stub is
> available for the !CONFIG_COMMON_CLK case.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/60083063b755e29685902609e024ecd0c4a1a7d9

cheers
