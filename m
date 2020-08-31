Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA731257379
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 08:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHaGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgHaGCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:02:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9AAC061755
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:02:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z15so2517708plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T0ddowV1YvN/aU8XxhlLoq1wELp6Tq70TmTHW0qRDVI=;
        b=oyZKTm6Tk8Vfn+6jwN/7gGN7iSX68l/t/xvDbQcC2eXx4gwvTmqL2o1sL3NWAqGw9e
         HlOdy/6xd2zXu5VIdMqgzyfvmP5PVD4c+iHDjw6shV3Yy16kPvWyIGSgpVDZyMla3KME
         UnW071eobQ0jbulqrWPqjlMGi09kcOsSxM5E0FUoe9tmTWINaYbWM6Bt4FyWPho2hktn
         6Hbf/Vua+a7ZbggXlT0Qo9cxJHzUVQMEz/UaTzitb2+IobwMNM5ZFpGNeZkpT+j3CeJZ
         OlnsmqPbKN3DgHr0aDVbsL1FzQcgdA9z7O5zOw0hBdbaro50Sg+uldE9v18Bmjkbb14v
         KXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T0ddowV1YvN/aU8XxhlLoq1wELp6Tq70TmTHW0qRDVI=;
        b=QxonZahoCH7M3GkTYLyM4/ppzejsYT5tIqEQAI5uLK/S5cFtgctjBJvtuzrmndJonJ
         WlVD8DDliKXsqN6TRRAeeAXR1ZVDuNVBUacAKxWEHmcjefI491eVB0iloa4o71Kp8kBe
         EVGupVL1TkqiNo/PsIGSjHYp+lT80Dw7qjLE8DavfBo7hY7OI3cAZjwgpjO3DnYqYamO
         w3vtTaMbagfaf/aw0FgXEEfLRpvjsTbLBGfyoBtmnNN4ZJFpYNG9NoGA6ZXjbxRAg4yS
         x3mbICTeNkxxHoDgw3AAjI3uj6iU0ZHk3J6ExPmA81msDPj37ldJAUvN6IERA5BJmiG8
         SmUg==
X-Gm-Message-State: AOAM533iklsys8RpKaF9NsY8yr2MizqYCwwgM7h+qP8I8rCCmn8dESyW
        c5VRKKoyM/17hVn4AC3S5mTl6A==
X-Google-Smtp-Source: ABdhPJykLmYFCGwOE6bqP4q4MynlYfHpxLNeOGfCqaMjdqKJQBPGSdKEXOfXuxq0dm9PoHZkmhlxgg==
X-Received: by 2002:a17:90a:4401:: with SMTP id s1mr171676pjg.79.1598853726264;
        Sun, 30 Aug 2020 23:02:06 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id s20sm5932548pga.7.2020.08.30.23.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:02:05 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:32:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Subject: Re: WARNING: at drivers/opp/core.c:678
 dev_pm_opp_set_rate+0x4cc/0x5d4 - on arm x15
Message-ID: <20200831060203.7guhirtxb72odow2@vireshk-i7>
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7>
 <20200827211832.3ebeda8a@canb.auug.org.au>
 <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7>
 <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
 <20200831044132.jb7aflr2sfbart2z@vireshk-i7>
 <CA+G9fYsLd77Wuz6Fdwr0w4eFvs=rX5ooewrztFtSe7MeyRJeGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsLd77Wuz6Fdwr0w4eFvs=rX5ooewrztFtSe7MeyRJeGQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 11:30, Naresh Kamboju wrote:
> On Mon, 31 Aug 2020 at 10:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 28-08-20, 15:42, Naresh Kamboju wrote:
> > > Viresh,
> > > I have applied the v2 patch series on top of linux next-20200824.
> > > and tested again the reported kernel warning is fixed [1]
> > >
> > > [1] https://lkft.validation.linaro.org/scheduler/job/1717615#L1881
> >
> > Hi Naresh,
> >
> > You meant this one ?
> >
> > [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
> 
> I have not tested individual patches instead applied all v2 of 8 patches
> and tested.

Ah okay, Thanks. That's the same.

To be honest, I wasn't targeting fixing this bug with that version,
but it went well after all :)

-- 
viresh
