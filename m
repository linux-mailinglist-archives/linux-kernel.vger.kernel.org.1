Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9E22BA08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 01:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgGWXLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 19:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgGWXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:11:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37179C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:11:43 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so6544199oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VYyVyx7yovkjycsaTkx7hlbmqO5yCk7NHwwjU5rwd9Y=;
        b=ehcBOTHT4yiii4tgvJJfpHNVbsyQEcDBLieJjsvPHE09Jc0XpP7sGCrlPE+EmHdei0
         YAIYQ9tYJGfRTDAdI6wowyl21gm6DyMbFi9BeQXsM4balelQ1Z553HjCkYSD9LrJQU8F
         GzbhlCoMvul+ak2MrFuFunDWo8vzv0Ym3rrk+IC/0Lc+zndqoUm/U00XFQppXO+vCxhy
         ajlGD7Z7E86P0ArbKEwl9wwLMGPm0MUfcieAbN2uBHz/2turwTEwaUAkDtVPHLFYUMWu
         IyrZ2ASZK/QSAV15vvQYCl0VolqqrpC9a0GucJ+Z8KyeHiDYzCJaO015LPM0B07/+Sxa
         lp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VYyVyx7yovkjycsaTkx7hlbmqO5yCk7NHwwjU5rwd9Y=;
        b=T+CfgTYZnslBCrxfolgk+82iZJSSoyBhoXRgrkT2f2XDPzrG0v4pmfjUvtb902TVG5
         d3zltS9vQ0YeCyjI22STd2AukKwNZMHbDqAAExXiiHlAlmafGWAeSQ+tKYx2U1hXg/9z
         jO48BzyFghbBlsV4+ldNkmbpFGSf/L6TjlhsPJKD5tZdjeodFYpsFfh0fGK4L4m4vZp6
         tFp5+q1U0OhTR+/MBwXlGCUDvky4jjGauRgQ4ltf5yb6DF2Ia7mdrSKUI4219F6lmuT1
         i8ND80f8OeGxJajp7HhtBCvwh0lmjFq5sa3DDA9yE7z+dckZxXlbfriEyN9LtX5uFCH5
         jnYw==
X-Gm-Message-State: AOAM530+ow81snrjOCD2pjdgHHegHSfEJlp61WORze6pZj79ahfnG45P
        kxLNJTJ+afr0vleYIPWoINd9Kg==
X-Google-Smtp-Source: ABdhPJyICL8bD0C+xYcrw9YKR/nEo2l025VRHU/xLRKffI0eI/ccnkXzzzjzeOMLJoTLd/K93kM2Nw==
X-Received: by 2002:aca:dfc1:: with SMTP id w184mr439503oig.79.1595545902189;
        Thu, 23 Jul 2020 16:11:42 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m13sm925823otf.43.2020.07.23.16.11.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2020 16:11:40 -0700 (PDT)
Date:   Thu, 23 Jul 2020 16:11:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Oleg Nesterov <oleg@redhat.com>, Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com> <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com> <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
 <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com> <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Linus Torvalds wrote:
> 
> I'll send a new version after I actually test it.

I'll give it a try when you're happy with it. I did try yesterday's
with my swapping loads on home machines (3 of 4 survived 16 hours),
and with some google stresstests on work machines (0 of 10 survived).

I've not spent long analyzing the crashes, all of them in or below
__wake_up_common() called from __wake_up_locked_key_bookmark():
sometimes gets to run the curr->func() and crashes on something
inside there (often list_del's lib/list_debug.c:53!), sometimes
cannot get that far. Looks like the wait queue entries on the list
were not entirely safe with that patch.

Hugh
