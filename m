Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C42B8544
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKRUEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:04:01 -0500
Received: from z5.mailgun.us ([104.130.96.5]:57376 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKRUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:04:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605729839; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NPmVss055K8CbLWs/1vukepUTozf+/2SWf1JuTKgk6s=;
 b=haENsjKvQQgWR7EHNMeNxHQy4r9QnptnN6AZ58RzSDYiBPRJCLZeyJROyLc1g9dnUhBrSl6S
 1wfiOMCQ5FbOwRUgmx03eXwM4ABxCMliYJQpkduCutGIvMFggoTQiBzA9NBQtoMOSLCd8y9q
 kHcsKEWJjPaL6nzdtfR0TF6b47c=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fb57e294146c5eefde3d6c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Nov 2020 20:03:53
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA01DC433C6; Wed, 18 Nov 2020 20:03:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECEB4C433ED;
        Wed, 18 Nov 2020 20:03:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Nov 2020 12:03:51 -0800
From:   abhinavk@codeaurora.org
To:     Rob Clark <robdclark@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Kalyan Thota <kalyan_t@codeaurora.org>
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: Remove chatty vbif debug print
In-Reply-To: <CAF6AEGsDyvFVxAME1_VUprPKdrpEGdvP9XrQEG_-=1mRRcRBow@mail.gmail.com>
References: <20201117172608.2091648-1-swboyd@chromium.org>
 <71aebca216babf4010c92d4d1ce9a9b4@codeaurora.org>
 <160565358127.60232.4382778730228368993@swboyd.mtv.corp.google.com>
 <CAF6AEGsDyvFVxAME1_VUprPKdrpEGdvP9XrQEG_-=1mRRcRBow@mail.gmail.com>
Message-ID: <4c955afcc2eb28794a5bbcc0e1642592@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

On 2020-11-18 07:49, Rob Clark wrote:
> On Tue, Nov 17, 2020 at 2:53 PM Stephen Boyd <swboyd@chromium.org> 
> wrote:
>> 
>> Quoting abhinavk@codeaurora.org (2020-11-17 12:34:56)
>> > On 2020-11-17 09:26, Stephen Boyd wrote:
>> > > I don't know what this debug print is for but it is super chatty,
>> > > throwing 8 lines of debug prints in the logs every time we update a
>> > > plane. It looks like it has no value. Let's nuke it so we can get
>> > > better logs.
>> > >
>> > > Cc: Sean Paul <sean@poorly.run>
>> > > Cc: Abhinav Kumar <abhinavk@codeaurora.org>
>> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> >
>> > > ---
>> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c | 3 ---
>> > >  1 file changed, 3 deletions(-)
>> > >
>> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
>> > > b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
>> > > index 5e8c3f3e6625..5eb2b2ee09f5 100644
>> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
>> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
>> > > @@ -245,9 +245,6 @@ void dpu_vbif_set_qos_remap(struct dpu_kms
>> > > *dpu_kms,
>> > >       forced_on = mdp->ops.setup_clk_force_ctrl(mdp, params->clk_ctrl,
>> > > true);
>> > >
>> > >       for (i = 0; i < qos_tbl->npriority_lvl; i++) {
>> > > -             DPU_DEBUG("vbif:%d xin:%d lvl:%d/%d\n",
>> > > -                             params->vbif_idx, params->xin_id, i,
>> > > -                             qos_tbl->priority_lvl[i]);
>> >
>> > Instead of getting rid of this print, we should optimize the caller of
>> > this.
>> 
>> Does the print tell us anything? Right now it prints 8 lines where it
>> feels like it could be trimmed down:
>> 
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:0/3
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:1/3
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:2/4
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:3/4
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:4/5
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:5/5
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:6/6
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 lvl:7/6
>> 
>> maybe one line that combines the index into values?
>> 
>>            [drm:dpu_vbif_set_qos_remap] vbif:0 xin:0 [3 3 4 4 5 5 6 6]
>> 
> 
> or possibly convert to a tracepoint (so it doesn't spam the drm_trace 
> buffer)
> 
> BR,
> -R
> 
>> But again I have no idea if this print is really useful. Maybe we can
>> print it only if the value changes from what was already there?
>> Basically move the print into dpu_hw_set_qos_remap() and then skip out
>> early if nothing changed or print and modify the register.
>> 
>> > This is what
>> > we are doing in downstream. So we need to update the property only if we
>> > are switching from a RT client
>> > to non-RT client for the plane and vice-versa. So we should try to do
>> > the same thing here.
>> >
>> >         is_rt = sde_crtc_is_rt_client(crtc, crtc->state);
>> >         if (is_rt != psde->is_rt_pipe) {
>> >                 psde->is_rt_pipe = is_rt;
>> >                 pstate->dirty |= SDE_PLANE_DIRTY_QOS;
>> >         }
>> >
>> >
>> >         if (pstate->dirty & DPU_PLANE_DIRTY_QOS)
>> >                 _dpu_plane_set_qos_remap(plane);
>> >
>> 
>> Sounds great! Can you send the patch?

Will finalize approach and send the patch in a day or two.

Thanks

Abhinav
