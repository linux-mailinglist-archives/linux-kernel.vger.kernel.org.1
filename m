Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCF2F818F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbhAORFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhAORFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:05:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5730222B3;
        Fri, 15 Jan 2021 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610730299;
        bh=laXPhcCLkTeAZvgHcd+qu4Tf9HBUf2C/0t1VIxtEP24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LC8Bzjyq6TsVcEcqEylU8ea/ctTXiXblbBKrDepV1Jtd8p/TI32bXx7zlFxujX6CB
         klKjTlVOvvhQSijoFemAesM4mbV0gvQHgP38FOsAb0PIHG4uup5jVWBJEgRb/+JfJ6
         Md7tA/+bf6z8kuZiF9NT94NYnjN8TZcZeV6uIVZGVF/9wZdPnOWJkmS43Mb1HnXmXV
         siXWWP2rcYI/dyyh/U23d2K1bgXfilPh6Kw63pHxFwGEvP4ILE87C0V9PSqRh3MjCV
         m4rYkfCh9fahfGBg1GYpuNvwuZ6IU0Q8LZe+t7YShMEGZmQ+i67yGdOTCZGvLrPlqX
         IxP+/r8NXJQBw==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: (subset) [PATCH] soc: samsung: pm_domains: Convert to regular platform driver
Date:   Fri, 15 Jan 2021 18:04:54 +0100
Message-Id: <161073026111.45158.8527116652734964268.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113110320.13149-1-m.szyprowski@samsung.com>
References: <CGME20210113110330eucas1p1e7efa719b5db55ccf3774450a8c1e452@eucas1p1.samsung.com> <20210113110320.13149-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 12:03:20 +0100, Marek Szyprowski wrote:
> When Exynos power domain driver was introduced, the only way to ensure
> that power domains will be instantiated before the devices which belongs
> to them was to initialize them early enough, before the devices are
> instantiated in the system. This in turn required not to use any platform
> device infrastructure at all, as there have been no way to ensure proper
> probe order between devices.
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: pm_domains: Convert to regular platform driver
      commit: 9fcdb21857cf42c0da7b9a929e6781eca557a2f5

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
