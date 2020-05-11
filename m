Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D181CE065
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 18:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgEKQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 12:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgEKQ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:28:01 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E269C2070B;
        Mon, 11 May 2020 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589214480;
        bh=dWnpFgb+Yx+pcGOYtWqzFL2thynqYWnO1OaoLx7QFcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1r5JMwQvUG65cvK8P/9WIeAwFKoXlUIJbPRdq5VFo9X6fs8fyFnAq6eXNviydjJT
         BdYV26bfkEKLslnf5ij/wG/z7Wq+aymrnC+HEO0ILvDX9cD1O6js758TulIe5Z3jcC
         vYWXDe7w28B73UGMgccD11aG5k8fcJQv1pEq4MyU=
From:   Will Deacon <will@kernel.org>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 1/2] arm64/crash_core: Export KERNELPACMASK in vmcoreinfo
Date:   Mon, 11 May 2020 17:27:54 +0100
Message-Id: <158920375123.230375.8898075017057814195.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589202116-18265-1-git-send-email-amit.kachhap@arm.com>
References: <1589202116-18265-1-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 18:31:55 +0530, Amit Daniel Kachhap wrote:
> Recently arm64 linux kernel added support for Armv8.3-A Pointer
> Authentication feature. If this feature is enabled in the kernel and the
> hardware supports address authentication then the return addresses are
> signed and stored in the stack to prevent ROP kind of attack. Kdump tool
> will now dump the kernel with signed lr values in the stack.
> 
> Any user analysis tool for this kernel dump may need the kernel pac mask
> information in vmcoreinfo to generate the correct return address for
> stacktrace purpose as well as to resolve the symbol name.
> 
> [...]

Applied to arm64 (for-next/ptr-auth), thanks!

[1/2] arm64/crash_core: Export KERNELPACMASK in vmcoreinfo
      https://git.kernel.org/arm64/c/203b1152d18c
[2/2] Documentation/vmcoreinfo: Add documentation for 'KERNELPACMASK'
      https://git.kernel.org/arm64/c/c0fc00ec6304

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
