Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D055727B2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1RN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgI1RN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:13:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601313207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzQTCyovgCSHNssns7ubkEo1CFFnZWpp62TbhfNMAPE=;
        b=Jd7MejtQbvhWtGoGQLC7/YRs5d6rJELscTwkC4jshG88kIPwZCgKcjjSmVn8O7X4gng+sq
        1ERHb4cdEgzISUBpk8u/A3GSCIxt7DVZO2s/mr1VPFADg4hxzEovfHREniNiNn8t5ASs4D
        LTX9W5GXKk5/3x90od5jVeefJMJ0P5M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-ZQ3NxP2GM5e8vk3W3AJVow-1; Mon, 28 Sep 2020 13:13:25 -0400
X-MC-Unique: ZQ3NxP2GM5e8vk3W3AJVow-1
Received: by mail-qt1-f200.google.com with SMTP id g10so1141051qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UzQTCyovgCSHNssns7ubkEo1CFFnZWpp62TbhfNMAPE=;
        b=Tq9DKbfMCl3pCFd0Bp3YgeGXvLHJ7lvWgXOX8OHzjsgj2SSTkzpIV+2stbrzMhgBdi
         8DVs8KASYEgFL7NInflHOkfXSEsyktmHQx3X4xxrRtRvBVd9PPaZtKnW8eqwAToPObK2
         pHo0kVusVxsa32BnNlOBTr7JbRYxtchZ56Sqqh939BRi3IxH666KR5ZFOi9rXkilHKQD
         OygFzXGzd8r2emK0QcqPoB7V6hD8BU9lRlTD5kHG67RrkBl+dle9icqQmY8DY2NxJH2k
         zxw4omhQ03zsK432hR3zjQim6BPs15M1L4hn4AK4mo8MMHARArwkJ7RqX1LlNE1Wp5zf
         yEBQ==
X-Gm-Message-State: AOAM533ix0UbwtVPcEq3rD+mF+Vj7j2bbrlJ3fLWHpXrInetBggaqOHC
        7nVRfLkuCps78ik1DahOZL2J8Dz977mZWVuoGYJrcC6QHtR0vrzWfgDFG6adAMXjF09R4ygIVCn
        ucVsZnC0x4fv+qFe853A9yWmM
X-Received: by 2002:a37:67c2:: with SMTP id b185mr428183qkc.366.1601313204604;
        Mon, 28 Sep 2020 10:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8V0QTYYkPQmLtfyIlkETX0gJaSvH40Uw2u573hFkYNil5ggvnca1qt9qmtZ+05ikBg4cfqQ==
X-Received: by 2002:a37:67c2:: with SMTP id b185mr428149qkc.366.1601313204131;
        Mon, 28 Sep 2020 10:13:24 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id g12sm1647356qke.90.2020.09.28.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:13:23 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:13:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200928171321.GA59869@xz-x1>
References: <20200924183418.GJ79898@xz-x1>
 <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca>
 <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 11:16:34AM -0700, Linus Torvalds wrote:
>  - split up the "copy page" into its own function kind of like I had
> done for my minimal patch

I didn't do that majorly because of the wrprotect() (of the fast-gup race) that
can potentially be kept if it's a normal cow.  Maybe we'd add one more comment
above the caller of copy_present_page() (even if we have a "NOTE!" section
already inside the helper) since it'll change *src_pte and it's hard to notice
from the function name "copy_present_page()".  Not that important, though.

Thanks for doing the changes.  I went over the whole patch and it looks indeed
cleaner than before (I also didn't spot anything wrong either).

Regarding the other even rarer "hardware race on dirty/access bits" - maybe we
can simply set all these two bits always when page copy happens and we want to
recover the ptes?  I also agree it's trivial enough, so that maybe we even
don't need to care about that.

-- 
Peter Xu

