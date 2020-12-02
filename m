Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C342CC406
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgLBRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgLBRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:41:01 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C3C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 09:40:20 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id bo9so5559049ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ki/Hvlj0Gq76K0xpYXKuMz7BFER2JLX78INWgIFB0Tc=;
        b=Xec8c/1/im8za540FjwT96wKz/EhCXa2kBp7zBDRiS/QSrDKRxAxSv+1pZWEjOl4es
         WVZUInRPV5IiM5LlVI/+8ZznxKrKy+6gIM30X8UcfLb/o+PU5+rE30u8r/Y8P/miEQNt
         7hRPh4vhlAwSldrX/sg4+/hAXJ1fhFzCj/N34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki/Hvlj0Gq76K0xpYXKuMz7BFER2JLX78INWgIFB0Tc=;
        b=pb6nOQpk3vW+VhKL9Ak5JR049v5IwjrdSQPYdfAWwR0pkDnBwHdIGdHV0sCnJU8GaI
         RaWXaHLSHJVHzsfWsOaHGncRWGq3ZaGvh3IJro9XCV2P16Ri3Ed/eaRcWFJKRzssFClz
         jOHc4dHTp6oy74JCS7eGVh683En4JMnFORVWWTW8J612kaWCLmXjrguGNlqeArPl0hG2
         jt1+SoAUVWfeNj79Lto9wOVB9Qis1AVMG/5sd5EJgiiBSGYVgm6CUVPtzYunEt6U3L70
         0al4SHNNn4ilEO8RzbCTQyIza7QSnebD5NNCxTu1d4lpwCX3DjZzEoU8SaQqJviYDG49
         M6zQ==
X-Gm-Message-State: AOAM531sXLDbKVfMZvW8m677Pv9nt/Wq0jKLEbFa0RWBDWhGTW3G1LF7
        oZzcS49Fcw6vGAuBzwsDCA57avDHU9358A==
X-Google-Smtp-Source: ABdhPJz+iqwoOZIp3fJokT5YMXDfaqmiLwlYGl06W/8tvs5o3n4l2SUxWYKRBdTEYO2Od3HCWqsACQ==
X-Received: by 2002:a17:906:c097:: with SMTP id f23mr920815ejz.136.1606930818857;
        Wed, 02 Dec 2020 09:40:18 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id z10sm386032ejl.30.2020.12.02.09.40.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:40:18 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id k14so4965560wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 09:40:16 -0800 (PST)
X-Received: by 2002:a5d:4388:: with SMTP id i8mr4929307wrq.262.1606930816557;
 Wed, 02 Dec 2020 09:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20201201042322.3346817-1-frkoenig@chromium.org>
 <57cc5999-e54c-219c-812b-71b214dbe760@linaro.org> <CAPBb6MUU0TayGLq-Jifh1O2RfhoTjimY7GEQcqdoxQ6itybbfw@mail.gmail.com>
In-Reply-To: <CAPBb6MUU0TayGLq-Jifh1O2RfhoTjimY7GEQcqdoxQ6itybbfw@mail.gmail.com>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Wed, 2 Dec 2020 09:40:03 -0800
X-Gmail-Original-Message-ID: <CAMfZQbye-KDtBG8UHUkyz3Fp0V=y0jJaD-CNLvXdZ-nAZUv7+w@mail.gmail.com>
Message-ID: <CAMfZQbye-KDtBG8UHUkyz3Fp0V=y0jJaD-CNLvXdZ-nAZUv7+w@mail.gmail.com>
Subject: Re: [PATCH v2] venus: vdec: Handle DRC after drain
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 9:58 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> On Wed, Dec 2, 2020 at 7:34 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
> >
> > Hi Fritz,
> >
> > On 12/1/20 6:23 AM, Fritz Koenig wrote:
> > > If the DRC is near the end of the stream the client
> > > may send a V4L2_DEC_CMD_STOP before the DRC occurs.
> > > V4L2_DEC_CMD_STOP puts the driver into the
> > > VENUS_DEC_STATE_DRAIN state.  DRC must be aware so
> > > that after the DRC event the state can be restored
> > > correctly.
> > >
> > > Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
> > > ---
> > >
> > > v2: remove TODO
> > >
> > >  drivers/media/platform/qcom/venus/core.h |  1 +
> > >  drivers/media/platform/qcom/venus/vdec.c | 17 +++++++++++++++--
> > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> > > index 2b0899bf5b05f..1680c936c06fb 100644
> > > --- a/drivers/media/platform/qcom/venus/core.h
> > > +++ b/drivers/media/platform/qcom/venus/core.h
> > > @@ -406,6 +406,7 @@ struct venus_inst {
> > >       unsigned int core_acquired: 1;
> > >       unsigned int bit_depth;
> > >       bool next_buf_last;
> > > +     bool drain_active;
> >
> > Could you introduce a new codec state instead of adding a flag for such
> > corner case.
> >
> > I think that we will need to handle at least one more corner case (DRC
> > during seek operation),
>
> Just happen to have posted a patch for that. :)
>
> https://lkml.org/lkml/2020/12/2/24
>
> > so then we have to introduce another flag, and
> > this is not a good solution to me. These additional flags will
> > complicate the state handling and will make the code readability worst
> >
> > I'd introduce: VENUS_DEC_STATE_DRC_DURING_DRAIN or something similar.
>
> I'm wondering what is the best approach here. As you see in my patch,
> I did not have to introduce a new state but relied instead on the
> state of next_buf_last (which may or may not be correct - maybe we can
> think of a way to merge both patches into one?). Flushes, either
> explicit or implicitly triggered by a DRC, are more than a state by
> themselves but rather an extra dimension from which other states can
> still apply. I'm afraid we already have many states as it is and
> adding more might add complexity.
>
> A lot of the recent issues we had came from that number of states,
> notably from the fact that not all states are always tested when they
> should (and fall back to the default: branch of a switch case that
> does nothing). I think we could improve the robustness of this driver
> if we mandate that each state check must be done using a switch
> statement without a default: branch. That would force us to ensure
> that each newly introduced state is considered in every situation
> where it might be relevant.
>

I'm finding it hard to just add an extra state.
The DRC nominally goes something like this:
VENUS_DEC_STATE_DECODING
received HFI_EVENT_DATA_SEQUENCE_CHANGED : transition to VENUS_DEC_STATE_DRAIN
received stop_capture: transition to VENUS_DEC_STATE_STOPPED
received start_capture: transition to VENUS_DEC_STATE_DECODING


The problematic one:
VENUS_DEC_STATE_DECODING
received V4L2_DEC_CMD_STOP : transition to VENUS_DEC_STATE_DRAIN
received HFI_EVENT_DATA_SEQUENCE_CHANGED : transition to
VENUS_DEC_STATE_DRC_DURING_DRAIN
received stop_capture: transition to VENUS_DEC_STATE_DRC_DURING_DRAIN
received start_capture: transition to VENUS_DEC_STATE_DECODING

So it looks like I would need to add another state
VENUS_DEC_STATE_STOPPED_DURING_DRC_DURING_DRAIN so that transitioning
back to VENUS_DEC_STATE_DECODING would be smooth.  Otherwise
VENUS_DEC_STATE_DRC_DURING_DRAIN and VENUS_DEC_STATE_STOPPED will mean
the same thing.

This is why I had originally added the flag instead of states.  I'm
still working on getting the states to work.  My first implementation
only added VENUS_DEC_STATE_DRC_DURING_DRAIN state and I haven't
totally gotten it working yet because of trying to work out the logic
around VENUS_DEC_STATE_STOPPED.

Please let me know if I have overlooked anything.  I'm going to try
adding two states and see if the logic is clearer.

-Fritz

> >
> > >  };
> > >
> > >  #define IS_V1(core)  ((core)->res->hfi_version == HFI_VERSION_1XX)
> > > diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> > > index 5671cf3458a68..1d551b4d651a8 100644
> > > --- a/drivers/media/platform/qcom/venus/vdec.c
> > > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > > @@ -523,8 +523,10 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
> > >
> > >               ret = hfi_session_process_buf(inst, &fdata);
> > >
> > > -             if (!ret && inst->codec_state == VENUS_DEC_STATE_DECODING)
> > > +             if (!ret && inst->codec_state == VENUS_DEC_STATE_DECODING) {
> > >                       inst->codec_state = VENUS_DEC_STATE_DRAIN;
> > > +                     inst->drain_active = true;
> > > +             }
> > >       }
> > >
> > >  unlock:
> > > @@ -976,10 +978,14 @@ static int vdec_start_capture(struct venus_inst *inst)
> > >
> > >       inst->codec_state = VENUS_DEC_STATE_DECODING;
> > >
> > > +     if (inst->drain_active)
> > > +             inst->codec_state = VENUS_DEC_STATE_DRAIN;
> > > +
> > >       inst->streamon_cap = 1;
> > >       inst->sequence_cap = 0;
> > >       inst->reconfig = false;
> > >       inst->next_buf_last = false;
> > > +     inst->drain_active = false;
> > >
> > >       return 0;
> > >
> > > @@ -1105,6 +1111,7 @@ static int vdec_stop_capture(struct venus_inst *inst)
> > >               /* fallthrough */
> > >       case VENUS_DEC_STATE_DRAIN:
> > >               inst->codec_state = VENUS_DEC_STATE_STOPPED;
> > > +             inst->drain_active = false;
> > >               /* fallthrough */
> > >       case VENUS_DEC_STATE_SEEK:
> > >               vdec_cancel_dst_buffers(inst);
> > > @@ -1304,8 +1311,10 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
> > >
> > >                       v4l2_event_queue_fh(&inst->fh, &ev);
> > >
> > > -                     if (inst->codec_state == VENUS_DEC_STATE_DRAIN)
> > > +                     if (inst->codec_state == VENUS_DEC_STATE_DRAIN) {
> > > +                             inst->drain_active = false;
> > >                               inst->codec_state = VENUS_DEC_STATE_STOPPED;
> > > +                     }
> > >               }
> > >
> > >               if (!bytesused)
> > > @@ -1429,9 +1438,13 @@ static void vdec_event_notify(struct venus_inst *inst, u32 event,
> > >       case EVT_SYS_EVENT_CHANGE:
> > >               switch (data->event_type) {
> > >               case HFI_EVENT_DATA_SEQUENCE_CHANGED_SUFFICIENT_BUF_RESOURCES:
> > > +                     if (inst->codec_state == VENUS_DEC_STATE_DRAIN)
> > > +                             inst->codec_state = VENUS_DEC_STATE_DECODING;
> >
> > Could you move this state transition into vdec_event_change(). That way
> > we will do it only once.
> >
> > >                       vdec_event_change(inst, data, true);
> > >                       break;
> > >               case HFI_EVENT_DATA_SEQUENCE_CHANGED_INSUFFICIENT_BUF_RESOURCES:
> > > +                     if (inst->codec_state == VENUS_DEC_STATE_DRAIN)
> > > +                             inst->codec_state = VENUS_DEC_STATE_DECODING;
> >
> > ditto
> >
> > >                       vdec_event_change(inst, data, false);
> > >                       break;
> > >               case HFI_EVENT_RELEASE_BUFFER_REFERENCE:
> > >
> >
> > --
> > regards,
> > Stan
