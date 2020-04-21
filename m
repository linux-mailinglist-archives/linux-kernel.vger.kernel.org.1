Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B061B1F87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgDUHJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 03:09:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32784 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDUHJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:09:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id s10so6032368wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mnRK7+f6MWldP7sRJPCD/Ckowsyp8lbBNzHdwkravLw=;
        b=e4XlgjwflFvyWWztQvW3O1PIWpz1i7SfPk9LBLGJQ/Buiu3mlj4XUBDz/8qnrgrGSo
         9AKM1uasDc8/lNg6VFRCCzom+Ryf8QtPU/llC2Cbpemm3wFeIDSVek6S72dodJZZmIxv
         s/HYMWW/KgIj6GROP8aMPV2Fim6b6fU4FID/dyDGlH7f0GeAHabX9qsXYTi/OSBXldsl
         KmELDNfuJHpLrXM/mS7VvFW/IoCJ6yDmPuK6zJD8BB0viO3mPv4ePzCPkjYkyT7sqJbx
         /UySjCoGcW6LAf9UI6cOJB/dXjHkmbhxwTxU+yoQHw+lZsxARZGUwr7uzMfjxF4lvKdT
         ewKw==
X-Gm-Message-State: AGi0PuYoTB9XyR34v5WBSaihcuUjg1RHBjTrtDMTXSXshbEKDQ6T3Cqc
        +mU5CwVwCBBzagy36yXOpA0=
X-Google-Smtp-Source: APiQypK1kf31IhHjCW9dEWKg5aIOW+8/ey3O9030weCpGExdjTrK5jo0w5OYWLg+g3P3GcrPaX/Smg==
X-Received: by 2002:adf:df04:: with SMTP id y4mr22736572wrl.413.1587452944230;
        Tue, 21 Apr 2020 00:09:04 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id s8sm2317137wru.38.2020.04.21.00.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:09:03 -0700 (PDT)
Date:   Tue, 21 Apr 2020 09:09:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200421070901.GB27314@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
 <CAHk-=whwRqkwdaJQf4g0-Evd6RmXR3dkkKyfnPjbnkeia=b1ug@mail.gmail.com>
 <20200414110429.GF4629@dhcp22.suse.cz>
 <20200420124759.GO27314@dhcp22.suse.cz>
 <CAHk-=whnAGzRqaKjLuhRuYLkGY4uY_H-9KxuoCOtW8DkSL38Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnAGzRqaKjLuhRuYLkGY4uY_H-9KxuoCOtW8DkSL38Tw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-04-20 10:31:17, Linus Torvalds wrote:
> On Mon, Apr 20, 2020 at 5:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > Any opinion on this Linus? Should I just repost the patch?
> 
> I'm ok with the patch, but it's not exactly urgent and I was assuming
> it would go the usual path through the -mm tree.

OK, I will repost then. Thanks!
-- 
Michal Hocko
SUSE Labs
