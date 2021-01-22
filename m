Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936DF2FFADB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAVDLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbhAVDLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:11:33 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:10:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u4so2945302pjn.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HzV/QdB1V+22ttG1OqjI8H9Tv8gExB2vH6oIJa3FoFY=;
        b=qBVEYUC2QwHEXoHH4XoAKIYeFzFwY3IxEIj/cKU9a4JMIxEQ+9psf1z2oWK5uTHnao
         2nC17bLd/zkImx6/h/9NJn9ak/jpmeiSi5N7DUYEiIxOt7u3SIlQFi9XfAFEc1pzQpnA
         Ftk4YLbQfJ0f/iQf6LFokQLUdTYEg7dRNSMtqYRP9oY+Vz7iFM+ajymInLTjxWh0HKlG
         ZHwOckX3v0LFStvxpWmnBz9Lfj/2Qy0Tab21YjueH6NS1pTaXcM7Idlnw2WGAu//cHQp
         fahaARgNx0C4Om4tp9DaV63uuWSNzqJETVmtOZ/ySUWqJZaqZJFA1aPROVplo+3SYPOv
         rUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HzV/QdB1V+22ttG1OqjI8H9Tv8gExB2vH6oIJa3FoFY=;
        b=nmMb2UCo+R0HmE4FPeQAitpIk2FNgU+h9n7eGwslrzXkqSYQV5Hu57o/qTSOtakEi+
         GpUIS5OHKj8HYTeAX9ncAKZ2bqcKi1VhLw5gBmN+rwcMCSwnFB3cPa4MHeRfA+VmsJX8
         F5Bt9KTryJvWSzt5aGU9VYHbKTLJMVqqBO+fBVvFVsvufyzJIyH3Gw3dAN5++8GNr71S
         CnpLi0/OXKVx5kXGEu72zOkYWUHajiVUR0Aa/KhicPw1hPiY2DkYWPrsV3tWJw+4sauu
         dEleUVq1YlDVkMYFad3m8ytEFy9wkotWiIeTfs2uQaU9U0mK7r8j+EGjqNIRy2pNfkQ7
         PWOw==
X-Gm-Message-State: AOAM5321a2OHkpaV93+EdtrpRnscYYLrAE3DBV9nqk4uMEH68Le6Z+W6
        wlVLoSW8zbPBPCTNiwSjFVH3pw==
X-Google-Smtp-Source: ABdhPJyupWax8WdpNUqEY+LgYIg8eTFUoGEKXp2u/aQpkUNNACz6Jd/SEr0jElZEhM/Z6cuvozCB8A==
X-Received: by 2002:a17:90a:ae07:: with SMTP id t7mr2719959pjq.115.1611285052073;
        Thu, 21 Jan 2021 19:10:52 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f29sm6715389pgm.76.2021.01.21.19.10.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 19:10:51 -0800 (PST)
Date:   Fri, 22 Jan 2021 08:40:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210122031049.u3nmxxzzhue5rniu@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
 <20210121063438.GJ5174@yekko.fritz.box>
 <20210121065728.trqph5uwvp43k46l@vireshk-i7>
 <20210121233957.GA4400@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121233957.GA4400@yekko.fritz.box>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-21, 10:39, David Gibson wrote:
> No, it definitely will not work in general.  It might kinda work in a
> few trivial cases, but it absolutely will not do the neccessary
> handling in some cases.
> 
> > I
> > did inspect the output dtb (made by merging two overlays) using
> > fdtdump and it looked okay.
> 
> Ok.. but if you're using these bizarre messed up "dtbs" that this test
> code seems to be, I don't really trust that tells you much.

I only looked if the changes from the second overlay were present in
the merge and they were. And so I assumed that it must have worked.

What about checking the base dtb for /plugin/; in fdtoverlay and fail
the whole thing in case it is present ? I think it is possible for
people to get confused otherwise, like I did.

-- 
viresh
