Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D22F7DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbhAOOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbhAOOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:08:49 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5DDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:08:07 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id c7so11705722qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S97i6AT8RiIBnpA9TrOdE+WMINZPh3gMrVKaHT8SvQI=;
        b=AyEz5HFbvrjtoATTZTyJk19CqsxNCSBEexmKakLdArxfOMmaXCPWwfF0v4XmrV6JT4
         +yFg7PXKMvIG+mfdmo7PawvFGMkWD5ogkx4fayrXnjQgmHBB88ZOvhshWnihBpw/mrgC
         M71FaO9EW8DUZKjrYE47t0EtbI/PhefULBsibFSkkMWc5F+ArcpD7uvLE5pYj7OYf0+f
         JVPmo5zmWmdDnKZBXYzrjD/rUzQzZWCnoPZkJE1dla3TA+z3YUacwrzvHzy8ObX4LxdP
         3cbEF44HW2vjJLOiuAPc/nNQfvPDyrttDeuvTj5h7OqlHdapj/yOHwwO/1rUj2/GUH5x
         12wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S97i6AT8RiIBnpA9TrOdE+WMINZPh3gMrVKaHT8SvQI=;
        b=aFZ7osULJDeG9Z7XyVuQkKo9d/hmhAOxmCvWHGFL0lkW1qvm7WgmZ9NILhrWZ2Y6AH
         UyGfpXhhv92O5jUU5/wLTnLsbmdVeevTej+ba6+l6NYOCk9Zeeag4IhmtIDhzTE5nPAz
         J2EeXz3vriH07XqIjuBIeBDw5O1JZ+q+ra6SaWz7MNDBz8s7YBtGH2G6/xFhr3nIGpo/
         aJSJMOER1oncbaEZgNpuv5uTqcOTTAsxEzlHYWeISIxkXcWz2GQfoVS1fVDezoS95/uH
         pWgqD+4jBF4Lp+4e8GKBLYCla+VKuXcm6+CgR8r0h92ORnzBEbIG51U6EnfKIcD190Oo
         gGjw==
X-Gm-Message-State: AOAM530I3VRi5ElpydqvbPhIoUsUUtFlkl0GTj/C3k7ZbB0haUCVQkBy
        DhGc3BfqmE02/8LlXNjKyvIYL9nv7rV1lYfj1beflg==
X-Google-Smtp-Source: ABdhPJwZpjfieKNEFJZpqcsV/gj6mKKxI1ktNZouHv6l3Vw0ybNnInc/LSJNzLqepr3Ql89owFGOILJPzsDtofXrDSQ=
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr12340951qka.403.1610719686159;
 Fri, 15 Jan 2021 06:08:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <03fae8b66a7f4b85abadc80a2d216ac4db815444.1610652890.git.andreyknvl@google.com>
 <YAGWavYGrpZXVF4M@elver.google.com>
In-Reply-To: <YAGWavYGrpZXVF4M@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 15:07:54 +0100
Message-ID: <CAG_fn=WSkyBnb5vo5AVpeqodgM=0GSwCrZNePF87SYB1y5fU-A@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] kasan: move _RET_IP_ to inline wrappers
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:19 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> > Generic mm functions that call KASAN annotations that might report a bug
> > pass _RET_IP_ to them as an argument. This allows KASAN to include the
> > name of the function that called the mm function in its report's header.
> >
> > Now that KASAN has inline wrappers for all of its annotations, move
> > _RET_IP_ to those wrappers to simplify annotation call sites.
> >
> > Link: https://linux-review.googlesource.com/id/I8fb3c06d49671305ee184175a39591bc26647a67
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Much nicer!
>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
