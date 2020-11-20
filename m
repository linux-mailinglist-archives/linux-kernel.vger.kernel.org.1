Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57242BB0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgKTQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbgKTQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:36:39 -0500
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF4B2225B;
        Fri, 20 Nov 2020 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605890199;
        bh=+6bZltzFpZ4MwiZnSxxhZ/CseoiCy6+hsLiO8faWlD0=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=MY8zmLEe/QE0BdrC68uX0K1xuhy2SkkVHfqAsWtkwIek7Vx4oy5F2X7ccpA/vRITX
         XPmuL7T25W3RAdJAOSsNWh4ixSwSkWhRtJrGIpz4KdRXSzH8K/owd1QH8jt0Oq7MPB
         sowyb5FxdJg+lXQhrEhgwzPq1oZvxpLcMWwBxuSY=
Subject: Re: [PATCH] clk: samsung: allow compile testing of Exynos, S3C64xx
 and S5Pv210
To:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20201119164509.754851-1-krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <f44c5f4f-bda4-a1c1-dc6a-dc31efa314c6@kernel.org>
Date:   Fri, 20 Nov 2020 17:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119164509.754851-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 17:45, Krzysztof Kozlowski wrote:
> So far all Exynos, S3C64xx and S5Pv210 clock units were selected by
> respective SOC/ARCH Kconfig option.  On a kernel built for selected
> SoCs, this allowed to build only limited set of matching clock drivers.
> However compile testing was not possible in such case as Makefile object
> depent on SOC/ARCH option.

"objects depend" or "object depends" ?

> Add separate Kconfig options for each of them to be able to compile
> test.
> 
> Signed-off-by: Krzysztof Kozlowski<krzk@kernel.org>

The patch look good to me, thanks.
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I guess it's best now to merge it through your tree as it depends on 
patches already sent to arm-soc? Next time it might be better to use 
immutable branches right away to keep the clk changes in the clk 
maintainer's tree.

--
Regards,
Sylwester
