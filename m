Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDF2C5ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391692AbgKZRjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391424AbgKZRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:39:44 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A87C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:39:43 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u19so3573296lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eB5D3rePuEGUvTD5ttlyy4gxcjPoA2bsyQLf4m9a79Y=;
        b=WUlVLCOmP7q37Nk7fxZ7ntkfLfv+4FUmwKwdlqvf4Ecabq37r9bx9DFbjFGf4SpFHT
         Xx6wy5cJ8bvVoZyu8k+r/uqYy5GMPUss4JpwxOZu6xyWz0OxExXEgnJsSKGyYzPS/h1o
         elPUK+QiE3sIThWTWOiRfGLVc3G13b+CPskec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB5D3rePuEGUvTD5ttlyy4gxcjPoA2bsyQLf4m9a79Y=;
        b=tFVkGx2ZMtdMz/GlW+SDMqFVxq8+Nz5ONQ7fjrespIwUoiro+exzrZSvT1dt/58vvy
         UQjJZWIaL/jjJOClql/TX5moXuA7O6QWEWIX8Vd1D2dpgPZyjZ6su8uMEyTG98UYdT7y
         4aopOawzhnyC4axZOkb4QTDf+xf3Npc9rzWa1CuzhgFSqQXEd8CkAGrvvWIGHFmtxb0U
         ZHtnOCFQV4oVaebW5ocGQJ4iccLLX+67eVdPPHcusVhlfsIeZJRC/7RKZmuMmSQg6sAI
         M5o9ZFT5UPLEACu1yJJibM+DaKgKmlCN5NytFaMadkmPpUU5OxM1rLTFoXcoM70wW12x
         b/Iw==
X-Gm-Message-State: AOAM530SMrjIUJ3E8BBSP+BfTW8FSX3YdWbIKICSppG4oNA17UhF7H8f
        8K35xcEzLe7S7nsitXHUjubgByIFoH6k7g==
X-Google-Smtp-Source: ABdhPJztkgG9Q2xbUlbIqz7Ner3pYn0KAc1Jtaoz/IuxRc5P18m4KxcwhKYq9zuaIGqGhnZ+eGDunQ==
X-Received: by 2002:a19:4107:: with SMTP id o7mr1991253lfa.542.1606412381238;
        Thu, 26 Nov 2020 09:39:41 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z199sm388544lfc.42.2020.11.26.09.39.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 09:39:39 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id f18so3164813ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:39:39 -0800 (PST)
X-Received: by 2002:a2e:7f13:: with SMTP id a19mr1771205ljd.70.1606412379030;
 Thu, 26 Nov 2020 09:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20201102091543.GM31092@shao2-debian> <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com> <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com> <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com> <20201112141654.GC12240@dhcp22.suse.cz>
 <20201113073436.GA113119@shbuild999.sh.intel.com> <20201120114424.GA103521@shbuild999.sh.intel.com>
 <20201125062445.GA51005@shbuild999.sh.intel.com>
In-Reply-To: <20201125062445.GA51005@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Nov 2020 09:39:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvQzJts-5PnFnJcUU5M3ZFv6RSaS01Mchv0unPzh-XVA@mail.gmail.com>
Message-ID: <CAHk-=wjvQzJts-5PnFnJcUU5M3ZFv6RSaS01Mchv0unPzh-XVA@mail.gmail.com>
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, zhengjun.xing@intel.com,
        "Huang, Ying" <ying.huang@intel.com>, andi.kleen@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:24 PM Feng Tang <feng.tang@intel.com> wrote:
>
> And with the following patch to relayout these members, the regression
> is restored and event better. while reducing 64 bytes of sizeof
> 'struct mem_cgroup'

Thanks, applied.

I do wonder if somebody on the hardware side inside Intel might not
perhaps want to look at that load pattern and at why performance
regressed so much. Maybe teach the prefetcher to avoid adjacent cache
lines that end up showing ping-pong behavior..

             Linus
