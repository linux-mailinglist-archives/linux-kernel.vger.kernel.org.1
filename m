Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190EB2FF260
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbhAURtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389139AbhAURr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:47:58 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C97C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:47:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v24so3706892lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kykA4foeTxbLS8CWzJvsbjzmd7nBL3addKFMK7SYEtY=;
        b=iMK3aw8mffMX36Y2EfAfZFJwILSWj2+hpckNL/ptc1M+mDKqVH7G2Xfr1xPz5MKBWT
         LzzZ0TZfDZ1vdcpvPg1LakBoHzZQR/oPP/dJSYoEjHwrolgId+nUmqluTElLkH2f+t9Y
         1pxoCYScqNMWRHqBZ2Opt52NmMZq6sI0K+NSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kykA4foeTxbLS8CWzJvsbjzmd7nBL3addKFMK7SYEtY=;
        b=U3OV7EM6g1oFtZplke5GYRex8iKUdpEyLR9dD5+WpHk5MCwIUq6kiJ96OM95kS4jIK
         1Rb2DOfhkF9u8izZVhegA8o/kjipopapKNE84y5raQqPTk3YF4mMEPhwkdbcCKrpNfTQ
         gWJ9aUoPbm7CCzYHFl1wkBeGUoWxgNenpu0hHL+Na4mJfJp4LLBoBpPLD40VnN6V0jJl
         XUNqDNl8h2bMtBvm1PWnA2jyn/V2Cj9jT1nhR86fTEgb8QNZD9v+EIZinQ40LVP+O0Pt
         eG2OQ1U3PvpXk93qv/Pf7YM2A3zxK+vTql0zhqgVTJybTFnPdhb11lqEuOzNXDR0hUNk
         5nyg==
X-Gm-Message-State: AOAM533dz9PGG8I+uxc7cHf42yUU+VPYh1sJbe6lbGp3t35NaDxh/feV
        fse2HktLXnP2NaUgPPsBJUf5wGfRnO8Q/A==
X-Google-Smtp-Source: ABdhPJyWVlxMs4cgFP4RyFQw8ElGOu0k1QgQnS1SIcXmJPHiM8TRpLo5f6Hze/aJSs/0Rt/ICRQaqg==
X-Received: by 2002:a19:2245:: with SMTP id i66mr166761lfi.400.1611251236181;
        Thu, 21 Jan 2021 09:47:16 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o4sm594962lfo.24.2021.01.21.09.47.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:47:15 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id i17so3512530ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:47:15 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr214331lji.251.1611251234794;
 Thu, 21 Jan 2021 09:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <20210121090020.3147058-2-gregkh@linuxfoundation.org> <ff6709dc-bb42-1e52-b348-c52036960bdd@kernel.org>
In-Reply-To: <ff6709dc-bb42-1e52-b348-c52036960bdd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 09:46:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whMm=NM4=ch++YqFn3W=ceNDOhLTFqdP47nxayzVt41Qw@mail.gmail.com>
Message-ID: <CAHk-=whMm=NM4=ch++YqFn3W=ceNDOhLTFqdP47nxayzVt41Qw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tty: convert tty_ldisc_ops 'read()' function to take
 a kernel pointer
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 3:02 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> n_hdlc_tty_read will return EOVERFLOW when size is 0, so this EFAULT is
> never propagated, if I am looking correctly? n_tty seems to be fine
> (returns zero for zeroed size).

I'll fix that up too.

Greg - same question - do you want an incremental patch, or just a new series?

              Linus
