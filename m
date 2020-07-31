Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C179D234A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbgGaRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbgGaRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:17:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E17C061574;
        Fri, 31 Jul 2020 10:17:01 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 885C17DE;
        Fri, 31 Jul 2020 17:17:01 +0000 (UTC)
Date:   Fri, 31 Jul 2020 11:16:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] scripts/kernel-doc: optionally treat warnings as
 errors
Message-ID: <20200731111659.3cfe5d23@lwn.net>
In-Reply-To: <20200728162040.92467-1-pierre-louis.bossart@linux.intel.com>
References: <20200728162040.92467-1-pierre-louis.bossart@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 11:20:40 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> he kbuild bot recently added the W=1 option, which triggered
> documentation cleanups to squelch hundreds of kernel-doc warnings.
> 
> To make sure new kernel contributions don't add regressions to
> kernel-doc descriptors, this patch suggests an option to treat
> warnings as errors in CI/automated tests.
> 
> A -Werror command-line option is added to the kernel-doc script. When
> this option is set, the script will return the number of warnings
> found. The caller can then treat this positive return value as an
> error and stop the build.
> 
> Using this command line option is however not straightforward when the
> kernel-doc script is called from other scripts. To align with typical
> kernel compilation or documentation generation, the Werror option is
> also set by checking the KCFLAGS environment variable, or if
> KDOC_WERROR is defined, as in the following examples:
> 
> KCFLAGS="-Wall -Werror" make W=1 sound/
> KCFLAGS="-Wall -Werror" make W=1 drivers/soundwire/
> KDOC_WERROR=1 make htmldocs
> 
> Note that in the last example the documentation build does not stop,
> only an additional log is provided.
> 
> Credits to Randy Dunlap for suggesting the use of environment variables.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Applied, thanks.

jon
