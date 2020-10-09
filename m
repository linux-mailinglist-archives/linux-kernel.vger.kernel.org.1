Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACC52888F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbgJIMib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIMib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:38:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F98C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:38:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h24so12816547ejg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AesKshfmiRP++qNG3gjQrrTs80ip3TGBIrMv0vi0zsU=;
        b=fHgg+equWL+AsqiPRNcirMOmTBGELl+GV8fNgHPNExE6iDa67fpSmGyHn7aWuww1Eh
         2j2b7DT/PHe7/zE/vPjFq6q02voZIp1tIyhfLRhi10AJym4NxW7xjTcCUPip76cdozFw
         hVfCY9F1OhINvmFajqUgD8xrI8/N8Aau9Alo+Msugm1F+nhBNKMrOo7dT5cH82LEi27d
         XfSYay+HtqXS6Qm//CViGLGXSi789MWitRh32bkkzLlP5aRa7595GPIqG4dOlKsuMbUT
         a0TuAiBKzLl7JCIHsphKy4ncsNAXm9Ffs3P8yy31t+42SHvgBIYMe42T/SUO4cH4oNK0
         PVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AesKshfmiRP++qNG3gjQrrTs80ip3TGBIrMv0vi0zsU=;
        b=rkdxpkShGTSno1M/bmuZ+YIGQiADGgZwYXOjEXg0KG1mVW4vtdeb10l5iuTUXAznt7
         dCi4bEVH69PRXFiT5Qjd0cbfz8T1GAAhNVlvAOePe06hCCzQp4aSVccKRYRiCz/iAOGo
         E8AD9iSoYMz9RsXlFfU+jPlpD/BqX6TDN2KJdN4N+MC04c75nRV8449RxtULbi/hkqUE
         n2wYov4LbXcp/t/BjrBQCj/616CrHwyD0YA1nC27oXikVHdv6QscGFs234okcDoEpcK5
         34PIw5d+MSonND9b4bMTaYlw+sRWvoS0CNjvMOKmrApA/4fJ7vHsKO5gYopDug4rnLKK
         SAsA==
X-Gm-Message-State: AOAM5317qECoGe5nGe86c4sHuHo1yy/7EHxYwReqERodsclsrrkHSSmu
        5hzlryYsBSxyuJG4aSSQfGBi57s7bzX1Rgk4B26A9Q==
X-Google-Smtp-Source: ABdhPJx+BxozC5PJ6wLelny8EIhIrfieUamO1EiURNVv1bUfDXjeY00e9QfFi4QZ4XU3+PKf2O4ZVAZvM+1nB2KAlck=
X-Received: by 2002:a17:906:4a98:: with SMTP id x24mr13743911eju.319.1602247108475;
 Fri, 09 Oct 2020 05:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-2-etienne.carriere@linaro.org> <20201008211804.soegjqsvmsgfmcne@bogus>
In-Reply-To: <20201008211804.soegjqsvmsgfmcne@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 9 Oct 2020 14:38:16 +0200
Message-ID: <CAN5uoS9EGrzoaJ7tA__A=dPx2Y1Cp=v2THMm9YJTrOLUpkaggg@mail.gmail.com>
Subject: Re: [PATCH 2/5] firmware: arm_scmi: fix transfer missing re-initialization
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 at 23:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 08, 2020 at 04:37:19PM +0200, Etienne Carriere wrote:
> > Implement helper function scmi_do_xfer_again() to process consecutive
> > transfers that are initialized only once with scmi_xfer_get_init()
> > and hence get the pool completion and responses message length not
> > reloaded regarding last completed transfer.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  drivers/firmware/arm_scmi/base.c    |  2 +-
> >  drivers/firmware/arm_scmi/clock.c   |  2 +-
> >  drivers/firmware/arm_scmi/common.h  |  2 ++
> >  drivers/firmware/arm_scmi/driver.c  | 10 ++++++++++
> >  drivers/firmware/arm_scmi/perf.c    |  2 +-
> >  drivers/firmware/arm_scmi/sensors.c |  2 +-
> >  6 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > index 9853bd3c4d45..508f214baa1b 100644
> > --- a/drivers/firmware/arm_scmi/base.c
> > +++ b/drivers/firmware/arm_scmi/base.c
> > @@ -183,7 +183,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
> >               /* Set the number of protocols to be skipped/already read */
> >               *num_skip = cpu_to_le32(tot_num_ret);
> >
> > -             ret = scmi_do_xfer(handle, t);
> > +             ret = scmi_do_xfer_again(handle, t);
> >               if (ret)
> >                       break;
> >
> > diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> > index c1cfe3ee3d55..9bb54c1a8d55 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -161,7 +161,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
> >               /* Set the number of rates to be skipped/already read */
> >               clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
> >
> > -             ret = scmi_do_xfer(handle, t);
> > +             ret = scmi_do_xfer_again(handle, t);
> >               if (ret)
> >                       goto err;
> >
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 37fb583f1bf5..6d4eea7b0f3e 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -143,6 +143,8 @@ struct scmi_xfer {
> >
> >  void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
> >  int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
> > +int scmi_do_xfer_again(const struct scmi_handle *handle,
> > +                    struct scmi_xfer *xfer);
> >  int scmi_do_xfer_with_response(const struct scmi_handle *h,
> >                              struct scmi_xfer *xfer);
> >  int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index c5dea87edf8f..887cb8249db0 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -402,6 +402,16 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> >       return ret;
> >  }
> >
> > +int scmi_do_xfer_again(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> > +{
> > +     struct scmi_info *info = handle_to_scmi_info(handle);
> > +
> > +     xfer->rx.len = info->desc->max_msg_size;
>
> I am tempted to just have helper for above and use it where needed.
> Or may be I just don't like the name of the function, how about
> scmi_do_xfer_rxlen_reinit or anything else. Suggestions ?

I think a smoother way would be that scmi_do_xfer() initializes
both
  xfer->rx.len = info->desc->max_msg_size
and
  xfer->hdr.poll_completion = false
instead of doing that from scmi_xfer_get_init().

>
> > +     xfer->hdr.poll_completion = false;
>
> Do we really need the above ?

I think so. Once a transfer is completed, poll_completion is true. But
the next transfer we expect should start assuming completion is not
yet done, hence this reset to false.

Regards,
Etienne

>
> --
> Regards,
> Sudeep
