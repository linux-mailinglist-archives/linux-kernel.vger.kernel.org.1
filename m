Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68FA2B8190
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKRQQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:16:28 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE97C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:16:27 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id y9so2501116ilb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6r7TUcFKHzpP6/Vq07kiuTKHa5WLL8VvWtDcmajR8g=;
        b=TYXxpYOZkvZXHUz+FHr13epLRA8eTYHEPLQl9PS4wDZTnWizPUAMyuknStt5LjMqyG
         NMBnqOPRTdaaCvePhAiUrwLSl3siNOVzF3YYrOzlMJD/O6M78cwxsMHvzymNOqASKxOV
         FFRpuJyco3cOWn9m6pbWIhdzNhQAWJw9BDvDkQXx0upo3N9OOf0XKf26duheog80jO3L
         F7dtHLbJbYDScUEXALebiigLI4pHfBJ27dnhNnsIXSivJlT1bbp336PY9B3zrkuysLkX
         jKm7xmcrh69BtHHTT6jQQvrBqKl1mYB27fVmOIY+veCdx0Hmn/ovXa1kmycM/DXge/GA
         kbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6r7TUcFKHzpP6/Vq07kiuTKHa5WLL8VvWtDcmajR8g=;
        b=CN/iPk6WOWSAzsvz4eXxF5QmU2nPyGeP/zM/WbP6EOIk3oiqe+smT/68rDbfh7oIR6
         ihwhNc4ss+DxYwLEPGG0WkI2j+WJeo7iyj4puXvaA2Qi4gjmyt0mqzfEOxDA9v/Utg8O
         UfYDf563jiV5HTnGBUWU6uip3+zx2K1ll5BQ5IOo57qpYxjEN4BXMJjf5PiEzcFA0p8/
         zYP0kl/hidPWTfT4QRkvAylCS6UxRv+Fe13nvXRHIIW00pwpRtOR9d7YRjmIENTFdDjD
         PGjTq/v+N7hrdiFFyGqOTsWxWhU5lXPdDlkQ06OznfQGepun3iH6ymy0Y2h/6Uos70C4
         kd8Q==
X-Gm-Message-State: AOAM5304geXQHdsCRBmoUtJk52Ch7jE5pS0eLDRXyKRLUN8jupL22FNT
        csuj1VLuyKNvOu8hqzyF1raBA8fNCebiDx1/lfOA8g==
X-Google-Smtp-Source: ABdhPJyAjgpX5wY/NtFJaXw+W8vZeafIfip+iAW8DYHfqNoE9p74VSv+qjZaJXOrdInYKGebWL5hYAgNZKvr3TfKCi0=
X-Received: by 2002:a05:6e02:47:: with SMTP id i7mr16770879ilr.57.1605716187125;
 Wed, 18 Nov 2020 08:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20201112115115.GA11069@ubuntu> <945f377d-1975-552d-25b2-1dc25d3c3a46@st.com>
 <2d25d1aa-bd8a-f0db-7888-9f72edc9f687@st.com> <20201116151028.GA1519@ubuntu>
 <e5e49e1a-dc2a-ce16-425c-d2d87f415868@st.com> <20201116224003.GC3892875@xps15>
 <50549519-d9ff-9048-a3d8-dab02bfda096@st.com> <20201117160330.GA15538@ubuntu>
 <a653c503-7fd1-7b87-88a5-88c9002ba410@st.com> <20201118000647.GA4113759@xps15>
 <20201118070836.GA19190@ubuntu>
In-Reply-To: <20201118070836.GA19190@ubuntu>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 18 Nov 2020 09:16:16 -0700
Message-ID: <CANLsYkzeEp5h_3ObJCHaa_g8snRQ17_BFNA3Am-zjM7PExgu=g@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] rpmsg: Turn name service into a stand alone driver
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 00:08, Guennadi Liakhovetski
<guennadi.liakhovetski@linux.intel.com> wrote:
>
> On Tue, Nov 17, 2020 at 05:06:47PM -0700, Mathieu Poirier wrote:
>
> [snip]
>
> > I confirm that all this is working as expected - I will send a new revision of
> > this set tomorrow afternoon.
> >
> > Guennadi, can I add a Co-developed-by and Signed-off-by with your name on the
> > patch?
>
> You can add the "Co-developed-by" tag, sure, if you like. As for the SOB: I'm
> not sure if this is a proper use of it? AFAIK SOB is used when that person
> "transmitted" the patch, e.g. if they developed and submitted it to a list,
> or if they received it from someone and forwarded it upstream (maintainer
> case). I'm not sure about this case, but well, feel free, don't think we'd
> be violating anything since I did send versions of code, similar to parts of
> that, some with my SOF, so, should be fine.
>

If a Co-developed-by is present, a SOB _has_ to be present as well.

> Thanks
> Guennadi
