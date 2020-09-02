Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4026F25A4FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 07:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIBFXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 01:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIBFXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:23:15 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B3C061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 22:23:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so2187243pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 22:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BVhFJ3Y+hjMqVUpwLbS9tGUo0xITtak6uttEh+ZRoAE=;
        b=fCMQSPyR6dqJGAxuqwQ3iQwXVR9XO4k3BEgkYmAL5kNppciYkogCXaku4r8hyC64bt
         EZgv2mebMFjGNTKx160KdU6YvcouTOBGBmSc6F5OlDUF2Oq1Inqt/CgxEy9nvcrk6V+8
         aLwxx5q0gIWPmlB7Tggypgri2EfouqVjjRT0LsobAcllcgxhv6CBt4ITtwjl6EjTjj+S
         xtwaQGnH0XJrSHndj9J78HeG1wKqYpCNKKf+hCEZlS6LV+4vH2GF2GKFGM1Ne+jOJz0e
         vUNGObEpeMOZ3EwWchFNgj+56ykk4/Aekxm8ChJXEyhj/zZ2gHWiwEd4srfTqJIXVuvW
         38gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVhFJ3Y+hjMqVUpwLbS9tGUo0xITtak6uttEh+ZRoAE=;
        b=fhuX4JJXWAKyv/4JvSEPmkJvi2/BKOmfxn2ndESX17HAT+fehTbDC4VOjtTyEbpAKQ
         rtBtRSDIka25Vgu81xMHFqm1o1B0PtmAjdYJ3YbyeawByB9DERRzifwUXobdtbWia6+l
         y+VCHHPn10yTfuAMcerjGYdOmv4ieeg7Y1WvdDDKQA1eiyYx35yK5k6X6NbfOOn0O8hw
         qEpxCvissJMZiX/kn0veZiykxlUHP5QaeKq+Fth9lKlOfNEwG8hDdRX2OPYEMWMG/V5p
         fzuU22a01gOqQrbuzeYYQoZl5DZ6yh7SgWuklsRiZnvd2O94dQtI4auB8DXGo92kjS0O
         ZXkw==
X-Gm-Message-State: AOAM5338iKrYZ1fAeOb/DueN9LCigtvA/NAR1u/DzuKAfC9TI6CWeJux
        rR0DpR1HfReNvo8b89R9dZln2Q==
X-Google-Smtp-Source: ABdhPJyVAj5bq2ZIy1KPMkq6FyhzjG9cOtRfI0Si6VHtWCcizDPw0evcn9d4QROXifoq9jqPssZ7jw==
X-Received: by 2002:a63:e741:: with SMTP id j1mr629326pgk.422.1599024194547;
        Tue, 01 Sep 2020 22:23:14 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id l24sm3848694pff.20.2020.09.01.22.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 22:23:13 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:53:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
Message-ID: <20200902052308.jvdbkyjuawfihea3@vireshk-i7>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
 <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
 <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
 <20200831084111.6udzvrdonxgzju4l@vireshk-i7>
 <cbfa012b-8f50-e460-972c-c51fa52bb858@gmail.com>
 <20200831110408.a6lwivim4w4jtkdc@vireshk-i7>
 <603071ec-6ae4-7e34-26e4-f64065b01ee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603071ec-6ae4-7e34-26e4-f64065b01ee0@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-20, 16:21, Dmitry Osipenko wrote:
> IIUC, there is no fixed formula for Tegra, at least I don't see it. For
> example, if you'll take a look at the 1300MHz OPP of Tegra30, then you
> could see that this freq has a lot of voltages each depending on
> specific combination of SPEEDO+PROCESS versions.

Right, it may not be worth it to clean this up :)

-- 
viresh
