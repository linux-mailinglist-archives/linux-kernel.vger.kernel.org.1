Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26C2B3DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgKPHwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPHwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:52:00 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6FCB206D8;
        Mon, 16 Nov 2020 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605513119;
        bh=kIDHVv2Ym+BUKnQTKS5yXXz7Bo9fBdvlozH3Mp6LzZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYn5MyHDC+hMuypGUTjD4UlI/0ltk6q0YIK5KJEt4NeUniKmUl4F4TAgJKfoA+Q+G
         VsdYsMhR7Rf/i/aoLRxZiIgtQjyuJc9M/ZA8i1YTBj4LRYsl5JTmJRUndGwe1uAoY9
         nk2s2gD+kH8zk4NfN48hqgzMjhY/0fMp4UfSuqfY=
Date:   Mon, 16 Nov 2020 13:21:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mediatek: fix spelling mistake in Kconfig "veriosn"
 -> "version"
Message-ID: <20201116075155.GR7499@vkoul-mobl>
References: <20201114120518.416120-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114120518.416120-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-20, 12:05, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig. Fix it.

Applied, thanks

-- 
~Vinod
