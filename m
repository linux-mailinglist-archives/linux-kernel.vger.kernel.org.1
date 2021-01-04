Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51C2EA0EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbhADXeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbhADXeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:34:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79EB022286;
        Mon,  4 Jan 2021 23:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609803214;
        bh=QAOQZTl/XC6cCUB+ppcK623n++34N2sso+HmUuS+NKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AmtRy2OBEKXkVl/pql/O8Rw/uvhd7Ryld1OE4VDPPWSvED+rd7Sz8XRwH4fXz6Vu8
         FieE3Rwzx00/Xbo57v78SLJ0FpLtq/4WoLimkTllvL6CMYMkaXpcOhAGAZ5FYRehPI
         yGdwLDlHOXt1pCRAYwH9Pi+J1HR2c8THbTNyMXHU=
Date:   Mon, 4 Jan 2021 15:33:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with
 clang
Message-Id: <20210104153333.4b6c7ae49edc4182d53bd17f@linux-foundation.org>
In-Reply-To: <20210104223336.GA2562866@ubuntu-m3-large-x86>
References: <20201230154749.746641-1-arnd@kernel.org>
        <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
        <20210104223336.GA2562866@ubuntu-m3-large-x86>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jan 2021 15:33:36 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:

> > > +++ b/lib/Kconfig.ubsan
> > > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> > >
> > >  config UBSAN_UNSIGNED_OVERFLOW
> > >         bool "Perform checking for unsigned arithmetic overflow"
> > > +       # clang hugely expands stack usage with -fsanitize=object-size
> > 
> > This is the first time -fsanitize=object-size is mentioned. Typo?
> 
> Copy and paste issue from CONFIG_UBSAN_OBJECT_SIZE

This?

--- a/lib/Kconfig.ubsan~ubsan-disable-unsigned-integer-overflow-sanitizer-with-clang-fix
+++ a/lib/Kconfig.ubsan
@@ -122,7 +122,7 @@ config UBSAN_SIGNED_OVERFLOW
 
 config UBSAN_UNSIGNED_OVERFLOW
 	bool "Perform checking for unsigned arithmetic overflow"
-	# clang hugely expands stack usage with -fsanitize=object-size
+	# clang hugely expands stack usage with -fsanitize=unsigned-integer-overflow
 	depends on !CC_IS_CLANG
 	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
 	help
_

