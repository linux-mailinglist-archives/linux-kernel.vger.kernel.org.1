Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C16232BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 08:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgG3GYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 02:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgG3GYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:24:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93690C0619D4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:24:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so4414191pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XPnPVe/hBWV8ylTxStT4hqgYjjgVSOD9uWxEIWOaFgQ=;
        b=ldIuMhjRCKAjbwoGPa+nSN6KncO7fsi1IvDYGFsNSnDyaQ+H/cnJ2f3w7dEo5QgvPh
         xtEqOV1uuf/gmhfscqmAA2ExohCpn3Zz+GXwzguHX1VAmjy6p2iBuNi2VejPqhC81xxw
         etkEWT9Vuu6P1PiO3NYhSe2KtJKglpTZUWrU9sn/Kgi4AZjoqS/Sk95euSmpJS4gg/X+
         IFFnCag173v57OWvBfRdhrSnu2LcIOlURV7JFtawULXaFhaZXDl5yULkxre5yrA2Spp3
         JQTO0XIuJ0tD2zZMmwmHfX/Tei4B3OXhvJ61prZxsJDwBDM3XqnHsCHjl7aWfE4TW40s
         rTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XPnPVe/hBWV8ylTxStT4hqgYjjgVSOD9uWxEIWOaFgQ=;
        b=CKkP2eXHy2ELDQeT+T1Jq2U6KsFrvz5ncdrxwoZ+pcT6kFrkTF3Ba9i2+9+NtVjHCp
         8bKDLk1L4ZARC00rLAvmwtfq4vcgjXS0i1SD59OLEIZexd2dL3/ErYYP8i0FxI7IcUgS
         9PfISWQUJOj++Vo3K4l6gvG8yXxeRfyXUDeYlRY6tYG9d+yZ2trk1Qzh6yZ5H4XIf4oo
         vNQr7MzQ/ju378CnVd1XnsXNd4CF1S8E5SQ6a53BmjxFz4YuOlmBr7qI2TN/WxDdIy4W
         KxRP2FcBWALdDsMc8DQwzaOYNa0By++gy30fkOCwYrhYXVfoBldXgQC42m92xFSCavQq
         Tx1g==
X-Gm-Message-State: AOAM533lI4dThwgBgrsqD76dyOqHQ6sIYIxgJfAmRuRQ83nX/fzUYqOQ
        HfCOsMJ1HhgG/osej7dTeXFdUQ==
X-Google-Smtp-Source: ABdhPJx3x1DBRy4eexY/OhOFytaYU7ysFTqceScvV/5SpmHvZFAmx47nY0u/kZ3Cq7/6tuca1ZuNbQ==
X-Received: by 2002:a62:1951:: with SMTP id 78mr1751266pfz.137.1596090257777;
        Wed, 29 Jul 2020 23:24:17 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id 3sm3489881pfv.109.2020.07.29.23.24.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 23:24:17 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:54:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200730062414.uq3ip7ukpu7nkiyg@vireshk-mac-ubuntu>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
 <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-20, 11:46, Vincent Guittot wrote:
> On Thu, 16 Jul 2020 at 16:24, Lukasz Luba <lukasz.luba@arm.com> wrote:
> > On 7/16/20 12:56 PM, Peter Zijlstra wrote:
> > > Currently cpufreq_cooling appears to estimate the CPU energy usage by
> > > calculating the percentage of idle time using the per-cpu cpustat stuff,
> > > which is pretty horrific.
> >
> > Even worse, it then *samples* the *current* CPU frequency at that
> > particular point in time and assumes that when the CPU wasn't idle
> > during that period - it had *this* frequency...
> 
> So there is 2 problems in the power calculation of cpufreq cooling device :
> - How to get an accurate utilization level of the cpu which is what
> this patch is trying to fix because using idle time is just wrong
> whereas scheduler utilization is frequency invariant

Since this patch is targeted only towards fixing this particular
problem, should I change something in the patch to make it acceptable
?

> - How to get power estimate from this utilization level. And as you
> pointed out, using the current freq which is not accurate.

This should be tackled separately I believe.

-- 
viresh
