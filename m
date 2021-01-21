Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9822FEAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbhAUMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbhAUM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:28:06 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:27:20 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 30so1255099pgr.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hU5q0Sko1dtjWyl3dPZ2Wmvya1h/lMcf2ondb1RlKrA=;
        b=V/9WTD9b5c9Ra7OAXiIb1Cr4wsPSfZhMEz4uCmsr1EXhXjj4sh4F0wtK6Dx7b3lQ1K
         ldNczaDIRWzx2aYg6Y1ijAAgRcc9pJzLT9kli3qwX/ub7OZ5thP5FipicHuJIpHebezU
         aYW+f2GGtyKaZFr1ZcpJVEVfytjy5emL2fILc1DYaIR9m6dMw6NyIexMxjhIdYZk9NEw
         ClmOrGe7k10AsIpm7/NMq2oEFQbfAZJHOPfX4HC0Bp9vPGfswnplSsLpUTv8vd/C6p/p
         IUVon/FpdOe9seG8uLNM6xT5SQqqed5DxVLvq3uzmu2kgLloZ3S5LiHpKDIRENnAdxGp
         6MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hU5q0Sko1dtjWyl3dPZ2Wmvya1h/lMcf2ondb1RlKrA=;
        b=TKxtJ/awBveMwVAvR4uLDwNe/1XczjCZX3xQsWb64BKl0CcBv0w3C/81MzGO6+j837
         5rN9yLq3DSA/i2AOVWImx6VoE5EoTM1/ogtZn75yVWPgUXdjjNYc03hOaNnYTagRToPP
         AhfNcSTBBucbeMBOUWyR8HS7HiHWC05/qFcf8UPRRs5owXT1DlAtkO2eA9pEBYKCthAH
         /eqIjqRMR8M7uoZS3Fi1jCLlSKhtLLtRi7r0TujdatWv67H7e2asEZn4QuMdM1FxVJzj
         oML2iFBV6xOx4f+nXt/fP5N0GGIFP/urieT/pO3oOAXQCTvYxWUOFatnMLps5NI7Vv2f
         ZjtQ==
X-Gm-Message-State: AOAM530eYA34kFZa5UU2aXTKDEkmqp5GLE3rdEPTOPBj/wISHcO3qm2Q
        DcvmB5IuBzqTzR7LQCfFfhx7W0xOO4T3IlNWG/X6hzV72F0=
X-Google-Smtp-Source: ABdhPJwvrgCS3UCF3bviwj9HDvs4ENPmUAzlUL2EEFwyD3gRuCx7zpDU5vfvODSZFju6Ly/BJz5QIDNYi0p9g4uxOR0=
X-Received: by 2002:a62:5c4:0:b029:1ba:9b0a:3166 with SMTP id
 187-20020a6205c40000b02901ba9b0a3166mr8580075pff.55.1611232039810; Thu, 21
 Jan 2021 04:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20210119172607.18400-1-vincenzo.frascino@arm.com>
 <CAAeHK+zpB6GZcAbWnmvKu5mk_HuNEaXV2OwRuSNnVjddjBqZMQ@mail.gmail.com>
 <20210119185206.GA26948@gaia> <418db49b-1412-85ca-909e-9cdcd9fdb089@arm.com>
 <CAAeHK+yrPEaHe=ifhhP2BYPCCo1zuqsH-in4qTfMqNYCh-yxWw@mail.gmail.com> <773e84d1-2650-dfc8-6eff-23842b015dcd@arm.com>
In-Reply-To: <773e84d1-2650-dfc8-6eff-23842b015dcd@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 13:27:08 +0100
Message-ID: <CAAeHK+yV_w3KKWg1bY-Kk=QGGR-=yT=9Ez-XOchY6XOA+h4T3Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: Add explicit preconditions to kasan_report()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:30 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 1/19/21 8:56 PM, Andrey Konovalov wrote:
> >>      return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
> > Do we need is_vmalloc_addr()? As we don't yet have vmalloc support for HW_TAGS.
>
> It is not necessary but it does not hurt, since we are going to add vmalloc
> anyway at some point, I would keep it here.

OK, let's keep it.
