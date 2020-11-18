Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486232B7F48
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKROT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKROT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:19:27 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91C12224C;
        Wed, 18 Nov 2020 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605709166;
        bh=XaegP8rxhA8VE/0u0GXID8TSpZ649eq+1cG8xQqz9bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y54VpLCzQc7w3YFE0LnOfIil7sxmOJJXGIhJ5qPvx/+0zFL/tH5WIiy+VqD7RQWoV
         sblXk682vha3Sf+XiVK5cHdGqqK1ip98g+2cVmhx82ai4Svch0//sDgZgk6zumsb1u
         rajRTndmSQNKh65rb5+ErD4Unz/d1CFcrmDgnCiE=
From:   Will Deacon <will@kernel.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        tboot-devel@lists.sourceforge.net, mingo@redhat.com,
        x86@kernel.org, ning.sun@intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, bp@alien8.de, tglx@linutronix.de
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init fail in tboot system
Date:   Wed, 18 Nov 2020 14:19:20 +0000
Message-Id: <160570494826.3611054.1738553498825865068.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:19:08 +0800, Zhenzhong Duan wrote:
> "intel_iommu=off" command line is used to disable iommu but iommu is force
> enabled in a tboot system for security reason.
> 
> However for better performance on high speed network device, a new option
> "intel_iommu=tboot_noforce" is introduced to disable the force on.
> 
> By default kernel should panic if iommu init fail in tboot for security
> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> 
> [...]

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/vt-d: Avoid panic if iommu init fails in tboot system
      https://git.kernel.org/arm64/c/4d213e76a359

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
