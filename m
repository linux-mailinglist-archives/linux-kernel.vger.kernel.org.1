Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C626953F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgINTD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:03:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB0C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:03:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so429954lfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lCp3kDrA6QrcbGyjex2I7KUZqi/r0wV3gacvDIaE78=;
        b=HG8R+P0wSkEFRTNr8Mv0Y10m6YvFO4YVFnMbSV3dBmCQG5Sqh0vfpcFYZoAJ4ARtXB
         5Nl6BJA4HVzuKfa0PXfluHX2neScJKXnlRAYpbYXR9s81/gcyFkkCpU+STIyvw4WvIAQ
         aD6eLgkUim5q6a9apDodAYNIOMXsCWGNBsoyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lCp3kDrA6QrcbGyjex2I7KUZqi/r0wV3gacvDIaE78=;
        b=G9+KaojTx3EM4L45qTTpxKhB1ouHVLtaT6/3OPBr34WFygo3tQHoJ0F0IRgbw9kpl7
         fTmT2iKyp4ap1IIU2TkE+Z24biM8l64gZjjtzNmOR25QdtG4AzpC9Ju0rLiFCU04VSpy
         t490yI2+SEr7E5a/kZQU11aqBCrGQujm4EKu+uyqJzKvCsgUAauNwI5kX+qG0Zfg+2Xy
         lePRU9rcjinW/gCxVoqzPj9lp2I3lBqGpM7IojPPCh42lORnluZ6Paz2HVklmOlpLKSe
         3Um5sAevnpAuWU+7lJ03RqtDwK4Gg2NxJRSEp50i+SnCmbxXl5kWWGii/81skPazKuS3
         5ndg==
X-Gm-Message-State: AOAM531Xm47nulyAxYWtUvkqt3nVa6E0O/E5WwRpVQeQ/0x62+quYLiG
        3OI5TC+ZcbE51XmsPsunfABFegs1hmgpzg==
X-Google-Smtp-Source: ABdhPJwSXsagO+s1IyB2r84K6EJa6KLnq6S+x+KU17crr3D4tGCdSZC6/+rS3sPXWzzHAnxfg2QclQ==
X-Received: by 2002:a05:6512:3f3:: with SMTP id n19mr4345404lfq.531.1600110232156;
        Mon, 14 Sep 2020 12:03:52 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m10sm3520757lfd.134.2020.09.14.12.03.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 12:03:51 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r24so636776ljm.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:03:50 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr5938341ljm.285.1600110230596;
 Mon, 14 Sep 2020 12:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200821234958.7896-1-peterx@redhat.com> <20200821234958.7896-4-peterx@redhat.com>
 <20200914142722.GA21906@redhat.com> <20200914175946.GC30881@xz-x1>
In-Reply-To: <20200914175946.GC30881@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 12:03:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpm129KBt42pQWHgvzH71=XcLvRmrUVoy2cnO8fVwfBA@mail.gmail.com>
Message-ID: <CAHk-=wjpm129KBt42pQWHgvzH71=XcLvRmrUVoy2cnO8fVwfBA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/gup: Remove enfornced COW mechanism
To:     Peter Xu <peterx@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:59 AM Peter Xu <peterx@redhat.com> wrote:
>
> However now I'm a bit confused on why FOLL_COW must be with FOLL_FORCE even
> without the enforced COW... Shouldn't FOLL_COW be able to happen even without
> FOLL_FORCE (as long as when a page is shared, and the gup is with WRITE
> permission)?  Not sure what I've missed, though.

Afaik, the FOLL_FORCE test was (and is) unnecessary.

If FOLL_COW is set, we're going through this the second time, and we
either had that pte_write() or we had FOLL_FORCE originally.

So can_follow_write_pte() doesn't need the FOLL_FORCE test - it's
redundant - but it isn't technically wrong either.

                 Linus
