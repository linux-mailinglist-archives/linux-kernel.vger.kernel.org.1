Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E372FE8CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbhAULas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbhAUL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:26:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D04C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:25:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z21so1172471pgj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aL4GPeleTKRCNW1fK6e7red/YB+a/GG2BxvUEBjR5W8=;
        b=uGsuauxP904q8sXK2v9yGjasS/3E0sveYxPOJmpLwGSi0oqBbCwrPmIPkOuJYT+MYu
         FYRI5PtnqyoNs940vWo4wo28MBZ+p0+AZYB9TpsTfbF0aA4zt6KH3GFB2lylaluC2tvw
         JYagpbIyXmtu0aLvHUJ9wsLY/8Zqc+LsAQUfvGnHrqT73WF09RgkemvFlkvlfkZHqi/V
         azpQ42z9E8mpTT9k8//Q4tGdsHr338AQ+ZV6xy0t9n20jacy/8beAPVsGQnMu4ThhlMm
         sdMrNlByVcszUPl3XxOsE5hy5v1ZBsNtDoIVMQBc7MndALFzFc8HQS/4I34evxiDFOgw
         nR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aL4GPeleTKRCNW1fK6e7red/YB+a/GG2BxvUEBjR5W8=;
        b=W7r9fOyBbLMem932J4aiopiWNS+vNAJeVl6VCu5NwZwgjAy65YGUgvaaLmdCtnu8jb
         A6yQRqqgH8/SbtfpbdAVQAwNgBUpiFhEEKY98ZB+t/ar5oTH3W0LU3gXHelMejakeSvj
         jyY55pUbsDFMBPCl9dIh/0eWWfZQW0LQ7HWyleCp+P3f9zNeZERFDOs2xr+OQZbatice
         cRA4jil3zQh/4Ve4ydv+G/iTx6idAEZnZH5AEF3Fgg0nsrm/QnEF7a2KacIA17xW77zm
         ZBBBIWhmMEEY72yfUsPdTmfTYaiSWsM9w9LpVtKfhrV8uW/f8kAC1s8CoyMmGaIMHbva
         IXGQ==
X-Gm-Message-State: AOAM530crxCQJZkzVn4BiBHKof7g7cvxuuX0egavuWqIq/AENH0mJM1S
        TusOFL/LAQ+0/yC9f12HtcSsBw==
X-Google-Smtp-Source: ABdhPJytWTErMkAfHV/6jgBPSRvh619jqHgv42YX3SLD7FLTMtKCDSBmc6FUIlFUK6j2ejD79Twvvw==
X-Received: by 2002:a63:e058:: with SMTP id n24mr1472541pgj.345.1611228339475;
        Thu, 21 Jan 2021 03:25:39 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a30sm5139273pfh.66.2021.01.21.03.25.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:25:38 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:55:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
Message-ID: <20210121112536.pwdxikqtgpxmmizt@vireshk-i7>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
 <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
 <20210120073912.yl4rgkthdyyznbfh@vireshk-i7>
 <94f4ed8d-ab54-4180-87f7-4ddafb52074f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f4ed8d-ab54-4180-87f7-4ddafb52074f@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 17:50, Dmitry Osipenko wrote:
> If OPP API was meant to be thread-safe, then the
> dev_pm_opp_unregister_set_opp_helper() should unset the
> opp_table->set_opp_data under the lock since it races with
> dev_pm_opp_set_regulators().

Right, I will fix that.

> Secondly, functions like dev_pm_opp_set_rate() don't have any locks at all.

It was on purpose. It is expected that this routine specially will
only have a single caller and calls will be in sequence. This gets
called a lot and we wanted to make it as much efficient as possible.

> It should be better not to add "random" locks into the code because it
> only creates an illusion for an oblivious API user that OPP API cares
> about thread safety, IMO.
> 
> Making OPP API thread-safe will take some effort and a careful review of
> every lock will be needed.

I agree, we have kept some part out of the lock intentionally, but
every other thing which can happen in parallel is well protected.
There maybe bugs, which I am not aware of.

Another reason you see less locks is because of the way I have used
the kref thing here. That allows us to take locks for very small
section of code and not big routines.

-- 
viresh
