Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F52B1BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKMNM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKMNMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:12:24 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78583C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:12:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y7so7553428pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSChFZYuKVQ6kJFqUobgfqBNEua7wugFhaZJbUddVJU=;
        b=MJGoH8t75hqvrgDelbft9/f+nvpZrL/SVH5RBBdO1dDiETE7AvAOI/PJUvuTYqt8RN
         Wuh3ea7yq56giaGUf/L+FOQYiFSAQ8ZKNblACwgZW0GBQyGwVxvjfJxIVpH7v/rI2HPe
         upuA+m0WM9Y2EBgl7qsSGUQpTyTiFts36+XODNAHRRs18pBEhCYttar+ThdFmsSPa205
         /xCjdaTTWqHYHHuriH/iLMM68PvwmYlc/H45JH/HO73STvm6MMTPnWifitve5wzoJCxR
         YIkazHH2PqIYPnKAVpKv4C2omQ8E3oDIi5b4V84y81vEAMinTHnu2XVJbiNlFLZErCvI
         yPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSChFZYuKVQ6kJFqUobgfqBNEua7wugFhaZJbUddVJU=;
        b=HD/MkZO0MK0LOWh1EBiOEZS/2brpmGWpBL/QVLpbyXQooIrUoG2jtuqthvsTco72vm
         BmUvQzqjubNmyo5if2vS4xQsrVwdhs/W8JoUxv3fbDdwsYQ7nMRQh89kUr5CFo+EOEwg
         ac1GvjIhWs260DWVQ83E0zVti8j8+pu16B/AGY4tGPnXnDXBYfr9XI4qOI+kzdbf4qas
         qYFBJd/hzzWjLwXR2w6M5ffQXhOlQ9eKSXA4Sf7oYaj1rkQXrK8sRR2MtH4OQThfQfpM
         oIELXx6LqNWBHy02G7oPVukOpafSOIu4Fz2fK57rCOwvuxhHIkQiMUiMi7B9UzRrUYRx
         pchA==
X-Gm-Message-State: AOAM5312ZywvUb+WSSfxxV/aAa2Nyw9MGOXq/6dx9q8uCW58HbACLRnl
        C3MqTWtUX/CU+EdA97HzffQx/ovWrCoLkeU3iO0=
X-Google-Smtp-Source: ABdhPJwIeMEnj2SAV64XEs5Zr4zzOck5AdIyiU9ANI65zRwyhPKc2S2cQ+YvDsNbWmSaIpYqDqiVhqLRNShcxiflrCU=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr1951718pfc.7.1605273143981; Fri, 13 Nov
 2020 05:12:23 -0800 (PST)
MIME-Version: 1.0
References: <202011131937.7Fy1Jnv1-lkp@intel.com> <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
In-Reply-To: <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Nov 2020 15:12:07 +0200
Message-ID: <CAHp75Ve14rt_xDS40-bE2PGzo9JGKzqU0nPz_kbwngkn-upGVw@mail.gmail.com>
Subject: Re: ERROR: modpost: "mac_pton" undefined!
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:42 PM Laurent Vivier <lvivier@redhat.com> wrote:

...

> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> >>> ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
>
> I think something like this might fix the problem.

...

> +       select NET
>         default n

You may also drop 'default n' :-)

But what I want to say is that API is under NET_UTILS, I dunno if the
driver requires full NET to be selected. And IIRC NET_UTILS is
selected by NET.

>         help
>           vDPA networking device simulator which loop TX traffic back
>
> I'm going to test with .config and post a patch.


-- 
With Best Regards,
Andy Shevchenko
