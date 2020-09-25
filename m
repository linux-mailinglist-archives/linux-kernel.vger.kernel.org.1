Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B42278362
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgIYI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgIYI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:58:37 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A461C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:58:37 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j3so942022qvi.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OBfQBhGGCt8PtYce4ad54bvtM0tuNhXLyEjVZdn2vo0=;
        b=cg1GOiq7LOLUUr2ZPF9UOQZEhGyHkiSH4usJtyGlc93pFYyp3MeuFIAVNCNgi9hdzv
         0fs/VTuatMxzKDQoGO3SfWiIa9zZ5CQlkqu7wcl/s5Lyr9A4ughJC/Yd0amLbg1aBQ7P
         ALa+P759USwyHBfmdRPqNhUxVjzjDd73Lvla4loc/jOKPZB6CeDv9VfSo6uEAURq3m3I
         Cu7eqRj3/VRCcMDiaqTKrFR1ippd4ooml63d+7fkKuZIb7arWiFJ1hZ3RHtYjYjssm/r
         ILjoaJeU0Ds4MRcZW4luRMPTzX/NqFGQgbKYVOjuhhSMI3gltC5fphntE7eEjXvrwZ5D
         VBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OBfQBhGGCt8PtYce4ad54bvtM0tuNhXLyEjVZdn2vo0=;
        b=HSMdJGzvDZsi8G6HlvVvFLk3tt0/UTCldQ/uB3MNUEL6pcNQdUaH/uM9J6tmefmBkP
         uP2FoSFGJfHdcaLx8nTyOEix64s+HPqst7N3TY+NLFUu2nZuUrPAuVz8a41ddVXMTyDP
         bvIdZXLefyoanilKv4EHluMPyzrkqw6wvhE2kNb6KAQ4rZFJT2XPgdvuO9R8uGJes/sp
         vg2F1aopA8I0NE3Oz2r+C4CsFyx+yiyb6GbIXyD7vJHgUKtkFTAXqyDEaH5HsUfd6Pl8
         vAVJiafTPs4DgqOta+E2kUuY47w1ptf+1O4zxvs3p2XZ1FY0yur3chCMsWP+MRRelsjU
         dfKw==
X-Gm-Message-State: AOAM533BfEpq7ZXzXEzUZnXqtM10ZqI2mx043/JwpyWIbnUNMo8v8uh/
        MXSvF9+C931jMzjdfEgCwU2RfN5I1+X46IsRZQo=
X-Google-Smtp-Source: ABdhPJyBvT5P50o5JK02BpCl7OikwzHKhA1tuwZnSZz9R0J0c7m5++Jp0WKkdcMIhof83aKVOfo8XDzSq1c6s7BDDdI=
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr3371262qvv.3.1601024316752;
 Fri, 25 Sep 2020 01:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
 <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz> <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
 <20200827133523.GC3090@techsingularity.net> <CAAmzW4PTgbVzf1dkvnzpHpYYTbLyeNM=OzywUBvkFw9rUhtR4w@mail.gmail.com>
 <CAAmzW4NabiAc+Nh=jtg9fUZTodQHHjf=mFTn=w32AJ43L9o2Aw@mail.gmail.com> <d587d057-75f1-288e-49d2-0c6ea387d414@suse.cz>
In-Reply-To: <d587d057-75f1-288e-49d2-0c6ea387d414@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 25 Sep 2020 17:58:25 +0900
Message-ID: <CAAmzW4PSwCZuZh=Nm_QJdOchCg5GBixU4sn7YYOzcbnLuG+J+w@mail.gmail.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 9=EC=9B=94 25=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 5:55, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 9/25/20 6:59 AM, Joonsoo Kim wrote:
> > 2020=EB=85=84 8=EC=9B=94 28=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:5=
4, Joonsoo Kim <js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Hello, Andrew and Vlastimil.
> >
> > It's better to fix this possible bug introduced in v5.9-rc1 before
> > v5.9 is released.
> > Which approach do you prefer?
> > If it is determined, I will immediately send a patch as you suggested.
>
> Hmm both Mel and I preferred the bypass approach and nobody else weighted=
 in, so
> if you don't mind, you can use my suggestion. Hmm maybe alloc_flags & ALL=
OC_CMA
> check should precede migratetype check in the if () to optimize for users=
pace
> allocations?

Okay!
I will implement a bypass approach and send it early next week.

Thanks.
