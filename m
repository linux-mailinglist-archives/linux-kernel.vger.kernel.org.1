Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0466224E9D8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 22:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgHVUtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgHVUtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:49:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DAAC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:49:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba10so4723224edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWBhEN4zwCq1UXqR2eUAbVePvkijEWRw/Us2lt1L+qo=;
        b=ap8KmymSZi/4Ab+GQAnYaHjf7t7egWBUtS2sU99/oFM6DU5LJ2CEkoxquPJSiwMraC
         IuHwEW58oTpGJrLaWnbI2xbU0NTivIagFQBQnBX2glNm6n3GNlXXw2lEJ1/vjcpPtcfo
         58EzoanvYPkriX+WmTUEkcrdHDpNOvZ7M+7Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWBhEN4zwCq1UXqR2eUAbVePvkijEWRw/Us2lt1L+qo=;
        b=tty5I++CR/b97CzTcblP2XPTXe8qbj11UsL/J+eAYmhrY0k18zbOEd7OK80od9WVgX
         lnrJorP+4S8cm/Y3xfxTvL82m5B3hGCgNRoGRlOlj1PZCBTpliCbMHfiPaqnH2EUnXOQ
         UqneLhTil/po3TRjo1YDrVroGTHBQhbC3ti5LfRM3yJBjBmhDFBOiNeBUaB6lhxf4OR1
         +s/LZSzzt+APVkX4PS9xQUkt+U3uH0mS2zGW0csAu/sdsOQCygo+HKcXn0/9IoMtHRQT
         fPVjWGFFl8WYYIFSSijsTF01f7cfP9RVcA0+uWYEpIF1zYjf+MsYtL666pYmP+DMyYah
         zEyQ==
X-Gm-Message-State: AOAM532lY9TWDYtF5VRxuHDeb3e03vmmGBdSmNSzFYMa0lYBopn8lRvo
        I0WHWDC7QEyDxgwK6NLNgAbDns+L2ax9SnkU8KosyQ==
X-Google-Smtp-Source: ABdhPJxz4nOzGHWQsVlY8zejQYaC26KZkFho11mHn5BiKLWBr4VqaVon82YVtsdZ8LqiNuNPfDy08q678i2lxTS9b44=
X-Received: by 2002:a50:e809:: with SMTP id e9mr8704529edn.133.1598129372560;
 Sat, 22 Aug 2020 13:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200821165221.32267-1-mmayer@broadcom.com> <20200822115636.GA19975@kozik-lap>
 <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
 <20200822164619.GA24669@kozik-lap> <CAGt4E5t=xNnOHAK3JM9kUGzGqbysDCsW5YmEXzVF9OBSUgPECA@mail.gmail.com>
 <81b2ad54-d4ef-cf98-886c-61c79e4cac62@gmail.com> <20200822204640.GA8064@kozik-lap>
In-Reply-To: <20200822204640.GA8064@kozik-lap>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Sat, 22 Aug 2020 13:49:21 -0700
Message-ID: <CAGt4E5tUNio1m-06s3HF6qviyzv7PE8bu3JNwNuedxHrpnD4mA@mail.gmail.com>
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 at 13:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Aug 22, 2020 at 01:21:47PM -0700, Florian Fainelli wrote:
> >
> >
> > On 8/22/2020 1:14 PM, Markus Mayer wrote:
> > > On Sat, 22 Aug 2020 at 09:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > On Sat, Aug 22, 2020 at 09:40:59AM -0700, Markus Mayer wrote:
> > > > > On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
> > > > > > > We would overrun the error_text array if we hit a TIMEOUT condition,
> > > > > > > because we were using the error code "ETIMEDOUT" (which is 110) as an
> > > > > > > array index.
> > > > > > >
> > > > > > > We fix the problem by correcting the array index and by providing a
> > > > > > > function to retrieve error messages rather than accessing the array
> > > > > > > directly. The function includes a bounds check that prevents the array
> > > > > > > from being overrun.
> > > > > > >
> > > > > > > This patch was prepared in response to
> > > > > > >      https://lkml.org/lkml/2020/8/18/505.
> > > > > > >
> > > > > > > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > > > > >
> > > > > > Your Signed-off-by does not match From field. Please run
> > > > > > scripts/checkpatch on every patch you send.
> > > > > >
> > > > > > I fixed it up, assuming markus.mayer@broadcom.com is the valid email
> > > > > > address.
> > > > >
> > > > > No. I have always been using mmayer@broadcom.com since it is shorter.
> > > > > That's also what's in the MAINTAINERS file. Please change it back. I
> > > > > accidentally used the long form for one of my e-mail replies which is
> > > > > where the confusion must have originated.
> > > >
> > > > I'll drop the patch then. You need to resend with SoB matching email.
> > >
> > > Oh, I am starting to see what's happening here. This is new and
> > > apparently due to some changes with the mail server setup on our end.
> > >
> > > I have this in my patch file:
> > >
> > > $ head 0001-memory-brcmstb_dpfe-fix-array-index-out-of-bounds.patch
> > >  From 6b424772d4c84fa56474b2522d0d3ed6b2b2b360 Mon Sep 17 00:00:00 2001
> > > From: Markus Mayer <mmayer@broadcom.com>
> > > Date: Fri, 21 Aug 2020 08:56:52 -0700
>
> Which means your patch actually passed checkpatch on your computer so my
> comment about running it was not smart... :)

It did pass, yes. :-)

> > > Sending patches like this used to work. Clearly our SMTP server has
> > > now taken it upon itself to rewrite the sender e-mail address. I
> > > wasn't expecting that. Let me look into it. Sorry for the hassle. It
> > > was not intentional.
> >
> > Yes, if you used to use the SMTP relay server which did not require
> > authentication for internal hosts, and now you use smtp.gmail.com with your
> > broadcom.com username, the SMTP server will rewrite the From: to match the
> > username used to authenticate with the server.
>
> Markus' patch did not go via GMail.  It was the Broadcom server which
> mangled the things.  The email headers:

Indeed.

>   Received: by mail.kernel.org (Postfix)
>   Received: from rnd-relay.smtp.broadcom.com (rnd-relay.smtp.broadcom.com [192.19.229.170])
>           by mail.kernel.org (Postfix) with ESMTPS id D5B3B20702
>   Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
>   Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
>   From: Markus Mayer <markus.mayer@broadcom.com>
>
> Neither kernel.org nor my final server (Gmail) cares about usernames in
> From fields of some specific domain.
>
> I guess you could try configure you git send email to use email of
> "markus.mayer" while keeping Author "mmayer".  You have to configure git
> send email for this and such configuration results in proper two "From"
> fields which maybe smtp broadcom won't change.

Yep. I think I've got it set up now. Stay tuned.

> Best regards,
> Krzysztof
