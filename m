Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBEC2AB490
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgKIKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:15:23 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D05C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:15:23 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id s8so7662428yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OC1VTLRt1Z5MsJoSN7j3NrTUZhVTSLlFsU5ZM3VC9vQ=;
        b=ri0T5ESodYUTVULMMwZwfH/O/w5YSI0yEjuuNyjQgkCVm4Aj8zfMCQXjjkehof0g/Q
         Xz2H5nh0oSZw+rfeLKWhMFzAZBi0E2kWg8Ll21qCWHkEwFz8nUiVMEV+6HESnqzf/jvT
         L11IERshipA+KOPZsxhDUFRAz9Wbrc7FVCOJie0bnBknqTlZeLKa1fVjDkXOLllpR0ol
         x8LNnpuNRBYjYx9sZ4oQQojzbsNgoNT7I5EAY05PVZz068mVYcgpjHEsySl/jSxwJbGY
         BC86+wLOvABMSDEFQFwHEluTvK02Q+lXa4utcD63Zl62OHoPSUeOASSmfsFkrU3+e2MG
         Nqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OC1VTLRt1Z5MsJoSN7j3NrTUZhVTSLlFsU5ZM3VC9vQ=;
        b=FjwJ4/1bOL8Du9cZ0xHJT148LSVSm/LWUEp0RvfRpNymjKyqZpJ1CMBT7rfrX8faOV
         3ygou/WeZgZWUfPcXUWLFzxiRW0Ufe2HasIEf2DkCURubJAOUjRriCyhSR7cPvS7Ot1+
         6T9ga3NmtBJ+zucagUGNHvG5PRD6sVcdtE6EXuZPD3/+LN99h7qxfD/nX5vrBZH1BEDi
         qbrN49Wm+Dui/Zc6UPbA/AZV7p47OSq1Jv1hOaqs+pNgDXRV2fGUHzG3SCTsm0I8dhXw
         8df7bwXVe945kv+DbU7UwVz/DAO08F/wuI0Vfio5ljo2hBprb7lHFgpW+YI0VpMyMFJe
         iMZw==
X-Gm-Message-State: AOAM531orLMDpWqof4nplr4vo7tFxQ6OotQJl0C3tgoQC6jTJ/c+absS
        VSsVJtya8gBrgGuoMJEwjMxHTZYskzTD3ulxgK0=
X-Google-Smtp-Source: ABdhPJxsGhITnPwz4TxcShV8ZC7Sut7bLwXcValgRFq074tOSPBSVGacFjXq7NXeBg2L5nkHutV0081aIIXkyLrWAU0=
X-Received: by 2002:a25:cf08:: with SMTP id f8mr12828573ybg.448.1604916922471;
 Mon, 09 Nov 2020 02:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com> <20201108082317.GA40741@kroah.com>
In-Reply-To: <20201108082317.GA40741@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 9 Nov 2020 10:14:46 +0000
Message-ID: <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix build failure
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Nov 8, 2020 at 8:23 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 07, 2020 at 10:47:27PM +0000, Sudip Mukherjee wrote:
> > When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
> > is unable to find device_is_bound(). The error being:
> > ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
> >       undefined!
> >
> > Export the symbol so that the module finds it.
> >
> > Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > ---
> >
> > resending with the Fixes: tag.
> >
> >  drivers/base/dd.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 148e81969e04..a796a57e5efb 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)
> >  {
> >       return dev->p && klist_node_attached(&dev->p->knode_driver);
> >  }
> > +EXPORT_SYMBOL(device_is_bound);
>
> EXPORT_SYMBOL_GPL() please, like all the other exports in this file.
>
> Also, wait, no, don't call this, are you sure you are calling it in a
> race-free way?  And what branch/tree is the above commit in?

I have not checked fully but since it is being called from probe() I
assume the lock will be held at that time.
This is from linux-next and the original commit is in "for-next"
branch of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
repo. I came across this problem while doing my daily allmodconfig
builds. The build log is at
https://travis-ci.com/github/sudipm-mukherjee/linux-test/jobs/429382451#L24431


-- 
Regards
Sudip
