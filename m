Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A12FE9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbhAUM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbhAUM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:26:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B8C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:25:54 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w14so1412191pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOyrg08vtxiHPYZkedOlgXvEt/7RDWD4URVSIByL7Fc=;
        b=vxEAz+KkpNsnMQSjbsAbC+YcXrwg5AqWezlWX9IuB6vUshHU2tz1TmfgwZoL+FpHrR
         5t6LE0FcRmyUiASd7urdAe/Ym0ifCVaGqaShldzrNMpFa1tCnfDh8cDxLaowNMTU96zE
         WOa8U+ToUCXZOWCbi+8Yz76+yriA20BTbDW7slV4qpSJNk/hmBI5lpCqCosrDzgFqbVt
         ofwtFI05bGL2f+QEK3I5lUT9uEJSTMYWjyyKpCab/JSPYPodCcetA958QHbz9Bxgnbcs
         GdwvjVYnAeJMdQmVQuxfTp04OErBJozK+vLXEtPULRCKkA3bp0S1C8ZTWl50ES3yyfC8
         6f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOyrg08vtxiHPYZkedOlgXvEt/7RDWD4URVSIByL7Fc=;
        b=ZpIqzic9BrTHoKrbfknpPFvjBeEJrkxS83pOefvhpifXgTrqhWqQdGfo5DtZ/pFokb
         v1zKs5v7Wy8Mg4SmR3jaIdsDpLRhzQXtz2vfs5378riO8WwGMEjmOqQmeq+k9THFNS/s
         Qd6DpnVyeQV3dlBEQL4yv687g3zI3ARCxv1QUgNhMzGoLfv8bh6Xh2z30j/NO011+pTe
         OvV+46XJ5891IntHoMBHK5tFvZszWDJ2KfjFFCL9t8Ms5LncJnewOu9w8CTrja+I5dpm
         rT4ahcTjco5wFcnxWidax5E2PIXrZYKdHyR16KeJm03lSg/vNmhlKvY4pThRSSbjWAwc
         Bbig==
X-Gm-Message-State: AOAM533bAvlddnz6QZ3WUpfLb6HpL5NI1DsX58YymiligtqsWf+b14G4
        GVVW7iIKGMATS1K1vH0+Ad0ymfqkr0MW1VTYH61aYw==
X-Google-Smtp-Source: ABdhPJzLUpxG/Y9OA/+eupih8gVMoAm2p9lHVjD58Asu7PLIsj0Vph2NRrbuCj/5X9qDer9lqDjZAQzLBpgFWo28lL8=
X-Received: by 2002:a62:5c4:0:b029:1ba:9b0a:3166 with SMTP id
 187-20020a6205c40000b02901ba9b0a3166mr8574872pff.55.1611231952154; Thu, 21
 Jan 2021 04:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <CAAeHK+xmmTs+T9WNagj0_f3yxT-juSiCDH+wjS-4J3vUviTFsQ@mail.gmail.com> <ed20df73-486d-db11-a1b9-4006a3a638a2@arm.com>
In-Reply-To: <ed20df73-486d-db11-a1b9-4006a3a638a2@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 13:25:39 +0100
Message-ID: <CAAeHK+xOcxNNNWosLZqTC1mOQZLScfDNwtTA0vCYTb8kc=UJ_g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:31 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 1/19/21 6:09 PM, Andrey Konovalov wrote:
> > Hi Vincenzo,
> >
> > This change has multiple conflicts with the KASAN testing patches that
> > are currently in the mm tree. If Andrew decides to send all of them
> > during RC, then this should be good to go through arm64. Otherwise, I
> > guess this will need to go through mm as well. So you probably need to
> > rebase this on top of those patches in any case.
> >
>
> Could you please let me know on which tree do you want me to rebase my patches?
> I almost completed the requested changes.

linux-next/akpm should work. Thanks!
