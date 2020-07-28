Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846E02310DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbgG1R3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 13:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731779AbgG1R3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:29:13 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C032078E;
        Tue, 28 Jul 2020 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595957353;
        bh=2T3mr7waKN2zzqEx10ZQKW4qYXOz5+D5jfjnMLkLR2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVCKMUptkWj96NFd/9wAfn1anprKpA1fwfJcUu2vSpsNVfOJyrX9Kybt/aAzDWI/3
         zhPgKHbFtGm4eNoNdXw3LASuth1mLDaaX/XN4AcfyVmGU2TOq0dJr129XX1ogXhViN
         lIysWUbEQBTENhX/MJzpx14RG9c5PDIptwAHWYT0=
Date:   Tue, 28 Jul 2020 19:29:08 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v4 10/10] module: Reorder functions
Message-ID: <20200728172907.GA31178@linux-8ccs>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <20200717170008.5949-11-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200717170008.5949-11-kristen@linux.intel.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Kristen Carlson Accardi [17/07/20 10:00 -0700]:
>Introduce a new config option to allow modules to be re-ordered
>by function. This option can be enabled independently of the
>kernel text KASLR or FG_KASLR settings so that it can be used
>by architectures that do not support either of these features.
>This option will be selected by default if CONFIG_FG_KASLR is
>selected.
>
>If a module has functions split out into separate text sections
>(i.e. compiled with the -ffunction-sections flag), reorder the
>functions to provide some code diversification to modules.
>
>Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>Reviewed-by: Kees Cook <keescook@chromium.org>
>Acked-by: Ard Biesheuvel <ardb@kernel.org>
>Tested-by: Ard Biesheuvel <ardb@kernel.org>
>Reviewed-by: Tony Luck <tony.luck@intel.com>
>Tested-by: Tony Luck <tony.luck@intel.com>

Hi Kristen!

I've boot tested this on x86, (un)loaded some modules, and checked
their resulting section addresses as a quick sanity test. Feel free
to add my:

Acked-by: Jessica Yu <jeyu@kernel.org>
Tested-by: Jessica Yu <jeyu@kernel.org>

Thank you!

Jessica
