Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57462273205
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgIUSfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:35:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:35:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d9so10047614pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/2Z8IartBkPtffqIjRI7bDn8ReaBQI4yKoJOHK76NzU=;
        b=N5VnRGG3UinLkmKATCgG20q65Ejs+/qK8kOdK6WTtEAzuq6GtOBWcP/A2Xc/L2DDHl
         FeAQ+dJzzzWSZdUZNBEZxz9MGUqoadPHzHPfiTRTiKBmt2Vaybqt9XMVQC7cfNbyYrSB
         O7M5aTKfIdUWnCmCeHADhfe+R49GLTvWguPCFVpXr/3TNR8DgmbgYLHfwjzn4z+/btRx
         KTy8zA2w2qPGp/0zzljIPNGTM/ZLFgjOBu2Crv1L+mux1usIFczRz+CMyyM3QkRAzs+w
         Cz43LvV9wOy7f6nRW6lDZiRkU0DLOdk9ODdcjB1I1fTu0alTg3vphjgLHXBhb2ChEa7S
         uKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/2Z8IartBkPtffqIjRI7bDn8ReaBQI4yKoJOHK76NzU=;
        b=t0kHhruu/706JBNynUtkEcTfSjSuv/LhxuObgA82HDGGjoFuwBWAWAwpbtkFSgdgsX
         Llxz9lQu9QwtoKw4sBNq1218d+QEGom9C0948B8USa83y/MVV7Y7mNrPNc4yXzbnNpMp
         Lf+2z/rgv4xu9FOrIYjH3YESTcFeLaUFYGtJPzDQlwuSfmxlFFhp02UoVevwAXmvgB0S
         nViu8yT+xRdvgqhZFEDR39MXTyPW62sUu+8U4e593YJQ5yDMobHLD7N+/nxuL7JYQgD5
         SXbVi9AvdGuDbNRhxlrNx/nYxS0DYAMyNQUwNjFv33Lk4aYk3lJPTQQuAPSae1Bkb54c
         xeGA==
X-Gm-Message-State: AOAM531kIDu0rtJkiNr3rkXqYHqLcH5mZzBNykxKUhbgND6uBMj9mKyM
        eaPjGo5pCRPnPZCYSEj1E1uJkFROo43qundBrjnLiA==
X-Google-Smtp-Source: ABdhPJwzOLY3JOyQMdXQlvGgHxA7es13k1t0ixfOKnHwmIn512BrNKuuEDqN2QxAEj7fYfAaMxDEPoHbj71Ti5BiV3o=
X-Received: by 2002:a63:7882:: with SMTP id t124mr685123pgc.381.1600713302134;
 Mon, 21 Sep 2020 11:35:02 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Sep 2020 11:34:51 -0700
Message-ID: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
Subject: =?UTF-8?B?ZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhkYXhfc3VwcG9ydGVk4oCZ?=
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>, dave.jiang@intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kernelci.org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello DAX maintainers,
I noticed our PPC64LE builds failing last night:
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047043
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047056
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047099
and looking on lore, I see a fresh report from KernelCI against arm:
https://lore.kernel.org/linux-next/?q=dax_supported

Can you all please take a look?  More concerning is that I see this
failure on mainline.  It may be interesting to consider how this was
not spotted on -next.
-- 
Thanks,
~Nick Desaulniers
