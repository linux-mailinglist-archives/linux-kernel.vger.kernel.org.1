Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9352E2B729D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgKQXqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:46:37 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgKQXqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:46:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CbMzF2x60z9sPB;
        Wed, 18 Nov 2020 10:46:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1605656793;
        bh=oMbUvmEwIV1erVGEeTb/ximWdVDTiuB2dVzFoifZbmA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=r9lvxBwKL2lvcH3aO/YmBX6QKSfdhqSdvs2+jYAXZfQGfMyi8gvbWF/wNKIqDt5+f
         UZLekQp2pC1C/BlLu7cGtTAGyLV0Y1dyTfJ2Ylq9WhvgIT4OemuO7rhB9CivqX+3OW
         xRVxWCN8/IDpFFNug+FQ7O82Uh9ZwS448JXg+ybVWjJx//manM1a+sANmvznk9bOwq
         o3vuyuq4WjSQ/9yUNsiZK0WPHTMYjz/Ox4qw554fIIiaT3fqHC6eJUFtUFKczetdCl
         4pv4/hsgn5Oi5gF6zkKO2ShBesne4UeWvEZkaDgZjqTDFwVHIWbAfszyu20a9p8lI0
         QjqeN8fhTy7yQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 3/3] powerpc: fix -Wimplicit-fallthrough
In-Reply-To: <20201116043532.4032932-4-ndesaulniers@google.com>
References: <20201116043532.4032932-1-ndesaulniers@google.com> <20201116043532.4032932-4-ndesaulniers@google.com>
Date:   Wed, 18 Nov 2020 10:46:32 +1100
Message-ID: <87lfez35t3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> The "fallthrough" pseudo-keyword was added as a portable way to denote
> intentional fallthrough. Clang will still warn on cases where there is a
> fallthrough to an immediate break. Add explicit breaks for those cases.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/236
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/powerpc/kernel/prom_init.c | 1 +
>  arch/powerpc/kernel/uprobes.c   | 1 +
>  arch/powerpc/perf/imc-pmu.c     | 1 +
>  3 files changed, 3 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
