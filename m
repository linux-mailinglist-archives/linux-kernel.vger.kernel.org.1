Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909072A4FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgKCTHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:07:50 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E705C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 11:07:50 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id i2so20287034ljg.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKUHzsviEuokxUGu22QFHyaH3lLKMM46sQ9d27q6DnY=;
        b=EzdzLMp/DLlOuVI3UfWBZa3MF6YmJiHzlplfPPXBVMASkRf9Sf9vzP9/wDbjlH37K7
         FUzOZepTJ9Zk8DxHsS++APrkxbxeHOgKk4I+HPOv2lXAogfFlbdAQ2lzXt3Bq5svOW47
         5eCW6xfTvMI+6aKzHBA0ba2616JChJCv8upyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKUHzsviEuokxUGu22QFHyaH3lLKMM46sQ9d27q6DnY=;
        b=Xq3GyzbU6Vp2SyBFww+KmAimb5g48N+mY9sTkPyHt9KxI0mxJi6+hz0JiYYTsILW8P
         /DowqZdib582ADhoXLIPTRfBTVFYov35/prgTYC8m9WuUAdzg7/oyHmPxpQMj9o44xzj
         4kaw1PGEQOdRQC51WqPZRg/PJ6az6ZHHlF3dGS6PvtgR/ZqNn7F2/JqAIOv2BKqVN2ik
         eYcs0pi6vLUh1GS+YICp1+CIjwq/U8oTb7mju+L0WKaZFVfHSzfE0ihBS+tPj1KqClKb
         ddtOt9e8ia8nn5v/vDYiR3Uem9QUtejVIBNcgQjZghK9zDO11DtNC4s7P1LVgbOPbLlX
         OqlA==
X-Gm-Message-State: AOAM5308A27BVkR6C7CkedkvULwyALpbySB44LClU3qvsyl3q4CZe8aU
        TeISYvNKSfKdLqfYYhRAbOugXUYw/GEP7w==
X-Google-Smtp-Source: ABdhPJxk0H67U3Cn86O+tE2tTjT5bePiTq0ywXN8TqnY993p1fbPqRXBTOhnXTmvGxo5MCZEV/u5AQ==
X-Received: by 2002:a2e:b545:: with SMTP id a5mr8785616ljn.274.1604430467759;
        Tue, 03 Nov 2020 11:07:47 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h10sm3863371lfc.147.2020.11.03.11.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 11:07:46 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 11so702894ljf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:07:46 -0800 (PST)
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr8682395ljj.371.1604430465892;
 Tue, 03 Nov 2020 11:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20201029100950.46668-1-hch@lst.de> <20201103184815.GA24136@lst.de>
 <CAHk-=wha+F9-my8=3KO7TNJ7r-fVobMrXRdUuSs5c2bbqk1edA@mail.gmail.com> <20201103190253.GA24382@lst.de>
In-Reply-To: <20201103190253.GA24382@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Nov 2020 11:07:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvkBYOq0-xRH1YGXn4imB2iDVN1wEZisMcQd7dPeNbuw@mail.gmail.com>
Message-ID: <CAHk-=wjvkBYOq0-xRH1YGXn4imB2iDVN1wEZisMcQd7dPeNbuw@mail.gmail.com>
Subject: Re: support splice reads on seq_file based procfs files
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 11:02 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > IOW, I'd start with just cpuinfo_proc_ops, proc_seq_ops,
> > proc_single_ops, and stat_proc_ops.
>
> I think Greg reported another test case hitting /proc/version

Yeah, that would be covered by that proc_single_ops case.

Those four cases should really handle all of the normal /proc seq ops.
Anything else is going to be something very special.

               Linus
