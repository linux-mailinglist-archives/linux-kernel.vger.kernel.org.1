Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5862A9464
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKFKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgKFKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:31:50 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F9C0613D2;
        Fri,  6 Nov 2020 02:31:49 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t11so717932edj.13;
        Fri, 06 Nov 2020 02:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8N2IRuQnolyQXy5yxaGIniNO8dc/B+5yGSA8aD4EoDE=;
        b=lHdUzkWWoaJfy2mGDpg1jn0up1rtpy2t99CMXBhJL1ybYmJ6qBiRonnd51l4uq9mYX
         0JNsxZ7a2CRcRDyqEIIJyclvj5m25kmBT1VF3N4ombJSB5m7h7fItCOZWW7buXm1oikF
         OGj1S/C1CYzDl2kGumLca52COUsUUNDUfu0SAEYvxipKbSQHhsemsHy2bSwfODyybUJm
         RnA7VzNHGmVAXkVO1cIuP6MyyImmyVokABJP3JZckjPkImdX86UZgAMUmSvFW2S9MIYf
         I/V9nm3O0T72AmTBG12TA7d5ot11IlFB/e2UCafPCIyelEq35U796axa6y/4C/zIahZ3
         i11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8N2IRuQnolyQXy5yxaGIniNO8dc/B+5yGSA8aD4EoDE=;
        b=k5lmW0kTU+9u4yWuyMqFlBuMIpS2AS0xhysaoKbUNt7/XAoteBZd5o6x/byV/YdWFP
         cpNxpfEXGGtFNhjEC35+94KdUo829MiGiRhHN0xTSGgi68op/dOIP829JNAZyCuTsV7s
         zLXTQRnbwW0GQBPM7i8/dXRDEpVWoAYGQ9agYzlp5tTC/nJfTMBx19+ArSvaS6kQ1hXl
         xZG7NRKrrQi0vkZTiQoxk1stnRA757JBArPC9f2cVDcyLLSXygUxrzHKlWvFJoCwJa6B
         eO2Y5JszUjOpCU6xZLs0IxT6qz9WvSNvVnknMFEEjyIs6h8SN9h0ertJs9/D/XyjgmoX
         zufQ==
X-Gm-Message-State: AOAM533fJD4w4L++Ls5nMi6Qf1NUqjQeEUCHoqA9jEWTSLQLIDsFdBON
        kzfEeUDnUVDIrbs3qJd9WLY=
X-Google-Smtp-Source: ABdhPJyaxlIgpDc5iZtEuHYd7wHXieGcPotHQWuNpR/PKHxOBenTH9q0mDqniOxjNPY0Lfu5XaEisQ==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr1277712edt.141.1604658708559;
        Fri, 06 Nov 2020 02:31:48 -0800 (PST)
Received: from felia ([2001:16b8:2d20:9d00:e580:adb5:1ef:950d])
        by smtp.gmail.com with ESMTPSA id h4sm696552edj.1.2020.11.06.02.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:31:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 6 Nov 2020 11:31:46 +0100 (CET)
X-X-Sender: lukas@felia
To:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] taskstats: remove unneeded dead
 assignment
In-Reply-To: <6ab2415b-0642-16ee-4be0-c909e07e7565@codethink.co.uk>
Message-ID: <alpine.DEB.2.21.2011061126130.20338@felia>
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com> <6ab2415b-0642-16ee-4be0-c909e07e7565@codethink.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Nov 2020, Sudip Mukherjee wrote:

> Hi Lukas,
> 
> On 06/11/2020 06:22, Lukas Bulwahn wrote:
> > make clang-analyzer on x86_64 defconfig caught my attention with:
> > 
> >   kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
> >   [clang-analyzer-deadcode.DeadStores]
> >           rc = 0;
> >           ^
> > 
> > Commit d94a041519f3 ("taskstats: free skb, avoid returns in
> > send_cpu_listeners") made send_cpu_listeners() not return a value and
> > hence, the rc variable remained only to be used within the loop where
> > it is always assigned before read and it does not need any other
> > initialisation.
> > 
> > So, simply remove this unneeded dead initializing assignment.
> 
> Might be better to remove 'rc' completely as it is only used for the if
> condition now.
> 
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index a2802b6ff4bb..63541f1ae04a 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -113,11 +113,10 @@ static void send_cpu_listeners(struct sk_buff *skb,
>         struct listener *s, *tmp;
>         struct sk_buff *skb_next, *skb_cur = skb;
>         void *reply = genlmsg_data(genlhdr);
> -       int rc, delcount = 0;
> +       int delcount = 0;
> 
>         genlmsg_end(skb, reply);
> 
> -       rc = 0;
>         down_read(&listeners->sem);
>         list_for_each_entry(s, &listeners->list, list) {
>                 skb_next = NULL;
> @@ -126,8 +125,8 @@ static void send_cpu_listeners(struct sk_buff *skb,
>                         if (!skb_next)
>                                 break;
>                 }
> -               rc = genlmsg_unicast(&init_net, skb_cur, s->pid);
> -               if (rc == -ECONNREFUSED) {
> +               if (genlmsg_unicast(&init_net, skb_cur, s->pid) ==
> +                   -ECONNREFUSED) {

I thought about that as well; and I did not like that because of the ugly
line break in this condition.

I did not try but I bet (a beverage of your choice) that the object code
remains the same also for your suggested patch. Try to disprove my claim 
and possibly earn yourself a beverage when we meet...

Lukas
