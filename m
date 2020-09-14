Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66650269392
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgINRf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgINM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:27:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2AC061354;
        Mon, 14 Sep 2020 05:25:55 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b12so17331924edz.11;
        Mon, 14 Sep 2020 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BdFAddq3RL7rFBEGnlqI6CKwA0tfgEjJpCRYq7bxjU=;
        b=SY+nMVNE8BVVG8ruSR5EiacuhIKxjjgXR9WrOal16ZSF/q8w+hTw0Ovle+QzD6126z
         7fcMPAlyyrMVpVqQt9fd7pJ+l946ySRRZ9i0JaFdIGyuYAczoOGJ/uxKt6pXehjk4vAX
         JLgJDFoB5rHn/zw0yh5fFvwqdFgLQz+5h7c+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BdFAddq3RL7rFBEGnlqI6CKwA0tfgEjJpCRYq7bxjU=;
        b=O+MeZ5SdvKr2bRWV5DPRmJIrfQD8YSTYfsPLuZWtYFgXrAi5CgxhlocIZJpnFbYCOG
         oIQTEoWl86IqRViCD6C7kA80yuiyx1PhFfC8eyRzDO3RfanIA7Pnyaqhj+2A609LlNR9
         AqAJFcskIgCQ7KNEIKo3xWclwHm3pA4SYi3URZPEX2IW0rNce56TFzTVd3es3civn+nv
         uUJgi4z4TTbq6oxhdo+rqOGhZ63Q3BEfl5lmU0amzSnIWCAb6cVtUmr7bcCPn5bq1Rbx
         wWcAW2gow4ZXc25tSXm4g3Jc+ZYcQXg6llNUxFyWUYpNut2KEnrtm3DDHQmFECI4IYCI
         HxFg==
X-Gm-Message-State: AOAM531m5dKwpX2BU0umpkX9V1PIgtvI+PVdkfyNCpPyWJTust9b6oOU
        1jsQ9++IIUWTLC1F8zrFRaJvUwEKOAQ9g1LZR/M=
X-Google-Smtp-Source: ABdhPJwSGNnu67PnYtbgAyhVZqnOww0LDfKxxJooWZDtBPLdj0aTdSYJeckD3nPCMOPCHtjf4qb+aGCqyjmZbea0upw=
X-Received: by 2002:a50:fb0e:: with SMTP id d14mr17550786edq.172.1600086354159;
 Mon, 14 Sep 2020 05:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200912183334.22683-1-lukas.bulwahn@gmail.com> <alpine.DEB.2.21.2009131156090.6163@felia>
In-Reply-To: <alpine.DEB.2.21.2009131156090.6163@felia>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Sep 2020 12:25:41 +0000
Message-ID: <CACPK8XdvmUN6XsqGEYMwyb1JhWtm9Nyrje8xXx2zBN4N=+gNow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: make linux-aspeed list remarks consistent
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        dri-devel@lists.freedesktop.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Sep 2020 at 09:57, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
>
>
> On Sat, 12 Sep 2020, Lukas Bulwahn wrote:
>
> > Commit f15a3ea80391 ("MAINTAINERS: Add ASPEED BMC GFX DRM driver entry")
> > does not mention that linux-aspeed@lists.ozlabs.org is moderated for
> > non-subscribers, but the other three entries for
> > linux-aspeed@lists.ozlabs.org do.
> >
> > By 'majority vote' among entries, let us assume it was just missed here and
> > adjust it to be consistent with others.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on master and next-20200911
> >
> > Joel, please ack.
> > David, Daniel, please pick this minor non-urgent clean-up patch.
> >
> > This patch submission will also show me if linux-aspeed is moderated or
> > not. I have not subscribed to linux-aspeed and if it shows up quickly in
> > the archive, the list is probably not moderated; and if it takes longer,
> > it is moderated, and hence, validating the patch.
> >
>
> I did quickly get back an moderation email that my email is being held
> back. So, that response validates my patch.

The bmc related lists (openbmc@, linux-aspeed@, linux-fsi@) on
ozlabs.org that I own have a soft-moderation policy. The first time
you post a patch I add you to a whitelist. Given the low volume on
these lists this works for me.

I don't know if this necessitates marking the lists as moderated in
MAINTINERS, but if you find that helpful then that's fine with me.

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
