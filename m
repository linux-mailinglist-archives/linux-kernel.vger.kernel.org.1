Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D827926F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgIYUnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgIYUnf (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:43:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D183C0613B2
        for <Linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:43:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so203220wmb.4
        for <Linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHGugZKiuicTkqumqMhBD3Ej3zjHyyQJPQkMpt/Ee1s=;
        b=FoObYSIkNkhUab7nCZY0LOTUDRIoHeC3JBUHgqXVTh+D9WaZubDjDHthm6vdOBgtFu
         k9hcU7TpIc+DC0a1yOMM+egIuA5ebCPU3SK4HHm1ndqvU3pdBWKiIIq3M8N58+vHE7g/
         AdXlqPBtq1hXlSbX68QW8q/xn7DtVJNVdnLkFJA4CJVdF97Nbo26P9lwQsaZLo6Q6M+z
         BnT5SxapKziFoYKcyY4+eBAdanDXxTeYavZnf1z0A22LTYJjBoQH8MKQtKPscJujJfXJ
         SW0KyNUdJW4mO/ahfZslo+foavfujq702Jz5MjbGLZb1l3tKv7C7QLm6tLgQhlHAAp4+
         TF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHGugZKiuicTkqumqMhBD3Ej3zjHyyQJPQkMpt/Ee1s=;
        b=FxB0FaPpJR1WKTl9r/u9GWNlrewOkrMJiGxdUcgOh/jB1M0h0Ci2Pqm5LQY0GVJ77M
         LKYK3GjtEZCYj8KWy/F5OGEhyO9BCW20Jf8zPEjx29rajjF54LMBJBS06sdoxUaXiOF6
         BjwMkSVA9u4c633B4k0t56XX8Ba6GI67NvJ08lFqKibajHtbQzjTQOXCskLrLd5h8xxw
         4SMrV7nyL/c3ZPoni6BtOfH/87UdruFEtnS6AkN4wz+J81cPU2xrfQqCAKkI9bJyK8bo
         V7ndy92SZTkBtqXF0ioojcoSX3F7G0BG9Clp4Qo8VtyPS+ZGLzMhd/4XDZLEA4q4BvXq
         eR+Q==
X-Gm-Message-State: AOAM5305KXAErlSqR9G4wTlTVxIl8PsfDBjY1Q6zEliAAi9XRbDD2WtQ
        3v1D+XfvgXZiFg8zGIg9loyJzS7oxKZHkPZuARuWKQ==
X-Google-Smtp-Source: ABdhPJzImlM+ZQ0OOhKmX/3z6alBYFwNZWoPfhFOFBI+RdnpKYnnVP9f725fVLBzle7oIaVhApy0Rpw2ORQ/UU+LLGE=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr156909wms.77.1601063036898;
 Fri, 25 Sep 2020 12:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com> <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com> <20200925180527.GA2883319@kernel.org>
 <20200925183614.czoqgq2kcttzfm2g@two.firstfloor.org>
In-Reply-To: <20200925183614.czoqgq2kcttzfm2g@two.firstfloor.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Sep 2020 12:43:45 -0700
Message-ID: <CAP-5=fXp8brNy7tCTAp4H1uegnCkrBxCiacz14+K3TY4_t3hVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to v1.08
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Jin, Yao" <yao.jin@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:36 AM Andi Kleen <andi@firstfloor.org> wrote:
>
> > Thanks, it now works, but then... You forgot to add the Cc: entries for
> > all the people in your actual e-mail Cc: list, and also the
> > Reviewed-by: from Andy, I had to do it all manually, so when I applied
> > your attachments with 'git am' I needed to go on and manually collect
> > all the Cc, Reviewed-by and Acked-by tags.
>
> For the event updates we should just use git pulls in my opinion.
>
> They are just too large for the normal review procedures, and usually
> don't really benefit much from community review anyways because they
> are essentially hardware documentation.
>
> Should just name intel / amd / etc. event list maintainers and you
> could accept pulls from them.
>
> -Andi

Are the scripts to make the json available? Perhaps then Arnaldo could
generate the changes.

I believe Kajol Jain has some unmerged changes because there's a worry
about the interaction with the scripts and assumptions in jevents.
Having access to the scripts would mean that we could fix whatever
issues there would be.

Thanks,
Ian
