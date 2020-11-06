Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC42AA175
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 00:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgKFXfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 18:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgKFXfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:35:45 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 15:35:44 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id v18so3232498ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMoRYBx4DAMN87q/Qxn/vkeSV0JGOokfdGoi2qdQtlk=;
        b=VQ+L+ATYA/FZIZUCETHW1K7D8w79F/MTq60EL9Ec3V4gnL9IJk8F3eb9idwCVvlRrc
         8Ei7CiqYZhn9fJsh+UeL/UiWhSlZBoGexP7WNISG75CFbsrLzos5TPu5Mh5YQxnnOPjp
         G1doOAZS+cP9vHOV84ZoEALRhSaqHK+v2uXvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMoRYBx4DAMN87q/Qxn/vkeSV0JGOokfdGoi2qdQtlk=;
        b=E03MNvN3bjyLvJoNNQLl1ASSuW86PiqA0+KvYuA6Xsvb+lZt0FmeEth41TuqBKMWVO
         9JFWhH2BdmOhSYYjouwmnetOZC0Qg5BdLFN6E/MxcCO9R+1z8JwDFvHeI53t9S6/Ce+M
         Vu4TyYDHYUBNY+dfrCrmWTA60lPKaDOYuHkmJWSuEACH5B9CjbNVTyuZ//o4Wc/DKNxz
         ZhWUOqPzXYjYf5CSMneAD/HgA0eTQ8Xn7KA4BKCCwZx/iCZIxylLONG+COdWMGcXXlmv
         QKB/hKqYyRsfiHblx1h3EAC3XRmdZzDTwWI6hgGrzHqHXwWJmOJOjLq/qa5K0B3f/xsK
         hhUQ==
X-Gm-Message-State: AOAM530OcxOKrGPz+8Vmhl6pS9Coz+9eMPjK+GcE78k+0lq5lpLTW8iG
        zjjj8ukcxR9L4O0C2gPTE9aBwCCxxC08Mw==
X-Google-Smtp-Source: ABdhPJzgF/ism6O6h1XdA9hGNBaEH4OWpsiV0OhgkLK1R4/hNoHTBiwlbyk3PlRM4ss0TMWjJ25bPQ==
X-Received: by 2002:a2e:b5b9:: with SMTP id f25mr1694646ljn.309.1604705741906;
        Fri, 06 Nov 2020 15:35:41 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id o3sm248623lfo.217.2020.11.06.15.35.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 15:35:39 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id s30so4246279lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 15:35:38 -0800 (PST)
X-Received: by 2002:a19:4815:: with SMTP id v21mr1885811lfa.603.1604705738619;
 Fri, 06 Nov 2020 15:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Nov 2020 15:35:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whM-Cm52o1kBQD4eS3Wx=XWr_z7sq=H88pmyeK_9L0=VQ@mail.gmail.com>
Message-ID: <CAHk-=whM-Cm52o1kBQD4eS3Wx=XWr_z7sq=H88pmyeK_9L0=VQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
To:     Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Guantao Liu <guantaol@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 3:17 PM Soheil Hassas Yeganeh
<soheil.kdev@gmail.com> wrote:
>
> The first patch in the series is a fix for the epoll race in
> presence of timeouts, so that it can be cleanly backported to all
> affected stable kernels.
>
> The rest of the patch series simplify the ep_poll() implementation.
> Some of these simplifications result in minor performance enhancements
> as well.  We have kept these changes under self tests and internal
> benchmarks for a few days, and there are minor (1-2%) performance
> enhancements as a result.

From just looking at the patches (not the end result - I didn't
actually apply them), it looks sane to me.

             Linus
