Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684002EF714
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbhAHSMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAHSMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:12:39 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8045C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:11:58 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d37so10182154ybi.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGuqOMzVk9XTfSbayKplmXBcPIXgslBdQRCunIBHgwk=;
        b=TeZ4aQU9Pqm0Bkg6WXniBfSiOk5leVZxf3P/UCpEZ2TfrrCGx/qHUim2Q7Y1KUkulW
         it6ah2sQv6t+gEDT6FeNsYtP5KnZyuQkW+ppPe2lbJUhZbXGA6stF+ua7tBk8l95VFKT
         Jl/i2WvvUbbQXy+6sSUteccIXjDeMf/isGbkHKNyu48cw7+m9zJsg8z/2QlKOvjiy8rv
         fuPlDfUusKTnZ5LqWqITnActxTq99fkly/VF2Pncr/ryBdKW+2u6lL7522/xM9z7YObw
         14MS9o/cwkfWpeLZCZTmValbm+ZEzCECX5xaMSClISsLq1NA7tKcIkBbYopoApcDXD2F
         DgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGuqOMzVk9XTfSbayKplmXBcPIXgslBdQRCunIBHgwk=;
        b=sWZcIpueQr977Xa3+fdx9FT79kaSVMglY99mCID3IjFm82by5eLDOrmjCjgmXc1Yle
         y0xgimgu2itwGncMhrK1tNzxqLdCYd6TPRx4xlKpG7u/nDMmwKWHUX7LCrvcZd9FtcBp
         aGtgt7vkr59mJSY21ofVCqajCSO6VffHtBaWiaT9JQTcJeYNv9q8kyrvXnkFBtGobMme
         am4e+sHgJfWJmEAkXj8m1svTC5j/pUATgvOOwgeFBzjHX/2Fj1HsPPcICeFbZmLt32i/
         dh8mKb+yv63hUv63mIXCgNpWTSR44dC8nSyEGq3+wjoXpXCzngIgsgW821rNu6YHZaGa
         rMMg==
X-Gm-Message-State: AOAM531yE4mlTLbRPIAX5Bz7meF4UMOs7gLnVA95jA/egJxzxvyb8ja7
        XaUNUaaUBZPVl8gfACxL/a8AL7vNtgvZyFNnzw9XgIKF
X-Google-Smtp-Source: ABdhPJzhHaYA0nHte3D9D0DJEJX58XC3G8cOoEIw41okP//nQF7Oyfj+2cPITT8aIg2DICWCqTMcDXTyyScn9rhnm2U=
X-Received: by 2002:a25:d6d0:: with SMTP id n199mr6923617ybg.27.1610129518130;
 Fri, 08 Jan 2021 10:11:58 -0800 (PST)
MIME-Version: 1.0
References: <90b1b5c8-36d5-4094-add4-3a2d211085c2@www.fastmail.com>
In-Reply-To: <90b1b5c8-36d5-4094-add4-3a2d211085c2@www.fastmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jan 2021 10:11:47 -0800
Message-ID: <CAEf4BzZ3fRMjKh5fCLStfJSexsP=rNxE50Mg3CFUo1uhe6B9ew@mail.gmail.com>
Subject: Re: Linux 5.11-rc2
To:     Christopher William Snowhill <chris@kode54.net>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:12 AM Christopher William Snowhill
<chris@kode54.net> wrote:
>
> There appears to be a regression with the filesystem NLS modules. I cannot load any of them. They all produce:
>
> modprobe: ERROR: could not insert 'nls_cp437': Invalid argument
>
> The system journal reports:
>
> Jan 08 02:04:56 mrgency kernel: BPF:No data
> Jan 08 02:04:56 mrgency kernel: failed to validate module [nls_cp437] BTF: -22
>

Seems like you are getting module BTF with absolutely no types and
strings, and BTF verification fails for such case (currently). Can you
please share your .config, and also let me know what version of pahole
do you have (pahole --version)? Thanks!

The fix is to allow such "empty" BTF, most probably, but I'd like to
double-check nothing fishy is going on before that.

> As a result, I cannot mount vfat filesystems with the usual CP437 default. Or any other code page, for that matter.
