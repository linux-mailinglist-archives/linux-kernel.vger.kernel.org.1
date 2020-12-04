Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1723B2CF1EF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgLDQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:30:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA6C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:30:05 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f9so3472270pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqQ8wemaUsbqYxxnu+QI3DUbnTFkVWHnx3ltod9bOCc=;
        b=fWyOpSDnJe2JI7hneqbXU2DIloScZnj4gARlaGa0ybg45ELuY0ScH8l2HXWVgHTlnj
         HosgwUd/Bpq0aaR5skfTpXh/iZQDjNkK2+CV/bQ01H5y9AOBL593SQJewl0ZVdEYr0PL
         jCqB4JZ8rSWK2E9PsNaFOU8EqCUyPMGT5RXR8u2eE2RBnSGftVJl5PZmRDgSqqAGxORI
         2qQDariNZJSHpdTHeCAALhHNe7wr0GVEXrwlfIGo8uaNg/KIwwKvUIoTE/J/Gw1v9Vv4
         STTg9bwApXQrbdjfZ57COxm6Cjxre2pjLgnS/Wehv09eZm2VU7YNSR4/R8ZYGfy+CT+e
         R5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqQ8wemaUsbqYxxnu+QI3DUbnTFkVWHnx3ltod9bOCc=;
        b=Fo32QXVjkqt1gqafapSAw6B3bjm1NaqedXfskq4MZxudeNvlfzlL5K8KUrC8/KtHG0
         qtbhIUUO3aTtubgEPFTz8OwvOXBXGnf/+XH8H4QHx5LGmvBsvvVuWiqArMmkC1DymWhZ
         NN1HL3O2KIwP3l3x8PjUAynt4G+NvIhXshoU39n2RShIzQdbKcy8lOqvR5anYi4lSCcP
         0QahCmaYte0tIs/xqPGWlczS7Z0SvweAuKBYeqr4ZknxRN4IK8GmP0ULixK31KcRF8H/
         nUbHRRzWsorb3gDnUCmXHRwccTiFB3a68mG1kc4oFK/oqTW/MRrDbVRUQRO1EvxbVJlb
         A1LQ==
X-Gm-Message-State: AOAM533H3M6EbgSQqVCR7mP08Aye4wkJBLg0/D+Cv0k/DJ/oHwIGrd2w
        n4MRo1xo+ijzYfJ7EweCLitU8UTC64a34aE97xh1/w==
X-Google-Smtp-Source: ABdhPJw10s9fEIyX9zOyS0QJHIlLwelmrS8QWA571EtQHByxTrDUGlsLkvNFEyuWilQhwBAdSsHJsgb6qcHh2YACh80=
X-Received: by 2002:a62:25c7:0:b029:156:72a3:b0c0 with SMTP id
 l190-20020a6225c70000b029015672a3b0c0mr4461020pfl.59.1607099403873; Fri, 04
 Dec 2020 08:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20201203233546.3482813-1-tstrudel@google.com> <CAPDyKFoH+_7QJepcPwth_EcBKuj1iU7y7i5semd1QZDsVwT0ww@mail.gmail.com>
In-Reply-To: <CAPDyKFoH+_7QJepcPwth_EcBKuj1iU7y7i5semd1QZDsVwT0ww@mail.gmail.com>
From:   Thierry Strudel <tstrudel@google.com>
Date:   Fri, 4 Dec 2020 08:29:52 -0800
Message-ID: <CAMGPabXRezPazh3PD4_sBycNtAQsi_-auu6rMP4=u74yoHJGrg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: create debugfs nodes when adding power domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uffe,

> >
> > +static void genpd_debug_remove(struct generic_pm_domain *genpd);
> > +
>
> Please avoid these forward declarations. I think it's better to move
> the code around.

I can move up
static void genpd_debug_remove(struct generic_pm_domain *genpd)
but moving
static void genpd_debug_add(struct generic_pm_domain *genpd)
requires moving all those functions implementation:
DEFINE_SHOW_ATTRIBUTE(summary);
DEFINE_SHOW_ATTRIBUTE(status);
DEFINE_SHOW_ATTRIBUTE(sub_domains);
DEFINE_SHOW_ATTRIBUTE(idle_states);
DEFINE_SHOW_ATTRIBUTE(active_time);
DEFINE_SHOW_ATTRIBUTE(total_idle_time);
DEFINE_SHOW_ATTRIBUTE(devices);
DEFINE_SHOW_ATTRIBUTE(perf_state);

are you fine keeping
static void genpd_debug_add(struct generic_pm_domain *genpd)
as a forward declaration ?

>
> >  static int genpd_remove(struct generic_pm_domain *genpd)
> >  {
> >         struct gpd_link *l, *link;
> > @@ -1987,6 +1992,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >                 kfree(link);
> >         }
> >
> > +       genpd_debug_remove(genpd);
> >         list_del(&genpd->gpd_list_node);
> >         genpd_unlock(genpd);
> >         cancel_work_sync(&genpd->power_off_work);
> > @@ -3177,36 +3183,44 @@ DEFINE_SHOW_ATTRIBUTE(total_idle_time);
> >  DEFINE_SHOW_ATTRIBUTE(devices);
> >  DEFINE_SHOW_ATTRIBUTE(perf_state);
> >
> > -static int __init genpd_debug_init(void)
> > +static void genpd_debug_add(struct generic_pm_domain *genpd)
> >  {
> >         struct dentry *d;
> > -       struct generic_pm_domain *genpd;
> >
> > +       d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
>
> What happens if "genpd_debugfs_dir" is NULL, which will be the case
> until the late_initcall(genpd_debug_init) has been executed!?

Good point, I'll return early if NULL and in
static int __init genpd_debug_init(void)
I'll iterate on the list to create the nodes

> Kind regards
> Uffe

Best regards
Thierry
