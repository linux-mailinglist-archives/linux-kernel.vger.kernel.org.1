Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB89272A58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgIUPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgIUPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:37:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:37:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so13210667wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVxfXE34UyHx4a9aedDaVHUi6pKMiF4098HvY7EGT4c=;
        b=BYc74rVcObsxY5RoY7FBMvjUz7I+HJaB7IhAMx9FrV1rganW2S1g6KUoFgpgpnqRys
         SMWPacFyEdfqMPAw5HLCbJQmqVoKTUYfmyOBS5OBxGnpGhFWTsvJUDm8nnbfIdQAnRtP
         aWeprctyWDcO0WTV0CPMaJuFaew74ic3MENre4wcGr/Tr9AA0Es0vAnGTQmPqQQH9S+o
         +AkdKBo++MoypREVKrTr/WFM2sS3+L4CeJ6HVm2xZY0709ol4d7QVZZEDV8tRX6B77wj
         ZTn0MrnZ2DI7QIXulRGzqTFj1m6iSSKzHv/qCHZXxt2ZHklgUOXHUQGCBfgHNiYtlCCe
         vWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVxfXE34UyHx4a9aedDaVHUi6pKMiF4098HvY7EGT4c=;
        b=Gz8l+vKeM3FQWkjApO5wrt/8zkuJwTRKxxOjCfEFfVvSnX5oDfz/WnpPHsIQhWtL2z
         U25kYnAzsfEwVvh+oQb5TFo47NBb0RyK0m29U+mcKIRvb0XRsVSB3F6QGOg1A7LIQOm0
         eUv7qXXmjvH1ciJDLxwcClTJ+pImtGpfoW04HBz1c9TdsL5MSFzKi4Luoy/Xq7FqnHIB
         e4ol53lilBM/pKGJW6a2zfgXgmVns/HF6kPtwQh0AsiUru8A1NVD1TejmITW5Q+86DS3
         zTF6waghumxJdK2nHYoF4AjbVrRoCL57zZA315fj0YheBB74e+dh/rxPwThTa9QfLjFW
         wilA==
X-Gm-Message-State: AOAM531mlenreYRvBX/HxFemNkoMUA8UYo+/zuXSprptKVpzsl4KZzbi
        XWs+jTldU9w71luhaVmPUEjTxvKDVgQLjl1VnyqRNA==
X-Google-Smtp-Source: ABdhPJxOztNZkizJnsXhj3wk+nWXFKqGPJsuyIzMb4d7s9SxqbYZ2lfULvl21tc0mzpAWLEjISHQ1AcbURiGb5k8xgg=
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr199189wmk.165.1600702641972;
 Mon, 21 Sep 2020 08:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck> <CAG_fn=WKaY9MVmbpkgoN4vaJYD_T_A3z2Lgqn+2o8-irmCKywg@mail.gmail.com>
In-Reply-To: <CAG_fn=WKaY9MVmbpkgoN4vaJYD_T_A3z2Lgqn+2o8-irmCKywg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 21 Sep 2020 17:37:10 +0200
Message-ID: <CAG_fn=XV7JfJDK+t1X6bnV6gRoiogNXsHfww0jvcEtJ2WZpR7Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
To:     Will Deacon <will@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 4:58 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Sep 21, 2020 at 4:31 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Sep 21, 2020 at 03:26:04PM +0200, Marco Elver wrote:
> > > Add architecture specific implementation details for KFENCE and enable
> > > KFENCE for the arm64 architecture. In particular, this implements the
> > > required interface in <asm/kfence.h>. Currently, the arm64 version does
> > > not yet use a statically allocated memory pool, at the cost of a pointer
> > > load for each is_kfence_address().
> > >
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > Co-developed-by: Alexander Potapenko <glider@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > > For ARM64, we would like to solicit feedback on what the best option is
> > > to obtain a constant address for __kfence_pool. One option is to declare
> > > a memory range in the memory layout to be dedicated to KFENCE (like is
> > > done for KASAN), however, it is unclear if this is the best available
> > > option. We would like to avoid touching the memory layout.
> >
> > Sorry for the delay on this.
>
> NP, thanks for looking!
>
> > Given that the pool is relatively small (i.e. when compared with our virtual
> > address space), dedicating an area of virtual space sounds like it makes
> > the most sense here. How early do you need it to be available?
>
> Yes, having a dedicated address sounds good.
> We're inserting kfence_init() into start_kernel() after timekeeping_init().
> So way after mm_init(), if that matters.

The question is though, how big should that dedicated area be?
Right now KFENCE_NUM_OBJECTS can be up to 16383 (which makes the pool
size 64MB), but this number actually comes from the limitation on
static objects, so we might want to increase that number on arm64.
