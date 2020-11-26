Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8A2C5291
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbgKZLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:02:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731216AbgKZLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606388547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cvGV8OUthTmjmbY5oJ7mRxJLMMwznOKcyuaPUff3ek=;
        b=VezbIcJalAdt/otNdxYgQil5QVSdbXlehicqEyhGBWBCVCiJzLL0t8enPJIlyr35Cchr2a
        nzZXjjyxclHMD639PRhxITSS3o/dSbOwkfB/MxNBsYLGLTjXuL4bYQXKHKR39jIc08qYEZ
        mrHxatGwzRXg07yudk4mrJJSGfZXrgI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-FaJPpW0bPCKcBwUw690mNg-1; Thu, 26 Nov 2020 06:02:24 -0500
X-MC-Unique: FaJPpW0bPCKcBwUw690mNg-1
Received: by mail-wr1-f72.google.com with SMTP id g5so1097061wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 03:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8cvGV8OUthTmjmbY5oJ7mRxJLMMwznOKcyuaPUff3ek=;
        b=UhTMw5Vk6mCj1kgUDJ62b+6yQlHcd0UB7wfNsQYcSEaypq39+QbKhFm0x0KH1Q1mEm
         1z3y2SRLYKBZxUpxTzIlPSXC0NKAfqAU7IaJrxhviCFEiL23qiR1Q3/abTalBIrVIwb+
         gno7pd9NAV0ESUvHZC8vFdhrZqwmoIOc+yR8DZIaRauNxJAZ4CvZounQpCj2xBti4WMb
         lKkF6qi5NSBHvxwhGLcaqR+1VvTXjXUsutS2Mg/OA5mw2KIwmVzMa2NTkBl+eiYLDau6
         RPAQIHLG0HrgaV3n8eZNTQGvjxpYKurwOuZue1ntsCsk7O0Qa9LiR6q2x6jEFx4PjSUO
         mUfg==
X-Gm-Message-State: AOAM531pRoGjJXkSJwQrVaQY0ravAmMEPp51ik+NUisODY0e2+P1NYgH
        zbmn9DNirlLAvBtr6uLlrj8Qvf9rZQ4osDJQxfvpgpc41adWZloYMQ8GcdquUz33uM+DF8aDwHL
        nM/KTJ1bIGqOQMVsl0z5xyls=
X-Received: by 2002:adf:a54d:: with SMTP id j13mr3210914wrb.132.1606388543441;
        Thu, 26 Nov 2020 03:02:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNurD+B9K0wyu+wLx1//nc60gT6N9gDdwcKceycA0Aw8hI/yIujAcODjNgQftSCd3n2mbAxg==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr3210886wrb.132.1606388543257;
        Thu, 26 Nov 2020 03:02:23 -0800 (PST)
Received: from localhost (cpc111767-lutn13-2-0-cust344.9-3.cable.virginm.net. [86.5.41.89])
        by smtp.gmail.com with ESMTPSA id y2sm8806139wrn.31.2020.11.26.03.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:02:21 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:02:20 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] memcg: add support to generate the total count of
 children from root
Message-ID: <20201126110220.k4o6s32er5jy2mdk@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20201124105836.713371-1-atomlin@redhat.com>
 <20201124112612.GV27488@dhcp22.suse.cz>
 <CANfR36hyrqXjk2tL03GzCk6rn6sCD7Sd811soBsZC3dHY0h9fQ@mail.gmail.com>
 <20201124133644.GA31550@dhcp22.suse.cz>
 <CANfR36hw8iSSszSt4sNh+ika3vTdXQnXHPLj5t2iLL=5-nzZZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANfR36hw8iSSszSt4sNh+ika3vTdXQnXHPLj5t2iLL=5-nzZZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-24 13:47 +0000, Aaron Tomlin wrote:
> On Tue, 24 Nov 2020 at 13:36, Michal Hocko <mhocko@suse.com> wrote:
> > This like any other user visible interface would be a much easier sell
> > if there was a clear usecase to justify it. I do not see anything
> > controversial about exporting such a value but my general take is that
> > we are only adding new interface when existing ones are insufficient. A
> > performance might be a very good reason but that would really require to
> > come with some real life numbers.

Michal,

> Fair enough and understood.
> 
> At this stage, I unfortunately do not have such supporting data. This was only
> useful in an isolated situation. Having said this, I thought that the
> aforementioned interface would be helpful to others, in particular, given the
> known limitation.

Furthermore, I can see that this is already provided via /proc/cgroups
(see proc_cgroupstats_show()). As such, another possibility:
the proposed interface could reliably produce the difference between the
maximum permitted memory-controlled cgroup count and the used count
(i.e. the remaining memory cgroup count, from root); albeit, I doubt that
this would be particularly useful to others i.e., the use-case would be
rather limited.


Kind regards,

-- 
Aaron Tomlin

