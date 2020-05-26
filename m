Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C441B4E79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDVUqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgDVUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:46:03 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31478C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:46:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e26so3476626otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bCg8bvNmgUuam7hE8aERJSHaUoXzmzcb4svUaIW+Bg=;
        b=j1svlTwB5CMoY1MWPNS26eCTOItSrWPJwu5Xirgfy9OmjsrI/8neRVSDltcQTuXssH
         MKz+GnOG0Y1eAQQgMyuqetCTCISJVqcQrwB42hbxF90ynmaH4CceJJmDU9nYJxRnq8Wj
         c2IaIf9FmYsh6iHTdd2N13fp3IZsFxL/GBgnn680ozcDRzM9JQbvyi4HxQlsLbh0ulgu
         lJDzCie2CjVLMNTBlGpLCW1jZ8DWARb/Ksc+dKjlbV/9Jd9ZC9hWpSuqqBm3aRYnKSRu
         MkE82Bm1SE4q0gTQA8LybxWDORjmjnd85NQtOLHxajqG7O11MxHgOi2Qou+qQ99VhbwB
         NIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bCg8bvNmgUuam7hE8aERJSHaUoXzmzcb4svUaIW+Bg=;
        b=NWehbz1+6jIBpniGx1pEjMuDPgSjYyRAl2GKkJ/jfC0cjXimhLxeuDKbBlV/hYaBwl
         yGMU2Zm1QTE3Fvyg2DvnD9krbDMMe3LnVE45quPQF2rnAu7pcg1aU7WNdMFz/ZHO1tZg
         XZYdxmsSjohqA35BD//KuiH7urUeB8S6socI0hX60ZC3J6rlXHcmvYRWzjAn6jK+UGaY
         18nBRZQk94PhhNy8Zre313XnfPOdtOzZzU0Gx17nyjqFCKE+sqdJBwJrK2J2Da3fl6Go
         0ggW3dvpyv9li5wdwh1sCpvIydD9hD1AlSutCNgXlw+XKhEqLL09cmnjBBM5QqnNx1J1
         Mujw==
X-Gm-Message-State: AGi0PuZNCjo/yCS/yKQyyVW6iwUePerQqjnDyi2HuPYDF281tMyyTF97
        Rhvpgsk3cTDVA1+6+AdzEQkwVetro5Gt/rQvfgkMMw==
X-Google-Smtp-Source: APiQypITlavDSzc4OSiUD5yDWrzXGkJyW5M+cDplprwAPZfSa72YOKqxb8R4uBmPFp3TN/4VifziBqcENPZT5t0ZvDM=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr749663otc.221.1587588361411;
 Wed, 22 Apr 2020 13:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200421235836.GA8319@lxhi-065.adit-jv.com> <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
 <20200422075413.GB4898@sirena.org.uk>
In-Reply-To: <20200422075413.GB4898@sirena.org.uk>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 22 Apr 2020 13:45:49 -0700
Message-ID: <CALAqxLW13oA376bqj7uTR4E4zmnX5ASK=rpqw3HMr4yOWQGaOw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup driver_deferred_probe_check_state()
To:     Mark Brown <broonie@kernel.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:54 AM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Apr 21, 2020 at 06:16:31PM -0700, John Stultz wrote:
>
> > The second reverts the default timeout back to 0:
> >   https://lore.kernel.org/lkml/20200413204253.84991-1-john.stultz@linaro.org/
>
> If you're reverting the timeout we should revert the regulator change
> too I think.

Maybe? The main issue for me was my change was clearly breaking users
with dts with missing dependencies where their setup was working
before. I sort of feel like having a dtb with missing dependencies is
less valid than wanting to load module dependencies from userland, but
they were working first, so we have to keep them happy :) And at least
now the latter can add the timeout boot argument to make it work.

For your case, I'm not sure if the timeout would run afoul on the nfs
root mounting case this one tripped over.

thanks
-john
