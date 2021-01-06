Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1663E2EC6A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbhAFXPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbhAFXPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:15:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D294C061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 15:14:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id c22so3261884pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xYoNxurN7RYiLRX5DTFEbJhs2mXXLc0TcPBStbYi+bI=;
        b=XCjXVexqO6br84vuNCwmm7JX8bKGx7p6bQKGwZ1PNxBDpTTn95YiNwBdCtol83AFFq
         LF/S4oy8uRyrRJbv0sTumUYa4D729fwANR9/L/AQ2hMGeRHn6OiVvrjt6Qv/QHYXVQHy
         0VgbEOKZSSxVqkY+4iW9v0YcGcvStS5sdvCnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xYoNxurN7RYiLRX5DTFEbJhs2mXXLc0TcPBStbYi+bI=;
        b=n37amv710BN+iAgc8qc2elDjAYKoFz9vBHkIORqcTtfmVoJJv89Z8r7C1XgrR3Dn66
         anRLX1HHlpOZA2+AP03fExgQfdV6tqWSYxM4k+NMhbEnVGZAgR2hNgdfdDEWmtdorP7/
         Uv15Kdq67DZxSJKjUX24qOfEATCLq3wJz1UPtVTX3i9yKM2TJaGOvhHRh4qNoJtd6x7U
         AeKfU7vCLrCPZ6p6U+GAApOVpkjU2HWd4g9XmahGqqBiMBI7hkx6tGS/IY9nSCiIx4UJ
         Zq2NoWEht7QVt9fiCvqI7cer79iWV1ogtqV2USpWdM7CvnpoIBdiJFJYwRezKTEENf9g
         xdQA==
X-Gm-Message-State: AOAM530OoQHdVUE/CHgFUfpsFrzNiuS4bYp1ZITNOuFusUtcihgtncYc
        MDVntq0AivhPHwcJtfioL0EPg9GVo/sNTw==
X-Google-Smtp-Source: ABdhPJxtZyANiYJ8vcaoNCZrhZrHCEaOmZXeCmfUZxjm5K/haIY+u0RwyoKcYRG5tmjKmHgTCak23A==
X-Received: by 2002:a63:101d:: with SMTP id f29mr6740389pgl.165.1609974879822;
        Wed, 06 Jan 2021 15:14:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 84sm3659234pfy.9.2021.01.06.15.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:14:39 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:14:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: commit ("1e860048c53ee gcc-plugins: simplify GCC plugin-dev
 capability test")
Message-ID: <202101061512.E0F3D28@keescook>
References: <2368d10b-85df-728f-675a-7a082ed0f54c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2368d10b-85df-728f-675a-7a082ed0f54c@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 08:44:58AM -0600, Dinh Nguyen wrote:
> Hi Masahiro,
> 
> With v5.11-rc1 and commit("1e860048c53ee gcc-plugins: simplify GCC
> plugin-dev capability test"), I get this error for my arm socfpga_defconfig
> build. I have been building the kernel the same way for many years now. Do
> you know what I might be doing wrong?
> 
> $ make ARCH=arm CROSS_COMPILE=${CROSS_COMPILE}
>   SYNC    include/config/auto.conf.cmd
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
>   REMOVE  arch/arm/include/generated/asm/mm-arch-hooks.h
>   HOSTCXX scripts/gcc-plugins/arm_ssp_per_task_plugin.so
> In file included from scripts/gcc-plugins/gcc-common.h:103:0,
>                  from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:
> /home/dinguyen/linux_dev/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf/bin/../lib/gcc/arm-none-linux-gnueabihf/10.2.1/plugin/include/builtins.h:23:10:
> fatal error: mpc.h: No such file or directory
> #include <mpc.h>
>           ^~~~~~~
> compilation terminated.
> scripts/gcc-plugins/Makefile:47: recipe for target
> 'scripts/gcc-plugins/arm_ssp_per_task_plugin.so' failed
> make[2]: *** [scripts/gcc-plugins/arm_ssp_per_task_plugin.so] Error 1
> scripts/Makefile.build:496: recipe for target 'scripts/gcc-plugins' failed
> make[1]: *** [scripts/gcc-plugins] Error 2
> Makefile:1190: recipe for target 'scripts' failed
> make: *** [scripts] Error 2
> make: *** Waiting for unfinished jobs....
>   UPD     include/config/kernel.release
> 
> Thanks,
> Dinh

Hi! Thanks for the report. Other folks have also encountered this,
and it appears to be a problem with distro packaging of the gcc plugin
development packages. You'll need to install the GNU multiprecision
libraries ("gmp-devel" on most rpm-based systems, "libgmp-dev" on most
debian systems)[1].

Hopefully that'll work!

-Kees

[1] https://lore.kernel.org/lkml/CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@mail.gmail.com/

-- 
Kees Cook
