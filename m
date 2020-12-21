Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6062DFB62
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgLULI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgLULI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:08:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07645C061285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:08:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e2so5416219plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCGxNgt4GzjA2J6Ybm1/RunLTw4Cq07YupT3iACrfFE=;
        b=B5uSct3PlX3Kr2qHj80JA4OzaFMIIWkWLrcFydCymroCnU4gdEWUxv+k4jLZQN5EmH
         r4KZ36GROasljVcxMEDBFuIjx5kDLgAYT0jx/0eFjIJ+RTwumNYYW5wiqWDYEGaIfGZ6
         B1J9gjOQlc6xCuXmInx6VPGQbW/KAlLapxKaFS9FEvbSBYBksXlg8agiKvEwwvZKdZsq
         g68GPvFpDpgpTs47V5dAaPJPY0td3gBMd4XF4IJGKXhhMLH7UxHarEzpnTluxYZhPwtJ
         zc5X0VzG2K69a8/Rau9IXEy2PP+GsTEWB0r4Gy4aYSNPDMAvW0fcn/Xpj1efl/rD+jv9
         Bw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCGxNgt4GzjA2J6Ybm1/RunLTw4Cq07YupT3iACrfFE=;
        b=Sk2Yxru7bvwKo0QipsGLJyVAddFbwjYUG8Y48/i6RfESXSjHyJyxBM5tIsQbNSpRri
         hBQD2WndlJ8KJE+yxHAFv4+LNzFt71db0sTqicr83mPsEpO7Nkkb572KHinOjJoeb7xk
         7xk3ukLC/DY+yWecr56PCEN3xSrAB0nUArfg+GtLeM1U3v4WkxmtwW9aoEpxhv5m04X2
         O0A0TqEB/FRKwPOUOrFEJqUI/7e+rRJIBPam9ygMqO+KJHKawYIbvmAxb1R1TduBHQFZ
         pLtd8lcG1q6j8wEnAGGNOGC2mGT55DW35LAxegIO8926aYETbTbQQmk3Fb1tSZ8KfNNr
         GScQ==
X-Gm-Message-State: AOAM531xzmZkTK9Cgrf89VPhl1T7J+3vyrVbb2j0M5r2qVRdrLiH/F6s
        6qmuHX8pD9CAwn8ELlZQ4DrS7GORgmRWYtHYW7wvuQ==
X-Google-Smtp-Source: ABdhPJy+5TgHcPSu8gMt1h1aG/LqaNFQSJjtwWsk5Gyn08DMQ3M95ZayPCuRTgLij5s8O5gnZE+fn6qyzAL9VBxRPHo=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr16683485pjt.147.1608548895665;
 Mon, 21 Dec 2020 03:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-8-songmuchun@bytedance.com> <20201221104013.GB15804@linux>
In-Reply-To: <20201221104013.GB15804@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 21 Dec 2020 19:07:37 +0800
Message-ID: <CAMZfGtWK5uJE=W5O+dg4XO5zgTQUVpL0bjPB6im4+GZa3U+dsA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 07/11] mm/hugetlb: Flush work when
 dissolving hugetlb page
To:     Oscar Salvador <osalvador@suse.de>
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
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 6:40 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 17, 2020 at 08:12:59PM +0800, Muchun Song wrote:
> > We should flush work when dissolving a hugetlb page to make sure that
> > the hugetlb page is freed to the buddy.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.
>
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
