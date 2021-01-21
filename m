Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F702FE22E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbhAUF7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbhAUF7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:59:03 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B5FC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:58:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so663755pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z5VmVFEUNkE+fR4NUGGnMzYHVXWCdiImlaKQN0S2ixk=;
        b=bQ1Uc5ygT5K4XceUViH0UPlujm180IO7i9jfk68RtpSH5woe9nWgMsYAfA9xC0t+0y
         XcmXo3AlQ4D4AYzWypZI3bp2rG1v2lshxjZRiVGO89imAlWz1VS+53NKdZMB5ZCtlGKc
         CESXeWw9SNErIDF2UwHuDTZCkvmTK/iQKuZ3+ounYm+bHpW6h3IU0PyKVcoyP5f3d5rI
         f7laXvvvjtYid+dztrdZtPZHHgOxNjMXt4sBvp5bNc+tNMHaGenvsJP7rYlBjXbNT51E
         EuUgmT5isUOpdjghqd3uo//bzvLkDwL3Pl5IRxtbSvulTZzYb7Cc2mxPTb3aI/D4bX50
         VIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5VmVFEUNkE+fR4NUGGnMzYHVXWCdiImlaKQN0S2ixk=;
        b=Ru5zyo30ayfIQwiVSatK33DTOsx0sbuikF8Hiy6SYR8FknAn5Pnmm0XeglEg0cxxdd
         /SJ9OeRm8Q/2G1J1cDLfQRWHO9sQjXt+RQn8aFUKsCglPUGr0/6iXiraFyntSReZdL7c
         XErYRfaouFNY2jL0voa+HnfdDp5jX2vwUXpXd5vUcGKHTc5pAX5SuXHFmSt4WrlRxySz
         /YD8q6hU6gTxHBkkIiL+YPJhRQlabjtMDPw6bkB+G+qnrYq9c8yC0yWu9RoCbroDAr0w
         zuICfbI7OwQs4llX8rp+hyat3TgN0XCq9SSdhb+atzffTIVAO/n5nNO8ECeMYpc9tItD
         AltA==
X-Gm-Message-State: AOAM531PVFuaceDDFIYM9cS0mf0maNXCFINY19+j9Ug6/JIRCDw+kh8F
        qLePztUYj93PSNuWa78z8ZTqoA==
X-Google-Smtp-Source: ABdhPJw+djOazZ/yvnG3PUwjwbM6nBOD1AJfGJWw/dPQUucUpCsVGIhHYsxPBHMLwxm8GnQ0MpC44A==
X-Received: by 2002:aa7:9af1:0:b029:19e:568e:c452 with SMTP id y17-20020aa79af10000b029019e568ec452mr12472321pfp.28.1611208702920;
        Wed, 20 Jan 2021 21:58:22 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id z6sm4148525pfj.22.2021.01.20.21.58.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 21:58:22 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:28:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210121055820.e5z3uykfttvxffhe@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <a6b5e6ac-90ec-9571-4fce-de7344bfcee9@gmail.com>
 <20210121054340.e4do45uvdns5bl5f@vireshk-i7>
 <91dadafc-26e1-13c1-37a2-d05ebd7b151f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91dadafc-26e1-13c1-37a2-d05ebd7b151f@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 23:55, Frank Rowand wrote:
> yes, but using the modified versions ("/plugin/;" removed) of
> testcases.dtb and overlay_base.dtb.

Okay, that would work fine I guess. I will try to implement this in
the new version.

> I apologize in advance if I get confused in these threads or cause confusion.
> I find myself going in circles and losing track of how things fit together as
> I move through the various pieces of unittest.

Me too :)

Today is the first time where we have some overlap in our work hours
(probably you working late :)), and we are able to get this sorted out
quickly enough.

Thanks for your feedback Frank.

-- 
viresh
