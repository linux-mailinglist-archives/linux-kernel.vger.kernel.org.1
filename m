Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610F1268F15
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgINPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgINPHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:07:35 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52CA20829;
        Mon, 14 Sep 2020 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600096055;
        bh=V3/far4j5J/ompVAq3Gu1Xzbic6PsatK795CwgtYLtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvLNo2OdWWgeMdGtk0Ym99FxTC82IleK73rFwU+2z0OWokNTygXXjHcdI8TdvkHCM
         /8hxRe2eU5LHkBi2JWgRHb6mirJrDewWw3BeyZy8FPsm4sOX1/sMaYGVWtyNkv3fPh
         Htklbwaj+1QdGw9M8FVvTwquub29NbefPUy/Bjds=
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v2] arm64/mm: Refactor {pgd, pud, pmd, pte}_ERROR()
Date:   Mon, 14 Sep 2020 16:07:28 +0100
Message-Id: <160008622201.2014428.16589477357188793973.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200913234730.23145-1-gshan@redhat.com>
References: <20200913234730.23145-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 09:47:30 +1000, Gavin Shan wrote:
> The function __{pgd, pud, pmd, pte}_error() are introduced so that
> they can be called by {pgd, pud, pmd, pte}_ERROR(). However, some
> of the functions could never be called when the corresponding page
> table level isn't enabled. For example, __{pud, pmd}_error() are
> unused when PUD and PMD are folded to PGD.
> 
> This removes __{pgd, pud, pmd, pte}_error() and call pr_err() from
> {pgd, pud, pmd, pte}_ERROR() directly, similar to what x86/powerpc
> are doing. With this, the code looks a bit simplified either.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Refactor {pgd, pud, pmd, pte}_ERROR()
      https://git.kernel.org/arm64/c/2cf660eb81e9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
