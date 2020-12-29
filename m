Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D2E2E7208
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgL2QA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgL2QA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:00:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AD9820825;
        Tue, 29 Dec 2020 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609257617;
        bh=UY0F8C8PXD2aQqC7MeA07K0MtYI+wxDDyEtyC7Wf4uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XH0AD38XRStsu59+r8+Sk6e6ZpIPWEcDRIdLEmL5igS48EcX3aTEMxd47dJUTwZmV
         0yWpr1+bVKsVXne54tSVUPZqvAa0T04Nbw3XuOdfnlCD575Q7u50GYmGGSn8G5j0/0
         gbAhlxf8JAQu5xcEO9FEqvYRtGtXrVW7EV+xHxSWjkc9ffCGjKQ+O+jX/KTOyJyvK9
         jmzwMoO2FCXdTwqqd+nd7BwCEjFrpLBbMHHPBNxihNJ6yP/1OVfXzauDixzEuh4Lwu
         Wj3ZMlM9ZZK5fS1XqVepxrKWmU9CuvjaVQ6TxVQIi+nEsTyiRA++wXS82uFZzjT426
         KO2cm0C302nTg==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bongsu Jeon <bongsu.jeon@samsung.com>
Subject: Re: (subset) [PATCH] arm64: dts: exynos: correct S3FWRN5 NFC interrupt trigger level on TM2
Date:   Tue, 29 Dec 2020 17:00:05 +0100
Message-Id: <160925760099.16829.11304554114761168205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210211859.215047-1-krzk@kernel.org>
References: <20201210211859.215047-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 22:18:58 +0100, Krzysztof Kozlowski wrote:
> The S3FWRN5 datasheet describe the interrupt line as rising edge.  The
> current configuration as level high, could cause spurious interrupts.

Applied, thanks!

[1/1] arm64: dts: exynos: correct S3FWRN5 NFC interrupt trigger level on TM2
      commit: d497d07b74f05f01b9c8c85b6679c2df57ecbdb4

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
