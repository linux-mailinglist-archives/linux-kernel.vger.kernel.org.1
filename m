Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840162948D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440901AbgJUHYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440892AbgJUHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:24:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D02C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:24:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so939518pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hAIhzFswDyObHC/AccJ2pW9tYMVZUmTRll6IsakeHDI=;
        b=hcxqhkvAd7gaUVg+ADZjC/g5t7FunCEWj40dk9Jkh/xjioI52ZXAkwo5BMXN3dd6bK
         5yXuvLzPNM3xRKnqdyMdj4t+47mqUiHukE7zp03beKQSUIMlvPx4UIwK8I+FHjqcmJK+
         m/BFHJXQmFjXQ8bMAZqWLhKkQs9XMJMwLfK9KLRTPTTK0VqGNT1ILV7h8O1faqdo/jo4
         RnbVTYrqOhJJX40NnBh57Kvpk11HcrFZljb+h+jDOuMIAQLRZDKUntg+d0RwJGn2AWEH
         05nApZQVycKIsoa+R52Nh1RncFPKJRVeAHd/N+wiBZk7rXT5ryOvdRuVzz3Kc2MSGxVM
         o+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hAIhzFswDyObHC/AccJ2pW9tYMVZUmTRll6IsakeHDI=;
        b=LpS6psXHKgwZNiD7bWRQCK7zVBqFc88cwf0eUFEsZDjUqdEMEjYTjyWkTjW+qcXbzh
         2RRHX8Qer5uzMUcdqUwoCzxdCn9ZElr6StKzRRBzZRkrtsxSPcGcsSXV9xIFbri1Vy4O
         KkJYSFIcnsMX1yXDAMK+tAUCiwh3LY9ekzCLNZp+Gu47b7OSPikz3HcIGxIre1R51GRH
         NsBNb9zZUeGqQwYcaBspDOamRuFkYT0XDQnQjOeXhKuOAJ2xjZy2ssSag2CzB/7qQoOv
         aOTB2iazRnAjqE2HDIayjGW+z2IE6qHqAcMhKlyFL53jdndvU4wxu0mQqSfyMbKa03n3
         KIdw==
X-Gm-Message-State: AOAM533RV5W7gZQrmmsWPFGDh5SPJ3+YwcmgAO5MiTzzXR/x7B4fHTN6
        QZjQF+GRjtGcmv3MYvCEM5p10g==
X-Google-Smtp-Source: ABdhPJxdvf151N9thd6CsPj2u4ESktngUMo7t9TYxraGbFVI19jZ698HL0h3xJRccblV6DfAzwc+Ng==
X-Received: by 2002:aa7:84c6:0:b029:155:d56e:5191 with SMTP id x6-20020aa784c60000b0290155d56e5191mr2068267pfn.41.1603265047189;
        Wed, 21 Oct 2020 00:24:07 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id o2sm1377845pgg.3.2020.10.21.00.24.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 00:24:06 -0700 (PDT)
Date:   Wed, 21 Oct 2020 12:54:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/8] drm/msm: Unconditionally call
 dev_pm_opp_of_remove_table()
Message-ID: <20201021072404.y43tjzd2ehclrejp@vireshk-i7>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
 <20201005062633.ejpehkpeuwksrx3e@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005062633.ejpehkpeuwksrx3e@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-10-20, 11:56, Viresh Kumar wrote:
> On 28-08-20, 11:37, Viresh Kumar wrote:
> > dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> > find the OPP table with error -ENODEV (i.e. OPP table not present for
> > the device). And we can call dev_pm_opp_of_remove_table()
> > unconditionally here.
> > 
> > While at it, also create a label to put clkname.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Can someone please apply this and the other drm patch (2/8) ?

Rob/Rajendra, can someone please have a look at these patches ?

-- 
viresh
