Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069AA2DDEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 07:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgLRGrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 01:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgLRGrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 01:47:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C50C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 22:46:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id j22so1587514eja.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 22:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHugSnggwtQXjIF+oGf7DjViLZB7YdsHZ2hb5vlrhlE=;
        b=HNJF663XPb4/M+ZGqahKV3X/KvydpE07OfxsZTwee3KqFsKLvKIj9rZY0fJ55HQwmb
         oYm9GAEc4jcTll35vc34awE3kfdsNMqUPmvI+AsmJXhdsJ1buLENxh3dpkb93/4JxB2l
         gJnx8l/dCevnCNH2bgcZLflVoVpx1ba2yoj3+QZ4YIpWaApEu9qQpaXcBeGEz7+YAWf8
         v/x66DRU5OLwHT4tmwbjmhtq46uzxsNHEzE9a74/lxk7r9wDVkygB8aTrBKYb6asEfqR
         jLHlO4pfRK7y1EAqrcNwRCRzkZ2IzKLhBllyO5nJ1rkfPw3kqeYuibYKHo7sNRVVcdf0
         +d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHugSnggwtQXjIF+oGf7DjViLZB7YdsHZ2hb5vlrhlE=;
        b=cy0hcjs2NdH0Oy1uPw9G2DVM9OqPIeVjvu4rbUkG6nbmyO//a8jeZeL5iSkAoSYIhH
         iepDYuobG0UdbtkHyQRvmHimPzBFOzuMc+L8am+4KrqpMJR/zepZgfAz6GpogemCvsGQ
         AxzZu2bkc9GsO09WASsrxUdrxDllRSMqlkBk+hVklMGVzK6DC+gudxjNLx6/LuE5RqFX
         SS/KtToCwxKyY0NBGzu7dL6D8X/qACEAdhodpUP0Fv6YNEwXthcuC0xuTaSxWrWzvuU7
         zDyuEgXM/E1kgieU9wHMWeoP79w6XkVdxmmhosUlYx3gbtijg2cvBrw2T7IZSwatt6tx
         qzHA==
X-Gm-Message-State: AOAM531S2atRRLCVCUM8ZO3i8DWQL82YmatPfBG6Xbf64ZqSVvDWfEMy
        OuSOQ9cbH+ihCq51397n4JO8AdNACT3bMsIDF+YGEX7QVAc=
X-Google-Smtp-Source: ABdhPJz3uAxbSN2jEtU3MtlLMGat/fs41Ywf6XXGmjKwivRGWFgz0AauY3U7kIopUoRxaIdZWPGHK2FwMcBYxHBdkqU=
X-Received: by 2002:a17:906:1e0c:: with SMTP id g12mr2569804ejj.115.1608274010220;
 Thu, 17 Dec 2020 22:46:50 -0800 (PST)
MIME-Version: 1.0
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
 <CAHg0HuzKb0e21bo3V53zskKtk+zaJXhxkU8m4w6Q2DWoWPkU6w@mail.gmail.com> <CAJCWmDdEPa23XDZ8pdStH=PgMszq4N6mHmNWtUA5Fn4THSNRmw@mail.gmail.com>
In-Reply-To: <CAJCWmDdEPa23XDZ8pdStH=PgMszq4N6mHmNWtUA5Fn4THSNRmw@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 18 Dec 2020 07:46:39 +0100
Message-ID: <CAMGffEm2LVxXJP-HseTqihcCvPeYOkCsaFHVNKXDZAYxCPzwTA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        swapnil ingle <ingleswapnil@gmail.com>,
        linux-rdma@vger.kernel.org,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, Dec 17, 2020 at 6:44 PM swapnil ingle <ingleswapnil@gmail.com> wrote:
>
> Adding linux-rdma@vger.kernel.org
>
> On Fri, Nov 27, 2020 at 1:54 PM Danil Kipnis <danil.kipnis@cloud.ionos.com> wrote:
>>
>> On Fri, Nov 27, 2020 at 1:31 PM Swapnil Ingle <ingleswapnil@gmail.com> wrote:
>> >
>> > Adding name to the Contributors List
>> >
>> > Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>
>>
>> Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Can you pick up this patch, or do you need a resend from me or Swapnil?

Thanks!
Jack
>>
>> > ---
>> >  drivers/block/rnbd/README | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/block/rnbd/README b/drivers/block/rnbd/README
>> > index 1773c0a..080f58a 100644
>> > --- a/drivers/block/rnbd/README
>> > +++ b/drivers/block/rnbd/README
>> > @@ -90,3 +90,4 @@ Kleber Souza <kleber.souza@profitbricks.com>
>> >  Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
>> >  Milind Dumbare <Milind.dumbare@gmail.com>
>> >  Roman Penyaev <roman.penyaev@profitbricks.com>
>> > +Swapnil Ingle <ingleswapnil@gmail.com>
>> > --
>> > 1.8.3.1
>> >
