Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81A32E011A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgLUThD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLUThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:37:02 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3EDC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:36:22 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id m145so2494399vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZZyncXwiQja2UVR2OiYE7gDJBGuNncgyLsAmPzZ+/c=;
        b=narslOk3Hvt1RGe1zhxswCbmFdemKIq+FjDkobRs9/VXBSyC/AGRgfWNpjsxSkR5r1
         oR4AJeSoxTEmamC0ao9bd5IZvgbscauG+A/E1+kCVgrbVBM3Jbw9/mk8A0rlgmZt32ur
         PjCYHGOXuQ0I667rjRyoz5PhqsLI9sq3LcXLJO9hmN6OpUS4X6MQBJXgHFJT0+DIiCpQ
         Vq7yVMVNH+75Zua8fVt6YyWqQDANSF7XBhSn1AF+EOwQL+TpGVYJMm8DBlBEvqyroy4E
         XV2AbfJGDXx1VGpECcBLSF8XE4k0eT9/JdZs8DfB7FFDvjdTqPLGSrSFBx2veWzvPqM5
         dWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZZyncXwiQja2UVR2OiYE7gDJBGuNncgyLsAmPzZ+/c=;
        b=cZpznDXYA+BKxtoT5kNBiP55u2t6R/IsRlztl8lErh6y3zRVUbZBrMhInyqJpmDZn9
         sCKyMI3w+h6KPM9zmSW9n4Rkgcf31ieiscSuaWXlxcW+6aiCC46yYQUBrCJ9RlLLQedz
         ysdLQdurE6XOGx46w5pwCzZYJmwf7j2Kdr/AqPH3RiyTT1PO2qK5OlOth/Aw0QD0t3LY
         y05LrmPufocopiMtSk2X8KtSi5cNkz73TCKKnSRji55rPXsxnWu8tOJVRvSYVRsm6Zik
         2LbaRi2gVtAifMhZwGDKAWg2IpTy/u+1ZDafzOHRxd0LVSP4mpbSTKBupPWXszy58Cl+
         RaXA==
X-Gm-Message-State: AOAM5316z0hoPhT7cz843ltAoTn4oou5NdrXgTtJjCT149aJ+9RPOwRD
        +BnqHpQ5/ju54MwDYSvlll5glbPskQYoD124jkHzrwqet5w=
X-Google-Smtp-Source: ABdhPJyrBEPum1+Ha9e9MR1wjXKQOrZ3ZlZ+t43OuSExGikpJ4e9J5AL9z/TcGa4LoqHca85LwSbFzl0qcZ3/g7+1hQ=
X-Received: by 2002:a1f:5cc2:: with SMTP id q185mr14390621vkb.23.1608579381365;
 Mon, 21 Dec 2020 11:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20201217020311.491799-1-yuxiangyang4@huawei.com>
 <20201217022306.GB15600@casper.infradead.org> <CAFqt6zYeDstXBHP+DCyBdmL4vDFBGekv7jrknU5c175sKVax4w@mail.gmail.com>
 <20201218095756.18d259ea243e434a8a90403a@linux-foundation.org>
In-Reply-To: <20201218095756.18d259ea243e434a8a90403a@linux-foundation.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 22 Dec 2020 01:06:14 +0530
Message-ID: <CAFqt6zbNoDAxdNEYY_noLjEHJ5xMP__e=cyB5y6GZ-agnaPfdg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Fix warning: no previous prototype
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiangyang Yu <yuxiangyang4@huawei.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:27 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 18 Dec 2020 09:39:30 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > On Thu, Dec 17, 2020 at 7:53 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Dec 17, 2020 at 10:03:11AM +0800, Xiangyang Yu wrote:
> > > > Fixed the warning when building with warnings enabled (W=1),
> > > > This function is only used in filemap.c, so mark this function
> > > > with 'static'.
> > >
> > > Good grief, no.  Look at the git history before proposing a patch.
> >
> > revert "mm/filemap: add static for function __add_to_page_cache_locked"
> > Revert commit 3351b16af494 ("mm/filemap: add static for function
> > __add_to_page_cache_locked") due to incompatibility with
> > ALLOW_ERROR_INJECTION which result in build errors.
> >
>
> How about we add a prototype for __add_to_page_cache_locked() to squash
> the warning, along with a comment explaining what's going on?
>
I think adding a prototype will silence some kernel test robot warning
and future efforts to make it static. I will post a patch.
