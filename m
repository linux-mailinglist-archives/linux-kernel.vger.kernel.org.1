Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CB32CBF4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbgLBONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730321AbgLBONW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:13:22 -0500
Date:   Wed, 2 Dec 2020 11:12:46 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606918361;
        bh=MKDehjXLSUVqaIsb3ipHdMuhYnAPmKKiY4GYITriiBQ=;
        h=From:To:Cc:Subject:From;
        b=KRBAzBolsq2xH8Qs8cz4VZYYYf6mibN8KaYHPB1AcqvnivNa3LfHaH6qkZqjHHvV8
         N39hB3WUHckh2EMljVXWP9HSVYIkL1T4cGlGPijkOZ3DY1jM1FSqb0Zd41OZFv0sTs
         QKqgdaG/hhuk/PFQjyOhFG52SFYu2UKjLQGK0gRY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: How to have a 'bpf.sig_enforce' command line arg in
 kernel/bpf/syscall.c ?
Message-ID: <20201202141246.GA96752@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I use:

module_param_named(bpf.sig_enforce, sig_enforce, bool_enable_only, 0644);

It explodes and if I do as before:

module_param(sig_enforce, sig_enforce, bool_enable_only, 0644);

Then it ends up as 'syscall.sig_enforce'.

The closest I got so far was:

commit aeacb019b61c4ea7689085574bd03d2c0810f119
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon Mar 19 18:01:24 2018 +0900

    kbuild: define KBUILD_MODNAME even if multiple modules share objects


Is there some way to set that modname var to 'bpf' in
kernel/bpf/syscall.c?

- Arnaldo
