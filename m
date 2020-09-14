Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45255268994
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgINKre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgINKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:47:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD0C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:47:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so16359300qka.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZH/jMrnhxDGa2Hx9c9vkwQ/mFENngwhEAvrQNpRWk8=;
        b=X/Y6K+/Px0NX64zhrgpov07rhAb/tILbtnASBoeej1aI5ScBxpo/mnlgjj7vuYarQ4
         y6Qkv0cYAUFZ9xB2u37kJqwQXa5NywisM6th3uUySuMR8Nw34d2/DVrq7eF+V01xN1vW
         3jPnRsqB3QIieaSp2g/iC1jpElLi8cWI6e5G13o0gLY5NVoTHt3Jqj/u3YEPH+c70t7N
         55mdYrppINs2ssqSaGPTwIVE/SHkI3atkB0Pl9ThjOf4FTg5K+WQlb58tPb+OMomCfPF
         Tl0jNND0MoBQAwWdUr2JRQXj55oxaFg3B99WKXRFDxpW8kxuo3qcgmI+tCe7KvfeZU15
         lxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZH/jMrnhxDGa2Hx9c9vkwQ/mFENngwhEAvrQNpRWk8=;
        b=ahaacnsKVbFPS/Bs5KfvsMzzvoiijqBuqvVMNCM2gpoACiukGrnzMnl3skfJqMMm9J
         7Y2/9JTcR9O0YJYr6igoJtVmct316JALkmuZ5jF4jZcW8V4LrZAjC/xBTB8Q2DBQY0Lr
         Yf28BxL+10v0vpg1p1nrzsVAQBajYAI5ot7pFuW5o8gC6LNC1FpDAG+zSQLjgl5uegHE
         qaAA7LGCvsW/n4B2DKKIKEDUxbQIs5kYnl2nvT70e/wlWKR9hoFOogKTRV+OugRsAFyq
         VDowNLe4t7onEdUjVBQCr7tvVTNVoYLJYVarSmEJec06HGzpj3D5AKJBWrCp61NBbRqB
         5YxA==
X-Gm-Message-State: AOAM533CbH5LeTHzEPpUfXt2nbmPTrL4K/cos0OVp4lLWl/OpR9qjue4
        5E2WCPFHGfo+XLN5EPAd4SCfnkhvAL4iKcoSXEM=
X-Google-Smtp-Source: ABdhPJzpfag3UOMHPurYcykEgT1/WEh/BxCPmhjQDi42pmbr6hedv9Uzlg/KKTAbj2ctZhjEMjMmU0kre6J17dYlBlI=
X-Received: by 2002:ae9:eb57:: with SMTP id b84mr12199593qkg.450.1600080440994;
 Mon, 14 Sep 2020 03:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200911083048.29055-1-shengjiu.wang@nxp.com> <20200911104042.GC4895@sirena.org.uk>
In-Reply-To: <20200911104042.GC4895@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 14 Sep 2020 18:47:10 +0800
Message-ID: <CAA+D8APvRMXkrYPdGd7H1+hj8AFP7=nvZ0QbpnH8o52-sh50GQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: ak4458: Add DSD support for ak4458 and ak4497
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Fri, Sep 11, 2020 at 6:43 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Sep 11, 2020 at 04:30:48PM +0800, Shengjiu Wang wrote:
>
> > Add a new kcontrol for ak4497 codec for ak4497 has a specific
> > pin selection.
>
> What exactly is this pin selection about - is it something that will
> change at runtime or should it be configured by the board in the DT?

It is to select which pin group is used for DSD. it won't be changed
at runtime.  So do you think it is better configured by DT?

best regards
wang shengjiu
