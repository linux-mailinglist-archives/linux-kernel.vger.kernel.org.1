Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40BB2B465F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgKPOtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbgKPOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:49:21 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA80C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:49:21 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so25500974lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9YYtxJZQ61dSHuSpVyOeAjqq4q4KVseeuBlzImXEsk=;
        b=iyTqTWgek9bpE1bnvCpobrfYhS0xCjKb3JBPV+nxXvs4iD6Z/VuKvsdWJkQfGdMT24
         a0aVXFiD7UOh2jj1/LZ8S17qmTdHdU0v+GxXMKhiRAlpGNrhLZ54+DwuC5RZyHzSx/UD
         2NnvlyyG4FPwdQOiosGPPn8y8am71+tfm9RPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9YYtxJZQ61dSHuSpVyOeAjqq4q4KVseeuBlzImXEsk=;
        b=mXCru/qrZWy1XAwA8QD6aHbAwy5lfhyp3k4F5TMXKCB+9mo8eor2H6rOvny8dgVr21
         KF/Z/Q9+qr20ZvUex3DQwrEmq36t5tl9sijEr9ZZnoeEDdWJ+Pi8l3+JTntCyaca5Y5z
         n7a9UOn6KY/YAfq1CGhNJJCnZDa6VJhnVYasmIbZ8teKmqQ129gV16//v9slTdz1uOWD
         iQ/eI+y9/lj7W6fW2KpdVar5VJGC+ESKNz/oTsH2BOM5Zn6cyjgCxUr2C+HhVzJ76Bre
         4PlcCI5gZzt1Tl6W5nGh0iw29tUmEJtn5QBTGv4CNyVD2Jd6ycgb6oUTHckgehAi/BZ9
         WwJA==
X-Gm-Message-State: AOAM533tcdXXXnzGDDGS09b+h9udRRzelUNnVl1SrD8AWLEJi/p6nrYw
        KaslGnXNr02h6RrTp25HU0G4DBWhSvmQlGHy06SdiZP21ulZEfwP
X-Google-Smtp-Source: ABdhPJybKMFf5F9fDnkcEIlA3gETcN9cfU8sjsqKeX/1OowNQYDHMKgr3Z4bnO8+xXrWp/CToC+gA2tOJl/m2hJTgWo=
X-Received: by 2002:ac2:5591:: with SMTP id v17mr5379656lfg.562.1605538159370;
 Mon, 16 Nov 2020 06:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20201116140110.1412642-1-kpsingh@chromium.org> <20201116140110.1412642-2-kpsingh@chromium.org>
In-Reply-To: <20201116140110.1412642-2-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 16 Nov 2020 15:49:08 +0100
Message-ID: <CACYkzJ4qpyP_tF+-AG6ukA1DLJJzV2xmaVO4r08bUMUCvOAT1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
To:     open list <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Pauline Middelink <middelin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, int);
> +} secure_exec_task_map SEC(".maps");
> +
> +SEC("lsm/bprm_creds_for_exec")
> +int BPF_PROG(secure_exec, struct linux_binprm *bprm)
> +{
> +       int *secureexec;
> +
> +       secureexec = bpf_task_storage_get(&secure_exec_task_map,
> +                                  bpf_get_current_task_btf(), 0,
> +                                  BPF_LOCAL_STORAGE_GET_F_CREATE);
> +       if (!secureexec)
> +               return 0;
> +
> +       if (*secureexec)
> +               bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);

This can just be:

       if (secureexec && *secureexec)
                  bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);

               bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);

> +       return 0;
> +}
> --
> 2.29.2.299.gdc1121823c-goog
>
