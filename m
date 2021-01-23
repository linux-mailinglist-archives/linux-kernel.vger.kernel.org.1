Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3247F301548
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbhAWMsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 07:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbhAWMsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 07:48:38 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F1C06174A;
        Sat, 23 Jan 2021 04:47:58 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id p185so8294720ybg.8;
        Sat, 23 Jan 2021 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aN7EytHww5N3j3kFCgyO4SKFxPdfz9Op56FRrH/YQkM=;
        b=iuaePtEUtbUdGJqILq35UWZCIWyMWPyZFLybCS6Cg638mLIi1lzVhMYxNy1C9cg/f3
         Df8p0EHIakqHY4LWWL7SrwarNlvzuKgcF+SU57SkWseLOIDkhEE7xNm2Y5DMLwdGssqk
         1sc1XTGdjIx2buyaCoosL/RLYEcNxpaxTRCWC8iuz9d9582mSFt8KlO86JSQD2JcC6ZO
         yHneLKZRPu5XYqtaAgwAMLS+ydsmrzcb+Lo/x1NCpmcSixeq6MzKsSSVtOvB0cl3Jj23
         h1ifLx9qDFubl1wVnDY/e5NU7ZM0Fnlai7QWadm8jm6bSOll5dLXw29yVWv6c0F5fznu
         3nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aN7EytHww5N3j3kFCgyO4SKFxPdfz9Op56FRrH/YQkM=;
        b=nhFqIIYWjmS8R2ab47FNAE4UjHDxbncP3BYK+ubOVi9ANKaRYkr4QhkdbLxmORN2KH
         nhIVU3tSIjW69rlrgDh6wQBZea7kUMpkIoNpJOcSDp2I0h4BkB39WIs4K60pqTXNsdQH
         nS3mZzsZN3LEX3L0dRLmva0M+NIHXbwvrGb0+pc7KACGYU/KvztVKX9rs4bOr3VnrDB2
         Tf+XBhUOi5/YA3v/J3fJ8IsRz/WvaxP/WD85VCoMvz14KpCX1UFqIB84BeDTbxr734fh
         WHuG1NQ8XDezvgLz8LR6E7kaKHXjFOZq00QqgBYlPV5tDYO5qCV4/kOxAmj/oY8Mo43Z
         fW6w==
X-Gm-Message-State: AOAM533UmBC0fHwtAYwkv4eTGVyxQBSzO1COXsoHYfHC6D95UT5EaUvL
        SSNMKeazEXu1vH5E8EM8scOIIuR3Dwq8sqCEmGvHp7uno1A=
X-Google-Smtp-Source: ABdhPJwNDSQYB0qrlV678QhKNABKUuL0Jnc5SUIaiSKyPSHV8/HbWsx/7zQBQ8epfsYNBWSApO8cBu2gFTyauQSBWqk=
X-Received: by 2002:a25:d84d:: with SMTP id p74mr12182691ybg.135.1611406077522;
 Sat, 23 Jan 2021 04:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20210118123538.564597-1-geert@linux-m68k.org> <14593d82cd227439a9763d6277186f76@protonic.nl>
In-Reply-To: <14593d82cd227439a9763d6277186f76@protonic.nl>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 23 Jan 2021 13:47:46 +0100
Message-ID: <CANiq72k0JOpfvcf6uFFbdBFnmwBVPmrBDuPRPmrqOKrDAKjCKg@mail.gmail.com>
Subject: Re: [PATCH 0/3] auxdisplay: ht16k33: Improvement, fix, and
 json-schema conversion
To:     Robin van der Gracht <robin@protonic.nl>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 2:36 PM robin <robin@protonic.nl> wrote:
>
> Thanks for digging this up. Not sure why this was dropped. I still think
> it's usefull.

Not intentional -- probably slipped, sorry.

Cheers,
Miguel
