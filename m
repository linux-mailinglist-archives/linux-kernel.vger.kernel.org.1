Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73462A990A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKFQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:05:16 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:05:16 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k7so855330plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoXLdGBXdDw+uNhHPXkAApRLi9OkMFj360uNnK0TzyI=;
        b=jxymNEiBQdKqAHykPjKbWpEhm4u9GCjg7eq5wCGyJLgHLTYslfM/0NPk0SXdfY24QZ
         cnpnmr2OE9cBW3K8cFRTos0+c1g5aRS87zl4gsPQecUKK3amXqdY+jjM+Q1nEYwMSJor
         JqheHA4SZJwORlrnrHUIlAjyb4X/ts3GNBBSAubExNR4oNKpQCWRPaFFcwOaBdReFR8P
         gUb8hdP1kCHx3otLu+Vvein8AqOttA77bCacIArXzOqpFzJYdob1AllyM63YX2IFVQ/O
         ro4Y1eWnlSN3BjVMzZ8AZPQZZDJWLEIJK/DXrp7l4yon8Mur8vvUBjCCLgLeXL/Y6Neq
         Qv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoXLdGBXdDw+uNhHPXkAApRLi9OkMFj360uNnK0TzyI=;
        b=q+RjPq8lkjr4B4ttrgJBARLORpzO0+QcW5SVhpIbbsAe9jYLSPAKK03T5iD3t4d3YG
         yXaS/qKNJiRuyPaVV6AXILtFCEJ1UJCryWEEUpjwYccR6nzqWBz+A5mw9DUqnWp5id72
         32w1kFEgSYhW/wefV0gPtOZvJbXvIqqGi510RvSGpdFUgrF68GcLmevBtAs199Y7YgBo
         mYQjS5pZS7YojCu+NvXMWU+iLebsX8eyRbuS0Lt3sFK+077cnGUyiUkXQ5muVjPjdlzq
         RlGNOrHA2EALIQkYv5zbzPeQbanK+X2SQx2oBA14Q+yu+VgYmQ8IdyvKCkJuEmGV/woB
         /y5w==
X-Gm-Message-State: AOAM530TaEal00LaD+xqPknKV1HlrqX0EXz81vLlZW12bXBs4xNxoYYj
        bpbx5gGXykbRhWO/iBRX277CGdkxTD0h4c2Ucic=
X-Google-Smtp-Source: ABdhPJz/nrWsBe1yaqnUnN57MUNrXaKdxF0bSsQg2P3Pu351GfUOcDtnIp/ZKl5jKvXBTQu/50DK+x9OZX4FbR9elts=
X-Received: by 2002:a17:902:6bc8:b029:d6:d9d:f28c with SMTP id
 m8-20020a1709026bc8b02900d60d9df28cmr2172651plt.17.1604678715972; Fri, 06 Nov
 2020 08:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com> <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
In-Reply-To: <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 Nov 2020 18:06:04 +0200
Message-ID: <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 5:35 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Andy Shevchenko
> > Sent: 06 November 2020 14:36
> >
> > There are few places when GENMASK() or BIT() macro is suitable and makes code
> > easier to understand.
> >
> ...
> > -     if ((d & ~0xff) == BRL_UC_ROW) {
> > -             if ((ch & ~0xff) == BRL_UC_ROW)
> > +     if ((d & ~GENMASK(7, 0)) == BRL_UC_ROW) {
> > +             if ((ch & ~GENMASK(7, 0)) == BRL_UC_ROW)
> >                       return d | ch;
>
> Do you really think that makes it more readable?

Yes. Because this tells explicitly how many bits are used for metadata
vs. data.

-- 
With Best Regards,
Andy Shevchenko
