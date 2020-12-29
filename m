Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4266A2E71F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 16:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgL2PvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 10:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgL2PvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 10:51:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D92420825;
        Tue, 29 Dec 2020 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609257032;
        bh=idGHe6XgGrHrozlc5y1HPIckvhMG9YuWl1lvsglwhz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAi10HZxlh4JvE6fYT9TDJ0pHxU5GT7r8p0bBUvlz1wEJEUCxBhnk+kenRazJmZ2G
         f+GEUAzurFkyDHoj8j0VuH/5A6OqHKpYoTxvQpJVVb91FAdSgRIBQWyowG6RkQ3HT2
         PrmsZk29tuX+i8emiWw+n3VrX2B00kU9pqhRHDUZ5os+gAtJQzRAQ8OeA6+35JPbcK
         81pU/Ux9zGZlWCJlM1ik6gzsa6Y4MLcfhpehHakAOk5Ne0xKnQTHfjt2RNj/BW5n9w
         AvuhpzOZ8/Z06J/fLpOq5YsoNs1nd2hb5W9uPa6oyoNtTFPLZNeLPr7mOrp+P4o0sU
         jNG/t6e40K4jg==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>
Subject: Re: (subset) [PATCH 0/2] Fix USB2 PHY operation on Exynos542x
Date:   Tue, 29 Dec 2020 16:50:21 +0100
Message-Id: <160925691513.14694.5573678403811317177.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120085637.7299-1-m.szyprowski@samsung.com>
References: <CGME20201120085651eucas1p1382e2677b29af0fc94a0b6c1f8d7da12@eucas1p1.samsung.com> <20201120085637.7299-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 09:56:35 +0100, Marek Szyprowski wrote:
> This patchset finally fixes the last remaining issue related to the
> system suspend/resume on Odroid XU3/XU4/HC1 board family. It can be
> observed that system suspend/resume fails on XU4/HC1 when kernel is
> compiled from multi_v7_defconfig. Chaning the configuration a bit -
> switching Exynos USB2 PHY driver to be built-in surprisingly fixed that
> issue. An investigation revealed that the Exynos USB2 PHY driver poked
> wrong registers in the PMU area on Exynos5420 SoCs breaking the USB3.0
> DRD PHY operation, what caused the suspend failure. Fix this by learning
> the Exynos USB2 PHY driver about the Exynos5420 variant.
> 
> [...]

Applied, thanks!

[2/2] ARM: dts: exynos: use Exynos5420 dedicated USB2 PHY compatible
      commit: 75681980c4e3d89c55b5b8f20b8f4c1aace601be

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
