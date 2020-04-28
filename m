Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B39F1BC1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgD1OuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 10:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgD1OuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:50:00 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7770C206D6;
        Tue, 28 Apr 2020 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588085399;
        bh=KQVhaFJwaQDI1LQ4GB7LyZpVuA9l1lrKtbwaO9ObaOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbNi47LSVdZKZiCKx5OXieBgFz0DUjpnCJw+d8ky+EBGf/9hMTjEH5FQdSwfpa4dz
         dVo8xHQgEcPIUhqEjBh0wR0hxCG1DDXBQZg/IaeTxSJQM/iBVtvBqUrSyeB4Lgof7O
         wIjlNWqIjUTtMeeXcGO5/k0pZ+DkMhnzJRVdj1OE=
From:   Will Deacon <will@kernel.org>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lkml@sdf.org, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2] arm64: kexec_file: Avoid temp buffer for RNG seed
Date:   Tue, 28 Apr 2020 15:49:39 +0100
Message-Id: <158807855142.208424.6865350866606582490.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330173801.GA9199@SDF.ORG>
References: <202003281643.02SGhMtr029198@sdf.org> <20200330133701.GA10633@willie-the-truck> <20200330173801.GA9199@SDF.ORG>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 17:38:01 +0000, George Spelvin wrote:
> After using get_random_bytes(), you want to wipe the buffer
> afterward so the seed remains secret.
> 
> In this case, we can eliminate the temporary buffer entirely.
> fdt_setprop_placeholder() returns a pointer to the property value
> buffer, allowing us to put the random data directly in there without
> using a temporary buffer at all.  Faster and less stack all in one.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: kexec_file: Avoid temp buffer for RNG seed
      https://git.kernel.org/arm64/c/99ee28d99607

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
