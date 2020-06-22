Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8911D2040CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 22:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgFVUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgFVUCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:02:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28646C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:44:55 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a137so16733780oii.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mg5y3to7GQinVmHOzDaJ7XV7WqxlCDc/TMo6EnpGcTs=;
        b=uDb/6m6qlj0PFysttennBODak4mm4qQYqd03MDZ1R33VQaWr4CXcIWuW+N7oowKUbF
         p/oFBS3BbFxCJCG9pp24WhMgvUKl/t9LrlfGnUet39at5E5hYfbcZOnMKzhNiLRgC8Ag
         NNR69Ib8p3Lw6dkFk+09kWRsu/7gEou0cOaeUPk3Aa5zNv5yEf9gY81qrBpajY2AheMH
         5K+RWOWuy+YxqTz+vRkg+PsgBnKgUDGAv/OlMOB0NbI1g7KeB4u4AB51sMu9IxvGHJCX
         9980XBEVvVrQMuSsLWfdeyoyHDyXOcY6SZ/YY2OfJ9YzflF7AQ2knlug0YsF8FnLkqm6
         4Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mg5y3to7GQinVmHOzDaJ7XV7WqxlCDc/TMo6EnpGcTs=;
        b=ZTJ/N8tgtdDZxQpuiTCSykSWGIYPmPvt/ow72LNJh+kyux2DMhYW9lpKHad8usNAu7
         gJv4rUHueyJP7jxCGbKTwbHcalt2gfORUxSIkDXgeY+YhhwJoCEydTiWGlxRs/NrTDZB
         aNRGM2XNlKtHT+B72O/Kcr2SOJN9KTywweixD5o0PsFhr8sz2F56E42lhJBXrN64K/eZ
         AXD/U2yYcrYAbg6gAviHA9kSkQ0U4vjoVe0ex8/1bZSUmAhJOzaWfOa76oX+B1Nq4pGw
         bsvu28VwRaY3nRBjrh4uUlEAAZ2a5+hrozlWT8qQnZWHipbJgsRPr367dlbFg3AVvpG+
         /Y8g==
X-Gm-Message-State: AOAM531V4p9/sBozb4nCqpy9eilRXfCI9Y0TmQNQbuaEnhJhIAj9Gf//
        TniBG0WgDqh6vBaZZEmZafplQPvWbvRde0pXHmwfLg==
X-Google-Smtp-Source: ABdhPJy3zt3r18SZTCCHa918AxYLYtT476CxByuaL4koYHT2akdNKZsP1b9JbWI38R6lwVzUcvP4UMhS9YXded0oISI=
X-Received: by 2002:aca:5d0b:: with SMTP id r11mr13230543oib.169.1592855094408;
 Mon, 22 Jun 2020 12:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+BqPeVqbgojN+nhYTE0nDcGF2-TfaeqyfPLOF-+DLn5Q@mail.gmail.com>
 <20200620212616.93894-1-zenczykowski@gmail.com>
In-Reply-To: <20200620212616.93894-1-zenczykowski@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Jun 2020 12:44:44 -0700
Message-ID: <CALAqxLVeg=EE06Eh5yMBoXtb2KTHLKKnBLXwGu-yGV4aGgoVMA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] restore behaviour of CAP_SYS_ADMIN allowing the
 loading of networking bpf programs
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 2:26 PM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> From: Maciej =C5=BBenczykowski <maze@google.com>
>
> This is a fix for a regression introduced in 5.8-rc1 by:
>   commit 2c78ee898d8f10ae6fb2fa23a3fbaec96b1b7366
>   'bpf: Implement CAP_BPF'
>
> Before the above commit it was possible to load network bpf programs
> with just the CAP_SYS_ADMIN privilege.
>
> The Android bpfloader happens to run in such a configuration (it has
> SYS_ADMIN but not NET_ADMIN) and creates maps and loads bpf programs
> for later use by Android's netd (which has NET_ADMIN but not SYS_ADMIN).
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>

Thanks so much for helping narrow this regression down and submitting this =
fix!
It's much appreciated!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
