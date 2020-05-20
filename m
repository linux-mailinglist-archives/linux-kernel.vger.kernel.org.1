Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AAC1DAD34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgETIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:23:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:23:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q2so2549816ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oz66q4UAEVR/PNvzqC0no71qGvbWiyB846KaBJkHgtU=;
        b=rKm9ZjaWIE2hC9QPpUPBTVRGKDDl5BqESk3XO+jd/cNexMh0EKlQf1Amp4dFqTXNhj
         Pb24R7m1bkaYrPy3tmojnvsEL6rflyOKl1O9FzhVuj78mEKk6hcwDi2Ry9sSihXaTjpd
         H3KRwWxDFs75o3Z4sg7Ol9e8dhEqMFy5w90wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oz66q4UAEVR/PNvzqC0no71qGvbWiyB846KaBJkHgtU=;
        b=LAPqdSzLvDyHxphyuLMYEy/QzW0bvoCCaGSPI5A965ZI9ym7CpHnoN95py46HjtBwh
         7nFeQFedD/OpKVOThMMw2DBmc6Vtg8x2AnyjXouV+k9Lmp7MtRwv3KKQZhtSewIyHQMx
         nhLCKbSdsktxmDE/+FinFQOGXKU8V9X9mYcbzmi8UrqO5BXtH+YVPt8u0CrZbChW1Do/
         M2bQAWJDHlOAxRR8Ob06WvJwj6FocrxKPJhQQ1+Zf3JOIfPo+GjZ4ZE5w4Twxw3T7X6N
         vR/74I6t2ayTPNoGqFSBboOvzgNkXmCNvMW/ONuP6jUwg6b6BZwK4awEfb/eQf1qUe9V
         DzuQ==
X-Gm-Message-State: AOAM533urCWjR5KPKJM2KDBNmOoYBp7ryOCK7nZrYHi/XZEcxsNFF5bk
        KD2uxo5UbNsudYWBWJMhAtHgEu0MCziuliPVD6xCGA==
X-Google-Smtp-Source: ABdhPJyAutftRRlL+OIere8EnY9rywd3lsy/s1EiRDf6pT9dthPdIPLw1F8/CGo5Jz3ePKIP+yltl0Q74gaOmFx2cao=
X-Received: by 2002:a2e:92cb:: with SMTP id k11mr2142631ljh.96.1589963029135;
 Wed, 20 May 2020 01:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <D90B73BA-22EC-407E-838F-2BA646C60DE0@lca.pw> <CAM4kBBKkOGOjT5fddQ_vongNx_cXmv0tCQzD9ZtrGgkuPTKfTg@mail.gmail.com>
 <CAG=TAF65nmW2m9-5z5xvLmfRAD0LZAxgARJOEAqvzA3GdN-iJA@mail.gmail.com>
In-Reply-To: <CAG=TAF65nmW2m9-5z5xvLmfRAD0LZAxgARJOEAqvzA3GdN-iJA@mail.gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 20 May 2020 10:23:38 +0200
Message-ID: <CAM4kBBJSEpB9kS+PKpd5HJT0Ox5rNWW2vsvHTVUw7Q59C-ktig@mail.gmail.com>
Subject: Re: zswap z3fold + memory offline = infinite loop
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 5:50 AM Qian Cai <cai@lca.pw> wrote:
<snip>
>
> >
> > Removing that check in ->isolate() is not a big deal, but ->migratepage() shall not allow actual migration anyway if there are mapped objects.
>
> Is that worse than an endless loop here?

Well, let's figure if there really has to be an endless loop. Would
you mind retesting with
https://marc.info/?l=linux-mm&m=158996286816704&w=2?

Best regards,
   Vitaly
