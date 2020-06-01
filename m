Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6611E9C46
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 05:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFAD73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 23:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgFAD70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:59:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B7C08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:59:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fs4so4427403pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NA1E6W4DOQQR0TlPgcKw9NVvnAaiGHBLZ8DNkR3l634=;
        b=OjaCnpgOnP/YYCID+Rz93FhTd2U7QVHyoVtzYLSoEJH2x2LSGBYivlkRSb679EK4NW
         SQq6o1KRAil7LtjoD1Z/xzrLBvCqdL0N+Z3D3DaKe1MhToVhGCf240F7k9/46dByUquG
         aBQVkAOcLHzW0ANcsjPGl8/DF5IzfFECrSQ15Zl/E/Xon0Kb1BPVx7GAaQ6G5gl2xGn7
         k5ZcxAw9jRjM8EGBhQGrrWPj2KrMJqfKS7rjnetXZYWjh4GHolKXY9bAo4RXiZUTOkUm
         2tsppNlTop5/oqei1seizSZRQ6OnUlTEM28eIjAcrv2z21wT5d9xm2SFsDTRa5PMx7DD
         ++JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NA1E6W4DOQQR0TlPgcKw9NVvnAaiGHBLZ8DNkR3l634=;
        b=gGONAQ9qr0BdFQ6UtdvnmiMzTyOC9Jp/mNaw1LTSA6u9G/926TWdFcbGEHRbRJWEw1
         1ncFVOlY6J/UcDaNmSS04eFYsIrXFJWl0niy36OX1ik+ADfGqnKrCsx44td5biYt4oF7
         7zCC9foTdq1/FwOsXg/FFK1iKR6hLwcWjNMc9dX/xQy4wNdBluXrhnKcnT1WDxePNRHJ
         Fie6/qVNoLMIRs8zatryJsqhcf42J3c0DS7UgHwl2Q8d9tteEp/iBY83DVVUP++m/uch
         vBEHRzJsaIgHaF5kY+PUCJor/YrlrrTx06Mc5+NQDFdk+BhmBqG98wsKsxmUNi1kgSWq
         897A==
X-Gm-Message-State: AOAM530FGeCMpqh/Moo7H26q6eQMf/+LmBROZdGW6uuaE8NEnO5nTXjC
        5XHx/qlnbWh2Ho1CxaAePIRdzw==
X-Google-Smtp-Source: ABdhPJyAxOuHg2URVuHC+jimTZWS1LiW7Emf4VAMdCY4cZbKouFnP1AwkorvJL4loRoJnKog8rBFzg==
X-Received: by 2002:a17:90a:a401:: with SMTP id y1mr19581498pjp.204.1590983965720;
        Sun, 31 May 2020 20:59:25 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id d67sm13009872pfc.63.2020.05.31.20.59.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 20:59:24 -0700 (PDT)
Date:   Mon, 1 Jun 2020 09:29:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: sh_mobile: Fix compilation warning
Message-ID: <20200601035922.5eovt7yt2qcokglo@vireshk-i7>
References: <f526f90ea62741716de2ecfa310ba22d8cf1d3c2.1557377015.git.viresh.kumar@linaro.org>
 <20200529121245.GA20272@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529121245.GA20272@ninjato>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-20, 14:12, Wolfram Sang wrote:
> On Thu, May 09, 2019 at 10:13:46AM +0530, Viresh Kumar wrote:
> > This currently generates a warning:
> > 
> > drivers/i2c/busses/i2c-sh_mobile.c: In function 'sh_mobile_i2c_isr':
> > drivers/i2c/busses/i2c-sh_mobile.c:399:26: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > Though the code looks okay and shouldn't ever use the variable
> > uninitialized.
> > 
> > Fix the warning by moving the code around and getting rid of 'data'.
> > 
> > Compile tested only.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Tested on a Renesas Lager board (R-Car H2). Dumping register sets
> produces identical results.
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> And code is actually cleaner now.
> 
> Applied to for-next, thanks!
> 

Almost after an year, wondering on how you reached this patch now :)

-- 
viresh
