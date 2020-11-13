Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF692B1456
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 03:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKMCib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 21:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 21:38:30 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A6C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 18:38:30 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f18so5877882pgi.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 18:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXjxCgHK5N9b7zzP9uVKvCwz6iy7qRuYMGOTQFwiuK0=;
        b=hJSD8MUUOWmrgT3ZO1i74rKAD7OM9oMVNKeyZ8medGAkyh5PFi6CM0+2ugX3bXolRN
         tyfUnhF0JFIeMRGdbeLVZQwiGSLoYwEkcw/q1EeEg6FFbUv1njD6fcTva+VIlFw3gLJj
         RVIZnwoVqwrziJaGSsRQU1d2EhM0/b/rouNXiCEDJr7cEADdbu/fU0Z7LbpgVT7KKuiX
         0My/9svSseJHm2jBOewY3KMQKy4PcFFV6FNQKmFfn03+AfyhFbSWJWFH6DFRVZeCGG+O
         5F378hWBKvdAAD7n/C4dK0Q23CN36cr5+QH4moTrBBEviybNpH9NXAuRcXCnSyTbPH5G
         qxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXjxCgHK5N9b7zzP9uVKvCwz6iy7qRuYMGOTQFwiuK0=;
        b=VMePkPkUy8x1L2huP4TD/eOcwUCnVQJJSPDo3Tmg44K4S6b+FuofUjz9trM6ZOMYES
         20ktnep/ltm5FRYHXsp9XP03uufKcW7NsMBKceUljw3BbwoXkwkEws4x7W/ggGflRVOz
         7ENx5pUfSe3frbIWJ49Mwd+ogUohUl7aQwpcoKs3EBL/A2u/AhqzOySKHXK7+lZ1Bmsu
         ej78FPnxPLvf0Dh5fGPh17/NA9NbqJDLdehXjtizNOLBg6MViOAs4hEgpi4hEh6HgM5T
         6ZEJF6xBgLluAqjZQJRSXCQ2HrtqLYYT8Z6/lFDWpZWcBrG20OTT60qVaETh+HrXZsO/
         7gCw==
X-Gm-Message-State: AOAM530kEfuNf60TpH1hu7a7nnmg7CQZV9z1hkFGkebhOSlM6QZzUMx/
        bwdNjFGTUseyx5XrX/7S7nE=
X-Google-Smtp-Source: ABdhPJx5oncmxeMZ4Mo5otq4CFSWPnxxK8Yj2CFB8esC8Y6Td0xsvZxHxlHvy0K+nUogVlmRFImbyA==
X-Received: by 2002:a62:8749:0:b029:18a:e2c8:a089 with SMTP id i70-20020a6287490000b029018ae2c8a089mr109524pfe.13.1605235110396;
        Thu, 12 Nov 2020 18:38:30 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id w63sm8061778pfc.120.2020.11.12.18.38.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 18:38:29 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:38:26 +0800
From:   sunjunyong <sunjy516@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ttyprintk: optimize tpk_close flush code
Message-ID: <20201113023826.GA23209@mi-OptiPlex-7050>
References: <1604469744-8708-1-git-send-email-sunjunyong@xiaomi.com>
 <X6zptw9Fbd3AKbPy@kroah.com>
 <20201112134122.GA20821@mi-OptiPlex-7050>
 <X61uGxi32JqMsGWl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X61uGxi32JqMsGWl@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg:

> The call to flush makes it obvious, no need to keep it.  And we have git
> history for people to look at if they are curious about past versions.
you are right. I would remove it in next version.

Any other suggestions ?

thanks!
JY.
