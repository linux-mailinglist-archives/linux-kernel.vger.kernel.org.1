Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B072B5AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgKQIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:07:14 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:44428 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQIHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:07:14 -0500
Received: by mail-lj1-f177.google.com with SMTP id s9so23183731ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeX7C5vr5ARghFPkpCSkjlq1kL4lAsqP7pG/tSY+qY8=;
        b=gzhQan6nVywZG7S1xnNGM0U8/ImuJhnTHvjUxY3df4XCGLIM7DBVFl/UF8O5plaYsJ
         wBg9zsvn0zn0TAZ3VYBe4UuPlXe5D0x1Q/0jNpwJwhHcwxob736AIiO+rPMNdyQ3KSWO
         uPkUW+67k6UpfyhmcC3ojDS1C9pISZ6KLn1x4xP5e2Z1BEou3vxDLU+RUx+PwSH8+lMw
         SAVUJhgXQBNRguVk06b92qfJLjwV9I606VOFQy3HiLj+e3sObwMkC3dknIrRPpPPP4DF
         dkr/pN0j93l5PdzciZduyWh0NAQJpz97U9XMeu1bDwSjBL0YbdIqj86iL7ozFFo/3UhJ
         J+0A==
X-Gm-Message-State: AOAM531ZCoaIvLdDe3I8IgC7hm4emOt9zTSnC3TOub1NMArZPo0JqQ1V
        Gw6bzx7ajbzIKppygA/0Rkvm8UYP39ec8w==
X-Google-Smtp-Source: ABdhPJyotRCIfpxR85L7mrAVS4geRpbhbMzifKPQs5f+Cmq5aobdnjwa20qZx+0lL4buOF17BOc35g==
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr1301856ljg.176.1605600430553;
        Tue, 17 Nov 2020 00:07:10 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c6sm2759006ljj.140.2020.11.17.00.07.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 00:07:10 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id z21so28848984lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:07:10 -0800 (PST)
X-Received: by 2002:a19:8605:: with SMTP id i5mr1340167lfd.356.1605600429965;
 Tue, 17 Nov 2020 00:07:09 -0800 (PST)
MIME-Version: 1.0
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
 <20201116155253.n3nuvzxup6izhh3m@gilmour.lan> <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
In-Reply-To: <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 17 Nov 2020 16:06:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com>
Message-ID: <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com>
Subject: Re: BananaPi M2 support
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please try linux-next. There were some regulator fixes that got merged recently.
One of them fixes an infinite recursion when resolving regulator supplies.

ChenYu

On Tue, Nov 17, 2020 at 1:12 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>
> Hi, Maxime,
>
> it just hangs on that last lines and nothing happens anymore, see 5.18 log.
>
>
> On 16.11.2020 18:52, Maxime Ripard wrote:
> > Hi,
> >
> > On Sat, Nov 14, 2020 at 08:20:54PM +0300, Sergey Suloev wrote:
> >> Hi,
> >>
> >> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
> >> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have saved
> >> boot logs for both versions https://pastebin.com/DTRZi8R7  and
> >> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
> >> kernel with default config, u-boot v2020.10.
> >>
> >> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
> >> The versions 5.8.18 and above all fail (5.9 and 5.10).
> >>
> >> Could you look at the problem or provide an advice about further
> >> investigation, please ?
> > I'm not quite sure what the issue is exactly? How does it fail to boot?
> >
> > Maxime
>
>
> Thank you,
> Sergey
>
