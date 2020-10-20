Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7EE2941C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408860AbgJTR5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408852AbgJTR5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:57:23 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC80722244;
        Tue, 20 Oct 2020 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603216642;
        bh=SOzbI8v4tKxmFoTBQOW5Gvk5G/F2F6ZWO2ejuOpcSP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2+vrf1CWc9od01aN5/G+sKeXMFQ5hXegR1hARF+6yBr/KiwC28hbclhQL246NvA+
         xQ9HjGdd6KU7j9XuBW074+AEtYHHFBFpEuoO46lKG68Fft1S7H5+d3Om6XDwDaGhms
         L/OzQjMAXgXMDvwU0/jE4vQlfj04BKSjBeZ2nW+A=
From:   Will Deacon <will@kernel.org>
To:     Will Deacon <willdeacon@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, nickhu@andestech.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>, green.hu@gmail.com,
        deanbo422@gmail.com
Subject: Re: [PATCH] arm64: Fix a broken copyright header in gen_vdso_offsets.sh
Date:   Tue, 20 Oct 2020 18:57:11 +0100
Message-Id: <160319358179.2175266.9755351535600425284.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201017002637.503579-1-palmer@dabbelt.com>
References: <20201017002637.503579-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 17:26:37 -0700, Palmer Dabbelt wrote:
> I was going to copy this but I didn't want to chase around the build
> system stuff so I did it a different way.

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: Fix a broken copyright header in gen_vdso_offsets.sh
      https://git.kernel.org/arm64/c/7bdf468a5b40

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
