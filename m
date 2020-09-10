Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966B5263FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgIJI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 04:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgIJI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:27:35 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6567C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:19:15 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id b4so1355369vkh.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uk61sTaccx0/hQSlwACkFUhiMOK87nMWadgiJgRmzUw=;
        b=Yq+j8D+Zda0smKuiw3v7rNXhIDyeTuPUck5pyNh+qPN84bKkTZfDzP+H/gRRv2m4HS
         6MWItL/yY2SrGp6RbOYgC9y93bfZqjXynvVA0V379DvvQR6SrL/WIt+PRnWlEBx0sV4/
         Go6Ly6CmM4x2XRnO5jPB8hlnWJyK2HnLylRmr4prouwyrAn17s+fVchnH3il+Mgl223a
         HovqDK05j7yg/prJUSWxLkZM74MXg+ylGZiLaZYLLDN99vLE0GPpPdYEHbho/R84JjVf
         GG7pGEyGrh4X/dg7sinQqugc9FzN25uG01lOmxt7jWSH6XLfhYoirBLTpZpHlyldpsyA
         +EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uk61sTaccx0/hQSlwACkFUhiMOK87nMWadgiJgRmzUw=;
        b=jPLC8wHHwE2vg1gnfEgxoaKErI2Xhw12AyblwmKI+nTf6ftmVFNKNqwdyphWACMkJM
         WG15mfZNtBkoOk/eASuZwnA0K2VauWq3tVW+ie6NiZc6Mj+MzKti7Qj1i+xV2FqkPmrw
         6+OAeW3vRam9pEtxXGiQbijwPKzhlAm5AGQ9dv0D/2wvk/5DB9sr7myuN3STDuXSju86
         SspcGvBEzJV0nHBrCQGUDJ2o6JiIdZmXt6PUkSzNahcTPxmAsVyKw8I/+817N1cNkCEI
         RAqp6HWY/pExn58M8sYLwEjOwSz4F5I3BpmnGjxUjNnCCShvhxjjHiCE0+dpRrT/1l3G
         3ZYA==
X-Gm-Message-State: AOAM531DA0YnmA/xccrlrpSlZOXXskq3x6tYInti7O37bz92GhTjaqXG
        1JsgUkCsHoPf2qyf7kse60eggUozaXVPubaIl8zqvQ==
X-Google-Smtp-Source: ABdhPJw3pZq9C5u57EnFxdNKPbvGPfqyEXBvz2ddeMDd27lufyfFe3J53FBP0DF2Cnb7F2JBXZFxeAbzyA1ZbcAMB6Q=
X-Received: by 2002:a1f:141:: with SMTP id 62mr3232992vkb.2.1599725954938;
 Thu, 10 Sep 2020 01:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200821204921.32536-1-sibis@codeaurora.org> <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
 <20200824164212.GA3715@yoga> <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
 <20200825175345.GC3715@yoga> <0101017476da3906-412a2e35-dc56-43ee-8644-83a998279c2d-000000@us-west-2.amazonses.com>
In-Reply-To: <0101017476da3906-412a2e35-dc56-43ee-8644-83a998279c2d-000000@us-west-2.amazonses.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Sep 2020 10:18:38 +0200
Message-ID: <CAPDyKFq=R9_4r+T8V7Fn2PvLr5HicKOTQMAGh4Lg3-Q=KaOiDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel-owner@vger.kernel.org, clew@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 at 09:23, Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2020-08-25 23:23, Bjorn Andersson wrote:
> > On Tue 25 Aug 02:20 CDT 2020, Stephen Boyd wrote:
> >> Quoting Bjorn Andersson (2020-08-24 09:42:12)
> >> > On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:
> > [..]
> >> > > I find it odd that this is modeled as a power domain instead of some
> >> > > Qualcomm specific message that the remoteproc driver sends to AOSS. Is
> >> > > there some sort of benefit the driver gets from using the power domain
> >> > > APIs for this vs. using a custom API?
> >> >
> >> > We need to send "up" and "down" notifications and this needs to happen
> >> > at the same time as other standard resources are enabled/disabled.
> >> >
> >> > Further more, at the time the all resources handled by the downstream
> >> > driver was either power-domains (per above understanding) or clocks, so
> >> > it made sense to me not to spin up a custom API.
> >> >
> >>
> >> So the benefit is not spinning up a custom API? I'm not Ulf, but it
> >> looks like this is hard to rationalize about as a power domain. It
> >> doesn't have any benefit to model it this way besides to make it
> >> possible to turn on with other power domains.
> >>
> >> This modem remoteproc drivers isn't SoC agnostic anyway, it relies on
> >> SMEM APIs, so standing up another small qmp_remoteproc_booted() and
> >> qmp_remoteproc_shutdown() API would avoid adding a genpd flag here
> >> that
> >> probably will never be used outside of this corner-case. There is also
> >> some get/put EPROBE_DEFER sort of logic to implement, but otherwise it
> >> would be possible to do this outside of power domains, and that seems
> >> better given that this isn't really a power domain to start with.
> >
> > In later platforms a few new users of the AOSS communication interface
> > is introduced that certainly doesn't fit any existing API/framework in
> > the kernel. So the plan was to pretty much expose qmp_send() to these
> > drivers.
> >
> > My worry with using this interface is that we'll probably have to come
> > up with some DT binding pieces and probably we'll end up adding yet
> > another piece of hard coded information in the remoteproc drivers.
> >
> > But I'm not against us doing this work in favor of not having to
> > introduce a one-off for this corner case.
>
> Bjorn/Stephen,
>
> So the consensus is to stop modelling
> aoss load_state as pds and expose qmp_send
> to drivers?

Would that mean qmp_send would have to be called from generic drivers?
Then, please no. We want to keep drivers portable.

Kind regards
Uffe
