Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0393020C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhAYDSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbhAYDQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:16:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029EC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:16:13 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id md11so7499869pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TFyTi9n3ka/cyTayJs708qTRhIpaSa+m1ThXr6zgmQs=;
        b=m1lvwU6arxvRMHE1lpJNFm1m+cxnW9TLqxKHhfwk5NHDVB2Ov5LtgfmbtWsI4wdjqj
         9TqvK9IvCw051+6UgEuYdpPnagAcA12eSm0TazMosWEos9bmEwhp7T3XZBF46+MsSAj/
         Obc0+tUl80bZYzeIxANw7E9PQHkmBT0oG+gOgneSl6WWvluI1weSV0pO6GSc1Br0BLPB
         sl1ZCkl4M3hS8dipMi5ujfUq17TM/kZoXy8utcs79IJDOBw5MTbIvOcBtQpjXBU2fL7t
         tKFa/J7Oghfr7mlfdsE4b2BlzQH2Ycxa+RGHO6jJHdVsudtUwBkzPypIKoDoXfxQACSW
         pSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TFyTi9n3ka/cyTayJs708qTRhIpaSa+m1ThXr6zgmQs=;
        b=ege2awfHJHLNP1auYVgYYk4aEE0dqSxEoDXQegWxnIy+k5JeAb+ya54ZCyw+gdZ+QB
         v0JrHGeOBMcynYgmvZVIr5YMEReHMO8M7ekn+jeyLG6Xgylu2Ago0MkyXjIPAOvnCNJS
         JnX8ARy+8ystA3HxUvzT+Ui0LZdCpQFt8x1aGh/S2/bDOeU6dLegkNlDDxycT9XfflT1
         p0tNWkkegacW2fdzs1W5+WQ/rNqLHsNJXg9U9oBsaRQ21basxE5SLdY70Y4z6l5+m1ZN
         JwFBI1AN04dXUm7hbIAbECVpw6OUmEwh38QIf1bdKhOHaSOri6BrueH05aJHuGMTc+dX
         tH2w==
X-Gm-Message-State: AOAM530U2k8+nfvG9y0V+rPnwRsq8prvEtTsJQB4Is4DYzzb5iU+SlRA
        yq7d3gcCoa9l62DadJZyCD7sPg==
X-Google-Smtp-Source: ABdhPJyMujvqOL88ASGrICY3CnuGu5T2z/8hnxHCCoCt/fl46YQ+vIcR13lql7BlEh2CZlgw88WPYg==
X-Received: by 2002:a17:902:9d8d:b029:df:e5a6:1ef7 with SMTP id c13-20020a1709029d8db02900dfe5a61ef7mr13871349plq.77.1611544573139;
        Sun, 24 Jan 2021 19:16:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id w19sm14921785pgf.23.2021.01.24.19.16.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2021 19:16:12 -0800 (PST)
Date:   Mon, 25 Jan 2021 08:46:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V6 5/6] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
Message-ID: <20210125031610.uscemdygdg463xk2@vireshk-i7>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
 <20210123030709.GI4400@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123030709.GI4400@yekko.fritz.box>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-21, 14:07, David Gibson wrote:
> On Fri, Jan 22, 2021 at 04:20:35PM +0530, Viresh Kumar wrote:
> > In order to build-test the same unit-test files using fdtoverlay tool,
> > move the device nodes from the existing overlay_base.dts and
> > testcases_common.dts files to .dtsi files. The .dts files now include
> > the new .dtsi files, resulting in exactly the same behavior as earlier.
> > 
> > The .dtsi files can now be reused for compile time tests using
> > fdtoverlay (will be done in a later patch).
> > 
> > This is required because the base files passed to fdtoverlay tool
> > shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
> > tag).
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
> >  drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
> >  drivers/of/unittest-data/testcases.dts        | 17 +---
> >  .../of/unittest-data/testcases_common.dtsi    | 18 ++++
> >  4 files changed, 111 insertions(+), 105 deletions(-)
> >  create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
> >  create mode 100644 drivers/of/unittest-data/testcases_common.dtsi
> > 
> > diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
> > index 99ab9d12d00b..ab9014589c5d 100644
> > --- a/drivers/of/unittest-data/overlay_base.dts
> > +++ b/drivers/of/unittest-data/overlay_base.dts
> > @@ -2,92 +2,4 @@
> >  /dts-v1/;
> >  /plugin/;
> 
> This still makes no sense to me.  Is this data intended as a base
> tree, or as an overlay?  If it's an overlay, what are the constraints
> on the base tree it's supposed to apply to.
> 
> This patch is treating it as both in different places, but that's such
> a bizarre usecase it needs detailed justification.  It really looks
> like the unittest stuff is doing some very bogus stuff that should be
> fixed first, before trying to do this on top.

I will let Frank respond to that :)

-- 
viresh
