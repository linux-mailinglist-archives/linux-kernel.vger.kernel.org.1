Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605B02B5C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgKQKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKQKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:03:50 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80544C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:03:50 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id w8so7974720ilg.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPHGLiORbaJbLxUM7+BhRXlMBVSZRTpOSLRe1ua1EJU=;
        b=Zn2SMY+essfbJPuhgilqqLmFJylQDR9RinMiH8a5O3JxvWKq3503dJmQxlV9cUvyN7
         kRW3XmOMkiKgkrQ12XtFqBg1/28VixwRrmA5WLxPAWEohqQMZHeiCvG7p2lp7BKbSNnz
         mijKzcpj+gO/ZFU96WloUL3Tu6VXC4WlEyLVqSQPHWOIC0h+q0fON5KEKzmtuMTPPyNk
         9pbgOxrBjcs5mIpiniS2rCZSSimk4v+hlJMW33vpPjMkLxmnnCTwqC7AVWloaQv1+GLo
         nDhhadH1doOxU6a2QA7hffRyqhuyg6A0zrnBwnMqDVtFzV4F7re2h7cVCcDMJPYTNli6
         xwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPHGLiORbaJbLxUM7+BhRXlMBVSZRTpOSLRe1ua1EJU=;
        b=EHpqrSAeGxZmt4WF3nuPsTU1cMRvafaEvntisAbUWj8uQJzUAX3CPgCC0vaJkKWlbS
         XzOqRFLCqHlsiSannlD2ODtIIKNDwYGsGWQYbnwNKpsNlLTGIH52knR7xlVAffzFsGEv
         xJ6roy8EOBDGRA8psWwwTF5/Mjo1cl1gTZKmwaiiWw/Co12i9pwhYM8KbOIHQzcps9e2
         3GSE+i/xV2fEJHOWXF8pvkwe/s1QaZ5bxwGruZXUz+MbcLhVooo7slmSepCdZ/TokDp7
         8raaSmD6Ifz5PTKNGB/tb/qWTCZ1Wc5sOZkqA7PhcFKIEx2f3AGYeM/dU0I8LW5rjN4b
         0BNA==
X-Gm-Message-State: AOAM531Zt8vWznY5WXmAqyGHfVYeIDaSeXm0lvgr5nhyadZbqC86H0cb
        05hTR5EKZCtOWAljg5oZcEwy1wAzxnZir4wS2mwRuQ==
X-Google-Smtp-Source: ABdhPJxpzE0hfqNEPElqTxkhKxnLGbU0Jc7DfYxYbIEhVnGR5svnoF49V7Yxf7pgQ7SOPd3w1CySAUjKJwnaY89p1O8=
X-Received: by 2002:a92:ac02:: with SMTP id r2mr11518854ilh.31.1605607429892;
 Tue, 17 Nov 2020 02:03:49 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHAgVUPHOPxDdt3LeAWqokxfuzqjZj4qqFkoKxFbRbRrg@mail.gmail.com>
 <20201020112413.xbk2vow2kgjky3pb@vireshk-i7> <CAF6AEGsCj-AtFozn8d1xiNNFNbuMJ0UxS-eMhBVXiQ7rKahKnQ@mail.gmail.com>
 <20201022080644.2ck4okrxygmkuatn@vireshk-i7> <CAF6AEGv6RMCsK4yp-W2d1mVTMcEiiwFGAb+V8rYLhDdMhqP80Q@mail.gmail.com>
 <20201027113532.nriqqws7gdcu5su6@vireshk-i7> <20201103054715.4l5j57pyjz6zd6ed@vireshk-i7>
 <CAF6AEGtgUVXm6Wwod0FC38g91Q8CotLFSoC4NmXx7GzcA=1mOA@mail.gmail.com>
 <20201104030353.ny7zvakgb4fsye6r@vireshk-i7> <CAF6AEGv215ixcAWmaOWs7UKAqmbMs=aFyTBBYLU-bt8XBnWb7g@mail.gmail.com>
 <20201106071621.j732gt4nqifjrccd@vireshk-i7>
In-Reply-To: <20201106071621.j732gt4nqifjrccd@vireshk-i7>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 17 Nov 2020 15:33:38 +0530
Message-ID: <CAKohpo=EhGtLqseRwbc9_zPeHCkzFoYcj2bz_YdQSN3M0ms4zQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] drm/msm: Do rpm get sooner in the submit path
To:     Rob Clark <robdclark@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Menon, Nishanth" <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 12:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-11-20, 11:24, Rob Clark wrote:
> > On Tue, Nov 3, 2020 at 7:04 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 03-11-20, 08:50, Rob Clark wrote:
> > > > sorry, it didn't apply cleanly (which I guess is due to some other
> > > > dependencies that need to be picked back to v5.4 product kernel), and
> > > > due to some other things I'm in middle of debugging I didn't have time
> > > > yet to switch to v5.10-rc or look at what else needs to
> > > > cherry-picked..
> > > >
> > > > If you could, pushing a branch with this patch somewhere would be a
> > > > bit easier to work with (ie. fetch && cherry-pick is easier to deal
> > > > with than picking things from list)
> > >
> > > It has been in linux-next for a few days. Here is the HEAD to pick
> > > from. There are few patches there since rc1.
> > >
> > > commit 203e29749cc0 ("opp: Allocate the OPP table outside of opp_table_lock")
> > >
> >
> > sorry for the delay, with that cherry-picked, I'm getting a whole lot of:
>
> Ahh, sorry about that and thanks for reporting it. Here is the fix:
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c718092757d9..6b7f0066942d 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -112,8 +112,6 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
>         struct opp_table *opp_table;
>         struct device_node *opp_table_np;
>
> -       lockdep_assert_held(&opp_table_lock);
> -
>         opp_table_np = of_get_parent(opp_np);
>         if (!opp_table_np)
>                 goto err;
> @@ -121,12 +119,15 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
>         /* It is safe to put the node now as all we need now is its address */
>         of_node_put(opp_table_np);
>
> +       mutex_lock(&opp_table_lock);
>         list_for_each_entry(opp_table, &opp_tables, node) {
>                 if (opp_table_np == opp_table->np) {
>                         _get_opp_table_kref(opp_table);
> +                       mutex_unlock(&opp_table_lock);
>                         return opp_table;
>                 }
>         }
> +       mutex_unlock(&opp_table_lock);
>
>  err:
>         return ERR_PTR(-ENODEV);

Ping.
