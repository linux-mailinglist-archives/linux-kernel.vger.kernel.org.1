Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDB29D899
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbgJ1WfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbgJ1WfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:35:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:35:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r186so723622pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ywjXoX2kkK2KmqL6ZyGoB6Pybvnry+Rvqj9uaI5d5iE=;
        b=X5W234U1YTYXSeJeyK2Vk+eLiUVBUfulNxLgtgDTC7Y2iq0ShIDFDyJL/pdwnwYUa+
         OEYlEzLQjjCTHnrkgNNR7g00BW8ESFAEEQT1XcoJj6ZFN54o+wKgCxjD+O60PhuDQ7vD
         84AXSoKF6QrULCiwA8LXd2DmMUV2GG7NtSjIJ6BviQWr4LdyVlTkrWrzwGw1XwH04BXw
         wUann1odVUWJfSTWmw+2UN7YWM3rbwimRI5KzkuOeG5fKlaBIz9oc3Vs4E2lZJFK3gLq
         v5fMgJHzOEzcx8IjzPNRfwrnMS/3QWCVvcyZ6Acqu806VBeEArIYp+nxMc7wfmvp6hZI
         ASUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ywjXoX2kkK2KmqL6ZyGoB6Pybvnry+Rvqj9uaI5d5iE=;
        b=iRolIGekerjSD7YVGx9mnKP3j3x3+gwBJ3Ocf7hNe1qh5/7j9PMx6ex9UH3ynPSokC
         WQ5SdsItMXYEkPQG0Ep3LSM6WTeu7wsM50uoxdrZB2mfEFUNyjXn+WRe9I3DrsrqZ8Aq
         40Tc9Y0yxPK2muPD4N5dMr5WCXM2J5+S3GWefFjH6csl527kAaQsMSXsarTIkN6H9aw2
         x6oV+xfw/0JnRlnXZY5ax47gij4XjF+jmL5+F8QBOlKGa5h0unrpYIkYH7+wE/Hjr63W
         tNjjfis3gabbc1zb0Z4zm87UsT+uU3+hCZKdQsiaZj2xv916ClIYCKgtGpFD6XypFvkj
         lKBw==
X-Gm-Message-State: AOAM531AIkgCHvH5pLMkCYHXHp2GE9KH69wy1N/OP+RUBQlquJWQFhhQ
        qfLX+5yq4rHZ8IO+xCyaj4rJUNXKOwBKfQ==
X-Google-Smtp-Source: ABdhPJxGfGHUfZR5/hgoqBA9Cp4UZZF2zoq2xSX/vVSEcnm+GlrQO4gwem8tQVD3yMYhu0Zz27HGPQ==
X-Received: by 2002:a63:e444:: with SMTP id i4mr6715119pgk.304.1603896392305;
        Wed, 28 Oct 2020 07:46:32 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id y5sm3087840pfq.79.2020.10.28.07.46.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:46:31 -0700 (PDT)
Date:   Wed, 28 Oct 2020 20:16:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        airlied@linux.ie, daniel@ffwll.ch,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcrouse@codeaurora.org,
        eric@anholt.net, kholk11@gmail.com, emil.velikov@collabora.com,
        gustavoars@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/3] opp: Add devres wrapper for dev_pm_opp_set_prop_name
Message-ID: <20201028144628.qm2t2hbzmouqkciy@vireshk-i7>
References: <20201012135517.19468-1-frank@allwinnertech.com>
 <20201012135517.19468-3-frank@allwinnertech.com>
 <20201028102942.zc5hgqpo2bfrn6in@vireshk-i7>
 <CAEExFWvNgK2wbvmxZjsJR4g-VBq=ggsBLew77rzmNdkpqTRuDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEExFWvNgK2wbvmxZjsJR4g-VBq=ggsBLew77rzmNdkpqTRuDA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-20, 19:02, Frank Lee wrote:
> On Wed, Oct 28, 2020 at 6:29 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 12-10-20, 21:55, Frank Lee wrote:
> > > From: Yangtao Li <tiny.windzz@gmail.com>
> > >
> > > Add devres wrapper for dev_pm_opp_set_prop_name() to simplify driver
> > > code.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > > ---
> > >  drivers/opp/core.c     | 39 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pm_opp.h |  6 ++++++
> > >  2 files changed, 45 insertions(+)
> >
> > On a second thought I am looking at dropping this one as you haven't
> > added any users yet and I am afraid it will stay unused.
> 
> Now it looks like that dev_pm_opp_set_prop_name() is used relatively less.
> Maybe we can wait until a caller, and then pick up the patch.

I am even wondering if we should be adding any of the devm_* helpers
for now to be honest. Even for the other one we have only one user.
Them major user of the OPP core is the CPU subsystem and it is never
going to use these devm_* helpers as the CPU device doesn't get bound
to a driver, it is rather a fake platform device which gets the
cpufreq drivers probed. So the only users of these devm_* helpers is
going to be non-CPU devices. Considering that we have only one user
right now, it may be better to just fix it instead of adding any of
the devm_* helpers.

-- 
viresh
