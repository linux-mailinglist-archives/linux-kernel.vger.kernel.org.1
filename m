Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2E2B34C6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKOMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgKOMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:04:50 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93448C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 04:04:50 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 10so13075372ybx.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/P+BFJm9V3bCqq77piSFzAunqU+dBwl/J23GLcO6iVA=;
        b=jjX2I5YFUVAtYSwrOat67S+PJXGoz9jq7M4OXHFw8PiMcLzgWjAz2EfjXtLq4Nl47L
         NAZDF5TPKWUI+KbeBVNtxe/zp0y/5Z7zBU5rOQPuVQzFen/iLBa2ntkLRm58E0Jd/G8O
         cKNGN1ldkVv5ymQfj04L0CL+Y4gyqVwibIqPS13AQXCDQRjawrsi9Xxgbp2vbhUmOiGd
         Yp95zh/G1mGd2YMlG6T4qvN9dE9uuX0CK2nBYcboS4Ogz+bXoe3Lnlzw12mQgeGtoW3v
         d7DdiWK9duM5wT+YYELBE6gbNfnP2MV9npU9prBZR038Uhj8bbePm8yPgHSLRnUbaAt7
         yc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/P+BFJm9V3bCqq77piSFzAunqU+dBwl/J23GLcO6iVA=;
        b=TNQsqURE3Bt8m5EZc8zVcuL7RguO6s5stO3dFldFjqzxivu4nv5hfY+rxGNeJ5llRF
         tFD49mg3sQwfnmJrxDVDQ6y1uaqq4wfn/eqXFnPJQud6BY4VhBJB5tZGwfPGEyY1L0nk
         CikGznNVpvEOvf5hYAz5wvXGMn1R+hWQIaQhfw6o6Tf5zCHDLcTzjAsZ4mKVFMPqeok+
         q8PUZGD8R6lWFKD5wEHTmH9I8hIHg1O114Wu9sH9IhwuVLTdmCmaAK9iiMKcstrNVSp5
         9HnZrhwfvjkwQUKIszQ/QrIl49SRDghljQ9bpaW7LemmTz2dG74+Gso0078sI6Utbt04
         2mPQ==
X-Gm-Message-State: AOAM533DWaAtx6TDaDjWcGDbazEzNpziSTrRL95fJ3gcw5Hw8JLjOeql
        ul/9jlt0M5Sky7Qxk7S2w2uLLnjOODzAnhlud8w=
X-Google-Smtp-Source: ABdhPJz3/k990kW27/EHeDqHHc2qas5VdpHfDtCsklE8ubE6ox32JuXxzPs7Z7kfWQZykm3BfAlPc9NqUEzHEOM2vn4=
X-Received: by 2002:a25:bcc7:: with SMTP id l7mr12597079ybm.115.1605441889375;
 Sun, 15 Nov 2020 04:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20201114000803.909530-1-irogers@google.com> <CANiq72m=OK2bF2Nc-ht=ibNa2m6RcBCjFuhrv9kyoxE6yaMqVA@mail.gmail.com>
 <CAP-5=fV0xe-8GEbnrh8Y4C8nWK2E2mGo1iiNpRCs+590VwJVEA@mail.gmail.com>
In-Reply-To: <CAP-5=fV0xe-8GEbnrh8Y4C8nWK2E2mGo1iiNpRCs+590VwJVEA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 15 Nov 2020 13:04:38 +0100
Message-ID: <CANiq72kV-hcmf17_rzywuKXe5U0kwCOb52SihwZHUK0z0AsECA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix dwarf unwind for optimized builds.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 9:14 PM Ian Rogers <irogers@google.com> wrote:
>
> Unfortunately no GCC version actually has this fixed.

Then we can say GCC <= 11 does not support it yet or something like that.

> This seems overly complex and unnecessary.

How is 1 condition more complex than 3 different ones?

Cheers,
Miguel
