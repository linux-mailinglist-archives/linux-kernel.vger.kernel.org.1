Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5022BA714
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgKTKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgKTKI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:08:58 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8A02222A;
        Fri, 20 Nov 2020 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605866938;
        bh=8OYpASKXTu9KPbeZYxIbchSINzj9CmWSfzZPFWd6tcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYKrmKnjY7+RymhKhb4/xJdJFl6FtyaMTSCgW7t2QWuMQ+CO4BxQGHV87sUCOlmPM
         2Dg27qNt6mg61w0KrKZVmtDjp1ijNvAtqycPcZwq5FGcfjY3/4/vhMygfzYBZImlgt
         OT7PLX1R0SOdKc/dj0K/iOq3a4BzJFHMnYfbBIJw=
Date:   Fri, 20 Nov 2020 15:38:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     mripard@kernel.org, wens@csie.org, krzk@kernel.org,
        colin.king@canonical.com, tiny.windzz@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] phy: sun4i-usb: Use power efficient workqueue for
 debounce and poll
Message-ID: <20201120100839.GH2925@vkoul-mobl>
References: <20201109121214.19012-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109121214.19012-1-frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-20, 20:12, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> The debounce and poll time is generally quite long and the work not
> performance critical so allow the scheduler to run the work anywhere
> rather than in the normal per-CPU workqueue.

Applied, thanks

-- 
~Vinod
