Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121EC2CFBF9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgLEQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 11:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgLEOy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 09:54:28 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 1/2] soc: samsung: exynos-chipid: order list of SoCs by name
Date:   Sat,  5 Dec 2020 15:12:48 +0100
Message-Id: <160717754142.10331.18160954059931033105.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202195955.128633-1-krzk@kernel.org>
References: <20201202195955.128633-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 21:59:54 +0200, Krzysztof Kozlowski wrote:
> Bring some order to the list of SoCs.  No functional change.

Applied, thanks!

[1/2] soc: samsung: exynos-chipid: order list of SoCs by name
[2/2] soc: samsung: exynos-chipid: initialize later - with arch_initcall
      commit: 3b4c362e5ef102ca2d70d33f4e8cf0780053a7db

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
