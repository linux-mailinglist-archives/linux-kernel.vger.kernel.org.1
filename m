Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E971E4234
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgE0MZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 08:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0MZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:25:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E31207D8;
        Wed, 27 May 2020 12:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590582356;
        bh=CI6ZUH/O6aqTBvIkDI9U0uYsW6TAdMGrPW9I0KuSBzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giXOSsWX1tfeRC3y3wfvOE+KqNzme8wtOZsQnCY1sOb8X/fCmLyEEsU3Tt2k+FOfI
         GCo257OUf98XszZXQOw2E5xzYd2R8ssR+SMZwhDIT9w5EHCc51xXHQkICKVmdPZHrm
         5sDRTzAfjXMOeyOaOjOrnOieRFZ/fg5Q5vO6bt74=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, suzuki.poulose@arm.com
Subject: Re: [PATCH V3] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
Date:   Wed, 27 May 2020 13:25:49 +0100
Message-Id: <159057996975.77588.7036217455816555869.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1590573876-19120-1-git-send-email-anshuman.khandual@arm.com>
References: <1590573876-19120-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 15:34:36 +0530, Anshuman Khandual wrote:
> There is no way to proceed when requested register could not be searched in
> arm64_ftr_reg[]. Requesting for a non present register would be an error as
> well. Hence lets just WARN_ON() when search fails in get_arm64_ftr_reg()
> rather than checking for return value and doing a BUG_ON() instead in some
> individual callers. But there are also caller instances that dont error out
> when register search fails. Add a new helper get_arm64_ftr_reg_nowarn() for
> such cases.

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
      https://git.kernel.org/arm64/c/3577dd37c703

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
