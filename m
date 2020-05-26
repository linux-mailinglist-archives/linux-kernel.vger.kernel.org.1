Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AA1B5B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgDWMW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbgDWMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:22:27 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC92C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:22:27 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 36so1351878uaf.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQp/+NnZT7xuP7zQ8iR6+6K7f5pp2S+U2r/fnGuT0Ss=;
        b=HGdvKG3DWQOKq1jelJ/RuzPy/tbrJMWphiFTtCkymuxBRKdjlGhNtZEi0Kt0bmdV2a
         xv5A+t2HqrfGrEBgWa6pm40bDm/Mt2MnMzs/reNMk9qtbAPAsJ2vOjmhRnMrcD4DPupT
         py150V+OjRpFRb7Js3Y1+qiRop7emtt+QvDKjXFTqBDG2+hj/NJUXvh+e6L3T8VkCbYs
         6VCt0cXj1xKujb80FDNI8QwpbPoUe08QlFEViKzgkYVFBnkryx7zXQmnleUySwGv1fUj
         4oAxFklpVn5O/8ZEvAmWA1QeI5t6xWV0GXBCtpZT0NjbUNJQ8CiOq5QYefsmruUCADJ8
         EodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQp/+NnZT7xuP7zQ8iR6+6K7f5pp2S+U2r/fnGuT0Ss=;
        b=bUaaumfyncOI5HNw5oqrBV3Kmt1kC5aX+Vjj/9YM6z88mlC0fCdWnrG3mk72BEYtTs
         Nrctd4Hzl0O7om2Sf4NsDDzCN4q0fKA6/LXBGXjujRe7dFuoieMCanhWJi8pyjR6Kqey
         EqFmFc7JzhpSA7WVepdVBh8cdro9I7GbIqAayeQ3qJ8i6RwwzRPBIvKOH3r2ZaCHyZW0
         rytxykFe/23G41YsPYayyopqDacWrI2WXq4LcHtiQizxHzyCf6GAJpj78Y1nticp/kmC
         SEIqOn1yqsOZlNPmhtYjD1h4SeIQx3rBVZ2xoNh8tIZzvFDtx9UQi6Vw0b6vYIIEmAvt
         X1eA==
X-Gm-Message-State: AGi0PuYHJF99CAjuWqDKuSX5baRc3qRBSR3WrTuQ6dkmDqXB6Ms2lHFV
        MavcSHs7Hwf45aZoOwicEVYmR9b3Nn9ZkyW0oE2n0w==
X-Google-Smtp-Source: APiQypIvMNnUtDTaqa3c9rLP6PGh1YHIOgeazgeaHOCVrZkHTM+3JCNPyqBZXIAga7ZH8cCkAGiF5V8I8SCrgq4WWiY=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr2692108vsm.165.1587644545946;
 Thu, 23 Apr 2020 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <1587633319-19835-1-git-send-email-zou_wei@huawei.com>
 <CAPDyKFogU2BT1vmcovrGvNEOtS+cxWwM09foMfN3bOPXEhhT3g@mail.gmail.com> <C3CD0DF8AD11A84CB25A1426DE537C61E59522ED@dggeml524-mbx.china.huawei.com>
In-Reply-To: <C3CD0DF8AD11A84CB25A1426DE537C61E59522ED@dggeml524-mbx.china.huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Apr 2020 14:21:50 +0200
Message-ID: <CAPDyKFpf7HWUk3Ss=swvrGYBh_nDoKW02vqThbN=CWwekp4zrA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: core: Use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
To:     "Zouwei (Samuel)" <zou_wei@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 at 13:55, Zouwei (Samuel) <zou_wei@huawei.com> wrote:
>
> Hi Ulf,
>
> Thanks for your review and reply.
>
> 1. DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file() imposes some significa=
nt overhead as compared to DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_u=
nsafe().
>   You can refer to the patch of 1a2b3666da58 ("mt76: fix debugfs_simple_a=
ttr.cocci warnings")

I see.

> 2. debugfs_create_file_unsafe(...&mmc_clock_fops) is corresponds to DEFIN=
E_DEBUGFS_ATTRIBUTE(mmc_clock_fops...), so I only modified this one.

I have now read the complete function header of
debugfs_create_file_unsafe() and realized that this is indeed okay.

>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B44=E6=9C=8823=E6=97=A5 =
19:17
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zouwei (Samuel) <zou_wei@huawei.com>
> =E6=8A=84=E9=80=81: linux-mmc@vger.kernel.org; Linux Kernel Mailing List =
<linux-kernel@vger.kernel.org>
> =E4=B8=BB=E9=A2=98: Re: [PATCH -next] mmc: core: Use DEFINE_DEBUGFS_ATTRI=
BUTE instead of DEFINE_SIMPLE_ATTRIBUTE
>
> On Thu, 23 Apr 2020 at 11:09, Zou Wei <zou_wei@huawei.com> wrote:
> >
> > Fixes coccicheck warning:
> >
> > drivers/mmc/core/debugfs.c:222:0-23: WARNING: mmc_clock_fops should be
> > defined with DEFINE_DEBUGFS_ATTRIBUTE
> >
> > Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> > debugfs files
> >
> > Fixes: 703aae3d09a4b ("mmc: add a file to debugfs for changing host
> > clock at runtime")
> > Fixes: a04c50aaa916f ("mmc: core: no need to check return value of
> > debugfs_create functions")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied for next, thanks!

Kind regards
Uffe

> > ---
> >  drivers/mmc/core/debugfs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> > index 09e0c76..9ec84c8 100644
> > --- a/drivers/mmc/core/debugfs.c
> > +++ b/drivers/mmc/core/debugfs.c
> > @@ -219,7 +219,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
> >         return 0;
> >  }
> >
> > -DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get,
> > mmc_clock_opt_set,
> > +DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get,
> > +mmc_clock_opt_set,
> >         "%llu\n");
> >
> >  void mmc_add_host_debugfs(struct mmc_host *host) @@ -232,8 +232,8 @@
> > void mmc_add_host_debugfs(struct mmc_host *host)
> >         debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
> >         debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
> >         debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
> > -       debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
> > -                           &mmc_clock_fops);
> > +       debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, ho=
st,
> > +                                  &mmc_clock_fops);
>
> Apologize for my ignorance, but why convert to the *_unsafe option for th=
is one, but not for the others?
>
> [...]
>
> Kind regards
> Uffe
