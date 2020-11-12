Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EEE2B10A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKLVui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgKLVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:50:37 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4540AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:50:37 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so6966545qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z3CD5S2CALksgVm8ns6TDId0Or2oDJ7UUxweYeXuETU=;
        b=U390PW+SMYc2n3VhGqRdsw6ONn1j5/PFCvEM+sQVMn87P/jOlwMimILpr8rOajdlyi
         8ZHLfqbRDeyFh6wvw+1TeVFDhfH2xbTfvCtZLSIIR5MnX//LoWO3SShkhTCUoBDKAXhN
         0v2Jdppw/64njlOh9pBLHiIpRQEWmT7nsTQlJ7trrTh43WqRbpWjJZOAxQbv51b6G8nw
         sDMGA3HWPsVEMphn7HzKe25+RJfep7tnTQehFspm0Jv44wIP9rPdq/Zd7Ua+lIiYFPbt
         6NQNtxAHfbzZ2imANyZP1v3HOmKbb9OQfImCYvoi4V12Wd8TziesokuvAn5GbLw4pm2g
         c7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z3CD5S2CALksgVm8ns6TDId0Or2oDJ7UUxweYeXuETU=;
        b=IzErNDyWUCWxLmGIEOHKpjqr7mNjRVmN/l3fOHNUvnz2RT4oJrLYX4L4jUSkhgDWtH
         p8XFLBGDWdR/VhG0aNSQzJs5rQt+VSyuHzq6QRC7fyp0yOSyJjQpD3CgwXDcIizk6bF9
         iThoqBfcJIb3ePEIFmAK7D3Ip7ox4W2WFOdO39qtyMJ1X4B2X7qLPJGUAvLeG/37AKdE
         W608B+HSlZ5gN/6oi5RXYWzefy6cdZSAJhJSV3HGNmmYP08cGdUU/rEbL0bGITHKy/Md
         Y5+c1xIWus6mcB88Ct/rY1cUUvy+CkR0Q+Nf5GVfns9g3NDFmNueynS8G24YOu4W9E8H
         /kCQ==
X-Gm-Message-State: AOAM533aDXEGRqBQUzRqKMxG4rqjmXkfP92IJqXbvnTlj4C81PT7mQtJ
        Vp0g8b/Gg5gR9c0bGVCVHfI=
X-Google-Smtp-Source: ABdhPJzndxGbL4rY+Uq8CS5dGOM9/e02yEyMIYyApn15onZ5PbPo/rpJ/ocftWBNZi52TI1ukQ4VNQ==
X-Received: by 2002:a37:8c43:: with SMTP id o64mr2049159qkd.176.1605217836431;
        Thu, 12 Nov 2020 13:50:36 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c79sm5529081qke.69.2020.11.12.13.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:50:35 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 12 Nov 2020 16:50:33 -0500
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201112215033.GA438824@rani.riverdale.lan>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com>
 <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
 <87sg9ghil5.fsf@collabora.com>
 <CAKwvOd=QrU6rCQ4_Ji=XsskPovOSXpk0NkjTqVjLijw1-CZ17Q@mail.gmail.com>
 <87lff8gesg.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lff8gesg.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 04:15:59PM +0200, Adrian Ratiu wrote:
> On Tue, 10 Nov 2020, Nick Desaulniers <ndesaulniers@google.com> 
> wrote:
> > 
> > Yes, though additionally Arvind points out that this code is 
> > kind of curious if there was overlap; maybe the parameters 
> > should just be restrict-qualified. 
> >
> 
> For now I think I'll just re-send the GCC changes and leave the 
> Clang optimization as is, until we better understand what's 
> happening and what's the best way to enable it.
> 

Note that the __restrict__ keywords also help GCC -- it saves it from
having to emit the non-vectorized version and switch between the two at
runtime. If we can verify it's safe, it's a good thing to add all
around.
