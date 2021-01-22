Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED27300363
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbhAVMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhAVMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:41:37 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2C9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 04:40:57 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id n18so2882267vsa.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClphIL3q1K8q6IpVIcCy6TMi4GHH1zyZNW4DosfTF0s=;
        b=pGxAl4r9My7hwNulTbNrsmmonZPCy8TgRWTdSkxnjPCrUaJxnbbuO0+by7t56BBgvB
         R21frnT+ixhNYBJDNmJjuaEaRIvlip1n5ILniLWkmHcuMnVDls0IXU1Gf3xuJwjvdaXO
         vQSTAhfG7H//DGMyvDorsPiz6/O1iN47m4imZqKp2v1kTDFpibmpzYjxp4B5c/cRR0xg
         UeLPUtp1K87UUL9OBsmBPsxB6TSyIXZq6y5IgvGnn5AOg9qQ/ao7M+WxDBboepIPqqVT
         l9YsSCUWGDAE2WYptZ0EneCzoKXKJXv5aUhGOtsILA8AioMJjAjJE7sJwJYS8KBbvn7b
         lhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClphIL3q1K8q6IpVIcCy6TMi4GHH1zyZNW4DosfTF0s=;
        b=jq6lGBU3Y7mxOV8WmWOL8+h/7+Rg16ZRKxkjsXL/wxvxzXRrZamTXMOetJdeWx/qc+
         S0lZY5LzTlvYJBMPgOnOMqF6L8aMntFCH9Ind5JgYHrHYjzZvr+bcK3ipViyqMagaC9v
         GCkxI07gHwlX6X25uJ3NB4BjMQ4FcGpywaC1FpcYl/fE3EI+B2ApfiUtthOZBz3qX0RH
         H7pO6IHoGNZdz8Vrh+K9VK5cUOQ2URsDTiQNoA8g80fJuCIEVAjgQH+h3x9E1rEYE8OS
         ahW+saLCB9px9hDtG/jfOG+67MHTtkChLLuelmyhxuUUpY++2A6kA8TgRED4f0gYrsN5
         o4Xw==
X-Gm-Message-State: AOAM530CRnxX38WKicnCXZdE8Pfdosl1smbQMKiFRoZ3lNhv2bTXQ2xq
        Td0GI1m0HB49lARs/dAkFi9E03w4vjaAuBxOjhA85/VS97R13kaC
X-Google-Smtp-Source: ABdhPJycOOdGh4IwFH1srbgKXrLPdiSgLgTte/M30a/Ge+v7n4j2LtQR/kaDidV288wtwdleGrP/GOPAeMWtPrZ2jgQ=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr680511vsd.55.1611319256481;
 Fri, 22 Jan 2021 04:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 13:40:20 +0100
Message-ID: <CAPDyKFpu-qGPK1XZJ34itTm+12s9zwqfyReX0gd26MkH6vkSYw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: core: hs400(es) fix probe/init
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jack <jack.lo@gtsys.com.hk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Adrian

On Tue, 8 Dec 2020 at 07:19, Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> Fix the probe if hs400-1_8v / hs400-1_2v is used in the
> dts and mmc-hs400-enhanced-strobe isn't set.
> That was the first attemped, but it turns out that some
> more cleanups and simplifications can be done.

My apologies for the delay with reviewing. I have looped in Adrian as
well, as he might have some input to our discussion.

Before I go into doing a detailed review, I want to make sure I
understand the problem correctly.

Are you saying that switching to eMMC HS400 mode doesn't work, unless
the enhanced strobe is supported, no? Or is this a DT only related
problem?

In any case, the main point with mmc_hs400_to_hs200() is to prepare
for tuning to run in HS200 mode (it's getting called from
mmc_retune()). In other words, there *should* be no need to support
enhanced strobe to support hs400, but I might be missing something.

In particular, the following commit could be of interest for you:

6376f69d20a6905c1d83be451065f70200490b98
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Thu May 7 13:10:20 2015 +0300
mmc: core: Add support for HS400 re-tuning

>
> * move mmc_select_hs400() in between hs200 & hs400es (preparation)
> * make mmc_select_hs400() independent and move it out
>   of the hs200. Run hs400 tuning inside mmc_select_hs400();
> * merge hs400 with hs400es function
> * remove mmc_select_hs400es function
> * remove mmc_hs200_tuning()
> * cleanup host->caps2 for hs400-1_8(2)v
>
>
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
> Replace patch set [PATCH 0/3] mmc: core: hs400 fix probe

Kind regards
Uffe
