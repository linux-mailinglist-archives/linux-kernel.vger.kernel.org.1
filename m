Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24D52B02CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLKiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKLKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:38:04 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56129C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:38:04 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w142so7582939lff.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+A/vQ2vpSPhL2cGD7MVzrNKm83MOBEdHKwC0JmJucQ=;
        b=QMC4BkXqJqc2FehnhxxYJ+tI5tSBh6b+Sp+PSWOBEO0f23ZHtwb3uVWJg45+Bu3M3M
         v5GwXcvlTcVUgTEO0oPtp9RDsZniHoyi8UKDj6Snj1a58LkacDGBKdOC5wjm7w+Mvggh
         xWXaLK9xL7IRgEyKJB8HP7ovcRmPq83pFvj5zQ4E4OOSEBOOctLojk4KkHgsYUbjeH0K
         +FsTR6oZHseFDreBbHDQskWoSmfjInIcaP5W7XtXQ3Cgpl6yCoVkb6kGVQJLwOSK1a3q
         kh8Ws1CMExGV1F9+fOwCw5jGKqedQ+jlZnIpstNUimbDr7pC/nwlIuTscAl7Mpc2ovOy
         dmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+A/vQ2vpSPhL2cGD7MVzrNKm83MOBEdHKwC0JmJucQ=;
        b=lB6rAzBAGQms2VW067KoI/zxzLP1FBslweEEoluPZTd/UFlTrXmjSUG2b6HDrk0tw+
         /BlsL7CpdHFvMnAQq15yVnPxKBb6vhhcJEge8VtAC8g3mAaymufnTFXHMukVp9XKKPT6
         D3gCxKQhPc3ymMwRDJxWslEJJOwVG07XBgCtSitWUs+XC7czoWCMmDW5MJi8Ppsaovmv
         hz0XhGOKW5ThjuSN3B/DpNMEJaYw1b8c5wl/Zjs7JfKKkKg+8NIChUO0gR5MiVdup5XF
         RD6wVRkvK/U/4v67oU+l8cVNyEP8oAFTRhv5kTMHkLTH1WroJyRxqWGKMKgrizLg9Bpm
         KjeQ==
X-Gm-Message-State: AOAM531ecHMX+/l9SamGos5xN+AMgaFRBwoeagIy9m3zBGwhDMGdoOHD
        0Y6g7J8ReCVaFr9rfV69QyBlDZ52W6KDjRK9RPK6nSwVO58=
X-Google-Smtp-Source: ABdhPJwVUogLbLgWh0H+1t04PcWwoEMWk9Msl9Y2j39LCUMrTYAzG8h8hrNPM3bWsKod/qZ2dNp3JOXgm8pvSPuSuTs=
X-Received: by 2002:a05:6512:21c:: with SMTP id a28mr4472348lfo.486.1605177482733;
 Thu, 12 Nov 2020 02:38:02 -0800 (PST)
MIME-Version: 1.0
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-3-git-send-email-anshuman.khandual@arm.com> <67e0864f-e025-aa08-d1b7-36cf19629197@arm.com>
In-Reply-To: <67e0864f-e025-aa08-d1b7-36cf19629197@arm.com>
From:   Linu Cherian <linuc.decode@gmail.com>
Date:   Thu, 12 Nov 2020 16:07:50 +0530
Message-ID: <CAAHhmWiWbUTt-BvjeqGm3mfN2L8A8gUOVVDNX0P=WCEDj=Mc4A@mail.gmail.com>
Subject: Re: [RFC 02/11] coresight: etm-perf: Allow an event to use different sinks
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, Nov 12, 2020 at 2:51 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Linu,
>
> Please could you test this slightly modified version and give us
> a Tested-by tag if you are happy with the results ?
>
> Suzuki
>
>
> On 11/10/20 12:45 PM, Anshuman Khandual wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > When there are multiple sinks on the system, in the absence
> > of a specified sink, it is quite possible that a default sink
> > for an ETM could be different from that of another ETM. However
> > we do not support having multiple sinks for an event yet. This
> > patch allows the event to use the default sinks on the ETMs
> > where they are scheduled as long as the sinks are of the same
> > type.
> >
> > e.g, if we have 1x1 topology with per-CPU ETRs, the event can
> > use the per-CPU ETR for the session. However, if the sinks
> > are of different type, e.g TMC-ETR on one and a custom sink
> > on another, the event will only trace on the first detected
> > sink.
> >
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm-perf.c | 50 ++++++++++++++++++------
> >   1 file changed, 39 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index c2c9b12..ea73cfa 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -204,14 +204,22 @@ static void etm_free_aux(void *data)
> >       schedule_work(&event_data->work);
> >   }
> >
> > +static bool sinks_match(struct coresight_device *a, struct coresight_device *b)
> > +{
> > +     if (!a || !b)
> > +             return false;
> > +     return (sink_ops(a) == sink_ops(b));
> > +}
> > +
> >   static void *etm_setup_aux(struct perf_event *event, void **pages,
> >                          int nr_pages, bool overwrite)
> >   {
> >       u32 id;
> >       int cpu = event->cpu;
> >       cpumask_t *mask;
> > -     struct coresight_device *sink;
> > +     struct coresight_device *sink = NULL;
> >       struct etm_event_data *event_data = NULL;
> > +     bool sink_forced = false;
> >
> >       event_data = alloc_event_data(cpu);
> >       if (!event_data)
> > @@ -222,6 +230,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >       if (event->attr.config2) {
> >               id = (u32)event->attr.config2;
> >               sink = coresight_get_sink_by_id(id);
> > +             sink_forced = true;
> >       }
> >
> >       mask = &event_data->mask;
> > @@ -235,7 +244,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >        */
> >       for_each_cpu(cpu, mask) {
> >               struct list_head *path;
> > -             struct coresight_device *csdev;
> > +             struct coresight_device *csdev, *new_sink;
> >
> >               csdev = per_cpu(csdev_src, cpu);
> >               /*
> > @@ -249,21 +258,35 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >               }
> >
> >               /*
> > -              * No sink provided - look for a default sink for one of the
> > -              * devices. At present we only support topology where all CPUs
> > -              * use the same sink [N:1], so only need to find one sink. The
> > -              * coresight_build_path later will remove any CPU that does not
> > -              * attach to the sink, or if we have not found a sink.
> > +              * No sink provided - look for a default sink for all the devices.
> > +              * We only support multiple sinks, only if all the default sinks
> > +              * are of the same type, so that the sink buffer can be shared
> > +              * as the event moves around. We don't trace on a CPU if it can't
> > +              *
> >                */
> > -             if (!sink)
> > -                     sink = coresight_find_default_sink(csdev);
> > +             if (!sink_forced) {
> > +                     new_sink = coresight_find_default_sink(csdev);
> > +                     if (!new_sink) {
> > +                             cpumask_clear_cpu(cpu, mask);
> > +                             continue;
> > +                     }
> > +                     /* Skip checks for the first sink */
> > +                     if (!sink) {
> > +                             sink = new_sink;
> > +                     } else if (!sinks_match(new_sink, sink)) {
> > +                             cpumask_clear_cpu(cpu, mask);
> > +                             continue;
> > +                     }
> > +             } else {
> > +                     new_sink = sink;
> > +             }
> >
> >               /*
> >                * Building a path doesn't enable it, it simply builds a
> >                * list of devices from source to sink that can be
> >                * referenced later when the path is actually needed.
> >                */
> > -             path = coresight_build_path(csdev, sink);
> > +             path = coresight_build_path(csdev, new_sink);
> >               if (IS_ERR(path)) {
> >                       cpumask_clear_cpu(cpu, mask);
> >                       continue;
> > @@ -284,7 +307,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >       if (!sink_ops(sink)->alloc_buffer || !sink_ops(sink)->free_buffer)
> >               goto err;
> >
> > -     /* Allocate the sink buffer for this session */
> > +     /*
> > +      * Allocate the sink buffer for this session. All the sinks
> > +      * where this event can be scheduled are ensured to be of the
> > +      * same type. Thus the same sink configuration is used by the
> > +      * sinks.
> > +      */
> >       event_data->snk_config =
> >                       sink_ops(sink)->alloc_buffer(sink, event, pages,
> >                                                    nr_pages, overwrite);
> >
>

Perf record and report worked fine with this as well, with formatting
related opencsd hacks.

Tested-by : Linu Cherian <lcherian@marvell.com>

Thanks.
