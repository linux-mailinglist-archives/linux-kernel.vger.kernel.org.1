Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E11BD6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 10:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgD2IBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 04:01:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47985 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgD2IBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:01:19 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jThec-0006vy-2K; Wed, 29 Apr 2020 08:01:14 +0000
Date:   Wed, 29 Apr 2020 10:01:13 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Brauner <christian@brauner.io>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: fix binderfs sample
Message-ID: <20200429080113.wetsjwkfxfrarfvf@wittgenstein>
References: <20200428212555.2806258-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428212555.2806258-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:25:33PM +0200, Arnd Bergmann wrote:
> A routine check for misspelled Kconfig symbols showed on instance
> from last year, the correct symbol name is CONFIG_ANDROID_BINDERFS,
> not CONFIG_CONFIG_ANDROID_BINDERFS, so the extra prefix must
> be removed in the Kconfig file to allow enabling the sample.
> 
> As the actual sample fails to build as a kernel module, change the
> Makefile enough to get to build as a hostprog instead.
> 
> Fixes: 9762dc1432e1 ("samples: add binderfs sample program")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing this Arnd!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
