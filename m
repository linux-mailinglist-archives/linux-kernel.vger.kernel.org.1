Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7AB2F5330
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbhAMTQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbhAMTQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:16:11 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBBEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:15:30 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id m10so3823541lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSCThISc7Qlzu1RlsYQR6XoaV7upxYV3AgzCQnNsQYQ=;
        b=I+vYrkbJgtuUYOxn5AQnBYgseZ0i5ZDHreByFwLF7gt6rivMEkaCjdj8wK6e6IMJza
         0O9LtoauPU3yToENWhKMtvdoUm69YBuAV2EX3xOWNK4BMvi1wzwjJWvggZDMi8CacAre
         iSYflK7L5TONTUPTWbSNUpGISB9IChvsjBjdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSCThISc7Qlzu1RlsYQR6XoaV7upxYV3AgzCQnNsQYQ=;
        b=eI+t+j68N4vDxK0qE0Zrij5fgXXkrW18Ll97H8GBigy3S3vZgBOjoOwDHuYhx7ZKqG
         40cZl18tCFhmmgh45unTsbzJhtk9/GhiGsO+SC8dQ0if0DjlGxaKtKWSpjDFi8q2dGI8
         fEXoQ4x9+W742I8cF5+5uSY0+6nl9dYk32UeX18GIV2SqJ/MWaiqzEZFCmkB/LauCXN+
         XsOFlEYUMHUf/n7B45VTLcy+5eCyVvnBqLVse/RQnLv2XUcQ3jpxBgk9US0R52WDuHms
         Lxy5BwxzyXo6/R2PV03DxHjfVo7xeYi+h0EsaDn6W0GTi3uadfijsZrIt2lFCcxKwn1R
         4PAA==
X-Gm-Message-State: AOAM530V21d3zm/43whWXpnNF+zKZKWc/7tU3aIIf34CHQQuHITB+tQe
        GMAJMASyyY70rgQa2Srmw0DwYm1XtgzTbg==
X-Google-Smtp-Source: ABdhPJwnOm9FgXG3djZS4YkiqjdELdN4YBnXu61naLLZEUxd4ZzgSwy1KvUFI09P+rfodkSmTK8WeA==
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr1520846ljm.507.1610565327603;
        Wed, 13 Jan 2021 11:15:27 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t131sm295298lff.81.2021.01.13.11.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 11:15:26 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id m12so4397389lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:15:25 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr1448932lfc.253.1610565325311;
 Wed, 13 Jan 2021 11:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
In-Reply-To: <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jan 2021 11:15:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
Message-ID: <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 9:58 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Maybe, we can raise the minimal version to gcc 5.1
> for all architectures.

It was discussed, but the immediate reason for this thing really does
seem to be specific to just arm64 (ie this is not some generic gcc
stack access bug that just happens to rear its head on arm64 - the
patch to fix this in the gcc bugzilla is very much arm64-only).

            Linus
