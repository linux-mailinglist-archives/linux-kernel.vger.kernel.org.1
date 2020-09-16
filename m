Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC326BA45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIPChC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPChB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:37:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:37:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so4604819ljk.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fv8yt3Mc4zl4f94N5JDsxGnqubAPR0A1k38BepP4lq8=;
        b=LsoMQ9jgoUVYemW5jeO9ZrjqVwiOIoBF/niIFvkCZZCE3WW2cGKEwmoLP2gUobuZUG
         iie+zJIMmfknwsDyXecyN0xYhoF45QgIeLyg2ZKVkQJKJz1AoKnT1CJS/VcSlmM27vPC
         FYfZvV4k6MVQMIpapJXFEF3vZ39QvJvF0ZW4LPqdr06CEHbaczP8kGyPLIXAn0w+ZrAa
         gjnfeNeID89L1DSP3hHtBC2NtCmfksQdpxbuHlLMZgFq9QGm5Q/GapYBtCqED2L+8I0N
         zp50Jv6CteM0WB12JdYId4TQ0AOf7dLULYFDZGJ6WkeLwCuwbOcBkZWxNJbA8epw0j6r
         cyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fv8yt3Mc4zl4f94N5JDsxGnqubAPR0A1k38BepP4lq8=;
        b=psp/hyAMJdt0ig5vHlZgFFqRqVE2WcuzqX/+TKOjsJRk86VXnah+TrFsnRL5ZxjW4E
         EJ4/N6hTeRtxF8O9PM/Q9AsP6RmUKvyz2xt4cOUc0E1SybfOuE/jKojcFMFIBnab6lLd
         Ltexm7U+VRFSJcYYswXeqYMuCVegfet1pttlvrzPkaJapvJaiGOBIMtx0Hr2wwyd+mM2
         06YVyvevEWaAGW5jG0aGT8Si26l6rUkZNTV6jJqOKGMX/QzG+BaJAxcSp7FoohZHk2s0
         CKrL66VwuL0hjqRrpESBn4wqzkFFj3r7nkL+DaRQzGFoSPgGET29dznMtKtsgI6Je9lk
         PkiQ==
X-Gm-Message-State: AOAM533H5CZ7NIKQZ/sVGFYoo9mF8V+or1IR9TbsLPhYDASSLS8JmHAO
        x0NVm19Yorat2PMN7GnwMFeFW/Yg1vX0J/Ol5XAUPA==
X-Google-Smtp-Source: ABdhPJx1JVUXcV+qAuIt1Ulq1cCdBPwGFDNwYw6hlbe2tZaHW1zQ0sz2/FL9dKBsZ62IDLjqiTT3waizNWoS86lRtaA=
X-Received: by 2002:a2e:9089:: with SMTP id l9mr8683636ljg.408.1600223819202;
 Tue, 15 Sep 2020 19:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200915132741.84869-1-zangchunxin@bytedance.com>
 <20200915144737.GA2581123@chrisdown.name> <20200915145533.GG3736@dhcp22.suse.cz>
 <20200915162604.GB2581123@chrisdown.name>
In-Reply-To: <20200915162604.GB2581123@chrisdown.name>
From:   Chunxin Zang <zangchunxin@bytedance.com>
Date:   Wed, 16 Sep 2020 10:36:48 +0800
Message-ID: <CAKRVAePsLTRzQC+5dYYYQ+x+fk8ogoME9uuobzyeJ2J-6kNHPg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4] mm/vmscan: add a fatal signals check in drop_slab_node
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:26 AM Chris Down <chris@chrisdown.name> wrote:
>
> Michal Hocko writes:
> >On Tue 15-09-20 15:47:37, Chris Down wrote:
> >> zangchunxin@bytedance.com writes:
> >> > +          if (signal_pending(current))
> >> > +                  return;
> >>
> >> This doesn't match your patch title, please update it. :-)
> >
> >I have to admit I have completely missed this and I think that this
> >should better be fatal_signal_pending because that would make sure that
> >the userspace will not see an incomplete operation. This is a general
> >practice for other bail outs as well.
>
> Oh sorry, to be clear, I meant the patch should match the title, not the other
> way around.

My apologies about that. In my first version of patch, it's
'fatal_signal_pending'.
But in this version, I used the wrong branch. I will update it now.

Best wishes
Chunxin
