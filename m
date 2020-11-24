Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1D2C34A0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgKXXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgKXXZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:25:16 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF27C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 15:25:16 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so542091lfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 15:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZpDzZfRGW5JQ+z/SLaL70l0Y+Id271dyPmoJFXV3Yg=;
        b=eMtd8miSV5Q4HzVm9lx1snZ252JU2LUG08CXEG9MZekZ6i7RMmkka/lMY+IPVuJ23L
         PqhYtLLZg6ffJmiv3yaDYTznuv3dIQ4YBw1pOJz9r2vKjiack1bfddd/lir5cfbryUH+
         /Jt2/UYsF/gTRVYdgZmuNAbHMgKvTDtyzGHaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZpDzZfRGW5JQ+z/SLaL70l0Y+Id271dyPmoJFXV3Yg=;
        b=q1YcecQxrX3N+/gw0/sgZGHUh7SbF4urCp8A6mhF2Wp6twYmAKHHNXl1FmAKhIpqjk
         +RB1Pysj6BDLox9bysFQxnpZCE9C4TXbaDiCaUkx+HeT+GVtWffB+8E/jhLpyaMi5kUw
         cyKqQokERSluExivseW8RISoSBJRE9Mn3AhCkpChdU8xcUAf/E+QVHUrGUV+rV7wHsvO
         RXhwU6MPMy2i2CF4JG9ILtEtyjj1IG+muq28pvHAL02ymnh6g+H6LC6da+Y8xrPhH7cA
         gi9y8SxftI3AVqBi1TmhKOTuCKMDik1q86nBARnSd9My+h46Hk82MlNmCGoYFzP+zigX
         VWng==
X-Gm-Message-State: AOAM530TL9NgrepCJjeZcdin/PHm7A+mxcl4VQUIpjdPFPbMAHbW0CJF
        xJl8wqBSnCyqgDsixz9Yz2nJeiMiVcT1Dg==
X-Google-Smtp-Source: ABdhPJwvuzI+N2WCfruuw1gkbB31recXCKV3GPttBL1O1VhUNHV9j8BZSwJCKIvdrTYGKETRFXYeIA==
X-Received: by 2002:a19:7f02:: with SMTP id a2mr197919lfd.48.1606260314537;
        Tue, 24 Nov 2020 15:25:14 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id k11sm45828lfd.3.2020.11.24.15.25.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 15:25:13 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id r24so490228lfm.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 15:25:12 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr172684lfy.352.1606260312243;
 Tue, 24 Nov 2020 15:25:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
 <20201124201552.GE4327@casper.infradead.org> <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
 <alpine.LSU.2.11.2011241322540.1777@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011241322540.1777@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 15:24:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
Message-ID: <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 1:47 PM Hugh Dickins <hughd@google.com> wrote:
>
> I think the unreferenced struct page asks for trouble.

I do agree.

I've applied your second patch (the smaller one that just takes a ref
around the critical section). If somebody comes up with some great
alternative, we can always revisit this.

            Linus
