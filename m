Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F362AC99B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKJAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKJAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:15:55 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C37C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 16:15:55 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 11so12625886ljf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 16:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJv0+NP1zw8VzJL3PKHO+qX/+1LnctrRFA8Fvvr1FOc=;
        b=MfT+4p4dezjt9OFQyTVf2a4eVfbfN8g8QHFYnZW7RXsbl8+WpvewDEF395+hietKgz
         WIGAZ3a2eiXwlVryYMWrO/u+4vgG1DlI2fSVPmv0Q6JI7Yx7DSAgEOTwu0/bCsxP1tHn
         XO1OsCipfH6MUQRL483uGEozrPyvd8DPvM7Ao0SC+MauGWfLJ1nb0gDoDi6tVECRYJUY
         +Ku64+9CAXE4mxZ8CmFzLj4yuQUUWpB+MrDbS/UTPDQMBYus58LkPoS0e6s2b3JqQSZ3
         RB/HnGVCCcIA11F1rjImWTQrSHyFd73LTktyPCnZ/WsMVFeRAYKjdk+lPu2wTOBRl3e4
         9Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJv0+NP1zw8VzJL3PKHO+qX/+1LnctrRFA8Fvvr1FOc=;
        b=DkY/28g+KpPJgb7BKmq4ZQZqJ+YSyrCk0AHAsK9y8Ctriqa4uDl+xCT4H5sBvL5YDM
         HLLuOXGpS9qQMrRihRTaY765kfvL5CyeFJklWinMbC5EU5Z02uBLpkf6ea08/JhK7tJ2
         OH+G3Bhq2lTCSc1AxWyXJxFH2gKRV/d9QX0ID2rFr3cvVc9qx8jU/0Cz16qctDucNhSG
         CDFcoCwxsBcUS6gfZBhI291kUfMKKw9OQ3oidfET2WsRXAwEIXiNGwoNuCwrxBzSsSAX
         P9rzpToByJSj69caZiAat3g13nAfN+ZKS2k4nPdBZ8VDwaSlQgTB4kGkMM/Jv/mdrMDR
         OIFg==
X-Gm-Message-State: AOAM5316+ubd3alqHVguVTT4LsfLO4JY0JiXdXkyJwhDd4a7Emmvbi9i
        Dthwk/6pXnfJNJPcma1HFN6lj2AXk/aLDfa318c=
X-Google-Smtp-Source: ABdhPJwVkHSeuhxB796y95XVlmrORp/3Zw5XT11jtpnaclujK2gL/9W4FyjiS/3FGH8kfJ4NwLbfEkTfs+Y5uiCsKoA=
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr7716319lja.283.1604967353417;
 Mon, 09 Nov 2020 16:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20201109215415.400153-1-jolsa@kernel.org> <20201109215415.400153-3-jolsa@kernel.org>
In-Reply-To: <20201109215415.400153-3-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 9 Nov 2020 16:15:42 -0800
Message-ID: <CAADnVQLdXRFv1MYQu8k9QrECQxe3LFAfuyU244-9LfRT5snoqA@mail.gmail.com>
Subject: Re: [PATCH 02/24] bpf: Add build_id_parse_size function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> It's possible to have other build id types (other than default
> SHA1). Currently there's also ld support for MD5 build id.
>
> Adding build_id_parse_size function, that returns also size of
> the parsed build id, so we can recognize the build id type.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/buildid.h |  2 ++
>  lib/buildid.c           | 31 ++++++++++++++++++++++++-------
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 3be5b49719f1..edba89834b4c 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -7,5 +7,7 @@
>  #define BUILD_ID_SIZE 20
>
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> +int build_id_parse_size(struct vm_area_struct *vma, unsigned char *build_id,
> +                       __u32 *size);

I think it's too many choices for such trivial api.
Just keep one build_id_parse() with two outputs
and fix the callers.
