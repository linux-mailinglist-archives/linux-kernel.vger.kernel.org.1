Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B4C258C12
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIAJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIAJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:50:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022AC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 02:50:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so311535pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAYNBHZDd70TdEjE2DczmYfKG/N2ztUaNH/TxTyh9Cg=;
        b=k18flmoNxQCq32ObHXfIj4WSLrlVekIVckTqF4jPygCGJxP9XbvDhVJWawCWx8I6TY
         RHBcxUTRSgu97cg6OPhcMFeZq69mO6ulAZJOXrZKH2w8FL1F3KnZkg5sqd/BihpLns9n
         D9f4uVDFD+u74wPgAy+6KJP8gBmgnVC5b39nsQ1NDOLjFixXd66a7Xvsu+/FsN7Ek5sU
         IQY2N34/Il5vnyP7XjKBGwSTrvF3jHsdCZjyT0AxkCENNXrty0919SyaOUwaJOLUYsu+
         ePFFbXvCObqmBVxeHXy2OMuC/5qkfbVmyDl34AQUq8u04rjxQ2UlkPmG0l8fpZ6r5NJF
         x2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAYNBHZDd70TdEjE2DczmYfKG/N2ztUaNH/TxTyh9Cg=;
        b=X/Sp0q9oVxLgYG1nU+KQlLwn+vQNnGVxzRNe41xhxdsfyHNNLbOOhKcZkjTmfbADKP
         mXeHTw5jJMn9jFTOUAyCuqnAxvdIwLgpFDdS5dwxQ4fhMPIIfLzagJcsJrIp5BRToXsf
         5W3KMG+xog+rCppBqq66QpoKqSVukR3XHQLZQLGm19qTMk+iApuqBLpGpyLFrcOGs2SP
         P1X2MyfmFYHCOwM3/fOHIgncvil6izVKbO8gkWdbHKolEzi4mdpjTN4nqDQA4GBViKRr
         L9veYNkZio2ic86aEUSbIZJHUOLBI2JI8cX35QCQhgIAyPZXxesE4wwrN2iB2fY+uTBX
         B7oQ==
X-Gm-Message-State: AOAM530Vmfja3l18kbB3vssvnN+xTqrPakjQD6g70y0UmMeL4FRdJdDt
        czHL4kO7ARleFYBX2vRjMOhw7w==
X-Google-Smtp-Source: ABdhPJxCEhDyYmSPEgTYFdTqAvCxaJppkKdnPO/SXStQluVtRk/f1mAkZEHxXLJ+5RamFIlFffPC8w==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr645391plt.163.1598953857535;
        Tue, 01 Sep 2020 02:50:57 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id 1sm1137318pfe.70.2020.09.01.02.50.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 02:50:56 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:20:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH V2 3/8] drm/msm: Unconditionally call
 dev_pm_opp_of_remove_table()
Message-ID: <20200901095054.pwnkzm5n3ys5r67p@vireshk-i7>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
 <bc64e031-c42f-9ed2-c597-18a790a4d3bb@codeaurora.org>
 <20200901083806.a2wz7idmfce2aj3a@vireshk-i7>
 <fceb0b09-30cd-5084-0d0e-e7795cfc5fc9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fceb0b09-30cd-5084-0d0e-e7795cfc5fc9@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-20, 15:15, Rajendra Nayak wrote:
> 
> On 9/1/2020 2:08 PM, Viresh Kumar wrote:
> > On 01-09-20, 13:01, Rajendra Nayak wrote:
> > > So FWIU, dpu_unbind() gets called even when dpu_bind() fails for some reason.
> > 
> > Ahh, I see.
> > 
> > > I tried to address that earlier [1] which I realized did not land.
> > 
> > I don't think that patch was required, as you can call
> > dev_pm_opp_put_clkname() multiple times and it will return without any
> > errors/crash.
> 
> We did see a crash (Sai had reported it), perhaps with dsi [1] and not this
> driver. But it was the same scenario that was possible here as well, which is
> dev_pm_opp_put_clkname() getting called without dev_pm_opp_set_clkname()
> being done. I think we ended up passing a NULL as opp_table in that case
> and the function tries de-referencing it.

Heh, yeah I did miss that stupid thing :(

> > 
> > > But with these changes
> > > it will be even more broken unless we identify if we failed dpu_bind() before
> > > adding the OPP table, while adding it, or all went well with opps and handle things
> > > accordingly in dpu_unbind.
> > 
> > Maybe not as dev_pm_opp_of_remove_table() can be called multiple times
> > as well without any errors or crash.
> 
> Can it be called without the driver ever doing a dev_pm_opp_of_add_table()?

Yes, as we will fail to find the OPP device in that case with -ENODEV
and so won't even print a warning.

Also if the OPP table was previously added as a response to
dev_pm_opp_set_clkname(), then we won't free it as well. So yes, it
should work just fine.

-- 
viresh
