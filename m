Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3B1EEF94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 04:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFECli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 22:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFECli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:41:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB99C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 19:41:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so9811632ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zd+zdiSrHowHhh1b+J06lfUeaSm83BjFgaTjWHrczMU=;
        b=J0K9miM4j9eF68SRGydo2qWV257tzFgn+zXZgNDlVsN8UI+P56NCvzd8J7lUUxCTVF
         RN855Q453tWgwpcbwuzrZuZ03GApAlS3UX5S6Wkwpc0dTKDYGPS/rpTgc1HE8kW4OGhp
         bPp8+wXoytif/zHrGcv7OHSPUioe7Y0P9NRMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zd+zdiSrHowHhh1b+J06lfUeaSm83BjFgaTjWHrczMU=;
        b=HThFX43E4QnaxdMMQC1TbGYmxbZIAKgFl2XexLoCQP0NHYiB3pGcZ+AwBIrc1lWNgY
         ZLKXlQxV1XfNd3CVIhInVI2qs4QkNX05Im4i27e9GhK7btMbUmAqiBGG16KT/MkrGjeM
         2Q0yFHN2CVxC/MLTgM/IWRoClYcvmzB97GpoUXFcM2lKFbp7oHz1ksydRTu3xQAwcELr
         486euim9jhjg1XyXdk8lRt1TxyKSZezmC/ptDJ0kbSPWO1K5fEsMtbNoSDGfJ7A/y4K4
         s0GZ8qo97SvZo4YoDjoHf2UTdZYhRJhDo6lB0J80mH3IfkzF+Hk76HM6Y+mlbF7iiGRB
         W3eA==
X-Gm-Message-State: AOAM530xMPNovE2RaGMDbNT3SdtsT1hvH28DPJCdQ6QsgC/XJ9c5nqfS
        XCmpFj3wvDpPvdN4YaULRlyxsdCLggo=
X-Google-Smtp-Source: ABdhPJxamV2I1bVkaQ7h1A79LW0WyLatXasNpLUR6ztHgyGeU0EedzfjX01D2OD7hXbirpW4pVEwIw==
X-Received: by 2002:a05:651c:10c:: with SMTP id a12mr3327463ljb.356.1591324894967;
        Thu, 04 Jun 2020 19:41:34 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id u4sm284545ljh.12.2020.06.04.19.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 19:41:33 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id r125so4824269lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 19:41:33 -0700 (PDT)
X-Received: by 2002:a19:d52:: with SMTP id 79mr4118228lfn.125.1591324892777;
 Thu, 04 Jun 2020 19:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200601170102.GA1346815@gmail.com> <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
 <20200602073350.GA481221@gmail.com> <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
 <871rmxgw4d.fsf@nanos.tec.linutronix.de> <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
 <20200604172904.GA1751362@gmail.com>
In-Reply-To: <20200604172904.GA1751362@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Jun 2020 19:41:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK846PwG_qNqyb-q-BSPALb=xZ9k6ThVjRm8u=vCpkqA@mail.gmail.com>
Message-ID: <CAHk-=whK846PwG_qNqyb-q-BSPALb=xZ9k6ThVjRm8u=vCpkqA@mail.gmail.com>
Subject: Re: [GIT PULL v2] x86/mm changes for v5.8
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <sblbir@amazon.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 10:29 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Yeah, sure - here's the updated pull request for the rest:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-06-04
>
>    # HEAD: bd1de2a7aace4d1d312fb1be264b8fafdb706208 x86/tlb/uv: Add a forward declaration for struct flush_tlb_info

Nope, that still points to

 0fcfdf55db9e1ecf85edd6aa8d0bc78a448cb96a Documentation: Add L1D
flushing Documentation

although it looks like the 'x86/mm' _branch_ does point to that commit
bd1de2a7aace.

You did something odd where you created a new tag, but used the old branch. Hmm?

                Linus
