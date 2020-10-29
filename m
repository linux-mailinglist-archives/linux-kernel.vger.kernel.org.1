Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A129E557
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgJ2H41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbgJ2HyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9E1C0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:53:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so896746plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4sw3w4XrFVZNMUzdJHDOom34bhUJxhQlbaLUHYjXdc=;
        b=DueEfr9al3mveAf2AlVsQ0gR2DKDGYDGjJTa0Vii6mWcNYhaeuLtqbkKodyHlYjQBC
         3BkwpMOYAF1qGKSWmfmH5C9hNOyQB37RutYwOag1LIV02vP1Fnc4pOroCN4BlxMAiW1u
         uePwv1krkhgMji5LJ5wadtnxysvC7OEana+RnLwkSYJvtYXRwdtktRzph/UO6mPREpSg
         nJT1Eh5iW9m7MjTz7w8MUz9hPdlcQo72rGEQLbOCyQLy6qGy93f6nw3Nn63xq+0+EJEg
         0H5Z3k3xakc8lSEy1IH1CH0WYfPWlJ4s51zs0iRC6tXg80TDdalS9EwzNFbFLAbsQEnw
         aneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4sw3w4XrFVZNMUzdJHDOom34bhUJxhQlbaLUHYjXdc=;
        b=Lwp8iR49BlozlRNA/hg51N01P/ma8P8+IlRfFf4jUFdviCvIPVYzkWEGCTKlFTV/8C
         GfR2g1h8NggQrOOIGXdAYYgNAqn7uVnYWu786ybOFcJWdguW7rWBlzsA1upeno1KwGr4
         HFJVo09SL4CPMNf09zdTXifGVx43NEEH0vTKoj9Nc93RAqLVux/B6JKxYl2V0DHlJe7q
         DSm3W2XUmDmOEeZSrLmv3jsu1IWd9IUXyjEzkfhV08xfZCvoqmCpnGMfUiBP4/PCVIJU
         /0P4H0JOAXA0Qx4iqEBrqfa3dNHb4vCzewFKVsRt65gEB6pWO/uko1PKQnx3DiC7Q2eg
         Om7A==
X-Gm-Message-State: AOAM531OdLv86etgdqwTU385jF7ZTH/DsIRWY886xyvoeSlWgJh6EDn5
        QNsyzyVPDafV853X0dEAuJKQwQ==
X-Google-Smtp-Source: ABdhPJxF27cGr7hvK/3UclnQsFJtoKHen+ck4vMPY0s5Ag+bdkxLWyKYRfRldLFwf1iay6yosmyI3g==
X-Received: by 2002:a17:902:8215:b029:d5:f299:8b11 with SMTP id x21-20020a1709028215b02900d5f2998b11mr2876637pln.39.1603958039058;
        Thu, 29 Oct 2020 00:53:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t129sm1995388pfc.140.2020.10.29.00.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 00:53:58 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:23:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        nm@ti.com, rafael@kernel.org, sudeep.holla@arm.com,
        daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
Message-ID: <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-10-20, 13:10, Viresh Kumar wrote:
> On 28-10-20, 14:08, Lukasz Luba wrote:
> > Hi all,
> > 
> > This patch set introduces a concept of sustainable OPP, which then can be used
> > by kernel frameworks or governors for estimating system sustainable system
> > state. This kind of estimation is done e.g. in thermal governor Intelligent
> > Power Allocation (IPA), which calculates sustainable power of the whole system
> > and then derives some coefficients for internal algorithm.
> > 
> > The patch set introduces a new DT bindings 'opp-sustainable', with parsing
> > code. It also adds a function (in patch 3/4) which allows device drivers to set
> > directly the sustainable OPP. This is helpful when the device drivers populate
> > the OPP table by themself (example in patch 4/4).
> > 
> 
> Can we please have some more information about this ? What does the
> sustainable OPP mean ? How will platform guys know or learn about this
> ? How we are going to use it finally ? What does it have to do with
> temperature of the SoC or the thermal affects, etc.

And that we need a real user of this first if it is ever going to be
merged.

-- 
viresh
