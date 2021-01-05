Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC82EA193
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbhAEAqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhAEAqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:46:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E0C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:45:34 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d17so39088664ejy.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyfJI4dtsxKeArXoeXBuITYdX7obBLwz+aJmFnS2pHM=;
        b=IP3IWi6e2D7+xXpMgFoVfG3j5yk5zojwINClAUPfOyGPF89KkP1tHBXXNDwNQxfPmx
         rclmTN4e01b32Q4BTt8S40p8vEMSozNGdHj6b5R6McxxdV/VFfwbfw4H/7yy/6YD3k59
         /X0Zrf0wqjSsrk6jC+Ud5ENIFH5F/x7FAm5sb7NPuQwVhMVJ6CgkvudtNdfSbI49ZDwe
         rUfkAA7lWsAWRmbCZw6s0DwrWLbYHhcQAYe+y3FVjk/LwwFstj6QoczkQruDtDA1MOjX
         S91vC0wN0Pihqr1Jo3rNYuwX62nlVJ3G0VqUHAjTMQ4m5YxxddZ54T367lb36msf3inh
         /Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyfJI4dtsxKeArXoeXBuITYdX7obBLwz+aJmFnS2pHM=;
        b=j8AjTGRK2iVxn+dhCgEK8+k5B2/fPtboWnglyd8bdiQt9FTBg3GwP/Wztc9dH8Cfi4
         EDxF8945yt46qb2lFKbIdjGZmqufzCQTa0azezvNREo9aI1benSKpnpWja0dZlr2s4oT
         qSF/LieyCmTs+7hQcDBQGKBf2eGvbHtykgz2Gdl0Mvqe4xSyvcAf9z4cQ8fYXEySBYow
         KNPr2Mj0BOEBRDeTlFPcHtiM+/pkRJuUSnCTqw6nKCDuy/rgpc6DOM7VCrZNOyvEn+dl
         8sLV9NMJqhZKckycZBapVdFVJmUwzbHRU9+plWcBKiXo7SlPdq/e42lydFbtijmZDcFS
         mcgA==
X-Gm-Message-State: AOAM531lggt3bXueMTCCZX7RXjsHMpq+BeHw3XDMxktDZD5fLZnjngxv
        iFShBlWkWb2p37cUJpaTL9J7Gtlfoj7KCYJ1tQ4p
X-Google-Smtp-Source: ABdhPJy7SZ7PohnHD5ePcszn2EXBc+UMBN5ZIumng4b1dP5Kx/luaYQk9zl65YJyS2HZ8nOihZv87LflCX3sg/+nDFw=
X-Received: by 2002:a17:907:700c:: with SMTP id wr12mr67410887ejb.398.1609807533402;
 Mon, 04 Jan 2021 16:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20201211084254.2038-1-zhengyongjun3@huawei.com>
 <20201211153321.GF2015948@madcap2.tricolour.ca> <CAHC9VhS9zCzWLhwE=6AOr7sO-LUdLDS6sb4tC2tDuT=LRYdzHw@mail.gmail.com>
In-Reply-To: <CAHC9VhS9zCzWLhwE=6AOr7sO-LUdLDS6sb4tC2tDuT=LRYdzHw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Jan 2021 19:45:22 -0500
Message-ID: <CAHC9VhTDZiPZ0h-51S-RS2cbT4HPhe=1JhzoqTZAdAhdJCa9Ag@mail.gmail.com>
Subject: Re: [PATCH -next] kernel/audit: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:34 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Dec 11, 2020 at 10:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-12-11 16:42, Zheng Yongjun wrote:
> > > Replace a comma between expression statements by a semicolon.
> > >
> > > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> > > ---
> > >  kernel/audit.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 68cee3bc8cfe..c8497115be35 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -2282,7 +2282,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
> > >
> > >       uid = from_kuid(&init_user_ns, task_uid(current));
> > >       oldloginuid = from_kuid(&init_user_ns, koldloginuid);
> > > -     loginuid = from_kuid(&init_user_ns, kloginuid),
> > > +     loginuid = from_kuid(&init_user_ns, kloginuid);
> >
> > Nice catch.  That went unnoticed through 3 patches, the last two mine...
>
> Yes, thanks for catching this and submitting a patch.  However, as it
> came very late in the v5.10-rcX release cycle I'm going to wait until
> after this merge window to merge it into audit/next.

This should be in audit/next now, thanks!

-- 
paul moore
www.paul-moore.com
