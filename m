Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679172B1A11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKML3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgKML1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:27:50 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D947022240;
        Fri, 13 Nov 2020 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605266868;
        bh=1zomMHvWXcdsFEpY4sbXNcY1W66L8ptaoK6dS+ccIoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=an66mwndtupBdyKycEKWTmObkunIbRrerl5BGTN98MB9my5eCUcIfj7adhLNxHtJK
         msfwqP2bauhj2rsMGFDV7X2OOa2HY57rUERf+iaDB9p1AaMcy6nPivgirr3vgOkisR
         +a1SZflwyZuFCDOGNkxnJC7uQNoAjWkxFJL9cLnc=
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        martin.botka@somainline.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Marc Zyngier <maz@kernel.org>, marijn.suijten@somainline.org,
        Mark Brown <broonie@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andrew Scull <ascull@google.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 0/4] Add KRYO2XX Errata / mitigations data
Date:   Fri, 13 Nov 2020 11:27:36 +0000
Message-Id: <160526082925.1979134.2091241052935700050.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201104232218.198800-1-konrad.dybcio@somainline.org>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 00:22:09 +0100, Konrad Dybcio wrote:
> This series adds Spectre mitigations and errata data for
> Qualcomm KRYO2XX Gold (big) and Silver (LITTLE) series of
> CPU cores, used for example in MSM8998 and SDM660-series SoCs.
> 
> Konrad Dybcio (4):
>   arm64: Add MIDR value for KRYO2XX gold/silver CPU cores
>   arm64: kpti: Add KRYO2XX gold/silver CPU cores to kpti safelist
>   arm64: proton-pack: Add KRYO2XX silver CPUs to spectre-v2 safe-list
>   arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/4] arm64: Add MIDR value for KRYO2XX gold/silver CPU cores
      https://git.kernel.org/arm64/c/77473cffef21
[2/4] arm64: kpti: Add KRYO2XX gold/silver CPU cores to kpti safelist
      https://git.kernel.org/arm64/c/e3dd11a9f252
[3/4] arm64: proton-pack: Add KRYO2XX silver CPUs to spectre-v2 safe-list
      https://git.kernel.org/arm64/c/38328d401167
[4/4] arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver
      https://git.kernel.org/arm64/c/23c216416056

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
