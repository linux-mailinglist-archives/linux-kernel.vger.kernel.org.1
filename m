Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1891F1C48C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEDVEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 17:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgEDVES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:04:18 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDC520721;
        Mon,  4 May 2020 21:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588626258;
        bh=uzln4Pud3znUaVLrXJ/2VBLassqd467HHBti1c0w4sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1D64umVPdKGTDrHCEl6UPZw+rkmnm7Wuv5L2nsENzpGvbO7Wql2rFPJk5bunNM9c
         NXgnaWayAG3aru9r7nPrB5S5O2+EzvX2rDdNNZ7ImJ8kZR4RzeMo5mEbjEGgGhKQG6
         u8SemSfFpY9zRYwL7RXKK2Dn9MiLfroD3YUXO3Oc=
From:   Will Deacon <will@kernel.org>
To:     James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_sdei: Drop check for /firmware/ node and always register driver
Date:   Mon,  4 May 2020 22:04:10 +0100
Message-Id: <158861396805.45075.3995796630639381619.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422122823.1390-1-sudeep.holla@arm.com>
References: <20200422122823.1390-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 13:28:23 +0100, Sudeep Holla wrote:
> As with most of the drivers, let us register this driver unconditionally
> by dropping the checks for presence of firmware nodes(DT) or entries(ACPI).
> 
> Further, as mentioned in the commit acafce48b07b ("firmware: arm_sdei:
> Fix DT platform device creation"), the core takes care of creation of
> platform device when the appropriate device node is found and probe
> is called accordingly.
> 
> [...]

Applied to arm64 (for-next/sdei), thanks!

[1/1] firmware: arm_sdei: Drop check for /firmware/ node and always register driver
      https://git.kernel.org/arm64/c/caf2cd610dbb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
