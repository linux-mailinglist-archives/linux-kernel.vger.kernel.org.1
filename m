Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6630272E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbhAYPr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbhAYPnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:43:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE7C061222
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:39:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a14so4580181edu.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rra/deV4BpPfJHrSK+j1oedRvhTg8xlMYVP/CjTCdbo=;
        b=oT2pKEpwEYuKqNalnjLTRHdVcq6t3+B3XXVLdpXKu3V4ApIJJzXxasqADy9EZXqUXh
         n/BuUY/5ALgsbICzl3RIKCjVDYUHtIYek61hqI9KUL/2LNmRfnQ0GzO+XTL2MXbd3aK/
         UsbqMjXr25onQ0szEsqlgipwxapnw7EPmLS3cPXyk2d8H28WIA52mQ7Yvol7ZM9ht9Zh
         4+OwuM1jkeN51/bu6vR4JrA/Y4arNiozGdwTdv4f8cWHV411+H+g+HOBpzxam46DRzaS
         2ThNiPt5XjxOw3h37ikX+KNHPGrNudfwkzs0vddCFZbZchOu9DDhuhN4cG8oBxIGQClP
         mP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rra/deV4BpPfJHrSK+j1oedRvhTg8xlMYVP/CjTCdbo=;
        b=oBEnjs67+G/MzUsYgFpVphNdzuP3W96hx3ERoyxDlYRuJN/ivIzD9TxuH1QGPlkMlo
         qs2hNK9nRjd+DQ26i7fLLCDduPEgi6w1EOWTqJoiTaRTeY1BramkjM8AROhQLQpdzob6
         hnfAHKORObN6Ea73+AfZj5yJO+Ln3LiRyVpB+ze/sgel/f0y5n45cNYboy7H/JYEgIrc
         W0kai/3trht/fxgYmVMXXkcxfUYq2pDNuJ/NxmsVF6cXmJMzV1mPHEZbCtMdJ2JiUZ6Z
         1R0cUycqK0vBM6EyvL8lXHrHYo0Fwu8QVAUpHg3EC+jORRvZztQe7G/bA5b5izRighu+
         CEQw==
X-Gm-Message-State: AOAM531fuwS+M5U4GXkyO4jmrYPu2mXYFjGwbCBk3w1k/vh9jGb+bZ7J
        YvSKzGIScg6oRNiEWGkZgMROLV4VGW+VHMi4EvtQ2w==
X-Google-Smtp-Source: ABdhPJzFrqfAwV4lIbCCiVu+IspFq83jhqoaMG65PKSTrukGguTs7XiN5FLFH6wPnByDVaUokuQk0Sd4Y5Qva95xCmU=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr934395edd.341.1611589170542;
 Mon, 25 Jan 2021 07:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
 <20210120014333.222547-9-pasha.tatashin@soleen.com> <20210120131400.GF4605@ziepe.ca>
 <CA+CK2bCu-uWWOxS_sPhfgzXTq-cqYFsHK_QFo7F+rStKpJJDRA@mail.gmail.com> <20210125142819.GU4605@ziepe.ca>
In-Reply-To: <20210125142819.GU4605@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 25 Jan 2021 10:38:54 -0500
Message-ID: <CA+CK2bBa+8dOatFgUB405yyKnSYfX-iaypzXpAhOmZN_KNBMhA@mail.gmail.com>
Subject: Re: [PATCH v6 08/14] mm/gup: do not migrate zero page
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 9:28 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jan 20, 2021 at 09:26:41AM -0500, Pavel Tatashin wrote:
>
> > I thought about this, and it would code a little cleaner. But, the
> > reason I did not is because zero_page is perfectly pinnable, it is not
> > pinnable only when it is in a movable zone (and it should not be in a
> > movable zones for other reasons as well), but that is another bug that
> > needs to be resolved, and once that bug is resolved this condition can
> > be removed from gup migration.
>
> My point is you've defined the zero page to be pinnable no matter what
> zone it is in, so is_pinnable(zero_page) == true

Sure, I will move it inside is_pinnable in the next update.

Thank you,
Pasha

>
> Jason
