Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC0A242E04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLRXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHLRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:23:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3A4C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:23:41 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v15so1575615lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrY/NxWx3/FaOMH2Zu/xiJfV6Atph/3rs8H9NXO5FQo=;
        b=b+S2a3dv91gBN5p4hLlLS3kGrhtpEqptSqM9+j4RM42U/tjZlfA5rD7v6Z2qIU4kAn
         NadltzA8Fkl37lUGOrDWZW2oPmMhkKva9Jy3+735PAhqC3zlJFArnTlW4T5zxWoFCWXE
         TjA3SPWJ77pB/afeA7ZSRuw8fAxCi87MmCf9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrY/NxWx3/FaOMH2Zu/xiJfV6Atph/3rs8H9NXO5FQo=;
        b=Ys9ilEEXKpGTJwLM6XvWU2vwa7W4XooFSk6ma2mJSeC3I2Wl0vK9HHsLryavRIVhO7
         tISDy+FmEeEvEeCPh3ere4fXj1dBdvc7nOvcTWeTkJlLv3R76HavDl3RmglkjeDL2Pb+
         Sl/rquXSe+pZf0MR9Nm9b0Vt96EAwOj6qeGyjA5FtDXnmah7ddaJN4G9S7BOxFCZ1hy0
         Hys7pQrcpr5znT8i/fBI0xNKBlCbrwvWTSprqVYzrgGzgG8dLVoyVGoXjr694lXKEZWK
         766RcsqXyTUWpwGH0GrYnaAvOCI2XlX9Nf0cJIyGYABAB9/d4wET0oyapgiznOwMIPTh
         mptQ==
X-Gm-Message-State: AOAM530y6Qe/zCRu6OAk3XGISSDSnIqdWJsr+S8MM5rmDwh4mTARiqYU
        Qsfs0FH1S54wxxizq5qzT2z6d9SyMjE=
X-Google-Smtp-Source: ABdhPJy13+i6Pz89Fgfms2wsUIKTkuc8dFd/YMApunW1QNQk/ZM7KSUa3zEMrs+WSpJ61W4M2aVo9A==
X-Received: by 2002:a19:f808:: with SMTP id a8mr232643lff.62.1597253019014;
        Wed, 12 Aug 2020 10:23:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n24sm557609lji.83.2020.08.12.10.23.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id s9so1586874lfs.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr215699lfa.192.1597253017201;
 Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0724405aca59f64@google.com> <20200812041518.GO1236603@ZenIV.linux.org.uk>
 <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com> <20200812055558.GP1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812055558.GP1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 10:23:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkE96-0OZzAJoyJEp_J9uKuojS9K9Zo-wuU+RUOcsiKQ@mail.gmail.com>
Message-ID: <CAHk-=whkE96-0OZzAJoyJEp_J9uKuojS9K9Zo-wuU+RUOcsiKQ@mail.gmail.com>
Subject: Re: [PATCH] Re: KASAN: use-after-free Read in path_init (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 09:29:47PM -0700, Linus Torvalds wrote:
> >
> > Do you want me to apply directly, or do you have other fixes pending
> > and I'll get a pull request?
>
> Not at the moment - I can throw it into #fixes and send a pull request
> if you wish, but there won't be anything else in it...

Ok, I applied the patch directly. Thanks,

                Linus
