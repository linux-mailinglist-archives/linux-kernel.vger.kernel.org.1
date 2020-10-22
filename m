Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF7296163
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895097AbgJVPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894695AbgJVPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:01:56 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E061C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:01:56 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w5so969599qvn.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZW7ZoAt++RoH2KNzOMUfkR9nPDRVg42jI1rqms4LUto=;
        b=BLx+jh/dSwo5bveCbRb1r/BPuf5nGGNomCaUbZ1uYN8SPKj/SS3O20TznF0/pZgI7o
         HNVitsiYKDNKcoOXdq3p+SM22IWG1iExEmphU5DBLENR2WloGJcPP4G7LE2pdNnvTWaD
         7P9BiCsZs8gpHFQZbg+i+nWw/dCPRC7FMpH13B7dLfMj7qA+hNVHJS7x8M16SAl4vKaY
         rHmTdQkjAfNvkVd6G7RnTnKncD4HWWjUvNH08xCEtj4QB+KJMVNbYSI/cMS7H1lFYxmk
         7Pl6Qe5QDJgtHdYHc1mXFSMFmnrwSOS0ioDedGmez1Pd8ZHm5waHh4vt7IzqIJdPmdZ1
         OaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZW7ZoAt++RoH2KNzOMUfkR9nPDRVg42jI1rqms4LUto=;
        b=puZwCPJ7sd8J1wltNimSc5W80COl1J/pCNr/3u72s4RLpsVUdkAbRm2FVczOXfAsCy
         YWjbRcFsqM8DSC+ffeqsIdzDCB1nkf2luwmUg+roIXCuaF1p6jwQcqQzlIroV9dgUa/p
         KlCVXEq0kcAOTdIfVB+RFCjuk9h4nPBso4tqlJ8K6sP0ScIE0UF3VIZU3uxr8ur0+lhn
         JDOV+Uka8E3vAMfw5GRgjSdafEAYNoGYI/6B0BavRvlFOQSArbgYS4MH0O9J1LxJbReM
         OwX4i92CU38HjdVXrNVoG2UrPBatTnUyrqLYX5Y4QW8q1Im/WCiQg7AP/L/uIAx1ZOqe
         AMfQ==
X-Gm-Message-State: AOAM530DDDp9mSYm4u9Dx+zDyIax47J6ZLj4G+nrMxbkMSD4QE6B4OKx
        v3++m3qvgEKa9l5ZhoeZKJMfsuAXWxPf3t4V8mNNUQ==
X-Google-Smtp-Source: ABdhPJxjJXjf9Aq3IRL0oMzaCxitWEeWCHsVMu6ZW0ZzTu98/LCMq90upg6L7qiUNwbJh8Gcv0OevVLEJHl9jwEXkB4=
X-Received: by 2002:a0c:b741:: with SMTP id q1mr2828937qve.37.1603378915161;
 Thu, 22 Oct 2020 08:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114553.2440135-1-elver@google.com>
In-Reply-To: <20201022114553.2440135-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 22 Oct 2020 17:01:44 +0200
Message-ID: <CACT4Y+YEa+mAH_RcYGRx=H=nk_VDB223_sKg3ZV7CHbm2ftiqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kcsan: selftest: Ensure that address is at least PAGE_SIZE
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 1:45 PM Marco Elver <elver@google.com> wrote:
>
> In preparation of supporting only addresses not within the NULL page,
> change the selftest to never use addresses that are less than PAGE_SIZE.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * Introduce patch to series.
> ---
>  kernel/kcsan/selftest.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
> index d98bc208d06d..9014a3a82cf9 100644
> --- a/kernel/kcsan/selftest.c
> +++ b/kernel/kcsan/selftest.c
> @@ -33,6 +33,9 @@ static bool test_encode_decode(void)
>                 unsigned long addr;
>
>                 prandom_bytes(&addr, sizeof(addr));
> +               if (addr < PAGE_SIZE)
> +                       addr = PAGE_SIZE;
> +
>                 if (WARN_ON(!check_encodable(addr, size)))
>                         return false;
>
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
