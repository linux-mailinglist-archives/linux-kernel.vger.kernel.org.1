Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F79299EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440966AbgJ0ATU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:19:20 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43807 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439128AbgJ0ATM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:19:12 -0400
Received: by mail-vk1-f195.google.com with SMTP id d125so2367295vkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee37VVRPxs0S2etLXGh6xV8laF1VNOAKF+VF0HuUjkQ=;
        b=kxAZv+0mQcKYBuVdzin8rkjMnzfhLBDPX6S6+L07huFlcjxF8mKM/BPqx9iHEfNk8N
         ntE+tHKzTZ/v0k+wkRefnMk9W1Su0kxMrgtS9PxdFum2FD4H1iGLmB2hQndy5GFsSjyC
         nCtpYS7ntjfwashOGhDSvJtZt9yx0K2VTtHno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee37VVRPxs0S2etLXGh6xV8laF1VNOAKF+VF0HuUjkQ=;
        b=CjkiAqOxNz1boapm7ljE6jYNsjFtYTaP/DFFkwRJU0ILgyd3M9WXGIbExhgjD066zP
         gtDcUCVvKF95+UHI/TPVgHuQjXYLuE6aIP77CMWw+m7BaHrc2julWSnM0fSs+KPkIoFN
         jPhgiVm8Jz1l9khQUukEp29jHeSlK1i+qARrj3V62YYWGQsALgWLkPdt9BTMSe1h08M2
         zmGXldGUp1jwK2WZdP3trFCuvLg61W0J2vl6rNYVipHbLWTCQLeEMUYn8XTpeQBQ88x4
         uLueOzpeVBwwI4JN6ruNq24oa6en3jcqLFnrNWYnpvCqfbnc9E1BJrSCjZHO4dYZqY8L
         FbLQ==
X-Gm-Message-State: AOAM530D5zC7fVvu60njF2bY8tS3iApHjCIBwybMC4g5uGwrdT6kJnq5
        bhRP2xrmHh766cPXGDswYdTn9Nb3TGgWAPCs+lsfDA==
X-Google-Smtp-Source: ABdhPJwEN10aQdM7CcIsGMKnEMqtd3YhNP4F1hLbo3BOr3kgS2UxLTXXi5WcIhIYa0t3Zw6dxKV2czwgy9AN9Kv6Ctg=
X-Received: by 2002:a1f:8d91:: with SMTP id p139mr230741vkd.9.1603757950953;
 Mon, 26 Oct 2020 17:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-3-enric.balletbo@collabora.com> <CANMq1KDSsfX3r1440qbmWggqbD7pU_iM4S36LUF8rsS2jVGqOg@mail.gmail.com>
 <ebba9def-e394-c183-dd80-6dc3716a7bd1@collabora.com>
In-Reply-To: <ebba9def-e394-c183-dd80-6dc3716a7bd1@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Oct 2020 08:19:00 +0800
Message-ID: <CANMq1KBfKK9-RfMK89hRCGzhqZVqs6+YRdw8o2K+jA+3VN1_gw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] soc: mediatek: Add MediaTek SCPSYS power domains
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Mon, Oct 26, 2020 at 11:17 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Nicolas,
>
> Many thanks for looking at this.

Thanks to you ,-)

[snip]
> >> +       if (id >= scpsys->soc_data->num_domains) {
> >> +               dev_err_probe(scpsys->dev, -EINVAL, "%pOFn: invalid domain id %d\n", node, id);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       domain_data = &scpsys->soc_data->domains[id];
> >> +       if (!domain_data) {
> >
> > Is that even possible at all? I mean, even if
> > scpsys->soc_data->domains is NULL, as long as id != 0, this will no
> > happen.
> >
>
> I think could happen with a bad DT definition. I.e if for the definition of the
> MT8173 domains you use a wrong value for the reg property, a value that is not
> present in the SoC data. It is unlikely if you use the defines but could happen
> if you hardcore the value. We cannot check this with the DT json-schema.

I wasn't clear in my explanation, and looking further there is more
that looks wrong.

This expression &scpsys->soc_data->domains[id] is a pointer to element
"id" of the array domains. So if you convert to integer arithmetic,
it'll be something like `(long)scpsys->soc_data->domains +
(sizeof(struct generic_pm_domain *)) * id`. The only way this can be
NULL is if scpsys->soc_data->domains pointer is NULL, which, actually,
can't really happen as it's the 5th element of a struct scpsys
structure `(long)scpsys->soc_data + offset_of(domains, struct scpsys)
+ (sizeof(struct generic_pm_domain *)) * id`.

I think what you mean is either:
domain_data = &scpsys->soc_data->domains[id];
if (!*domain_data)
[but then domain_data type should be `struct generic_pm_domain **`?
Does your code compile with warnings enabled?]
or:
domain_data = scpsys->soc_data->domains[id];
if (!domain_data)
[then the test makes sense]

[snip]
