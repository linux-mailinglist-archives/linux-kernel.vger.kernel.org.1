Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B62AE72F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKKDqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgKKDq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:46:29 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E4CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:46:29 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id r9so1224840lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3t6N7lawJjBP2JugApBZuMw/tDi4/dja54qTDC3LDTE=;
        b=TCz7gfD9YvJvcCxajlG6fxu8egxpS/yMtxA7AtAKfhbTeVp9svnlgyN8ae87GeuKTl
         BzC+tFAEHFRDVWc+1mi4jQSfJV7skfozbiZSehuNU8eINmLL/2dyr7sN4yizhq4b6y2G
         S0XqaqQxIwN7gfhJicBtnGgxYDMC74UVZ0zyFkFvYSJs8OY877SgXaUy1natQE+fKKEy
         diWvzzLekC66kRWvJTDtzCHeclpgwWn3LvIsgie6KYnoucH/HQsiinfTsIfpczamaYlP
         oC0uEdA88n0DZscfoCaJ0hOULesiFw33gCwekJtYA5YnNY+gEFvesVSLswqbMWouofZH
         7fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3t6N7lawJjBP2JugApBZuMw/tDi4/dja54qTDC3LDTE=;
        b=EqG0bqI2o1Qc0zsdtEdg8hyepHxxd3NwMAitflrjpcY+WOGa30wBjl3CNN9pZ2I00C
         lfb/WA2oDfEwHLp8OPVXc708h4xV4A0hsswYuHUVoOKGuDO6hdnrd7iKeRxn4lnN0tHN
         os0J8JuMmEJj54m23lzhwm7czcFuO7N915XAkFdaZsDjeFtetRFOy1ytSrsMWkqJ/K71
         +JkmJrbfkPMTybN/reYQ81fVWSFW7QtyJiVROcGHx85C+/J+e9SRHs2ft7bEZ0kkBIKK
         +x805NbUtrCv7hZlW+Hcls2ylvK31SQkxGSwWOLHRw3WLThJvWMGDwBnqBBaqBPUSwVR
         lMVg==
X-Gm-Message-State: AOAM533Escmr4Ml6jyYRzVzOrWYzun9P+i8/ERKEUER8bWaVbplZ+yvF
        SuB5bRn6ztHZWZcgCluuZQUlGL8mUnV1ovoxoOV4+Q==
X-Google-Smtp-Source: ABdhPJzhri29Lcv9I2CrgJRKofFFWBADl34Hok9TBcgb9X3tchwfM041ia/PkFydhh3aebhCMShBjKb9IGXv3lgcTqw=
X-Received: by 2002:a19:3f56:: with SMTP id m83mr8121092lfa.381.1605066387685;
 Tue, 10 Nov 2020 19:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20201109191601.14053-1-zengzhaoxiu@163.com> <20201109192508.14186-1-zengzhaoxiu@163.com>
In-Reply-To: <20201109192508.14186-1-zengzhaoxiu@163.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 11 Nov 2020 04:46:01 +0100
Message-ID: <CAG48ez3OyH61+hJ+Azyoae0fA6=8tnVOw3VqKebCcH=dTvh2dg@mail.gmail.com>
Subject: Re: [PATCH 2/3] lib: zlib_inflate: improves decompression performance
To:     zengzhaoxiu@163.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 8:27 PM <zengzhaoxiu@163.com> wrote:
> This patch does:
> 1. Cleanup code and reduce branches
> 2. Use copy_from_back to copy the matched bytes from the back output buffer

What exactly is copy_from_back()? Is it like memmove()? If yes, have
you tried using memmove() instead of the code added in patch 1/3?
