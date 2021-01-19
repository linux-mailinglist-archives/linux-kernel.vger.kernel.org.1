Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83F2FB718
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbhASKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbhASJx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:53:28 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C969C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:52:46 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id h18so10722821vsg.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvjIP08JcWTDKv/EkjmGjjz2/Ez706ArkiY7SpIuCxU=;
        b=S76XbketDfZ5GOQP3pIs7MNG45HGRAYb/s53ny9BZCQVB19xEkUeQS01TTyf168ona
         Dph7cxIw6Z8V1n9ieX5l131KhH5A+VOkODESEHvkz/WMefABtTe+zMkoTtHZDH/c3Ur0
         VwzTLh0YRvzQ5DxgAwqwwNkMlywDSr+l+iAbDEpUAz/VwYhsZEdXl6r9F7CA/eyt0I9I
         p66qw5dAFsWdoTR59kT9AEoZjYWnHF7dIx6iMOvhYIrh4nXYunYMOCqUhhBAPpA/Mwnd
         NYVEi4txXDV6FnnXd8MtbkEdPJwcXgc//iI7JkmsSOL/vndGB73Ls5MUNmGRU6q84Vvj
         8JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvjIP08JcWTDKv/EkjmGjjz2/Ez706ArkiY7SpIuCxU=;
        b=cZW12lJUT5btiP7wfCmL1g8/s2J19d315C8I+fsiA/v08MHbBT2f4N8x5BGivcWMlu
         DCGbPpdkvC97k6tONyaz8GqaJDpxkOv/vqhAD3CWRmhKNdD2RzNkOV72VEhwkqnlaKNA
         vQzkecoQiZOzJrGvyBTGJfiONSqhX6czoQs+FaUhodNG+WSXVvgRTx4wK6uoPadrR39l
         o7Y9oGqmtaO+XTciDc2dneHp6fEs3QfvnF3DMDQOAjlr2O1lnZfcMj5QDJSQlK73HFsh
         scHVM4I7kNj9+SycUHrCauV8JvzR54LTW5ssFX1uRfeB5M0v4kAqSzAi+4raiMfd3SQ0
         6+UA==
X-Gm-Message-State: AOAM531xRDjjXX7IRR+zVqx0nAAm6VhaROzp3pJxqhGs5MFlaRYfSX/y
        irA0fRkWBy6v+j1fV51SxpqtpmrxS+5KtpgfweAyaA==
X-Google-Smtp-Source: ABdhPJxAkvFe7flhE98SBpSnM5IMOBz4v5rCx2G5W8QFgBx180sUyyr3j2h5bpp9P7Jgbxy5KNOUIPyvIujWKp8D73U=
X-Received: by 2002:a67:facb:: with SMTP id g11mr2168122vsq.19.1611049965177;
 Tue, 19 Jan 2021 01:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20210118011330.4145-1-digetx@gmail.com> <20210118011330.4145-2-digetx@gmail.com>
 <20210118072855.anncyl6z3e5uznvd@vireshk-i7> <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
 <20210118110506.linvsoca7jbl42iq@vireshk-i7> <CAPDyKFr7SD_A9sKD2+90XfjP09T+PCLE=8qvn=M-yPEPXvBhsg@mail.gmail.com>
 <20210119034428.qgjjlvti6sirsnzy@vireshk-i7>
In-Reply-To: <20210119034428.qgjjlvti6sirsnzy@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 10:52:08 +0100
Message-ID: <CAPDyKFp3OpV5qgfB_EGf=fyCR5b0b0zntbsXAJJsWbJX09gF6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: domains: Make set_performance_state() callback optional
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 04:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-01-21, 13:46, Ulf Hansson wrote:
> > You seem to be worried about latency/overhead while doing the
> > propagation upwards in the hierarchy. That seems like a reasonable
> > concern to me, especially as the genpd lock is taken at each level.
>
> I am not sure how many levels of domains we have normally, but unless the number
> is big it won't be a very big problem.

It depends on the SoC topology, so obviously it differs. But more than
a couple is unusual, I would say.

However, I think it may also depend on how many devices that are
hooked up to the domains and how actively these are being used.

>
> > However, to mitigate this can be rather messy. In principle, we would
> > need to walk the hierarchy upwards, each time a new subdomain is added
> > in genpd_add_subdomain(). While doing this, we would also need to keep
> > track on what level we set to continue the propagation of the
> > performance states for. Even if this can be done in non-latency
> > sensitive paths, I don't think it's worth it because of complexity (I
> > haven't even thought of what happens when removing a subdomain).
>
> What about a new field in the domain structure like 'can-handle-pstates', and
> then whenever sub-domain gets added it just needs to check its parent's field
> and set his own.

That would work if the topology is built from top to bottom, but I
don't think we can rely on that.

For example, when a domain A is added as a child to domain B, domain B
doesn't have a parent yet (and the "can-handle-pstates" don't get set
for neither domain A or domain B). Next, domain B is added as child
domain to domain C. Domain C has the "can-handle-pstates" set, which
means domain B gets the "can-handle-pstates" set as well. This means
domain A, will not have "can-handle-pstates" set, while it probably
should have.

>
> > So, maybe we should simply just stick to the existing code, forcing
> > the parent to have a ->set_performance() callback assigned if
> > propagation should continue?
>
> I think it would be better to fix the issue even if we aren't fully optimized
> and making the change to make sure we keep propagating is rather important.

Alright, let's continue with Dmitry's patches and discuss this further
when v4 is out, as he seems to have it almost ready.

Kind regards
Uffe
