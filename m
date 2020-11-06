Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52CB2A9640
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKFMiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKFMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:38:21 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DA4C0613CF;
        Fri,  6 Nov 2020 04:38:21 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so366664wrx.5;
        Fri, 06 Nov 2020 04:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oJeBlvI7pAnkAsw70khux5ZoE/B4WwO2O42ItTpncKs=;
        b=WAJEZpwwyivZPgyV6gkLhK0Y/cm6bIad7kY58MOOTMAbjJoZKo0iDiFWuKcjli0joP
         gc+bfTLQPAg9SP87socW83t/aUHOoTR5RkwijNPW16vWWKOF6rzrZiJYpQvdwZ+wsgGu
         D7rOJMI/NojscP1nzw2xfqEZ81UmtOQSOGOfRKz5Y6gTgtZqESPFkj3QG5PhGjv5d6Cn
         uKNrf3voJrN3tlytYswcULxhhRXwFCkKmGS2/UZwTyRjZrUyzQz8RqawV8qq70IoNrqd
         F6bbtQl8r+roONbnTq6cfe03thF20gW839OV3v7rCEGQDuBGD8D9ci+v5VSxgZnPoSVn
         XUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oJeBlvI7pAnkAsw70khux5ZoE/B4WwO2O42ItTpncKs=;
        b=GdLUE+dD9qvhoenjwCcNTz04gYLJO5RQUNyxm2u4ExHQvlUoCi437QeecI+xriSzL1
         z5+2Dd1zMZmw/2WdF4FZeZlvQ8Yt5z8bGU4dcg2U7yc1EOKi188o+UnFBsi6Bec6xTSG
         0L2o7DITft9n3U+Xkek0nB8BXXSWeaJT+QfOGaqtPh0XiCLCzhn+GxOK1oK5MBXD8Lf9
         7eXbJYZi3NQRZuPS2LHU+ZnRdEwznE2FiDqk2lqYwCp6vrV+FoP0I5Dy5EcHox88E5L5
         qWEFhX0TruvzVtH5unAJF47kpUAiRHaOevuwa8S66wprF8tVwULxv5opmWqsdWuuGHy+
         Nxlw==
X-Gm-Message-State: AOAM531W3BBfVl/jg2YWuTF1wKBgz3Uso2pXfM9Plr2lMG55XXZ0hTKU
        onOUGZD5O8XlP+vpMcZMeEI=
X-Google-Smtp-Source: ABdhPJzlriX3iwt1mvdV4n7Fm1xf5GeKZnsqhivtwgEd646SLG0R7IIo49K7n1ZP2ZMZwzI9QXBiww==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr2375463wrj.328.1604666300066;
        Fri, 06 Nov 2020 04:38:20 -0800 (PST)
Received: from felia ([2001:16b8:2d20:9d00:e580:adb5:1ef:950d])
        by smtp.gmail.com with ESMTPSA id j9sm1924110wrr.49.2020.11.06.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 04:38:19 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 6 Nov 2020 13:38:18 +0100 (CET)
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
In-Reply-To: <aea9d12d-88ee-f262-4328-03993521668f@codethink.co.uk>
Message-ID: <alpine.DEB.2.21.2011061331250.20338@felia>
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com> <6ab2415b-0642-16ee-4be0-c909e07e7565@codethink.co.uk> <alpine.DEB.2.21.2011061126130.20338@felia> <aea9d12d-88ee-f262-4328-03993521668f@codethink.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Nov 2020, Sudip Mukherjee wrote:

> Hi Lukas,
> 
> On 06/11/2020 10:31, Lukas Bulwahn wrote:
> > 
> > 
> > On Fri, 6 Nov 2020, Sudip Mukherjee wrote:
> > 
> >> Hi Lukas,
> >>
> 
> <snip>
> 
> > 
> > I did not try but I bet (a beverage of your choice) that the object code
> > remains the same also for your suggested patch. Try to disprove my claim 
> > and possibly earn yourself a beverage when we meet...
> 
> Lets decide which beverage.. ;-)
> 
> Using gcc-7.2.0 for MIPS:
> 
> original:- ab81d3305d578c2568fbc73aad2f9e61  kernel/taskstats.o
> After your change:- ab81d3305d578c2568fbc73aad2f9e61  kernel/taskstats.o
> After my change:- 0acae2c8d72abd3e15bf805fccdca711  kernel/taskstats.o
> 
>

Interesting, can you share the diff of the objdump before and after?

I bet it found now a different assignment from variables to registers or 
so; with the beverage at hand, we can then discuss if that is effectively 
still the same object code or not.

Thanks for confirming that my patch here really remains the same compared 
to before, even on MIPS :) I only checked x86-64...

Lukas 

> 
> -- 
> Regards
> Sudip
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#148): https://lists.elisa.tech/g/linux-safety/message/148
> Mute This Topic: https://lists.elisa.tech/mt/78069241/1714638
> Group Owner: linux-safety+owner@lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [lukas.bulwahn@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
> 
