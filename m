Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8D1DD10C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgEUPUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 11:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbgEUPUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:20:09 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D7120721;
        Thu, 21 May 2020 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590074409;
        bh=VBHf/uwr9lVUGNN4guQrPlWpSAkPwFVKYMF0nx/qEf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNZpuo0s+QAkT1PVqY2bgohTDbUXm3WcmnYR9HKTaONoJ5ZdEUxBB4jj6Hn2CKyCK
         WBVQ/37AWr11YRcpYt9BnZldDlmN49hfPfiLm3Dj7y91a0RLJ8XxXiZFnitp7y7QaM
         GyE9pGj2NSVwl2KIOOlhC4p1mpZqHJfzsCDh29O8=
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Price <steven.price@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: smccc: Fix missing prototype warning for arm_smccc_version_init
Date:   Thu, 21 May 2020 16:19:59 +0100
Message-Id: <159006645790.155638.4933300366215582782.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521110836.57252-1-sudeep.holla@arm.com>
References: <20200521110836.57252-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 12:08:36 +0100, Sudeep Holla wrote:
> Commit f2ae97062a48 ("firmware: smccc: Refactor SMCCC specific bits into
> separate file") introduced the following build warning:
> 
> drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for
> 	function 'arm_smccc_version_init' [-Wmissing-prototypes]
>  void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
>              ^~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/smccc), thanks!

[1/1] firmware: smccc: Fix missing prototype warning for arm_smccc_version_init
      https://git.kernel.org/arm64/c/269fd61e15d7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
