Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2974C287EFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 01:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgJHXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 19:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJHXKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 19:10:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA9C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 16:10:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r21so2234054pgj.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 16:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=huNoRIdSFpI9osYj0Zanh/sVIIaopm6n5nRrz69OQbw=;
        b=m4LWGF/tsX9ES7Pg2pKcZIC8l64KYx/UzR2x6lpLCzQTfCXYw11yP5EmAFa37yNKFU
         gapizvmE/3LmANm9YRL8DBkIG6a6TRaG48/aYtl+i7aL7BuR12BMnX+BvX59MqFJwXJM
         GQnZUkNb9/+vJ9MZQLttwxNXodwBiSK8A6hZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=huNoRIdSFpI9osYj0Zanh/sVIIaopm6n5nRrz69OQbw=;
        b=q/cukKbAOXaPTabVhddJQFRX9ZUh7V3hINX8jTXwV110ysKGW2Ymmmb0gkEAckrEV5
         aLo/7rgGcx/ltwx3PIWa/ZN3aOmdtkGaIiZcUMtgkpciKpPjmDne0au9NOYPabiTBk28
         vvBbB8lJl4PPWz+85QfpmSBNooJg+aMYThv8no5Xg8lWM9Jp9jM4BjbOHEPc2CGMf8Wm
         S7SWwv0Rg6RSXeRsn55ZkN+XaUnZTs/dO1kzguP8no9hbsGEm3hU151I6PwkbqKK7jfx
         ARGq7IiU4YRitFQXEwVT7UWwPaH9EpAB9jNlxSDEkd8ePMloO3wQhclf1cygoo/pyVyL
         wpgw==
X-Gm-Message-State: AOAM533ExBB/MEFhGLpCdmexSsuI2FfDx2P1GKEtNut1as4NFHsLU7F5
        aM83xUSU9MSPJloTaa9nqnhZfA==
X-Google-Smtp-Source: ABdhPJz9MNSH7R58VxI81YC9Wu68n7SohNOGAow2G71lbVpzp/qQZq+clc+42N5sqiR7/n6+knThDw==
X-Received: by 2002:aa7:94a4:0:b029:151:d786:d5c2 with SMTP id a4-20020aa794a40000b0290151d786d5c2mr9273480pfl.50.1602198639047;
        Thu, 08 Oct 2020 16:10:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w187sm8143383pfb.93.2020.10.08.16.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 16:10:37 -0700 (PDT)
Date:   Thu, 8 Oct 2020 16:10:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Pekka Enberg <penberg@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Odd-sized kmem_cache_alloc and slub_debug=Z
Message-ID: <202010081608.E1401C067@keescook>
References: <20200807160627.GA1420741@elver.google.com>
 <CAOJsxLGikg5OsM6v6nHsQbktvWKsy7ccA99OcknLWJpSqH0+pg@mail.gmail.com>
 <20200807171849.GA1467156@elver.google.com>
 <CAOJsxLEJtXdCNtouqNTFxYtm5j_nnFQHpMfTOsUL2+WrLbR39g@mail.gmail.com>
 <CANpmjNNhG4VuGq2_kocsTD3CnCv-Y4Kvnz7_VuvZ9Eug+-T=Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNhG4VuGq2_kocsTD3CnCv-Y4Kvnz7_VuvZ9Eug+-T=Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:31:35PM +0200, Marco Elver wrote:
> On Fri, 7 Aug 2020 at 21:06, Pekka Enberg <penberg@gmail.com> wrote:
> ...
> > Yeah, it reproduces with defconfig too, as long as you remember to
> > pass "slub_debug=Z"... :-/
> >
> > The following seems to be the culprit:
> >
> > commit 3202fa62fb43087387c65bfa9c100feffac74aa6
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Wed Apr 1 21:04:27 2020 -0700
> >
> >     slub: relocate freelist pointer to middle of object
> >
> > Reverting this commit and one of it's follow up fixes from Kees from
> > v5.8 makes the issue go away for me. Btw, please note that caches with
> > size 24 and larger do not trigger this bug, so the issue is that with
> > small enough object size, we're stomping on allocator metadata (I
> > assume part of the freelist).
> 
> Was there a patch to fix this? Checking, just in case I missed it.

Hi! I've finally carved out time to look at this, and I've figured it
out. My prior redzoning fix was actually wrong; I'll send a patch to
fix it harder. In the meantime, I've also discovered that the redzoning
code wasn't safe for sizes smaller than sizeof(void *). This oversight
is, I think, what caused me to incorrectly handle the changed offset the
first time. :P

Anyway, patches incoming...

-- 
Kees Cook
