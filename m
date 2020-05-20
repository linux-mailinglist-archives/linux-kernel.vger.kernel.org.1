Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9321DA9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 07:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgETFLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 01:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETFLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:11:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6105C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:11:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so699122pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/m6niOd1NL5NVGvyIcf8eZtiO7xInyuSa2CKuSwQQVE=;
        b=rIL2Lv/gm1aCjMYo+nB9G6CfhwFNR1U0F9OWcdjoQyTACOP0cRfWiEDLIB/9cT+Qf1
         RTJcfULUTufKreOyLZC58J7W9ze0mUIkJWeR/qle61XTP8ryw8uAiFmQV4QRgbtYSEBZ
         sCYpbT1gb5pHIUSLdbWKD2KT6t6ugXMjfASiGDzzlmKudPekPRTkt/D0kcpcO59zc2LH
         t4pX1x7GByUbosJWsQiEdUmKvFpsvedHoKC1Ym98Zu0MzlbQkH62pGcNqKA9N90lNB8G
         cB96zR9Bvg/gLL8ntuCXNhgx5U1gViyyuJGOMDAmu1qFWAf6GZoSPh/SH5+wBpNE85pw
         XMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/m6niOd1NL5NVGvyIcf8eZtiO7xInyuSa2CKuSwQQVE=;
        b=N7oVxDIOeuT6JuAfewSY1nbcDWMvl9Q3TEvf+qLSvp9MWa1mY15luw9qGA75RxGSLi
         Ts17CkJNacJCt73t67Az8MBzP3fhLOnSzxcaC7lfLB9ISCSwIyeuR7YeySVJ6V7A7nbn
         970XGqtR2mAE9WH5XhH+JZCjc9WvLpk793W+nTHLOtS61rqwxwSfCRMAVHXFOJCOZ7ka
         2XbLQ9HS2zMU8ZFvHmOzFoQbqlYVvEK8W49bCSZGrJeMrajtxk5iEMTQro6XsEYaq2PI
         bT4Op6egl4cXuDazONRK148Oh7JPBol/HyfdCVLH7iBS2fAHBNsQdSGDWVICfWIVSWux
         nLug==
X-Gm-Message-State: AOAM532WuCGvPkaHoZM3z+vKW5uxONn53WUHHFGEybJ6+sBe92zcNOTe
        /VAibXdFe5o0KJVIlNCJivWRUg==
X-Google-Smtp-Source: ABdhPJxRIht5NenwbR7QLDBX/oTQxZ44KG81mQ0A140ugddejatOzrcwLqInWuhbQgy11IV/YtgYtg==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr2858616plr.89.1589951499124;
        Tue, 19 May 2020 22:11:39 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k65sm966516pfd.156.2020.05.19.22.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 22:11:38 -0700 (PDT)
Date:   Tue, 19 May 2020 22:11:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Olof Johansson <olof.johansson@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        wufan@codeaurora.org, pratanan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/8] Qualcomm Cloud AI 100 driver
Message-ID: <20200520051135.GA11847@yoga>
References: <CAKMK7uG-oP-tcOcNz-ZzTmGondEo-17BCN1kpFBPwb7F8QcM5w@mail.gmail.com>
 <20200520045900.GA2105777@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520045900.GA2105777@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 May 21:59 PDT 2020, Greg Kroah-Hartman wrote:

> On Tue, May 19, 2020 at 10:41:15PM +0200, Daniel Vetter wrote:
> > > Ok, that's a decision you are going to have to push upward on, as we
> > > really can't take this without a working, open, userspace.
> > 
> > Uh wut.
> > 
> > So the merge criteria for drivers/accel (atm still drivers/misc but I
> > thought that was interim until more drivers showed up) isn't actually
> > "totally-not-a-gpu accel driver without open source userspace".
> > 
> > Instead it's "totally-not-a-gpu accel driver without open source
> > userspace" _and_ you have to be best buddies with Greg. Or at least
> > not be on the naughty company list. Since for habanalabs all you
> > wanted is a few test cases to exercise the ioctls. Not the entire
> > userspace.
> 
> Habanalabs now has their full library opensourced that their tools use
> directly, so that's not an argument anymore.
> 
> My primary point here is the copyright owner of this code, because of
> that, I'm not going to objet to allowing this to be merged without open
> userspace code.
> 

So because it's copyright Linux Foundation you are going to accept it
without user space, after all?

Regards,
Bjorn
