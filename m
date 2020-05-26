Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074D61D8B61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgERXEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgERXEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:04:32 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E8B8207ED;
        Mon, 18 May 2020 23:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843072;
        bh=lrFNLpW8KhYy18+5zt78mNnTXnB06Ha6B7EMQ8Ew1kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWpoxrgPDf7dHjixCPxuo1Su1pauZNr02N4tTNozX2hUN/540HjmaC0K1kG3jKhaB
         9Ox9BcHZdgsvrPOlZvZOvy2c6CqmdwH5J+gUZpdzTbcTjfT3omagoaIg20l8Iye4eI
         KHJ9xy5WlX37vdnwk31MsMLcKJHaZuqphRw62ENQ=
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, 0x7f454c46@gmail.com,
        hewenliang4@huawei.com, lorenzo.pieralisi@arm.com,
        Dave.Martin@arm.com, hushiyuan@huawei.com, tglx@linutronix.de,
        mark.rutland@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: stacktrace: Factor out some common code into on_stack()
Date:   Tue, 19 May 2020 00:04:10 +0100
Message-Id: <158982146278.388.8558956941501712685.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <07b3b0e6-3f58-4fed-07ea-7d17b7508948@huawei.com>
References: <07b3b0e6-3f58-4fed-07ea-7d17b7508948@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 11:15:45 +0800, Yunfeng Ye wrote:
> There are some common codes for stack checking, so factors it out into
> the function on_stack().
> 
> No functional change.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: stacktrace: Factor out some common code into on_stack()
      https://git.kernel.org/arm64/c/bd4298c72b56

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
