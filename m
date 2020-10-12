Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7B28B206
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgJLKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgJLKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:12:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:12:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so22392574ejg.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmVmFIUNT4Wupci76xBxABrZMx+zyajrqk5q8LZr/Os=;
        b=R0w/bK3ITaBcdVnsfq7spkvUuQ1tHsnj1UG63RulbeaLiedEJxPa3bDSrXYbbZKSf5
         xEdZ+fwxvrG4TxC8HW33Pz0jPecJ02VtgeqgMTxNaOOMfc9PLbu1hfFXSSAyLNDz/WUQ
         Sz9TGoEUjcvsU5Q5pa++/P0+VCIJnuBkumoAP20UsYhZnogG0rTfz+e77cc4ZmQAcAIb
         YjjUrsOf4w/QRzYzb8tCoORDzqwsaQZv6fJBrtkKMVUPD6lFzj4eSOGEVYz/kRF3HuIC
         x0zRE2dhsTdJhNJMP2b/82L+fTRiAQa0/QdIxMmGCOTmRLLwmaaYgMBIzChzRl+U4yGS
         qarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmVmFIUNT4Wupci76xBxABrZMx+zyajrqk5q8LZr/Os=;
        b=mTUup0urqg3eyEE4FocfoaB+SbTdnhv0A4g1Uq/oQJ0uV76aqJ78HNrrV/mXCbJSsj
         EVdwS+iyLRj2IHKi5fsoAFCyG5Iei3zi1id9iWl1ec7/Y3plrxEzPeeLEpMA90PURXJn
         xDuGsiL+w/D7iP22F63J66lYolRlWXkiZDmnpNbQC90p+1fF3VCWC4HJTmpFuTUskWZ0
         7HF44klGV8tHeXHDaE+Aw/G1HW6mqDQWtIMQPOI7WECQa7SrVGdrwnvDM8J7k8EKfit8
         gYdF4I+dINOVGXrVOLesEIFCXGQkTzssES6kjISjTV84CH1oKKXIkaf6lhv5S6uaKlWw
         PyBg==
X-Gm-Message-State: AOAM530+J/OmSHPcIOAUO3RrmSdMN6L1zcc6GSgj5xDazTjYGOMyS3yo
        ZencKOuPjXlxFkX9K2tlQdPlb2VeFGQJu9GKgxV+aQ==
X-Google-Smtp-Source: ABdhPJwQWGNBKj1XAqiwPto53ra1G7ksfQJUPPrZIPr4BTHa6hZcTDvS2eqBYi+DJrnwXDQWoPrGBgEm1P1U2Nzl+q0=
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr28265243eju.44.1602497530533;
 Mon, 12 Oct 2020 03:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-3-etienne.carriere@linaro.org> <20201008210839.6nnl2tvm2re2ckvu@bogus>
 <CAN5uoS-t2De5OvawUSeK1NuskqpBEt-rWGVtJky-E=+RRpe+_Q@mail.gmail.com> <20201009155816.il56rbatvcagyosz@bogus>
In-Reply-To: <20201009155816.il56rbatvcagyosz@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Mon, 12 Oct 2020 12:11:59 +0200
Message-ID: <CAN5uoS9QtSrkgqePYugYys6Kgx2my+o=tmJRjQK2EVA_W1jZKw@mail.gmail.com>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: add config dependency for smc transport
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

On Fri, 9 Oct 2020 at 17:58, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 09, 2020 at 02:33:41PM +0200, Etienne Carriere wrote:
> > On Thu, 8 Oct 2020 at 23:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Oct 08, 2020 at 04:37:20PM +0200, Etienne Carriere wrote:
> > > > Fix dependencies for configuration switch ARM_SCMI_PROTOCOL that
> > > > is not exclusively dependent on MAILBOX since the alternate
> > > > smc transport that is depends on HAVE_ARM_SMCCC_DISCOVERY since [1].
> > > >
> > >
> > > Do you need any build issues ? I don't see why this is needed.
> > >
> >
> > This change is for consistency of the kernel configuration.
> > Without this change, a kernel configured without CONFIG_MAILBOX
> > cannot embed SCMI support even is using only the SMC transport
> > enabled thanks to HAVE_ARM_SMCCC_DISCOVERY.
> >
>
> Fair enough, however instead of adding to the list for each added transport
> we need to do better transport abstraction now that we have multiple.
> I don't see this as critical, let me know if you disagree.

Not critical, I agree :)

etienne

>
> --
> Regards,
> Sudeep
