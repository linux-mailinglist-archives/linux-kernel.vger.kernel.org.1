Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7AE2FF355
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhAUSjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:39:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbhAUS1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:27:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3098423A40;
        Thu, 21 Jan 2021 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611253604;
        bh=QysK3//OaVDkByWt5f/lEPJXTvpY0D3NLUd5u1I8rOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hu+4lv60UhIAlVXcvc3D4Kg9gtw9J1PRjsUA7Z8LEj0vuIKkPbQDJZd9xQyyTLdPU
         XCJu6XFFBzLQoCqr6f7oOc4BZWadyCq0XaaCsdxSO+ZYTk6MrdtfKd3CRMcp+Iqxi9
         yXkGiTrW0FJO5nbVNSGD8U7aTlAilCpWMqZ+V5BqDDWIrbG352aLGLtnav4yD28Wde
         vWlTyCrV0RWWQMF4atqRLAWcgms5zD+EP4VFLlr5k5DicoHkx1hzRX4sIksaVtafUm
         9Efi+4WAPY/s9IQNx/x5TZYx16M/q6fkHDBxxtrq8Q2QE9JxtE79toavHFkcRvKaFw
         n1rlXAp9aJhcA==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
Date:   Thu, 21 Jan 2021 18:26:39 +0000
Message-Id: <161125239746.2653965.4342337503570976678.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1611206601.git.sudaraja@codeaurora.org>
References: <cover.1611206601.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 21:29:12 -0800, Sudarshan Rajagopalan wrote:
> This patch is the follow-up from the discussions in the thread [1].
> Reducing the section size has the merit of reducing wastage of reserved memory
> for vmmemmap mappings for sections with large memory holes. Also with smaller
> section size gives more grunularity and agility for memory hot(un)plugging.
> 
> But there are also constraints in reducing SECTION_SIZE_BIT:
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
      https://git.kernel.org/arm64/c/f0b13ee23241

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
