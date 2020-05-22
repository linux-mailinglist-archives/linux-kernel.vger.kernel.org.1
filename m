Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA21DECC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgEVQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 12:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbgEVQHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:07:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA05BC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:07:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n18so10339187wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y8G8Cr4f4rfT3qP9XB4YsQxMGrFdw5kv2bwKIhECzEQ=;
        b=M4S1re4IxtPB4uz7ev2Dxi7XhWkpEpK0oyeu145VKS2QUzgc3VYvczjharT/1XPRWX
         Et8KJeKKitNjWZGKyyedEkWN49FRMRBvBR++WqCTelcUVxMV8vwu0HsHhLO3wZre5+al
         b5pUXEN+MFggE3NV0E0usghAsmQGLkxLoFv3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y8G8Cr4f4rfT3qP9XB4YsQxMGrFdw5kv2bwKIhECzEQ=;
        b=NxhAoy+2Fd/To5bPx/JcZKPNaL7kDfanfYQksb2+Z3DJvO82lZMRmefvTMPs5gpXNZ
         goSIhNzfIJy+pGSyEajKx8ak4nGs6GyRXjMcLCLhcUdwdiWTfTBs4gTIjExcqTD6U6Ho
         6A7ypeStCelhBLYBPse6Y1g9bfZozYcptrKPDuCPLOznQcP27cCLSsgdniOmteVEzD60
         d9DQEwb7taRbQ9f6BOV4KkCF0wE/ShuYhtlIyG8S3GJZeWuZjdlCDXUcJY6JpdO7DtPI
         7GFA7vQUEpd7du5hsnYvrYLldU+3NBj4e7Dwekbh+Ukc49piA/MgJ/eAU1z3lOx3yWgR
         ECpg==
X-Gm-Message-State: AOAM5338Eiz04PN0+ld6ykj0/GDfDIoqZlj5LsZr3UE7qijJ6pXcAn9l
        dIIIiNeTZ18D/Nv1Eaul5QcZfQ==
X-Google-Smtp-Source: ABdhPJxFSX/gaRvSszmQKzOfUmtK2r22sJfM5mZo8Np+pY8SmZbaq+y+alKsx7j8XX+Y8tYyY+XbdQ==
X-Received: by 2002:a1c:6708:: with SMTP id b8mr3497093wmc.40.1590163630570;
        Fri, 22 May 2020 09:07:10 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id b145sm10712934wme.41.2020.05.22.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:07:10 -0700 (PDT)
Date:   Fri, 22 May 2020 17:07:09 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
Message-ID: <20200522160709.GC1112005@chrisdown.name>
References: <20200505084127.12923-1-laoar.shao@gmail.com>
 <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
 <CALOAHbBTt1pMo0kwheWqPfU7RTXcDHWJ-x8=5mpw327uiy2qzA@mail.gmail.com>
 <CA+G9fYtmpjunUetTmf2yquB1rwZA+nnWOiueWbAMx483c0wUvQ@mail.gmail.com>
 <CALOAHbCdXrU1AeLd4pWubutuG6HP4xKvxRkXeOv=sd_MMW58rg@mail.gmail.com>
 <20200522160626.GB1112005@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200522160626.GB1112005@chrisdown.name>
User-Agent: Mutt/1.14.1 (2020-05-03)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Yafang Shao writes:
>>I will do it.
>>If no one has objection to my proposal, I will send it tomorrow.
>
>If the fixup patch works, just send that. Otherwise, sure.

Oh, I see the other reply from Naresh now saying it didn't help.

Sure, feel free to do that for now then while we work out what the real problem 
is.
