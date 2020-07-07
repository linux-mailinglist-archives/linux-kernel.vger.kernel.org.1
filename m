Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38F5217949
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 22:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGGUYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgGGUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:24:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED2C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:24:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k15so25530834lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XqDOhPELSzMgZFeHVQzNLAfVHgv7dPOLnk5RnzM4P4=;
        b=LY4FvMZzILikh15a8T4+gZcC0iBGtJIHSCWGKPXPFccoqV7BkYRThzmBYw+Gn++IR0
         KDHlg9I55kRP3bn6OA1SY3gKt8aJQqmugf/5wZuoWhDeEEHYDWHOD/dvGo2Wt9x4Qui/
         iilyA/ngA43BVbE72OqjP1/UYdQ3shqLk3Ktc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XqDOhPELSzMgZFeHVQzNLAfVHgv7dPOLnk5RnzM4P4=;
        b=o7gTZi4ZSEFKBmmshl2g1Jd1jd1gL8SOO7qs7Ap5M5F0wGGy0hMMHF4oMp42Jn4DcR
         bsRnLlYR6ny2boSBRTTZjsSfnC8cueUHNVNyiMJpXRJUFRIAwITp3T0+ZhN+oicqjxyz
         WNEnSfdUZGju+TwfO9ges9bPZqvdbPpEUjuKGNHGkixG+IuiFR4jKt2qM87nXJwobtcX
         9jLxWA/pm/E/2At1hIWLSv4rs4uhsq1pVIf5aYU/awlEX/oFqpE5/4Zk9EFgGJvkMKSK
         ukqjC53oMXk7RVexqqIgTM8TBun7fs+a0BDVyv3cgaN46BgDoKBsl8GSufvoioeVI983
         C5Iw==
X-Gm-Message-State: AOAM5336B0f9dWcBpgCfOnoy/BTmV7o0vIwRdRfdxNawnZHOrWVoCjDq
        Rk562EAv/swFNh7WSzc8TiMc72Fb5jk=
X-Google-Smtp-Source: ABdhPJx7F5ysMcLsDmxj9/R5SEiTsJ1lAwfynaOLPg+Xf/va5w5kD2flwis/SJR69BY6DM0Hw0PokQ==
X-Received: by 2002:a05:6512:10ca:: with SMTP id k10mr23736568lfg.177.1594153459136;
        Tue, 07 Jul 2020 13:24:19 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id o4sm9766582lfb.52.2020.07.07.13.24.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 13:24:18 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id q7so38276278ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:24:18 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr30598178ljj.102.1594153457543;
 Tue, 07 Jul 2020 13:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707174801.4162712-1-hch@lst.de>
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jul 2020 13:24:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
Message-ID: <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
Subject: Re: stop using ->read and ->write for kernel access v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 10:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Al and Linus (and Stephen, see below),
>
> as part of removing set_fs entirely (for which I have a working
> prototype), we need to stop calling ->read and ->write with kernel
> pointers under set_fs.

I'd be willing to pick up patches 1-6 as trivial and obvious cleanups
right now, if you sent those to me as a pull request. That would at
least focus the remaining series a bit on the actual changes..

           Linus
