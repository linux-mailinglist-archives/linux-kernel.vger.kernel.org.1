Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32D2B255E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgKMU0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgKMU0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:21 -0500
Received: from localhost.localdomain (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883BC2078B;
        Fri, 13 Nov 2020 20:26:19 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, sudeep.holla@arm.com, mark.rutland@arm.com,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/3] arm64: cppc: add FFH support using AMUs
Date:   Fri, 13 Nov 2020 20:26:17 +0000
Message-Id: <160529906735.20198.6590820523478984130.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106125334.21570-1-ionela.voinescu@arm.com>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 12:53:31 +0000, Ionela Voinescu wrote:
> Many thanks for everyone's review.
> 
> This series adds support for CPPC's delivered and reference performance
> counters through the FFH methods by using the AMU equivalent core and
> constant cycle counters.
> 
> This support is added in patch 3/3, while the first 2 patches generalise
> the existing AMU counter read and validation functionality to be reused
> for this usecase.
> 
> [...]

Applied to arm64 (for-next/cppc-ffh), thanks!

[1/3] arm64: wrap and generalise counter read functions
      https://git.kernel.org/arm64/c/4b9cf23c179a
[2/3] arm64: split counter validation function
      https://git.kernel.org/arm64/c/bc3b6562a1ac
[3/3] arm64: implement CPPC FFH support using AMUs
      https://git.kernel.org/arm64/c/68c5debcc06d

I also applied the irq_disabled() abort as per Mark's comments:

      https://git.kernel.org/arm64/c/74490422522d

-- 
Catalin

