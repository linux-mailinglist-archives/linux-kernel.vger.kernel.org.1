Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A22C1F13
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgKXHon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgKXHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:44:42 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29FEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:44:41 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d17so20954493ion.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvY/zTM2h4wL/LpgmgYVY5tAEx3mPbdJuEvi9xauaCQ=;
        b=p/S76T8vOP8S23e7I2kPiCmG/Z6NFpUrkUZUHwFIjBjTn460LCKD3FwoJUaz7d3nIs
         v/x5jO7vVNFYLMDaJc6EGmh2JZKVArv4Advo/irL8slY+dBxBFm5L4M2yMLO32rhJ5jn
         zbcLtx1HyLYTUjRdb4GHJ4adYerXc/lNNWjDDUTLCF+YHSuqomgYPiRJcT4fRwC5WL1p
         f55Zjx59m+BFe0AT8mlI54U2ZDtNHuqTmElRcHif5n+9i+a9rsqG9I30cKkt4RIFAymq
         adeGM3KU5b64wcfL2MwrcWQFwC5zV1IYt4f62VpbObIGoboyK9giGfXfhJJAmmvCMKRy
         aGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvY/zTM2h4wL/LpgmgYVY5tAEx3mPbdJuEvi9xauaCQ=;
        b=JUD4UDm629TrJibqkN9lYMt6WMEgMUEuX4BEHRLBfS05txjG3FimnXmAZjS+C9ZvEM
         ir8LICihDub07w1n/Zs+xL/Qt5YtS8AGOJqs1Cl0d/jl3eH69sWmKjMrJYsSN7aVYrBx
         8VkbI3o4DYmDY4h3pbEz3QXxpgXimQ9XmhXCqmQepD7pD9SVItzW58gplz7XN9bESJRK
         PV4i9LdhuFWZnIZKHD/Fv5lTEP+A4wAzSY98WkcknJXLcrNJ3mxYQFUfuw1NVZYTDENy
         qBKIy/Mw7ChQYVrmqz7fFNHjSlnANCtzxrOF8FUmJWUHMqlcYKvPl9oXitCQc4Gvonob
         tuxw==
X-Gm-Message-State: AOAM533C/rbD/WPVW/Sqp4iL8t+eNgahJ7r570ke/JdR+3FYEHrWNRDU
        HwaNbqUucH7DRk8DrqzgewunI5dQOJmDXhAzjB0XumMChLdYBA==
X-Google-Smtp-Source: ABdhPJzithm4YuKGHNGewOo/Bui7kn2ZGersM7beMqUzIsNGnvuvyD7renM5aBK8Eaa63mt4Fhr6+G6W7vFsU7jDjr0=
X-Received: by 2002:a02:ba90:: with SMTP id g16mr3374625jao.96.1606203881169;
 Mon, 23 Nov 2020 23:44:41 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
 <20201123172430.12854-1-yashsri421@gmail.com> <148208ef84344069a6c95d3f686a86ca1199be90.camel@perches.com>
 <CAKXUXMzcMWeM2M81b2PZ+D54LO6xd+m667vygWVF93Mnsq8QQg@mail.gmail.com> <8f6f634f3c4e079fd16922f2dd1109f2974319b2.camel@perches.com>
In-Reply-To: <8f6f634f3c4e079fd16922f2dd1109f2974319b2.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 24 Nov 2020 08:44:30 +0100
Message-ID: <CAKXUXMx599Y6oJ_XBJCNbuFnoU0MzsiFzENhnD3nN6D4tYj+aQ@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: add fix and improve warning msg for
 Non-standard signature
To:     Joe Perches <joe@perches.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 8:26 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-11-24 at 07:54 +0100, Lukas Bulwahn wrote:
> > On Mon, Nov 23, 2020 at 6:33 PM Joe Perches <joe@perches.com> wrote:
> []
> > Maybe a patch reduced to the very obvious synonyms helps newcomers or
> > people with lousy memory to be reminded that it is called
> > "Co-developed-by:" not "Co-authored-by".
>
> I have no issue with proximity matching for nominally invalid uses.
> I think the method used wasn't great though.
> For trivial spelling defects, levenshtein might work well enough.
>

Yes, that is true. Aditya has actually created two patches, one using
some edit distance to find matches and one using a fixed match for
those cases (the one you see here). Both patches complement each
other. But he has only sent the second patch to you yet.

I guess when the other patch is sent out, it is a much clearer full
picture how this fix option will work.

Lukas
