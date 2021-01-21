Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC42FF289
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbhAURyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388889AbhAURxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:53:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CEDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:52:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b26so3724990lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+y6HoOTll1MrzW4hWMYJZHq72DOCpTTxfpDkrq4N/Y=;
        b=FmSo8fym+siyyWbcP6UJV64jCQmMTi8M0aceneJgTnzYSWzLEZBNHkHRRjvSbZT6nr
         9NPdk32hoP7CozXT4K1gD5rIfkh8wQSpJJYxvSmy++Xxxy1qpTZ7DwWaIBmK8Fjtxy6D
         8kyG56odyty95Psbws6h//gOfRFBwGjbRNqWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+y6HoOTll1MrzW4hWMYJZHq72DOCpTTxfpDkrq4N/Y=;
        b=G9azPdWqzKxIi5w9ITn+IzA8zW1uu06dB1r5LDBEA85r+UtzYfsrH0qn2gvA2gT/l/
         W1p1UHECq1eCTFYniwy3ORuz3EFGL5rSJWQdivTG6F/UQoDxNzvMFQUIMZdIAN8tUR6z
         LyonEirWeaHVjdIGvu4i/ixde3npUxXx4wT7cMARAtW+nrT+2jLma5HsbDXzH4+jPGLK
         4oKNt7vy23IPIrunB9gdyuihBZF8vrgOclwkxyYBhc0t6eqCsc7HXESPIgMuh1s+M16v
         EM6c84nuVXcchkd5PMXEJSZWa25CAteKIK15YOhmpQEHq9hO2wY94Nba0ZT1m6YVnAmJ
         48Eg==
X-Gm-Message-State: AOAM531RjQetqsQ8rzc8pgusW20OpY1pqHew5TlkpJiVbUKZ54pZNlic
        KyALx6vEmpsPvjtzaqvALUMBDnk64SIS0A==
X-Google-Smtp-Source: ABdhPJz5fi2x+1CCG82h/o5FSm4/obBXnsTxYtZJc5NtB2vCGQVaBZ1Vlxwko6rZPc8L1ZBepGMakg==
X-Received: by 2002:ac2:5201:: with SMTP id a1mr154999lfl.515.1611251570165;
        Thu, 21 Jan 2021 09:52:50 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id s2sm449256lfc.261.2021.01.21.09.52.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:52:48 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id n11so3503105lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:52:48 -0800 (PST)
X-Received: by 2002:a2e:808e:: with SMTP id i14mr221403ljg.411.1611251568409;
 Thu, 21 Jan 2021 09:52:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc> <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
 <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
 <ce1230bd-e310-9b2a-a1ed-1547bd7181e7@kernel.org> <1005a065-fbe7-ccaa-90a0-6488b8fa66de@kernel.org>
In-Reply-To: <1005a065-fbe7-ccaa-90a0-6488b8fa66de@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 09:52:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgW9DXzC2KJGfm7XcXtd82y5J6MW2Patj8UiGaK+3Pqsw@mail.gmail.com>
Message-ID: <CAHk-=wgW9DXzC2KJGfm7XcXtd82y5J6MW2Patj8UiGaK+3Pqsw@mail.gmail.com>
Subject: Re: tty splice branch (was "Re: Splicing to/from a tty")
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:58 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Which is weird as you Cced me. Let me check what is wrong with my e-mail
> setup.

Yeah, I think you were cc'd on not just the patches, but on all the
discussion that preceded them.

But better late than never. I was actually much more nervous about the
much more subtle "cookie continuation" stuff, not the trivial
conversion patches.

Which just goes to show that most bugs are when you don't really think
about it because it's "trivial".

            Linus
