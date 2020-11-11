Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415862AF79D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgKKRyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:54:33 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D75C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:54:32 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id e27so4353601lfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5z5ZWxKl1XdvN7r77o5/F7KFBS3l/2PI63c9zLP4QU=;
        b=IJDhODGPEFIKEwMbT+gjJFRHugQW5o0Hlvzl8+o+nf98y8sQ3VdTfAfYeL/5ndK9KW
         aG8LwYMlatfX1lNMM9AQFeL9Wf4skmcYCGuv7sBm2S/ZhFPbKHTg5BbMp32OoiPTuRIr
         opV9yB8PTauJ3VpOi/LI/4Fcpb1qDDS0tA4Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5z5ZWxKl1XdvN7r77o5/F7KFBS3l/2PI63c9zLP4QU=;
        b=QjxCrpeQMpvLDGo749rmae/aTfiwvEhHW5FhD52/PS6/G4wfKh2TBbzLM/EKk08sUl
         jMpEK4e3uPkQMpyEcuV+coqEUpWghrNqjl1WT77+xZzyCE9af+zaQZD2f/OBsJ/Q+ih/
         RQYU7BwPIyOt9X2sqkXxGD0fwQC7Aojem7s213HpOlWsx/oIaK+ZP/ecNO7zqIazbeZa
         xtOLe9OEHkaVi9DSj4+S9qX2OgA7WAap0itl0gg3Cs4a9VNF9zh8DtR8gHpxBqLJ/2Xw
         uXhmWqr3eSaismLOwp5GY+tVEWeIfLoYDMHQL+ucT/owc57g1xwXq9tWYTJ//IMw0JDU
         XLAQ==
X-Gm-Message-State: AOAM531MWkdQYgiJQ2U+5YryMeaS3J0iT1jOfM62t0GKJQL6G8iyFVZr
        EdMh+DPzYnFH1gBvbsOwGUALhSrT8oGdnQ==
X-Google-Smtp-Source: ABdhPJwUZoYpobOpYtqAn3cIPaCjUTU5PJsvIU2sgY8TnqdgIv8Is7CSjxQ0k3+4VCJgq0ov2ytYpA==
X-Received: by 2002:a05:6512:20cd:: with SMTP id u13mr3008299lfr.373.1605117270808;
        Wed, 11 Nov 2020 09:54:30 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w12sm296472ljo.67.2020.11.11.09.54.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 09:54:29 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id x9so3043975ljc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:54:29 -0800 (PST)
X-Received: by 2002:a2e:a375:: with SMTP id i21mr8669216ljn.421.1605117268642;
 Wed, 11 Nov 2020 09:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20201104082738.1054792-1-hch@lst.de> <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk> <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201110232028.GX3576660@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Nov 2020 09:54:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
Message-ID: <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Any objections to the following?

Well, I don't _object_, but I find it ugly.

And I think both the old and the "fixed" code is wrong when an EFAULT
happens in the middle.

Yes, we can just return EFAULT. But for read() and write() we really
try to do the proper partial returns in other places, why not here?

IOW, why isn't the proper fix just something like this:

    diff --git a/fs/seq_file.c b/fs/seq_file.c
    index 3b20e21604e7..ecc6909b71f5 100644
    --- a/fs/seq_file.c
    +++ b/fs/seq_file.c
    @@ -209,7 +209,8 @@ ssize_t seq_read_iter(struct kiocb *iocb,
struct iov_iter *iter)
        /* if not empty - flush it first */
        if (m->count) {
                n = min(m->count, size);
    -           if (copy_to_iter(m->buf + m->from, n, iter) != n)
    +           n = copy_to_iter(m->buf + m->from, n, iter);
    +           if (!n)
                        goto Efault;
                m->count -= n;
                m->from += n;

which should get the "efault in the middle" case roughly right (ie the
usual "exact byte alignment and page crosser" caveats apply).

               Linus
