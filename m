Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57DD2B6DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKQSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgKQSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:46:41 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA38C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:46:41 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 81so8235539pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbPU/gVFpRBjfHHgn0CIOWxdoQu0ENZU+XM77WCwy8Q=;
        b=qeAL7FLylET2GPn+pzFKpYu9xteF5Jw3rkCDbDk+faIG7rp5ldn8mBK93VcWFou1mo
         NWcN/JWbnIZN8i0S+GN+L9LXF1H48gsKCKZT59v3V+GBUvs+FI/kZU2SDgH1pqpn76be
         8bh2Iz3ogMpqOBKeAjb476EoMkyfe2wB9enPE615AFfjXI9wQoo9ufYPnZNi0M8iGAY6
         KnNVagO2qflKCrJLRdPWeZG2Htx0XDWm2gevAVnYLJlyDGvQzXqJ0uJvkNjc7bUJxbl/
         bNXtrrSZxXJTZt1wE4fJUY3/6FfZfNYFUYGE0gehFeEQVoaQim7cIiYG3OA9PQC1kdwx
         EWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbPU/gVFpRBjfHHgn0CIOWxdoQu0ENZU+XM77WCwy8Q=;
        b=QmjH4yVBZxNDEDWNOOBwvZSLtv5jWZQH2n1RgIKUhNgVRsT1Giuuqgs7GYuVgckscA
         //UIH17zyMF/0W8mYA+3bS3FV45/PA1doaV5f8I6Kfo4BijnLMo8p9sM/kmvZl4PaNeA
         1gM5mtniDQgOOKVmxH8aFFnwELnjI6puCuWo+Vk/T8sb1BiBpstsXtta88nLGbRHT/Jm
         EMoDbSkxWvPeF0xuMd0iFPiaIPeltplAW7jwy9SK/vsZLXTLN0w+Be6PeTr3TinwnXgS
         yNHSf5BLDuivs2g7xdHBRZBxiYlNECKaPK1RnE1pml51rlx8D7+azXeuzDcq4aKDAxRr
         n5/A==
X-Gm-Message-State: AOAM531ICJdkUMOJaYYaYsh3MvWdwms5bar7a4mnMjpbgLGO19Gi42Hn
        gKLyb4jsHnVY5YGB6mwe14ZktEVSMI04Re4NdSqeCg==
X-Google-Smtp-Source: ABdhPJyGcBJD+2CIIeyd2MA4qNiJjON9aBxX5W5OsSqqEhLT4fZuw2DrTFg2ZAVZPSg7jLDxxiulHA4xeuZn5SgVQHU=
X-Received: by 2002:a62:870c:0:b029:18b:d345:70f3 with SMTP id
 i12-20020a62870c0000b029018bd34570f3mr730164pfe.30.1605638800507; Tue, 17 Nov
 2020 10:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20201104013447.GA21728@kapsi.fi> <20201117030427.61981-1-jhubbard@nvidia.com>
In-Reply-To: <20201117030427.61981-1-jhubbard@nvidia.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Nov 2020 10:46:29 -0800
Message-ID: <CAKwvOdkEFPYmH+JFC5a0+whb_1H84gS1WU5FVpV071Bc4mhiCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     jarkko.sakkinen@iki.fi, Andrey Konovalov <andreyknvl@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Marco Elver <elver@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:04 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> Hi,
>
> I just ran into this and it's a real pain to figure out, because even
> with the very latest Fedora 33 on my test machine, which provides clang
> version 11.0.0:

Hi John,
Thanks for the report.  The patch was picked up by AKPM and is in the -mm tree:
https://ozlabs.org/~akpm/mmots/broken-out/compiler-clang-remove-version-check-for-bpf-tracing.patch
-- 
Thanks,
~Nick Desaulniers
