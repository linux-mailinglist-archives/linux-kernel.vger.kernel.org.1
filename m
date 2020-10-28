Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FAC29DB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgJ1Xmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390516AbgJ1XeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:34:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D64C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:34:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x23so405845plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lutL77mM1puGVoqt7Nw9AlgWOlFK54HVQ3QwD1U+gIM=;
        b=O/Ivy3Ru9S8NFuMxeUTduXhnV/j5fokiemcD7qvMICg4A0mITpt7rJmU1k54rj5Enz
         S4KqZc1VRb3Tta1I6shweaTe605FT0mqwJ2X0W0GLhoUNQeQQ22EMr1YDqpuuyTQzqaz
         HDQkYqtRiXpKAULNF1TMAUuS3O19+WzB2DBZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lutL77mM1puGVoqt7Nw9AlgWOlFK54HVQ3QwD1U+gIM=;
        b=r2MYMRMhDOakDFQTL2SjPJ9zLPuerLzO1buTLf/3dq72guysSFKyJpqRu0vDFFs50d
         o5BVoMA/ZGTW5vLejhQ67iE1qcpplL4+wuhPo43A4QP9v3A87hmHjrSeIvACq5L9sSm/
         jazrZk1Z32mFaMZJfBqmpp2INw1cSNxIXjI+PZSpu3ZyiW7MerSXxeasJhEXLr9RHrOP
         Rh7OiD519v/Dv47MCMbrfdS1fyTZx6qoR9HSf1GjDYZCZpeHBUFUvOSccBgzdHyxdCg2
         zlmPktR4uHVuISIcNm9wnPXpIFBT7ZYBhjKwIxgcEG0wfH03/tyvj1YPhqXM1VEzR96H
         aIFA==
X-Gm-Message-State: AOAM532D17dTHlYCQro+Q1ZgFLfoIYvlxeQtIdU/5/JMuJKRDBmNbH9f
        /rgV71jyHXbYTqaZ1rAEaLkRM9vVurXJbg==
X-Google-Smtp-Source: ABdhPJwFnWal4xvuigM9HzPJaGw+AlMfxvzHNaNiNLLZ4jpIHilVZCVNHJwbCfwH+dT5t3kakQxBvQ==
X-Received: by 2002:a1f:a94c:: with SMTP id s73mr52459vke.19.1603900972298;
        Wed, 28 Oct 2020 09:02:52 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id x81sm574000vsx.19.2020.10.28.09.02.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 09:02:51 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id d19so3129126vso.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 09:02:51 -0700 (PDT)
X-Received: by 2002:a67:b405:: with SMTP id x5mr5981883vsl.4.1603900970936;
 Wed, 28 Oct 2020 09:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <1603811067-23058-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com> <003801d6ad41$a1bb8970$e5329c50$@codeaurora.org>
In-Reply-To: <003801d6ad41$a1bb8970$e5329c50$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Oct 2020 09:02:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_Dwb=YRMKcKME9vdxbSgSn-08dznoVXY6VzCaHL8OnQ@mail.gmail.com>
Message-ID: <CAD=FV=U_Dwb=YRMKcKME9vdxbSgSn-08dznoVXY6VzCaHL8OnQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Fix the parsing error in service available event
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 8:47 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: Doug Anderson <dianders@chromium.org>
> > Sent: Wednesday, October 28, 2020 8:07 PM
> > To: Rakesh Pillai <pillair@codeaurora.org>
> > Cc: ath10k <ath10k@lists.infradead.org>; linux-wireless <linux-
> > wireless@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Abhishek
> > Kumar <kuabhs@chromium.org>; Brian Norris <briannorris@chromium.org>
> > Subject: Re: [PATCH] ath10k: Fix the parsing error in service available event
> >
> > Hi,
> >
> > On Tue, Oct 27, 2020 at 8:20 AM Rakesh Pillai <pillair@codeaurora.org>
> > wrote:
> > >
> > > The wmi service available event has been
> > > extended to contain extra 128 bit for new services
> > > to be indicated by firmware.
> > >
> > > Currently the presence of any optional TLVs in
> > > the wmi service available event leads to a parsing
> > > error with the below error message:
> > > ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71
> > >
> > > The wmi service available event parsing should
> > > not return error for the newly added optional TLV.
> > > Fix this parsing for service available event message.
> > >
> > > Tested-on: WCN3990 hw1.0 SNOC
> > >
> > > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > > ---
> > >  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > > index 932266d..3b49e29 100644
> > > --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > > +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > > @@ -1404,9 +1404,12 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct
> > ath10k *ar, u16 tag, u16 len,
> > >                 arg->service_map_ext_len = *(__le32 *)ptr;
> > >                 arg->service_map_ext = ptr + sizeof(__le32);
> > >                 return 0;
> > > +       case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
> > > +               return 0;
> >
> > This is at least slightly worrying to me.  If I were calling this
> > function, I'd expect that if I didn't get back an error that at least
> > "arg->service_map_ext_len" was filled in.  Seems like you should do:
> >
> > case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
> >   arg->service_map_ext_len = 0;
> >   arg->service_map_ext = NULL;
> >   return 0;
> >
> > ...and maybe add a comment about why you're doing that?
> >
> > At the moment things are working OK because
> > ath10k_wmi_event_service_available() happens to init the structure to
> > 0 before calling with:
> >
> >   struct wmi_svc_avail_ev_arg arg = {};
> >
> > ....but it doesn't seem like a great idea to rely on that.
> >
> > That all being said, I'm just a drive-by reviewer and if everyone else
> > likes it the way it is, feel free to ignore my comments.
>
>
> Hi Doug,
>
> The TLV TAG " WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT" is the first and a mandatory TLV in the service available event.
> The subsequent TLVs are optional ones and may or may not be present (based on FW versions).
> This patch just fixes the bug, where the presence of any other TLVs are leading to a failure in parsing the service available msg.
> If, in future, we plan to use any other services from firmware, which is exposed in the extended TLVs, we will need to add a new variable (and not service_map_ext) to set the service.

I'm not sure I totally understood your response, but look at it from
the perspective of the function ath10k_wmi_event_service_available().

That function calls:

  ret = ath10k_wmi_pull_svc_avail(ar, skb, &arg);

...if it gets back a non-zero error code, it assumes that the
"arg.service_map_ext" and "arg.service_map_ext_len" values are now
valid and it can use them.

Before your patch, ath10k_wmi_pull_svc_avail() was returning an error
code.  That let ath10k_wmi_event_service_available() know that it
shouldn't look at "arg.service_map_ext" and "arg.service_map_ext_len".
After your patch, you're not returning an error code but those fields
aren't being filled in.

Said another way, if you remove the initialization of "arg" in
ath10k_wmi_event_service_available() then everything is broken.  While
things work because you _do_ have an initialization of "arg" in
ath10k_wmi_event_service_available(), it feels fragile to me to rely
on that.


-Doug
