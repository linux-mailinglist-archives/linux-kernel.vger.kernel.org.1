Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AF123389C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgG3S4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgG3S4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:56:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8677C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:56:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so17066235ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9XvOCIZomYoWOybgFc4dJIRisyri6goifQpHivVhjQ=;
        b=NiSqZ1L3+jKj/ENVQ7FTP/DPPS7DkO3KYGOG80dxounEWJap2KYLCVPiXYxX35JvIE
         yysoMAH2ARnCKDKdURlmQKiKl91+24V6C44MrEGKVrvlJ5Wdft4ekQxS5KepHKOSdW4l
         cVBxf3/FlbWYUi1SOp/+iZVLg28JNzYfYL+78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9XvOCIZomYoWOybgFc4dJIRisyri6goifQpHivVhjQ=;
        b=YJqEo/W+jcKhTtyvmFjFXf49QG5P0rvmc8QJmwm/ib6BEbTivtCHi2BxLLv5fbAk9I
         n+CkECB5mXNiAcfGKugjDcHAqHeRNjWnwJLbFSb8SZA8GrDIaJgg8n+Le0ojLsNHQL73
         Romla5elITIlWZMwwysYCqdZU23tDHoeJjGKqhtlJSF3yrqHSN8cNFzEIMlZF/PgnKVn
         TcMqqkEbv7ooCVOKxiP90wX5e4qG5p0mGD+/PoP9Fsb8Fuj2DzrrbVlqcx+kqX8lTHvx
         sjOTssdEX3+26wsREW2duvItZttq/y/etJlSFX83oKqrOcqVTsuK3LaoEsME0Y/qPqON
         j54Q==
X-Gm-Message-State: AOAM532RUKG7SNrVZlT2PwVOuiUQQblsb6j8RNgMOEzWcOQdl9PO6A0M
        /KfpZ4kwoSJRGQfddlax+oOkYKyu4cU=
X-Google-Smtp-Source: ABdhPJwJ+4U1eJ9MVKsd44utOWcm58NWCqlydvXP0O11iqY3q8nFg8oyS4YQK5Jwo3rUqQIGHNr2xw==
X-Received: by 2002:a05:651c:118f:: with SMTP id w15mr254508ljo.211.1596135399919;
        Thu, 30 Jul 2020 11:56:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 197sm1197591ljf.103.2020.07.30.11.56.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 11:56:38 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q4so30015414lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:56:38 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr277841ljj.312.1596135398246;
 Thu, 30 Jul 2020 11:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
 <20200730211522.1ea3561f@canb.auug.org.au> <d23eba90-ee2c-efe0-0cb6-88e99fb22e54@ti.com>
In-Reply-To: <d23eba90-ee2c-efe0-0cb6-88e99fb22e54@ti.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jul 2020 11:56:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn8OB-QbxpffK=Lhh6Mhj+Y2ALFZ1asCgtnQOnmQgWUw@mail.gmail.com>
Message-ID: <CAHk-=whn8OB-QbxpffK=Lhh6Mhj+Y2ALFZ1asCgtnQOnmQgWUw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGFybTY0OiBwb2ludGVyX2F1dGguaDo0MDozOiBlcnJvcjogaW1wbGljaXQgZGVjbA==?=
        =?UTF-8?B?YXJhdGlvbiBvZiBmdW5jdGlvbiDigJhnZXRfcmFuZG9tX2J5dGVz4oCZOyBkaWQgeW91IG1lYW4g4oCY?=
        =?UTF-8?B?Z2V0X3JhbmRvbV9vbmNl4oCZPw==?=
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Emese Revfy <re.emese@gmail.com>,
        hsinyi@chromium.org, Will Deacon <will@kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:47 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
>
> I'd like to note that below set of patches:
> 1c9df907da83 random: fix circular include dependency on arm64 after addition of percpu.h
> 83bdc7275e62 random32: remove net_rand_state from the latent entropy gcc plugin
> f227e3ec3b5c random32: update the net random state on interrupt and activity
>
> also break ARM build for the case:
> #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)

Lovely.

I think I'll have to revert 1c9df907da83 after all, and  use Marc
Zyngier's patch to just remove that troublesome <asm/pointer_auth.h>
include in arm64 instead.

This turned out to be much messier than it should have been.

            Linus
