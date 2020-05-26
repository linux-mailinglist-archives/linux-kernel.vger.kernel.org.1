Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6AB1B5ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 17:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgDWPOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728551AbgDWPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:14:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58FC08ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:14:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so6970252wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v46Ikk3Jz0r+b0XX/bOEpsMp0yxP+bghxd3vH+HYhPc=;
        b=MIWxKE/qjLCX/xGHYA9pPPU0BNfKH43CNGFsg6DeK/Mru9tvWVDKwiaZOn1XHjMoVE
         i4PYlH8O7bplYaTQeMICT+fzY8fnWvVzPWCE5yQuez2xPFjAeqSQYiNf0Uh7R/Wo38Lg
         Z6hX1p59FRmd8cXRcaKNBTpSFrbXarSJk9IonBz+osP259UyeH0oOSynqm+2NZi2Ahkn
         mHD1tRQfsYU56pVs27oV5Y7kgyFt8LHsXNWTr7pGFlFyAJIxKMc0HJpPsylF6zrtlQY4
         5pwVLUZ8W5eDfGynjFnJROYgC6aT3odwPB41c02RsLfkH8QAoKuW6rYRcLWEg9G1cGkc
         OQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v46Ikk3Jz0r+b0XX/bOEpsMp0yxP+bghxd3vH+HYhPc=;
        b=i8zpbEJ7Ws+Uh6zkgVMlLwu7AK49jyfus3yenUuHqNGIDuIlhxKmDsr8Gk04511h0S
         HxnnFJe2GvE0U69n/wUmIaGSYCS0pKJ/mlAi1MJVn6dM5cZVt3FTIvGJNEY4mBt2zX3j
         HvKOco0zyxouWwMZwQJhKo4DXwOI0RyJVpcA3TjfZJ/RLj/dfK4Jd2Gm27UyGSibOjzh
         0l1onqhziwkXRWUqG5J1FTYl6jkkQwbGjrPtPmVrktymDw1y307kOtryKdXx7A1xcF+Y
         hrw5LMc6FEnVV8cBnxYSB+rB9WaazGH27DfTWNGIl25N/GNODTM7W/0SRs1as12HVesD
         FJnw==
X-Gm-Message-State: AGi0PuZhnhQLM6/6adeqxkVbKkKrL8z69lLVfOK+/BA/U5kvVPWVAOnX
        ZczDtvO2JN4c9bMcHc2gP3Wz37+b320=
X-Google-Smtp-Source: APiQypKEu5s0OhD4gtUwKlNwoPw/ork7gNul9QoWfqC2s5n+wpnmvRh1OKW8lXO0WhhFY70e5NcqhA==
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr4587343wmb.130.1587654846044;
        Thu, 23 Apr 2020 08:14:06 -0700 (PDT)
Received: from linaro.org ([37.167.216.250])
        by smtp.gmail.com with ESMTPSA id x18sm4083518wrs.11.2020.04.23.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:14:05 -0700 (PDT)
Date:   Thu, 23 Apr 2020 17:14:00 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v6 05/10] PM / EM: remove em_register_perf_domain
Message-ID: <20200423151400.GC65632@linaro.org>
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-6-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410084210.24932-6-lukasz.luba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 09:42:05AM +0100, Lukasz Luba wrote:
> Remove old function em_register_perf_domain which is no longer needed.
> There is em_dev_register_perf_domain that covers old use cases and new as
> well.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
