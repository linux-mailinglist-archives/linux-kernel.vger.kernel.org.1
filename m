Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FEF29971D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785756AbgJZTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:36:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38578 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1785719AbgJZTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:36:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id h10so11683134oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ysSlN5Tw+8xH995xyNFoH11OC8nwORbFcbyWXKMjO8=;
        b=SDJXLDzlnMI8DIH2tg3vO1PKE8jLEAH9s27+k4BhCidZM9U86NVwRiL0683f8BNb/a
         Q2KisblbWauLt9IVfRv/hBIE9frovPPefvOQMo9z0uBRxRw4gREVlLzTPYvnpph1sHNP
         lwDWtQei6XnbdcEUJeYsmDdOuNrY/D9B+lWqSxV15zJpyYMcSy1F57VIOtlk9NTlQypu
         EjEkER8Czy1ZiGKfRXoPUemtSyA8USjBFUSCqt535pd9Uog/FeGkT9lPuUeL8fRYONPn
         URk1P3tc/UassStbBGJsgW+lKTvHyNoNMzLDX3z6e6RVs7o0uE6ciFr7TDk/BZj97I1x
         tErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ysSlN5Tw+8xH995xyNFoH11OC8nwORbFcbyWXKMjO8=;
        b=q6nEUE7UKmYGFuNEwf7oURlbQjCL47cI9/yAHCJUKT2RLFvqHOaUqAGKrtM5Dr1LDs
         lnY92reCIqEERX9BfRywzb4F2EeSTFNYICL1trqMBVlQUAgLjkRMiE8w3nKEVP/BDhcF
         JzcuJMW7egwScPCWUuaKV1ndCJI6UN/svMGbkmD+TybLqawfDNbqwbR8Uk8yv47szWDE
         UgasPuryve65XKZIPpNML7FXh+nMmSgkLP2SJLGBEnK+g2bFU1jR+SvSWJtl59ZOL7mJ
         TRGFzQk64S37st0QYqTPxN9p//dvV/EK+A/o4SXagQBofw38VhYOb+dh50hw06mm+Zqn
         uy0Q==
X-Gm-Message-State: AOAM530wAyDOPkvahdd2PUxuHE1NYEGkeshoS4peB9BDVJoFBdDiJiwP
        b3ypZGJ0785zBzEwrZWQDKg=
X-Google-Smtp-Source: ABdhPJz1luWp8J+17T/HhdkmAS4b6ea/N4WBdQo5t6husfQr4I68I4ofC2QOPr/uQgMGCrMSfsCJog==
X-Received: by 2002:aca:b256:: with SMTP id b83mr11449268oif.116.1603741014350;
        Mon, 26 Oct 2020 12:36:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b17sm4769216oog.25.2020.10.26.12.36.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 12:36:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Oct 2020 12:36:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
Message-ID: <20201026193652.GA77796@roeck-us.net>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:36:07PM -0700, Joe Perches wrote:
> Use a more generic form for __section that requires quotes to avoid
> complications with clang and gcc differences.
> 
> Remove the quote operator # from compiler_attributes.h __section macro.
> 
> Convert all unquoted __section(foo) uses to quoted __section("foo").
> Also convert __attribute__((section("foo"))) uses to __section("foo")
> even if the __attribute__ has multiple list entry forms.
> 
> Conversion done using a script:
> 
> Link: https://lore.kernel.org/lkml/75393e5ddc272dc7403de74d645e6c6e0f4e70eb.camel@perches.com/2-convert_section.pl
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@gooogle.com>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

s390 (all builds):

Error log:
error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
make[2]: *** [arch/s390/boot/section_cmp.boot.preserved.data] Error 1
make[2]: *** Waiting for unfinished jobs....
error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
make[2]: *** [arch/s390/boot/section_cmp.boot.data] Error 1
make[1]: *** [bzImage] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [__sub-make] Error 2

Reverting this patch fixes the problem.

Guenter
