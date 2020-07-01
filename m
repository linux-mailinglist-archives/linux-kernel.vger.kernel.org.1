Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12D210603
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgGAITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 04:19:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35695 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgGAITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:19:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id e15so18828503edr.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=thbUP8KbOogeqAEdzq644Nq9+Yx56Jb6fhYA6UnFTDs=;
        b=DcJq6UDwAkFZXyDd4sxK3n1EazehLvdrmD1MaeL0POhAOkv/1Urj0qvYNur1hdWcgE
         nrWDkiteol9LkLu3KUPypJopsGOSbDYLTjG4OgIrlgaY59sqA/lPzDJR950YvbxD1xOr
         qj/XOmXhFnl//0Oxauztw5E72VQfpM3vW3nuzZ9W32IHUt4GompMjHgvw8bxM3ZUGho0
         jeX0mhWWihOTnlSRBotBXTLk0sL0322Yl7Onc4DB6zDpsXTgomSWqpzDxYB/hBG/WDsD
         ZWsLkvq8Y9cx/5/e3gbJqKq01MJ5+5sHwItpEeUbeHxoB2OxWO8XsdkJArKTXY3m5FQh
         OKLQ==
X-Gm-Message-State: AOAM533GbZJQ6TCgkpQMEwUnoMWpMcJDDr+zo9K4GZNrbE7mmiHEuOJA
        5Vsxvq+rsd2wjESvrjoswIjoj34A
X-Google-Smtp-Source: ABdhPJwur1+7K8jfjciMaTh1Q1nX6ZIJsSyfVDTVFKntMDoCtbOJ+EapOxRLydxpvqxlKyEk9DQ/hA==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr28057806edq.215.1593591593695;
        Wed, 01 Jul 2020 01:19:53 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id c15sm2061538edm.47.2020.07.01.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:19:52 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:19:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PANIC: mm: memcg/slab: percpu_ref_put_many - Unable to handle
 kernel paging request at virtual address ffff80096d78f000
Message-ID: <20200701081951.GL2369@dhcp22.suse.cz>
References: <CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-07-20 13:24:54, Naresh Kamboju wrote:
> While running LTP mm test suite on arm64 Juno device the kernel panic
> noticed on linux-next 20200630 tag.

Can you try to bisect? The new memcg slab allocator series sounds like a
potential candidate. One of the patches has changed the memcg reference
counting which is showing up on the stack. This might be a side effect
of something else of course but bisection would tell us more.

Thanks

-- 
Michal Hocko
SUSE Labs
