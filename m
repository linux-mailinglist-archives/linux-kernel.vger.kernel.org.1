Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841DD26290B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgIIHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgIIHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:38:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A81C061573;
        Wed,  9 Sep 2020 00:38:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m8so1467861pgi.3;
        Wed, 09 Sep 2020 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nNv35u1ldXzOEKenltQUlGYnPVKRgGyBIl7aYeHbKY0=;
        b=Hvk45Jt+K2CExex1KQEe7xijNtxPDH900J+LbezL+idLn6L7Z5GV6Gdp/Qio1t7BBv
         ZlRWBjJ3NuxH1Als0iszlmnIDTJNynFnbc4XsbMVhOj745QKNUaVGPtbpwMGWEhInqr8
         9bwLAQUuiQWLJJWPLBA1WvsNALpxUxLGCylKXkXanocyf97PLW7MMfIVFzk3lxFOGYqG
         BAS79CU0LAc29/hoWg4nF6i8NWLXCttOpMarR01kSp/MmOlm1Z83Ue0EO/PTpaEnH8A1
         gv8C44sg52k2IKEX8iEo0H3FBm1R7b6+U00SIearqMWLoO6GUAIG0XyKzkj7X7CuEAXt
         Pouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nNv35u1ldXzOEKenltQUlGYnPVKRgGyBIl7aYeHbKY0=;
        b=W5e+4WowWaCyEX0YUPYSXi+wYR+G6QQD93vXIei6P1Owqb99jZorMIFFwq32f4vGjv
         Ee6vM27MQ0cQayg6GXx9vFxgWZvPCzfYjLGfu3Appw0cZ6I1Tutvtsy8P61iOC1gZQS2
         NnffYvL2TdfmPL4xHTyusUzlsGjmiDe9zGTIaruQaZLPY5/QMjV0Y4DFkg3SGgJoPhEo
         FAhd/VkfQUDR6vdF54KTRj21GteBwAUpYTHPLGA/NKxIexZpSt9ZCvAZU2PHNGIMvmri
         i/ItsFKY+650f7UNEEox7b815Fs26eWF4F5Q5DhA3UHK0C3NLToreX0XGg071TO8iRxY
         VIyA==
X-Gm-Message-State: AOAM531m39CYCBHw7Sdd83wvo31S34WkG30KGH+dCa633tsj+C1mb3P9
        +EBg4ovaWICiQlYeEqAvl0k=
X-Google-Smtp-Source: ABdhPJwsjfw30kgxWLkWH0FSYkSjPrI7Numm+JV/jM7fOZPTD7AjKnHY1CCZhtaVU/77wx21QRXW+g==
X-Received: by 2002:a63:4f26:: with SMTP id d38mr2019642pgb.72.1599637122985;
        Wed, 09 Sep 2020 00:38:42 -0700 (PDT)
Received: from adolin ([49.207.200.122])
        by smtp.gmail.com with ESMTPSA id s8sm1796012pfd.153.2020.09.09.00.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:38:42 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
X-Google-Original-From: Sumera Priyadarsini <sumera@adolin>
Date:   Wed, 9 Sep 2020 13:08:36 +0530
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH] scripts: coccicheck: Do not use shift command when rule
 is specified
Message-ID: <20200909073836.yrsqb6o4i3c47xd4@adolin>
References: <036792a4-0454-732a-8a0e-83123713445c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <036792a4-0454-732a-8a0e-83123713445c@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:52:19AM +0200, Markus Elfring wrote:
> I find it helpful to avoid typos (like the following) in the change description.
> 
> 
> > … Makfeile. …
> 
> … Makefile. …
> 
> 
> > … paasing …
> 
> … passing …
> 
> 
> > …, resuting …
> 
> …, resulting …
> 
> 
> > This patch modifies coccicheck …
> 

I did make those errors but I also rectified them. This is strange
because my commit message shows the rectified version.
Either way, I will send a v2. Thanks for pointing this out.

> Would an imperative wording be preferred for the commit message?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8#n151
> 
> Regards,
> Markus
