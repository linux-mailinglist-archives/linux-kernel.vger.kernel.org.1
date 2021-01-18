Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7AD2FA3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405362AbhAROzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405356AbhAROzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:55:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F66EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:54:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 190so13864386wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bJKOCIhgp2n2XDRcM4f1+mhwqcxWdVNau3p3HbDQCsQ=;
        b=KbFMIpZl8sxRjKqORQuoy0bbEKHAsIFWrTPauw8EWR0jhNuKKZEGP/zuqK95fjHeX/
         lFy76l4st/jJl3GWQDDUSj2JYqxUIHVU9VRmQcZlyNZW8NJ4hhnbH8k6hmZZXx/RWHV/
         7odDwx25iRfazRG0bagwmgXkvV5SkjJANBw0UVpp3gK1N+OeDB23LZe86HKnhHty0Wzv
         Z90YdryTRsnJzyCLcR3y6v4Ig56vmt9IwH6Umd977izSVciVE1zIofrC+O1VJERXB6iY
         pPUmwZmH7jOF3CZ8y1xi9a1O3lJXkSKdOCbPhBlkpdS05RAITTywf3lujT4zteEEBY++
         Go0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bJKOCIhgp2n2XDRcM4f1+mhwqcxWdVNau3p3HbDQCsQ=;
        b=mf5HHQgvaid2iEiII3lEcPSOKPJX6wIA88cL4+KaEitXMz0WnG8KbfC5b9PkB0Fq3s
         noe4dOqUfZ3kyazH8i9qO1b1nxaxVPZwojj6uziHktUxvvpXU0mjF3cFHfWE72PTGnA6
         xlG/E2xr8gzf0KwDMgJ3vf9PS780xsOVGWlhkwqxHFXdJNsvpnk2ujmHNVdmlfMKlPLy
         WenHWNpJbufu3TvfPX2cn1tmfidMd0au8MBqOQphXmrJFwhyzLlpQQwSvApJFjzXMnNs
         r1E6HZ73KEYomTkY82mtOQrS1IeXiKBAttpVqK0heJTz6W6tyDRdFCdsvNCpdOv7SP5e
         UCuA==
X-Gm-Message-State: AOAM530WeIaG31/IPtRQCabgB8se8dvsxEUSqz6LqQur3zJdG2UNE5DR
        5aTgA9WWiySwBAHfyLHm63eWfA==
X-Google-Smtp-Source: ABdhPJz6bW3BGvz8nTjOKnqiVeRy9unK18MMh2g7waN9oE7GE7k4Wvz87vgOhlNoIs3aMnmGr/BJ+Q==
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr21519184wmc.36.1610981676034;
        Mon, 18 Jan 2021 06:54:36 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id h125sm12879816wmh.16.2021.01.18.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:54:35 -0800 (PST)
Date:   Mon, 18 Jan 2021 14:54:34 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 00/21] arm64: Early CPU feature override, and
 applications to VHE, BTI and PAuth
Message-ID: <20210118145434.2lar7xkgwy5yj54i@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:12AM +0000, Marc Zyngier wrote:
> It recently came to light that there is a need to be able to override
> some CPU features very early on, before the kernel is fully up and
> running. The reasons for this range from specific feature support
> (such as using Protected KVM on VHE HW, which is the main motivation
> for this work) to errata workaround (a feature is broken on a CPU and
> needs to be turned off, or rather not enabled).
> 
> This series tries to offer a limited framework for this kind of
> problems, by allowing a set of options to be passed on the
> command-line and altering the feature set that the cpufeature
> subsystem exposes to the rest of the kernel. Note that this doesn't
> change anything for code that directly uses the CPU ID registers.
> 
> The series completely changes the way a VHE-capable system boots, by
> *always* booting non-VHE first, and then upgrading to VHE when deemed
> capable. Although it sounds scary, this is actually simple to
> implement (and I wish I had done that five years ago). The "upgrade to
> VHE" path is then conditioned on the VHE feature not being disabled
> from the command-line.
> 
> Said command-line parsing borrows a lot from the kaslr code, and
> subsequently allows the "nokaslr" option to be moved to the new
> infrastructure (though it all looks a bit... odd).
> 
> Further patches now add support for disabling BTI and PAuth, the
> latter being based on an initial series by Srinivas Ramana[0]. There
> is some ongoing discussions about being able to disable MTE, but no
> clear resolution on that subject yet.
> 
> This has been tested on multiple VHE and non-VHE systems.
> 
> * From v3 [3]:
>   - Fixed the VHE_RESTART stub (duh!)
>   - Switched to using arm64_ftr_safe_value() instead of the user
>     provided value
>   - Per-feature override warning
> 
> * From v2 [2]:
>   - Simplify the VHE_RESTART stub
>   - Fixed a number of spelling mistakes, and hopefully introduced a
>     few more
>   - Override features in __read_sysreg_by_encoding()
>   - Allow both BTI and PAuth to be overridden on the command line
>   - Rebased on -rc3
> 
> * From v1 [1]:
>   - Fix SPE init on VHE when EL2 doesn't own SPE
>   - Fix re-init when KASLR is used
>   - Handle the resume path
>   - Rebased to 5.11-rc2
> 
> [0] https://lore.kernel.org/r/1610152163-16554-1-git-send-email-sramana@codeaurora.org
> [1] https://lore.kernel.org/r/20201228104958.1848833-1-maz@kernel.org
> [2] https://lore.kernel.org/r/20210104135011.2063104-1-maz@kernel.org
> [3] https://lore.kernel.org/r/20210111132811.2455113-1-maz@kernel.org

Pretty cool! Left a few minor comments here and there, other than that:
Acked-by: David Brazdil <dbrazdil@google.com>
