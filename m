Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA62CF696
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLDWHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgLDWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:07:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A6BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 14:06:54 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so3979543pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gori3kUA64YgNU6UBCdbHw2TXtwN2d5yKUIKFTfI0AA=;
        b=moAcN6+ODHOyETjJBqhHDKOFH35pHugAZVIworJx8Bh8XiqNthLTtglxYxCQMcgD9t
         EuhEIrf5nys/mrqLdGSAeWPGHhgA2PGTdFkRkwfmcnnD9gFDUqc6ZiIOgqz320yBsIjF
         eDE4NFjkwKX2C7oclt2PA12CfOEDMnZhd4Vkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gori3kUA64YgNU6UBCdbHw2TXtwN2d5yKUIKFTfI0AA=;
        b=Yj//EKbBQWLPJlDL/BK01wjsdZUCtuECXvXqgmlDFwBtbv5t/rDzykzMu/w7Llg6CN
         jEz4dBBKtesTpSkyC5FOFJRbVbApBPBKn7ZWvglYnlbixw1C6ciQiEikC63kXRz5Tpf9
         pnY08VobS/+vcPiz/oxXdxHfRkUnf3e1c02oF1g1mcdADWOR9zCc8Ts/dVYdMMNPUpbg
         75hmD4jix1LOeGRz2SVZYaazarME0wQaDbcZH80p544WGXsXqdkA/YYXHIeKh1adQvhJ
         oEHkdlCbhUc/LLnDmgC89fyuoDt7QHighnCBF/7LOqu38hpl1incKYN5I3/y3qo3J03q
         LKKg==
X-Gm-Message-State: AOAM531qcy7+CVLvPKNMzTtSynHeL0RWcDIpebdG3oRHt8YJP2OsX/VB
        d0DLEGRnXq9NWqp1essmiJNZuQ==
X-Google-Smtp-Source: ABdhPJz7QSFylPAL05DlClEVzxlehxj1vIt6CBLVjFNfrVgwlmbSrF2SLY1xtozHZOjTroYefQocwA==
X-Received: by 2002:a17:90a:3ee3:: with SMTP id k90mr5882162pjc.164.1607119613927;
        Fri, 04 Dec 2020 14:06:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm5622902pfe.30.2020.12.04.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 14:06:52 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:06:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Emese Revfy <re.emese@gmail.com>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-plugins: remove code for GCC versions older than 4.9
Message-ID: <202012041403.792DE050C@keescook>
References: <20201202134929.99883-1-masahiroy@kernel.org>
 <202012021101.E0BAFC3B@keescook>
 <CAK7LNAQxS2Zn3O4Q0Ca5KgoyEwW5_5DtPDZoXAH+dxbki7dmLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQxS2Zn3O4Q0Ca5KgoyEwW5_5DtPDZoXAH+dxbki7dmLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 06:35:38PM +0900, Masahiro Yamada wrote:
> On Thu, Dec 3, 2020 at 4:01 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Dec 02, 2020 at 10:49:29PM +0900, Masahiro Yamada wrote:
> > > Documentation/process/changes.rst says the minimal GCC version is 4.9.
> > > Hence, BUILDING_GCC_VERSION is greater than or equal to 4009.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > Do you want to carry this in the kbuild tree, or would you like me to
> > pick it up?
> >
> > Thanks!
> >
> > --
> > Kees Cook
> 
> 
> Please pick it up.

Sounds good. Thanks!

Also, Emese, I haven't seen an email from you to LKML in almost 3
years. If you're interested in staying on CC for GCC plugin stuff,
please let me know. If not, I can update the MAINTAINERS file to reflect
reality. :)

-- 
Kees Cook
