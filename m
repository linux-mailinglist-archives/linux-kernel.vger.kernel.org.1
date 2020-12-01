Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356972CAB1B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgLASyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgLASyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:54:20 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:53:40 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d20so6361207lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2qeRu/LeJOscAYThRsCGXT4SMQV2re1YPCsWBbPqRc=;
        b=rK2Pj8AUNIWuRIo19w+AThX5iFBV7G71XMh0o3Y1lHfwC1op2ZT+Ds+rCfuUN6n6d7
         1ykwf6Ywr1VjIujuk1nfGj5be+1k7OJ68arM5Q1lHeNvFEDq7XNmYlLhh6R7X7mHOpOS
         myi6IZvJB8EsF5v2xd437mTx0ucyGR6mTBJpbbviaCRAG4kXWkrOVrsZ9k9do23Q3l2Y
         C1qlBZuvB5HRsS6P2Hk3PRdStJQUhmNSlJ1dZmqFVQwjV6GwFcbTGPDEHeEPWq9gFAAH
         Yz18P3pKzjSkJKSjh2mRpPiQ0e/CK5WhjAHLJGcDXehdRSRfyGG9e7sT0ku9mCD7JlR4
         v0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2qeRu/LeJOscAYThRsCGXT4SMQV2re1YPCsWBbPqRc=;
        b=M904T4nNk7GzgR4WoZwHXHIsSUEXyvlrwZ7Y0IqL3UuEYRznnbLPaf+mj9k0iE8X2O
         jTAvxdw2wBeBzYbY9ooWGJIrpOMisHmMzOH22TXoRUk9W367vI+r6N6Uvtu1e1XW4Vsn
         y4V4xD4lpggJPKJhh7jr9c/YObJybmYHAeqyRlxmafBtirt3Gj2TiLqMAqqeWqzEL0t/
         gdKuWOXfydtnScvUfLIh5yWRWerzyDesUkgCL9dvnI+8YevbTqaLsPhM16F0vzFGiAYz
         rL3Gbz8Z+5LoKXDcYOAazBxUJ/t/hb3yoT02wYrWnPPc1gwOP9i5TwElIB1Vg9EbklFs
         QzDg==
X-Gm-Message-State: AOAM5315njh0Ki8TsRZLcLcNgfaefN2/2yJDgRHuST97MRgZXeGHWLxK
        Z+UlroJ7jdgh2Taik4svdBKmda8ESI+SieBDrgH5yx64JIAfbw==
X-Google-Smtp-Source: ABdhPJzVcEtnodYh2pnvREeVDWuHhxl6qGmUGOqC5xL1m0tP0kIKv1axWSCin5LLtY9uzzHHpIoJgcZz5d2YlNpqS7Y=
X-Received: by 2002:a19:9c7:: with SMTP id 190mr1949940lfj.545.1606848818502;
 Tue, 01 Dec 2020 10:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20201117003135.1749391-1-rkir@google.com> <X7OUZmlRAuwWWHEn@kroah.com>
 <CAOGAQequ6hhzCjpf8V9vp=0xrAS3rs283goSFFfxVFw0ByjfPg@mail.gmail.com>
In-Reply-To: <CAOGAQequ6hhzCjpf8V9vp=0xrAS3rs283goSFFfxVFw0ByjfPg@mail.gmail.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 1 Dec 2020 10:53:27 -0800
Message-ID: <CAOGAQeq3jcksFbp8EWtW_XyuqkOvvFOHW2J3wp60ug7X8SgnjA@mail.gmail.com>
Subject: Re: [PATCH] Update MAINTAINERS for goldfish-rtc
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 2:43 PM Roman Kiryanov <rkir@google.com> wrote:
>
> > > +M:   Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > +M:   Huacai Chen <chenhc@lemote.com>
> >
> > It would be nice to get an ack from the people you are removing and
> > adding to this entry :(
>
> Hi Jiaxun and Huacai, could you please ack this change?

Gentle ping.
