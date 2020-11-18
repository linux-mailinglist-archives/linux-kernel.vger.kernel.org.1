Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AA2B8601
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKRUtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:49:41 -0500
Received: from ms.lwn.net ([45.79.88.28]:46618 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgKRUtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:49:41 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C7FDF50A9;
        Wed, 18 Nov 2020 20:49:40 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:49:39 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] doc:it_IT: align Italian documentation
Message-ID: <20201118134939.5f1f46bb@lwn.net>
In-Reply-To: <20201114083342.13935-1-federico.vaga@vaga.pv.it>
References: <20201114083342.13935-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020 09:33:42 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Translation for the following patches
> 
> commit 0aa78b105f57 ("Documentation/changes: Raise minimum supported binutils version to 2.23")
> commit 7d7178873560 ("Documentation: include sign off for reverts")
> commit 905705a8fd43 ("docs: programming-languages: refresh blurb on clang support")
> commit 5ff4aa70bf34 ("docs: submitting-patches: use :doc: for references")
> commit 030f066f677f ("docs: submitting-patches: describe preserving review/test tags")
> commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element arrays")
> commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for kernel builds to 4.8")
> commit 5b5bbb8cc51b ("docs: process: Add an example for creating a fixes tag")
> commit 858e6845654d ("docs: dt: convert submitting-patches.txt to ReST format")
> commit cca73e4946c4 ("docs: Correct the release date of 5.2 stable")
> commit c170f2eb9648 ("docs: Document cross-referencing between documentation pages")
> commit 7c8b9e3000f8 ("kernel-doc: Update "cross-referencing from rST" section to use automarkup")
> commit 27def953b63b ("docs: deprecated.rst: Expand str*cpy() replacement notes")
> commit 17dca0502314 ("docs: deprecated.rst: Update zero-length/one-element arrays section")
> commit 3519c4d6e08e ("Documentation: add minimum clang/llvm version")
> commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
> commit 9f364b605f34 ("submitting-patches.rst: presume git will be used")
> commit 4ebdf7be21d6 ("Documentation/maintainer: rehome sign-off process")
> commit 7433ff33e8ba ("Documentation/process: expand plain-text advice")
> commit eb45fb2fb16d ("docs: process: Add cross-link to security-bugs")
> commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> commit f67281a72b30 ("Documentation: process: step 2: Link to email list fixed")
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied, thanks.

jon
