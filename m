Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFA42B1D84
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKMOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:32:32 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A15AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 06:32:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 35so443994ple.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 06:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKsfKEf+GNMvGiNqdoXFj8LsO8EZDmjg+Vwnzohiz2c=;
        b=rhdQuRAL+eee0zLTcoFbG9XkIiyNjeRgIcT4mBWaLtA5+AcEt5gYg15irc5Oe5ZrbS
         6wMumYNj6ox8wliQR93Gj714vw9ltgwfUIf0JXCgFLzrUStGUlAsMMcVilbbpOFdCycA
         njzByqCLLOlCpSgCs/9MaWF0z7r4IuDVh+atCUBPVCZKyLB7yH9XPdMlb4+94fI41sf0
         CmlOQy6sRQTf2pNXlNUAVmV+oCyUU3kMMJC4NIOI84kJYlGU/dILsZkOVPDBJgsyBmtU
         Eur1skJIUj3dlIaJAGCmEDWD4iRc8iPnhqJtDpCATR/yto/wLsZniVoAKWWrVM63Uamr
         oRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKsfKEf+GNMvGiNqdoXFj8LsO8EZDmjg+Vwnzohiz2c=;
        b=MdmldN4odiJFsp5UFYZsoZYsT2M1YvNsy4wUcgb0RiuDtlWxoivQAW65Uvr6PPVCW8
         v0EZHILb7bQlLkxmnDpYY282eNjU3MinKdqPeIZIgLDqgOQ569WEVjJV+SERiSii0dJG
         NAy87QQitbIbULCBdM9YBa5s/pgRP3jyKtbWNQB5037e0/k4hYwNTgHBvceJSeSYYHgv
         uXkibYQ0OLyRtlXNAvbJvDxhCKkeuytS/8+ItJhu5BDNtBvWySeqL71XN+prIbEVv65a
         ld2UcQ8+D6BG3bNTVWShon994uDBPq0XF0aeb7Mo0as1GDdwUt7ZrJJNHb1QM1Ea7Lje
         AS9w==
X-Gm-Message-State: AOAM531a4oVocSC4O7Lj81ttJ92uUGXW4V5eOd85bpD8weQp7GEW4lP5
        OgvxsNAWLM2I5FZqSM1TwJ81dMmhI6OrI4xFNy8=
X-Google-Smtp-Source: ABdhPJxrnisDTPx7awlahwJHRMxkZlQBUFFymed8s4pHVmgmJoOiNfg026uDK3X/tAi7hFDMDy2rvZ0uApmFDUYoo+M=
X-Received: by 2002:a17:902:bc4a:b029:d6:7ef9:689c with SMTP id
 t10-20020a170902bc4ab02900d67ef9689cmr2479009plz.21.1605277951574; Fri, 13
 Nov 2020 06:32:31 -0800 (PST)
MIME-Version: 1.0
References: <202011131937.7Fy1Jnv1-lkp@intel.com> <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
 <CAHp75Ve14rt_xDS40-bE2PGzo9JGKzqU0nPz_kbwngkn-upGVw@mail.gmail.com> <87d01fe1-1746-d31b-80aa-6adf286884c8@redhat.com>
In-Reply-To: <87d01fe1-1746-d31b-80aa-6adf286884c8@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Nov 2020 16:32:13 +0200
Message-ID: <CAHp75VcQn1W11dJj_KgBadwZadRbA7=2+U=eQU7uKYHV_g4xyA@mail.gmail.com>
Subject: Re: ERROR: modpost: "mac_pton" undefined!
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 3:19 PM Laurent Vivier <lvivier@redhat.com> wrote:
> On 13/11/2020 14:12, Andy Shevchenko wrote:
> > On Fri, Nov 13, 2020 at 2:42 PM Laurent Vivier <lvivier@redhat.com> wrote:

...

> > But what I want to say is that API is under NET_UTILS, I dunno if the
> > driver requires full NET to be selected. And IIRC NET_UTILS is
> > selected by NET.
>
> I think GENERIC_NET_UTILS might be enough.

Good!

> The problem I have for the moment is to find or1k-linux-gcc for my Fedora 33...

Usually for a compilation test for the kernel is enough to have
precompiled compilers from kernel.org [1].

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/

-- 
With Best Regards,
Andy Shevchenko
