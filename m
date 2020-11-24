Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85C82C28A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbgKXNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:47:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387707AbgKXNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606225641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xffRRUEFdYVf/iIYdkTproP9RPvaJX79D3rZJfNU7HM=;
        b=Rvf2CO+I0D7YKoyuSatgKKVSSS6SlejBUQ7yErOb+JLjrdgwqnwSgDXPHKX431r40KetHC
        cNPFoJQz9grcdrdR2mFYVTSXNUGm0Fv/kExyu9ykEgvy43BciG2pTqkcgDJRVzYhR0mZYF
        qwJLuCSJ5vnp4RzJZJuBQyPBsVQCstc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-y1L_LCbENfOjwrBfHeO7eA-1; Tue, 24 Nov 2020 08:47:19 -0500
X-MC-Unique: y1L_LCbENfOjwrBfHeO7eA-1
Received: by mail-ed1-f70.google.com with SMTP id bc27so7894311edb.18
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xffRRUEFdYVf/iIYdkTproP9RPvaJX79D3rZJfNU7HM=;
        b=Xn2vT8pn4RdEbuDd3WwhwDvIvhkjYBT65e+o3B3mA0w7l+hBlY01NgbP9Wt9TIL7FB
         fD20Av3STYTChG6fVTUVfjs/m1H/NQHhfq9kKNS3mVc2wyeQLSgTd97TaZk9hh4MD5oT
         bxOFLFKrs77XY44vQ3nRAz1n5AniOhz0//+jiwzSV4BjU5qUW1/S6O7/dKz/mmLLT7J/
         3vpXZ4+yKv53DBL6Mc31x6XSBYWZGYn4qWLfna9EwT0ngVlRtQe16a7ziDuBuWpQzqD5
         Xh8oUuquga/QizkVcsEzprtFoF04o7U11s0wbmtTZKUBXRc0aVPQTt3iZh+muWSQ7vFg
         16ww==
X-Gm-Message-State: AOAM5301AZ+Abw6ATwb9p8P4fMhDQbTH7y0ber5nFKgEBr3xpmfn3j3/
        TPmRRlIQrYZeVGBbQ+KskcWR8kXJeV9amIlBeslpKd/Ztn38Yp3r6mq8CRT1X4CpKMEVzTafU1a
        8nOpNOTUoHoRKXOtIBA7k/sZDDoNyohDPLHvBQF8=
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr4062572edt.141.1606225638300;
        Tue, 24 Nov 2020 05:47:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqRJKaDCOU8o8lJUBpvIonCI4iSMmccpTsGPpfIOAUjWgIRZoULRAqw8LcNxkGji38m0SYjUfv9vLzN6m/Y+w=
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr4062564edt.141.1606225638122;
 Tue, 24 Nov 2020 05:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20201124105836.713371-1-atomlin@redhat.com> <20201124112612.GV27488@dhcp22.suse.cz>
 <CANfR36hyrqXjk2tL03GzCk6rn6sCD7Sd811soBsZC3dHY0h9fQ@mail.gmail.com> <20201124133644.GA31550@dhcp22.suse.cz>
In-Reply-To: <20201124133644.GA31550@dhcp22.suse.cz>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Tue, 24 Nov 2020 13:47:07 +0000
Message-ID: <CANfR36hw8iSSszSt4sNh+ika3vTdXQnXHPLj5t2iLL=5-nzZZw@mail.gmail.com>
Subject: Re: [PATCH] memcg: add support to generate the total count of
 children from root
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 at 13:36, Michal Hocko <mhocko@suse.com> wrote:

Michal,

> This like any other user visible interface would be a much easier sell
> if there was a clear usecase to justify it. I do not see anything
> controversial about exporting such a value but my general take is that
> we are only adding new interface when existing ones are insufficient. A
> performance might be a very good reason but that would really require to
> come with some real life numbers.

Fair enough and understood.

At this stage, I unfortunately do not have such supporting data. This was only
useful in an isolated situation. Having said this, I thought that the
aforementioned interface would be helpful to others, in particular, given the
known limitation.

Kind regards,
-- 
Aaron Tomlin

