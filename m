Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B312615ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbgIHQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 12:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731849AbgIHQUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:07 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28C1221E3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599566928;
        bh=ltST+N2nkPHvcvm7JM5iKGeE+dIaJdibruzqpP8T40g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lvMYbcf2Ibl+iac3x1pKdiMwh0OR3WjP+192kCA8xya69fNPOeYR1yJxOTXQ+J+yc
         ZxrTgF6czpTYAvCpXMIK7Lhl5AUBjmQvtpIQybs1OJUTe6q6j+e7omdFgoLTJi55jY
         OuPkkXlHjmePtJck1Z9u25ED4sQIPfZQn/Xt3mH0=
Received: by mail-ua1-f42.google.com with SMTP id e41so4959387uad.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:08:47 -0700 (PDT)
X-Gm-Message-State: AOAM533jzKYqGRL0FlFILyg8y0KEgdTHHO+ncE4xfrji7FT8b03bgpvg
        INjn+rZHcIs8gP+cS+YwMvHO1hL0H4QTWPYYkXNumg==
X-Google-Smtp-Source: ABdhPJzn5o5SdhSG4SNzohoTwQqYAZp7JwVtypVBguxbjsJFGyTmhXrdBWjuiaFKPmjaiikdExbd/KIqXlbl31C3Bcg=
X-Received: by 2002:ab0:136f:: with SMTP id h44mr12688533uae.60.1599566926910;
 Tue, 08 Sep 2020 05:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org> <20200908103444.5e526uawa45om6lt@vireshk-i7>
 <20200908111141.GB23095@mani> <20200908111813.bbgfxo5v7qt6ujpc@vireshk-i7> <CAHLCerMndYeEBOxtj8mV7OdOP9pufx+C7n1F9m+CFAneuh8DnA@mail.gmail.com>
In-Reply-To: <CAHLCerMndYeEBOxtj8mV7OdOP9pufx+C7n1F9m+CFAneuh8DnA@mail.gmail.com>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Tue, 8 Sep 2020 17:38:36 +0530
X-Gmail-Original-Message-ID: <CAHLCerPm6MXr662CaA3zZm4fQ3dJ_StJt3Ehutc3xnc0L9wj3Q@mail.gmail.com>
Message-ID: <CAHLCerPm6MXr662CaA3zZm4fQ3dJ_StJt3Ehutc3xnc0L9wj3Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware registers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 5:18 PM Amit Kucheria <amitk@kernel.org> wrote:
>
> On Tue, Sep 8, 2020 at 4:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 08-09-20, 16:41, Manivannan Sadhasivam wrote:
> > > On 0908, Viresh Kumar wrote:
> > > > On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> > > > > Use regmap for accessing cpufreq registers in hardware.
> > > >
> > > > Why ? Please mention why a change is required in the log.
> > > >
> > >
> > > Only because it is recommended to use regmap for abstracting the hw access.
> >
> > Yes it can be very useful in abstracting the hw access in case of
> > busses like SPI/I2C, others, but in this case there is only one way of
> > doing it with the exact same registers. I am not sure it is worth it
> > here. FWIW, I have never played with regmaps personally, and so every
> > chance I can be wrong here.
>
> One could handle the reg offsets through a struct initialisation, but
> then you end up with lots of #defines for bitmasks and bits for each
> version of the IP. And the core code becomes a bit convoluted IMO,
> trying to handle the differences.
>
> regmap hides the differences of the bit positions and register offsets
> between several IP versions.
>
> > > Moreover it handles the proper locking for us in the core (spinlock vs mutex).
> >
> > What locking do you need here ?
>
> Right, locking isn't the main reason here.

Having said this, perhaps this patch can be held back for now, since
we're not yet using some of the features of regmap to abstract away
bit fields and such.

We don't strictly need it for just different register offsets.

Regards,
Amit
