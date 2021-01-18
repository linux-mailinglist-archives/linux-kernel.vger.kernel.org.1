Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C0C2FA485
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393359AbhARPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405685AbhARPTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:19:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F62722BEA;
        Mon, 18 Jan 2021 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610983112;
        bh=nM+lfs14ARK1bF8opGADOumEAAcUiSZcjd5lmJuVlkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1gOPdXRCIC8WKBRf95b5FLRYEkXC02veXoRz1AFE3mDTyVuBlncjPPflZiAnSdlg
         E3DoN5/bgVkTCto2AsOrjg8xZwvEYSCA+M8peb+9EsiRvVqAUFxqxrmHqXCxm+eLMl
         e19hr9xlqeqW8nMXJ1CRTBPwBsf9rkJRHKZ0DFvbA4kSgzHEyP8lkQvdyl0/RssnxE
         MQkrEHugk+QfSftgR9WXRtbxMrl7ocVNdhtgpDGg6B7+eo8rlSU0duHLLpIk95/tek
         prxaHzCTr2optVAXIloL6eNGtGv8cuDBl8bf2FjNb1Cknjlbm9Oi1eIAEkg+PO1AN1
         wSENRuy9VF9Dw==
Date:   Mon, 18 Jan 2021 16:18:27 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: harden ELF info handling
Message-ID: <20210118151827.GA22792@linux-8ccs>
References: <20210114222146.25762-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210114222146.25762-1-fllinden@amazon.com>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Frank van der Linden [14/01/21 22:21 +0000]:
>5fdc7db644 ("module: setup load info before module_sig_check()")
>moved the ELF setup, so that it was done before the signature
>check. This made the module name available to signature error
>messages.
>
>However, the checks for ELF correctness in setup_load_info
>are not sufficient to prevent bad memory references due to
>corrupted offset fields, indices, etc.
>
>So, there's a regression in behavior here: a corrupt and unsigned
>(or badly signed) module, which might previously have been rejected
>immediately, can now cause an oops/crash.
>
>Harden ELF handling for module loading by doing the following:
>
>- Move the signature check back up so that it comes before ELF
>  initialization. It's best to do the signature check to see
>  if we can trust the module, before using the ELF structures
>  inside it. This also makes checks against info->len
>  more accurate again, as this field will be reduced by the
>  length of the signature in mod_check_sig().
>
>  The module name is now once again not available for error
>  messages during the signature check, but that seems like
>  a fair tradeoff.
>
>- Check if sections have offset / size fields that at least don't
>  exceed the length of the module.
>
>- Check if sections have section name offsets that don't fall
>  outside the section name table.
>
>- Add a few other sanity checks against invalid section indices,
>  etc.
>
>This is not an exhaustive consistency check, but the idea is to
>at least get through the signature and blacklist checks without
>crashing because of corrupted ELF info, and to error out gracefully
>for most issues that would have caused problems later on.
>
>Fixes: 5fdc7db644 ("module: setup load info before module_sig_check()")
>Signed-off-by: Frank van der Linden <fllinden@amazon.com>

Queued on modules-next.

Thanks Frank!

Jessica

