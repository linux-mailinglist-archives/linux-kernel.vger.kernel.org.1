Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1126AC80
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgIOStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIOR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2B5C061220
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:24:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so3575128ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlLASjtOWZl97ccS56UuppG/O1DcME2TKl7d1jzvYzM=;
        b=ZQ4GHeUyUTLfgc95eXulgPvEP8C1iC3CepnrK9c7pfKYqS19IJUGCmeEpx5/qKZ02M
         zzlDzATp4hfO861tzoWuNixpFbmNPSR7fXNK9Pyas2eKtrBsZmkJKLUIKMnfkIZRLHXC
         WbAoAlOxBDEO1ElAIYEY4Jq81yKgIiBKzhNdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlLASjtOWZl97ccS56UuppG/O1DcME2TKl7d1jzvYzM=;
        b=D3KYbiPupNn2UL3qZiMEH2iNc2+XNg5mjwJbKfqWG6fiN6lcyMqEt+mUPgbxzcsSKw
         7JhyFF/kCJwdE7wB1miuYLzkszW+pVv6GKMR0sUxsK77t96IH4MOv/mFX8qTDteVS/Hq
         m99gOOpja0FbqyglOh0820ix/fytrm/rdCxY72abt0Ze66l+DGHY8+WJaPI05j3AgckX
         bd5An9kbC9eZRZB5bHuvguRRDED9ZN/DLccAbBLNuqAu2d3mnStkOrlqqREajE9D9inN
         z5t2MOHiC9Vc0Xz9SZOSDK3v+XgSs/towfiFsUGTMScuAetcwPMzUVLHLgWJcxI9OrF3
         cPIg==
X-Gm-Message-State: AOAM5308n5Iko8e6xtHX5CG9vAyUTmtNcjCDocEYOfXezuekbNR29WG0
        xlbZIpP3U31OUuk8h9YX8+t1Ksw7fiRElw==
X-Google-Smtp-Source: ABdhPJyIYUQ19QTt3UFVJuuKX4qkdEuX77xRM/S3CnhDJESC0LZCCktvUOiPb+EUWwLqMsEtC6NFtQ==
X-Received: by 2002:a2e:8e30:: with SMTP id r16mr7783238ljk.304.1600190684056;
        Tue, 15 Sep 2020 10:24:44 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b14sm4032580lfp.176.2020.09.15.10.24.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:24:43 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id b19so3503572lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:24:42 -0700 (PDT)
X-Received: by 2002:a2e:91cd:: with SMTP id u13mr6495156ljg.421.1600190682261;
 Tue, 15 Sep 2020 10:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200915140653.610388773@linuxfoundation.org> <20200915140658.820608455@linuxfoundation.org>
In-Reply-To: <20200915140658.820608455@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 10:24:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBNqZm2E89SiTmtSPQr+pbdswwdPY6oH_wF1rvAeJnAQ@mail.gmail.com>
Message-ID: <CAHk-=wiBNqZm2E89SiTmtSPQr+pbdswwdPY6oH_wF1rvAeJnAQ@mail.gmail.com>
Subject: Re: [PATCH 5.8 108/177] gcov: Disable gcov build with GCC 10
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 7:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> GCOV built with GCC 10 doesn't initialize n_function variable.  This
> produces different kernel panics as was seen by Colin in Ubuntu and me
> in FC 32.
>
> As a workaround, let's disable GCOV build for broken GCC 10 version.

Oh, Peter Oberparleiter actually figured out what was wrong, and we
have commit 40249c696207 ("gcov: add support for GCC 10.1") upstream
that enables it again with the fix for the changed semantics in
gcc-10.

                          Linus
