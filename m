Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4A26E703
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgIQVBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQVBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:01:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:01:45 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so3119379qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71NkNHP0R01eMpLBKZ+eul66Yg6+u+oK86rQqAUsTRI=;
        b=qrS6RlXv0SSH5MY2IRAA4hFZaIZEZ8sCa9b3drzGXkH7msyVVJl2CY7qPJuO488s4w
         z6dkkcEeRdPBeVeMx0KhHrt7Wqx3oQlMotQZacO1c5oLQp/2ba7N8JteLENPKMxCJqV0
         4xNpEFhMAwYT01QiYvrvFzMmh+absFaOkjqk9LbmigCXSZm/2xtAOQ8mrttiYbfbTpYE
         KmQcc/z8dSjq0q6KShUaGmhAizehyes1y5TZKAy5cB0Q163MXr2OE+5NISyrM5YWr5B9
         oSFTu7iekalP1aodD3z2IW8uXatSz2ZCn7exRBt4aizZllPHMgqdqtO7VzOeEmP36XaN
         4fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71NkNHP0R01eMpLBKZ+eul66Yg6+u+oK86rQqAUsTRI=;
        b=TkD9H/8GWROWjXc9gNkXxgR2EXC7en6go8r0x0Yuf9bbOaK2RaGLn2WTsASs9Ds3Fh
         OdnGzYfWtNm2Xep36lwlBbsAASqh1yFeOZK5pFU940bdhfu9GoAXsIoRIVAw0m1QGdUd
         aUgzaQLxXLnVsYSWMfEoW5nhYyAl6ubx+S3FxByDhu53tXpLmBOQfEUXaKmbNcAOU3VO
         ay686Y9IDEtrwa1lQRwbh6ENrIcQwQ97EElHhEfMdK+OzFwr+6/gWLf+2wUO7IudJMfm
         /yblXHsi8Vk+VJTySs0fMaXjIjLoqIFnAadoAMseHkUL9v+8vr2fATFNMJmQJ7EnZFjR
         oJGg==
X-Gm-Message-State: AOAM530estQS1rMTUCCz24cz+Cj8lR09G6NMp1QJ/FLDCCkJajFYHAL+
        /TXRD4vte4zpIOA2nrLZNozoPRm7cR65E7ic2pGroH3t
X-Google-Smtp-Source: ABdhPJycV7BNmRRthSEHTlFtoTdelAi0Gj6AVCUBCe66kU0oQcmdd67QHHwJ6m3H/8GtiHO3kmy+tUfk8HU5vfFg7p4=
X-Received: by 2002:ac8:76d0:: with SMTP id q16mr17885308qtr.164.1600376504666;
 Thu, 17 Sep 2020 14:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200914135654.55120-1-wanghai38@huawei.com>
In-Reply-To: <20200914135654.55120-1-wanghai38@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 17 Sep 2020 23:01:33 +0200
Message-ID: <CAFLxGvwpspyEQ2PUORZt+aKmcXBrQ2i8q30WwCAq3j6FGd6p4g@mail.gmail.com>
Subject: Re: [PATCH -next 0/4] ubifs: Fix some kernel-doc warnings for ubifs
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 4:06 PM Wang Hai <wanghai38@huawei.com> wrote:
>
> In the ubifs module, there are some kernel-doc warnings,
> this series of patches can fix these warnings.
>
> Wang Hai (4):
>   ubifs: Fix 'hash' kernel-doc warning in auth.c
>   ubifs: Fix some kernel-doc warnings in gc.c
>   ubifs: Fix some kernel-doc warnings in replay.c
>   ubifs: Fix some kernel-doc warnings in tnc.c

Applied to next, thanks!

-- 
Thanks,
//richard
