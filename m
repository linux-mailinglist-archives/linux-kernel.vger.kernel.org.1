Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85E328972B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbgJIUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388755AbgJIUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 16:00:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C3C0613DA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 13:00:33 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t6so1236028qvz.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qC/FqQbzG5/8jBosr6Y+NLl7/pG/587C+U8/pqT5iw=;
        b=RRUTeULREpVOpNCQWXgAIZtaaHU8E5Qq14J1066Xjyg4JyW+HUwF9cBse1Bm1R4yvF
         odnAPK0J/+XH5En6zvKFETGOP1FMbcrshZcR4wRbd0JMtk2CJfn9aGg5UNteTQysd1FJ
         S3euxOGxf2xPj1vwUUU2L+IztRLTks0tkt1bWKWHHOCklQliwV5W67dfYAWKVunbtxfi
         j28syp4AXrV/3kw8gQNOTUgNLA6WjIhFU6TNExHEV6kET3+rFz5mYpN+8kd7pWnBwVoS
         zMXfZjguwobHwKpMm5I/i8fOhAeRaU4YfcBNFouYTO3atevtpgWq6lDkTu7XR39ArfeS
         YDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qC/FqQbzG5/8jBosr6Y+NLl7/pG/587C+U8/pqT5iw=;
        b=gB7rQNBjZIi/2qzZvbXOhAbOjMvaR8teGHrwozRsgU7iicKslXgyjML2lFRnlld1nK
         phXgyeWtn6KUM7Uh+vx8tWtEZTD4Paaoe04yt55tsZ4YxpP4zrTMc7vVJ288GKYci/de
         QsXRaqwQGsV6QSbRZGR8+jPaDAyolnR+FBbEIDqPg+mxz3ed/e4S+POlMFrHlKINpz39
         b/2Sgvs33EI/KEQfjE0MtaOWyAbChUXBK40x7iR6GiP8wz6NPwOb+0QIs4BcuxP1Wry+
         1x6uIt5zPknmdVBCQVQUxFmf3BGecl19YFpmnLAJacKuZ6JLER7YYoGeLTAoiAb2HXPe
         SDAg==
X-Gm-Message-State: AOAM530vujI1q+sXM4WuGwAQ2g4D/dbvuegQeQaJtmMeAo/+VnxK8vN2
        EZYSmjgC6tjeDPSid2nLDzyRl1LaxH8UAyrDg8CNOg==
X-Google-Smtp-Source: ABdhPJyt2PbWXX+6xs5+udRRLnk5TTa8q6pvQu2pHMe06wvrZ9hObKg6j7VG+fDE+ZYoNUjjCw7tnImmctdGVpBBmmQ=
X-Received: by 2002:a0c:9a4e:: with SMTP id q14mr14190214qvd.22.1602273632019;
 Fri, 09 Oct 2020 13:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201007193252.7009D95C169C@us180.sjc.aristanetworks.com>
 <CA+HUmGhBxBHU85oFfvoAyP=hG17DG2kgO67eawk1aXmSjehOWQ@mail.gmail.com>
 <alpine.DEB.2.23.453.2010090838430.19307@blackhole.kfki.hu>
 <20201009110323.GC5723@breakpoint.cc> <alpine.DEB.2.23.453.2010092035550.19307@blackhole.kfki.hu>
 <20201009185552.GF5723@breakpoint.cc> <alpine.DEB.2.23.453.2010092132220.19307@blackhole.kfki.hu>
In-Reply-To: <alpine.DEB.2.23.453.2010092132220.19307@blackhole.kfki.hu>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Fri, 9 Oct 2020 13:00:21 -0700
Message-ID: <CA+HUmGidgRqPmgCH=g7+H9g+TZAyh1-2y4qfzfZB3DYtHtjdKA@mail.gmail.com>
Subject: Re: [PATCH nf v2] netfilter: conntrack: connection timeout after re-register
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 12:49 PM Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> What is the rationale behind "remove the conntrack hooks when there are no
> rule left referring to conntrack"? Performance optimization?

That seems to be the case. See commit 4d3a57f23dec ("netfilter: conntrack:
do not enable connection tracking unless needed").

Francesco
