Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF322C2827
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgKXNgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:36:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388314AbgKXNgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606224976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmB+/CVA1mnMQlH6qVDGPxzbBFzcsBI6srHn67igccA=;
        b=gsV9KdM/YQkMxbJBYxOowUm3+1oWNEUVlQatMAZTy3tySUu90rTuYOtNtMoR8hmT3ElC1A
        kGyhRAAigowjx3Fwvv8HFIDlYSj01UQaGmfg9JMWgXwAGXG/DaaB7J5dh6y9mYAQkCj8fs
        mDSLFDs7mMI7SILqUHioJwuV4wy0W1w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-hx-v_bO1O3qrxSZ_4lAuIQ-1; Tue, 24 Nov 2020 08:36:14 -0500
X-MC-Unique: hx-v_bO1O3qrxSZ_4lAuIQ-1
Received: by mail-ed1-f71.google.com with SMTP id x15so7922705edr.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmB+/CVA1mnMQlH6qVDGPxzbBFzcsBI6srHn67igccA=;
        b=GuOpEZ4J+/W0wYouAH+C+29faZtITmrndhWy7GFMAgTmcLXc5bo4rduU6P9BdOCzUF
         G0eSPNzB1rwOguKXZAjFrjdw/oRhkXDXLwTlm21ooSC2HQC5eJRmPcIzZpmXI4o/OAsn
         WjX2ZBWwJJspmdhMwfg7Da2hkXVoAPcRvY260TWbEiA4uWsDOtyuJ+5vJAprFmDm+WJD
         7OwWfFu/QwtyGuULTys60jvBJLSYBciEHhUIykeNXNYKuucjF5mZUP5dWAQ1kjBsTDWB
         BMiCcuwDtjJ01xcq6s7dEhnxHRwNz4fwhH+4ekejdzGiD2sc8W85l2voear/5H96u0BC
         HjyQ==
X-Gm-Message-State: AOAM53362t7OsgmakxHmqAdBiaFbrbT1JNZp5HZoixt/7Z882H+n8BE+
        tBBoQFsUCyrCOaQ3oJtbWehqymhb3QJtyiLUGELwrp4XqhnkgOuxK9hEnP0mOnrf7fH79ZSsIyK
        hStO4lN+jFx7e15RXeL9zt9qN7QuSyss174fWopc=
X-Received: by 2002:a17:906:4154:: with SMTP id l20mr4250328ejk.96.1606224972733;
        Tue, 24 Nov 2020 05:36:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLgDbRxAg0TN/5K6JMqyzhfN/CF2RVQvZyZNIJ9qnPaKoz49FJ0/KWFYWQb2Ccdbt4ydh+BSG7gnj+/67GBf0=
X-Received: by 2002:a17:906:4154:: with SMTP id l20mr4250314ejk.96.1606224972551;
 Tue, 24 Nov 2020 05:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20201124105836.713371-1-atomlin@redhat.com> <20201124112612.GV27488@dhcp22.suse.cz>
In-Reply-To: <20201124112612.GV27488@dhcp22.suse.cz>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Tue, 24 Nov 2020 13:36:00 +0000
Message-ID: <CANfR36hBxRsHV+JZfT6_RZRXBvCu0p=4xUOSxzco-BvrTEP37w@mail.gmail.com>
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

On Tue, 24 Nov 2020 at 11:26, Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 24-11-20 10:58:36, Aaron Tomlin wrote:
> > Each memory-controlled cgroup is assigned a unique ID and the total
> > number of memory cgroups is limited to MEM_CGROUP_ID_MAX.
> >
> > This patch provides the ability to determine the number of
> > memory cgroups from the root memory cgroup, only.
> > A value of 1 (i.e. self count) is returned if there are no children.
> > For example, the number of memory cgroups can be established by
> > reading the /sys/fs/cgroup/memory/memory.total_cnt file.
>

Hi Michal,

> Could you add some explanation why is this information useful for
> userspace? Who is going to use it and why a simple scripting on top of
> cgroupfs is insufficient.

Thank you for your feedback.

Indeed, one can use a command/script to manually calculate this.
Having said that, one that creates a significant number of
memory-controlled cgroups may prefer a quick, simple and reliable method
to generate the aforementioned data, for management purposes only.
As such, I thought this patch might be particularly useful.

Kind regards,
-- 
Aaron Tomlin

