Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96052B7572
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKREms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKREms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:42:48 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2309C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:42:47 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q5so623298pfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FAkYiB6meTJKy5RR09ScXUKaG++fKpzrVpSRg+ogsA=;
        b=ExmeuoikpUaQ3dSbxTpC19m1l8uJ6rBIfz7ksxGRERPMO6qN63faXklev3v8jOsobc
         Gx2D97gLiQlOcN3uE0xBG9rmquSaE2PEeiIQsLpBWFPko/0xPkG3ljltN7Ciu29RpmTC
         Vi72R9f7vUEjtBDo2JQlG3COdb+MJCSolXLv83ZCgabHRPUr94etTV0m3Il9uFfhazDn
         n7i92YV+Kh2v+FYqNtc/A0T+fHGLnEljE8pQoPwoovF3Ca7zFZ82RgX0ILzjak8xNPrN
         IJhq7mct3w6pw84dy2QrcAkGBEDl3PUm4aVsbkvJrCWjcV4VkQ5Xbf8+t4wLU0IqvXzJ
         ySmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FAkYiB6meTJKy5RR09ScXUKaG++fKpzrVpSRg+ogsA=;
        b=PcOiShKay/ftp7IwhI9lU3sFq+U2VA7y/6SVEKSXBW1kKuX8LPr1Rg29xM7zw5mVPf
         VVaCfagitGpUscFiVw2Vfu0N3VZGDOkc1GINbODJE2IlDhNXPC641sOZZ7wFUogLdi+e
         MCkJs60qKrBOHY1gau9APc2lbG/qLqs14SOP0xru5nPz/1zvV7mY42Krr5ONIpKFlajc
         rLHcYqUCbTI420eP1kG1OrZn8EgXhuBzLQ/D8OCc8+48mBO0Ez2GQOlvgkzCyf+jaOEx
         pATlttm4fbF41jIlMe462troo1NdCpAAaGneo2HgibzL2kTWxpY6jcrrjY9v/U2+HHRo
         VrNg==
X-Gm-Message-State: AOAM531UuNOToo2wy3eFpqZ+IGrexSphafN2mEaFMei4oxMt5Atttqr2
        2JFkSI8idSO+o2fy0PwY0VjYrg==
X-Google-Smtp-Source: ABdhPJwxk1ODqQ9kvlqWkFYqsEqVW2twgRg4V0X3+9BHvObvNB6doecYDMI44/2RhNOgPvuAJG4Epg==
X-Received: by 2002:a62:f252:0:b029:18a:deaf:37d0 with SMTP id y18-20020a62f2520000b029018adeaf37d0mr2954563pfl.48.1605674567369;
        Tue, 17 Nov 2020 20:42:47 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id q200sm23782663pfq.95.2020.11.17.20.42.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 20:42:46 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:12:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201118044244.gbr4ujz6ilxatkde@vireshk-i7>
References: <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
 <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
 <20201106105514.bhtdklyhn7goml64@vireshk-i7>
 <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
 <20201109065742.22czfgyjhsjmkytf@vireshk-i7>
 <2fa8a5c0-f66d-34bc-7f1c-8462e7532e0a@arm.com>
 <20201117101128.6uapqg56arwqmm5p@vireshk-i7>
 <0858962e-3a30-d177-594b-bb8e3149dd8d@arm.com>
 <20201117105337.vjwtig3qxpc6owmw@vireshk-i7>
 <CAJZ5v0iRs-uxzdV4vikN1VOwGuoorkRt2uqFSvbN2kySG-6duA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iRs-uxzdV4vikN1VOwGuoorkRt2uqFSvbN2kySG-6duA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-20, 14:06, Rafael J. Wysocki wrote:
> Is this really a cpufreq thing, though, or is it arch stuff?  I think
> the latter, because it is not necessary for anything in cpufreq.
> 
> Yes, acpi-cpufreq happens to know this information, because it uses
> processor_perflib, but the latter may as well be used by the arch
> enumeration of CPUs and the freqdomain_cpus mask may be populated from
> there.
> 
> As far as cpufreq is concerned, if the interface to the hardware is
> per-CPU, there is one CPU per policy and cpufreq has no business
> knowing anything about the underlying hardware coordination.

It won't be used by cpufreq for now at least and yes I understand your
concern. I opted for this because we already have a cpufreq
implementation for the same thing and it is usually better to reuse
this kind of stuff instead of inventing it over.

-- 
viresh
