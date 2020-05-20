Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199751DBC06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgETRyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:54:44 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04AE4206B6;
        Wed, 20 May 2020 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997284;
        bh=EV94N2IIkGZzV+14r1rugh4SSd9XfTPJ8E4cS0nEkS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfHXIMvbuOyN/UvyyunVQAwg5AvLKmQ653t5+gRzkHhMBCkJIXahw7D++Novj8c3X
         sq9SqqgPBsADAQpz81mVYWr+VrQKGsyYBH90xFtxmCvs00LWkdmL4Y1EFpXqjZ0DlI
         0DQOS/Sp9rvnHsg4w+pc7x5n3FVyaE5js6ccjj8E=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V2] arm64/cpufeature: Drop open encodings while extracting parange
Date:   Wed, 20 May 2020 18:54:36 +0100
Message-Id: <158999641420.123499.9803666962947435393.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
References: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 14:33:34 +0530, Anshuman Khandual wrote:
> Currently there are multiple instances of parange feature width mask open
> encodings while fetching it's value. Even the width mask value (0x7) itself
> is not accurate. It should be (0xf) per ID_AA64MMFR0_EL1.PARange[3:0] as in
> ARM ARM (0487F.a). Replace them with cpuid_feature_extract_unsigned_field()
> which can extract given standard feature (4 bits width i.e 0xf mask) field.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeature: Drop open encodings while extracting parange
      https://git.kernel.org/arm64/c/f73531f0257f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
