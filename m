Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB91291FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgJRUSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJRUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:18:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F9C061755;
        Sun, 18 Oct 2020 13:18:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e15so1529650pfh.6;
        Sun, 18 Oct 2020 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4EwdmieLopr730fBT092jGmCV6jWxaZo5R8egPxRxBo=;
        b=bEdLOYq0uwT93zPsTlYzcu7NYL6GQWq6YgXjrhZkf9QNU0jlqSEVF6ssnhdafsSTs6
         IuIJQ0arVKhAiHFMXk3TrN3YvGlkVWWizd5gDHZ6rIJZfLx7VHQVIAEPxVwKpqZjx/nm
         ze6W3bHse4Xx7rxiG9pYTKEez22Q/GTz3+Z7Riz117jy9CDBBoIYGVEIE9/rq2y76UBk
         SBQYpQQI97ZAYtPfH9NINxiJTIZT662CnAyXvoWN8juPzh0nArXfILe2MS2kbX+GO9RD
         5r3epRL3Tg643LU7AV5dM7y/r5IyWwY+EIDGe8k5rPd1VjP186t6CJJTWbisOLX5nBwL
         QahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4EwdmieLopr730fBT092jGmCV6jWxaZo5R8egPxRxBo=;
        b=Jb68pUNCyuSWh8HNmWqhZ7Q3uION4TH/ByE3fyGh974Fm6misrTOyw57367xf3spKr
         RkRP7DztZJwPCkCambGdVEZcR6U5vC5aayBDQhgniOLJhGO+y0EfiU45Ygso4XiwIBh0
         hnsWxAuRuJAFL0zSRV5j5fjxspMP5w3TZbeODc4s5NtbjlDtwwsx6K1dbx8B4KBHqIe7
         KgxHd1ZIea0Xmu60I6lClb7rRHTggmPWAxRpRhnX1Ede6XY6eRYSNPSbJ7bWci3Ni5vC
         x0UBPq8xkcX0lDA8JReYI+ZaEYtOysU5x8SaBhfz56A/uvtw1cYjz/uGibyor79zqBeZ
         RegQ==
X-Gm-Message-State: AOAM5315ehbS/tyjpt/MBOMGETkJHcXqrFFJnHofI39QKvEvXl76F3qS
        Ss75T0tMdiQ5G7gnKckf9b5koPXRA2MY9uM=
X-Google-Smtp-Source: ABdhPJyQZEIkpoknp6K5CxLnfAdAyWDE7RCHr3fovGFQbRnzux3BEae4kATuON86B8qiqoel4KQSFA==
X-Received: by 2002:aa7:911a:0:b029:155:8521:ba6c with SMTP id 26-20020aa7911a0000b02901558521ba6cmr13117544pfh.8.1603052298968;
        Sun, 18 Oct 2020 13:18:18 -0700 (PDT)
Received: from PWN ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id e4sm9568856pjt.31.2020.10.18.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 13:18:18 -0700 (PDT)
Date:   Sun, 18 Oct 2020 16:18:11 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
Message-ID: <20201018201811.GA697615@PWN>
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
 <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
 <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 10:09:06PM +0200, Daniel Vetter wrote:
> Adding dri-devel too, not sure anyone is still listening on linux-fbdev.

I see, thanks!

> On Sun, Oct 18, 2020 at 8:13 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> >
> > Recently, in commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros
> > for built-in fonts"), we wrapped each of our built-in data buffers in a
> > `font_data` structure, in order to use the following macros on them, see
> > include/linux/font.h:
> >
> >         #define REFCOUNT(fd)    (((int *)(fd))[-1])
> >         #define FNTSIZE(fd)     (((int *)(fd))[-2])
> >         #define FNTCHARCNT(fd)  (((int *)(fd))[-3])
> >         #define FNTSUM(fd)      (((int *)(fd))[-4])
> >
> >         #define FONT_EXTRA_WORDS 4
> >
> > Do the same thing to our new 6x8 font. For built-in fonts, currently we
> > only use FNTSIZE(). Since this is only a temporary solution for an
> > out-of-bounds issue in the framebuffer layer (see commit 5af08640795b
> > ("fbcon: Fix global-out-of-bounds read in fbcon_get_font()")), all the
> > three other fields are intentionally set to zero in order to discourage
> > using these negative-indexing macros.
> >
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> 
> Patch looks good to me, but it says 1/2 and I can't find 2/2 anywhere,
> not even on lore. Did that get lost?

2/2 is just updating the fb documentation:

[PATCH 2/2] docs: fb: Add font_6x8 to available built-in fonts
https://lore.kernel.org/lkml/717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com/

I did `git format-patch -2 --thread=deep`, did I do something wrong when
sending it?

Thank you,
Peilin Ye

