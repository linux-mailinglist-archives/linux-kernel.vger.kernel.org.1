Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8128D18B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgJMPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgJMPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:53:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C0C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:53:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d24so18003510ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfWK18NtBDXacS+2pipGCwnD8aetIwryhOD9nHjnVHU=;
        b=TipCg4sWfwgXfVOd4QpSAltaFjXpF6ejlUins3SGwO0NqaeJyM9Z3vm7kIssqFq7Bg
         aLvy5cCON076ou3CmJyszaKgPdOJH57ZyUekH1LdbbCNmOTZ7scqMrPtPB8Hvaq562nT
         Bbz1U/Jxr7CcjdRs42Asy7oHfQqdbeUoy6eRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfWK18NtBDXacS+2pipGCwnD8aetIwryhOD9nHjnVHU=;
        b=WuTX/eqgKd2KWGpTKE/7LPB5Sitv7YqvUv6IYTEL06KxP6/d051v4N6PzS0YqEVMTF
         uvl9spYMtj+hXWoK4vlY6sgZQHRxRjrL7fRmNKzvDHtc6T9G/GCRVLGmYLwVaeNlQCrr
         MFJ98V8lNqbHS9R9VivWILjKnogvZyf55S5Vg3Z3/bXJTYCzXcnL/VTsfNRTQKfY5WgG
         uavwX6zAriKn7HreYtuMmEZ2gTK1hQ7EBjnbXSyriWX6bVfJAACeTT1RZ8QgeYRiYx/H
         XSZo0hVvh+dIzAqZN5AgTDGeyDTI1zJzz4SM7EIsRRM0JbEwp48vJmoIHTdAeOIIeYmi
         7ILg==
X-Gm-Message-State: AOAM5301/PTaSuN/EzfFt6JBQWpZuf0cFlP4YZv72BcmybEpHtL7O/wZ
        bCRPl7kE/IV6P6PRlEKayEU5tZIOPElPGw==
X-Google-Smtp-Source: ABdhPJwkVS7x1YnMApmu+zXnvb2In/83SGS+addy4mRQh8erb1gLhyozKiSfpHVWYkycWuuFYHaFUQ==
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr74136ljk.160.1602604422846;
        Tue, 13 Oct 2020 08:53:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c4sm23748lfm.294.2020.10.13.08.53.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 08:53:41 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id v6so218833lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:53:41 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr28334lfa.148.1602604420750;
 Tue, 13 Oct 2020 08:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201012172415.GA2962950@gmail.com> <CAHk-=wgf8ko=b-F74+Qc+EX6M36kHx5wEBCS8nJK1WSod9UO0w@mail.gmail.com>
 <20201013080557.GF3302@suse.de>
In-Reply-To: <20201013080557.GF3302@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Oct 2020 08:53:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8txKwKjZ-2ZOVEoEePaiSXfEAsj5druEZqH1asmpPXQ@mail.gmail.com>
Message-ID: <CAHk-=wi8txKwKjZ-2ZOVEoEePaiSXfEAsj5druEZqH1asmpPXQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.10
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 1:06 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> So pre-allocating has its implications. If we decide to pre-allocate on
> x86-32 too, then we should be prepared for that fall-out of the higher
> memory usage.

Ok, fair enough. Probably not worth worrying about then, particularly
since 32-bit x86 is becoming  more and more just legacy.

           Linus
