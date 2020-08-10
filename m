Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7E240792
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgHJO0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 10:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgHJO0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:26:41 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506F22070B;
        Mon, 10 Aug 2020 14:26:39 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gregory Herrero <gregory.herrero@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] recordmcount: Fix build failure on non arm64
Date:   Mon, 10 Aug 2020 15:26:37 +0100
Message-Id: <159706958035.25067.17604192727592443780.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <5ca1be21fa6ebf73203b45fd9aadd2bafb5e6b15.1597049145.git.christophe.leroy@csgroup.eu>
References: <5ca1be21fa6ebf73203b45fd9aadd2bafb5e6b15.1597049145.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 08:48:22 +0000 (UTC), Christophe Leroy wrote:
> Commit ea0eada45632 leads to the following build failure on powerpc:
> 
>   HOSTCC  scripts/recordmcount
> scripts/recordmcount.c: In function 'arm64_is_fake_mcount':
> scripts/recordmcount.c:440: error: 'R_AARCH64_CALL26' undeclared (first use in this function)
> scripts/recordmcount.c:440: error: (Each undeclared identifier is reported only once
> scripts/recordmcount.c:440: error: for each function it appears in.)
> make[2]: *** [scripts/recordmcount] Error 1
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] recordmcount: Fix build failure on non arm64
      https://git.kernel.org/arm64/c/3df14264ad99

-- 
Catalin

