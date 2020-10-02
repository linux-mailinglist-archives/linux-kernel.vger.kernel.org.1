Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD14281401
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbgJBN1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:27:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A9C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 06:27:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so1127891qtn.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zrpmNv9TwKzBwkVfbm5DOPz5PI+5NOjhq3Gy3n1KaMg=;
        b=Rd2A/Weuc+n5WsaDOpKuAiVOCTvh1UKrmHrmyJbGKoFiQz/LW/SvNo+v4+f7sKmCT7
         Id4WyMVvSTH8unM3e+u6wRqu+AF7Dm/RP4LkDzDjqQJbAbiNJ1Ljx3+QLOLEBXDE2O7n
         POdrPxccPfAYA4RXPI+x7zUMLyU6Hv5z4vfGuBxlP02x9Yo1xHD9EzDO7jfeaYzoabdY
         FYI5+8R0g1e0DjA0n/KGkn3miYtkTq4lITpne0IdguBLjyg+h/EPDTeDxxNB+fPDkKxq
         gjOwy6yjUA31e7yN6fx+JJG2iJ/L+re3SBOrNy4Ik3pC+VnnT/Xmv+K2nfxn4qNipul3
         uxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zrpmNv9TwKzBwkVfbm5DOPz5PI+5NOjhq3Gy3n1KaMg=;
        b=f/Nw0nOcRtFZfa4+ohw38ePvWw46pvYJokDS2dDz+ENqVLdn/IoHQN9pEoCCSApErT
         TG1XpQhvW7HEBUF/szSyZwWBvZHiX9AdmEauKelKEvLScyiAEvtT5HDm4pqGgjP//olI
         QuBs34FB5IRmdI3DSoi/vdlk6vwbQSmh46PtHEwC7laO8q2Ls5XJbdb4KkfuEKX/cwXj
         r8Be6bD+NGsR6e5ZPvTfROWleRsrsoqJtFleWb5BRe7tE0x0fAtsmnBplV1BDJkr7L2r
         XfB704TEmbUVPN48RMdUumzVBMo+r1uEGuYcfU4iEmYhQ6u5+qK48HigkprVG75lZj8K
         aoSQ==
X-Gm-Message-State: AOAM530Rt9cPlWa+/0Vv/heq5kZT3xu68z5uIAFMlSoDZ9kgZ4LAUXVz
        6o8DIKD4kdlmGhqIer1SxWknSQ==
X-Google-Smtp-Source: ABdhPJwlVwM9MAnCLAE0xRO4pwEYKddVvRYLA8GvopEROKXDbMOwOrms04uggw9W2U/fDnQvNTYMaQ==
X-Received: by 2002:ac8:7613:: with SMTP id t19mr2283473qtq.259.1601645259959;
        Fri, 02 Oct 2020 06:27:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d668])
        by smtp.gmail.com with ESMTPSA id g188sm1064288qkf.3.2020.10.02.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 06:27:39 -0700 (PDT)
Date:   Fri, 2 Oct 2020 09:25:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20201002132557.GA525590@cmpxchg.org>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-5-guro@fb.com>
 <20201001170036.GA29848@blackbook>
 <20201001172713.GA500308@cmpxchg.org>
 <20201002100350.GC24008@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002100350.GC24008@blackbody.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 12:03:50PM +0200, Michal Koutný wrote:
> On Thu, Oct 01, 2020 at 01:27:13PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > I do think there is a bug, though: mem_cgroup_move_account() should
> > use WRITE_ONCE() on page->mem_cgroup.
> If this were a bug, wouldn't be the proper approach
> rcu_assign_pointer()/rcu_dereference() pair?

Yes, you're right.

I'll double check these code paths and follow up with a patch if
necessary.
