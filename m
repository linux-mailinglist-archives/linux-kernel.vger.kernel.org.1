Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451F1302198
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 06:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbhAYFIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 00:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbhAYFIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:08:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2EEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 21:07:20 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y205so7726268pfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 21:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOUhfnWWdDSn5rx6Y3alCW/0otHcbj316dnvYqN7gu4=;
        b=tsUFnxshHE+L1KHEKNbr7GW5VWbpojZwNMWTulN94mLxAv5nmHR7FU5jkiJkbLDiE5
         V2ApnArVL/VkkZmSeKVcldSXit/+C4iDHMVeKZHLwgfxAeD47Z84LDZQbeiT+HHmZYPg
         vhR2WbNrS3ybuGoEaHuW03cfqBHkGveM7jl9/RmRpGuE+kaGS59pDNCGnh3xcxougmPa
         p5iwfNjdh3OX84dG6S1nsOx92g93IwETYXENEkA23sHcgYRNnGYk0XN0GuINmTB5VT0N
         5L72Gi8F+chKV5JbtZpv9Y3Np+0lxsXH9bDLf1Y/OnavILi1C9rC3WvB65TvMTatvJYY
         riEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOUhfnWWdDSn5rx6Y3alCW/0otHcbj316dnvYqN7gu4=;
        b=eTfNI8NQkW/emI/z+0rvPbU+R2ufj8DPI64djmCQzTVcP8L0CuFnv48gxn5vNiGsur
         cDYfF4DNl1QopvD2CrdfJ7p8uuYJ/YtanfNro2T20k9fS/tnTIhX0t80OYGFzEayiUsc
         Gvz70lBhY88jU5WRcaPFE9U0DK22gwCahW2pIUgq6ma0lcQNuM+Jk+6X66IXUigvvqBS
         Vn0u+Pv2xFql0dwxXNYc1ZFRd93iGLCkLNw++kguZPWg3OlHOanWGKglY4WaKbos4Seq
         4H2O967aq1GsQH1JnmNL+wk6S1Hmn68rYdRoHR9MoGpKysXoq1acr5ONKNJSpwBZdiO1
         Mstg==
X-Gm-Message-State: AOAM532ApFKe71rZ1dXXuNi0GmYUJ15NqAfcIOL+THT9/CwUZsgKlS6g
        SP45IEl0WPz+tAnQEqAKB5ynkhuQZluzHnMW0/axZA==
X-Google-Smtp-Source: ABdhPJyeBE3eTqrFGflPEz5F2VO+wo1F0NwBGgPBQd4npB+pBnnp/e4ggx1odd0vcPNrzmFXdQJHbZsp2DakZO11Wz8=
X-Received: by 2002:a63:50a:: with SMTP id 10mr327154pgf.273.1611551239885;
 Sun, 24 Jan 2021 21:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-7-songmuchun@bytedance.com> <88a384ba-8487-c66b-e7b-eb6055e3775@google.com>
In-Reply-To: <88a384ba-8487-c66b-e7b-eb6055e3775@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Jan 2021 13:06:44 +0800
Message-ID: <CAMZfGtW5S42rPtOJexNv+Zf2S-J0kG8T1KpWS_ozQb2eG-YH0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 06/12] mm: hugetlb: set the
 PageHWPoison to the raw error page
To:     David Rientjes <rientjes@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 8:06 AM David Rientjes <rientjes@google.com> wrote:
>
>
> On Sun, 17 Jan 2021, Muchun Song wrote:
>
> > Because we reuse the first tail vmemmap page frame and remap it
> > with read-only, we cannot set the PageHWPosion on a tail page.
> > So we can use the head[4].private to record the real error page
> > index and set the raw error page PageHWPoison later.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thanks.
