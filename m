Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67D226F987
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:46:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:46:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so4932997wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgPTd8GJDPNaoiWfgXmr6X5TAsaC/3AQihdlF5dTIOI=;
        b=qqhCH+vkGBp6YZSODpBl+ykCrFasu1vfprL2nycyIhNjHPUV7ySJpsDabxXJsyrBJe
         43CB2zqs/djSdJMfzd1nKkOAw9kxDUJZ6l5+QvZWrdCGxrasbp/afVvkSW/nFZWiAvTV
         eNX3pbWirs5zIdt0XnFKFTS2n41cETV7pnB81hO3ftQKFVApTJyQPypSgOwpItX1hjXY
         zLN5rWDVLcWx+zNyxBm4+W3G1yAp5+ov34msaSYEt2r2zzPh1iMM+qGez/n8/YxJ09Z0
         3l/IJNmZ5UN5xIN1BewwYPYZgxqfmdfjVBQ3bsSpz+VGrkceVBWMIyW6oNT7WTMbWpAB
         QIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgPTd8GJDPNaoiWfgXmr6X5TAsaC/3AQihdlF5dTIOI=;
        b=KBSgvEpvTTJGgBwi61eMMhRjUUlItbuM1CI1IHrWDlPt5gl694ZrggsoGNBPu8Rkd9
         cxzYDuxFSPXiDz+fXB30A1lmLCxavUPxfY+xx8ld4tYJjVcICb/J+ovHKJJW92YMo7jb
         ojQ1PAD+G7cXBEd19jbWmT6NEyl0GFXuc7Dd3pNvQohqt9mSq6oIoXAvoNxN+AuwPEab
         Ekp4NOjI9A8D0Lnja7a3Y+aFk/DpqCvpb87hcRgjoj5K7Ncp7RRydiA9T2+Kv83OoF1O
         Zw5glowN9+XB/MNqx+fa/Y1JUOpZMyC5zCW7yoiRYpYQYqoN66sYHnC0udtmeorSc8id
         8ZYg==
X-Gm-Message-State: AOAM533cNAteZNO/aRikwliXZFRw1cybtzjJr/jnX8nbEwBuYo6Xo+TP
        E+NQHULOZfIhrCf9r22B8UZIOfDLqWTjTcpd1y/HDQ==
X-Google-Smtp-Source: ABdhPJz0jOiQsriiNYEfJ+pE5eUwdvbpZPECY1GZun6q57sZypArkv+Sx/04wqxBCoSj7MWqFfka1wEaaXu/ecayX5U=
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr36360211wrt.196.1600422371731;
 Fri, 18 Sep 2020 02:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <28d17537bbd029104cf7de4f7ca92246449efa50.1600204505.git.andreyknvl@google.com>
 <CAG_fn=UACdKuiKq7qkTNM=QHcZ=u4nwfn7ESSPMeWmFXidAVag@mail.gmail.com> <CAG_fn=V2MT9EfS1j-qkRX-TdH4oQxRbRcBYr8G+PV11KJBO26g@mail.gmail.com>
In-Reply-To: <CAG_fn=V2MT9EfS1j-qkRX-TdH4oQxRbRcBYr8G+PV11KJBO26g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Sep 2020 11:46:00 +0200
Message-ID: <CAG_fn=WpOoAf4t1iKrWcD+LBaCvL6tf_QYeqoX65UWPi92h=6Q@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] kasan: rename tags.c to tags_sw.c
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, as we are going to have CONFIG_KASAN_{SW,HW}_TAGS, won't it be
> better to call the files {report_,}tags_{sw,hw}.c ?

Sorry for the typo, I meant "{report_,}{sw,hw}_tags.c, mirroring the
config names.
