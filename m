Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8C2D77B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbgLKOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405940AbgLKOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:21:51 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F35C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:21:10 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id s23so2890729uaq.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnFp9RbB9wQQJXRSh+J9XRRP7zAmGLoO9EugBvK4tDg=;
        b=rDPJ7Ckd3C/fw0396+Qmzza6rNsVm0sElX2DKpLjVtSwcKdhsQPe++zFmI0+S3hD4E
         Fiy2lO6bMrKh5klWqOWHL/UkZiwO7RDm/gJW0xlBVKOUBzLPd2cdycJAHt1FExaevdwY
         Vj+/LfuUsv3jEw6+5MMxLRZWGTfk7sUH2gFfCdE24XbJNC34u9FxRVJO6aq4MVUKxq5z
         77ozEwUhnmjptB7xGs0X3weaby2g+W8In5hCaDjriKx6kDfNFSODivyso/dKvLK2V2k9
         sOSQH/oeIaEM2Ki91VTAYQDNISpn1EcuvAZYkdBAoMVqD5VV4Q84eep2yAR6n7quVOeS
         pEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnFp9RbB9wQQJXRSh+J9XRRP7zAmGLoO9EugBvK4tDg=;
        b=CvpTlScHUfo7qAby/z9X/k86nKhqfePgOUBFE+9dp9ujcYP7pB0FsB0xPODuJ2kvrW
         0e6DkY81Z/vrpUvAI5voiyj0Y7q5L9p1G3zEeni2KzUmOlSCBvK0aTvy/zUOJP1CHbfe
         Yl9vxhAXAF+RYBQWYKUmraQoqyhjzvK/LGBpTO4lpULzQJYxBE0vRk9r42p4b7b8X+cc
         861ehit+MItp9Pl0mRCF7PGWNaMRIb3OjcGP19CPG3Ypf9BlSmMGuaHfIds/Mi1euHFJ
         rYkRxkpywyzlFC2Q7UvIHvC1HBYcNbjefnffVAU2jRxo1riKxW8bW9Uls+OEScaKipCL
         M//Q==
X-Gm-Message-State: AOAM530bD36S1TzjAGA6mNDfIP/4Bay4e1CtuXwcdGcp4hl0S4nigBwJ
        jQp2cQSkhwJitDBDYG2sGQGrOPAjhij/lfmESm8kiHWNJSybk+oy7cw=
X-Google-Smtp-Source: ABdhPJyQLTaKPvIqxy25PPhpXK+U6oey+7qtJRvdYCJWsNqNjLPhBQuXQsmqEUuVCc/AT7jY3M8WQT3Pd9pJCK4Twss=
X-Received: by 2002:ab0:1c07:: with SMTP id a7mr12507808uaj.17.1607696470025;
 Fri, 11 Dec 2020 06:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20201210203318.6914-1-semen.protsenko@linaro.org> <20201211141624.GQ4077@smile.fi.intel.com>
In-Reply-To: <20201211141624.GQ4077@smile.fi.intel.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 11 Dec 2020 16:20:58 +0200
Message-ID: <CAPLW+4k3z4TjR6RPTLwkOO8tqY4ptDhPRCEJBZH0cfXu+qA2kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: dwc3: drd: Avoid error when extcon is missing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, 11 Dec 2020 at 16:15, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 10, 2020 at 10:33:18PM +0200, Sam Protsenko wrote:
> > If "port" node is missing in PHY controller node, dwc3_get_extcon()
> > isn't able to find extcon device. This is perfectly fine in case when
> > "usb-role-switch" or OTG is used, but next misleading error message is
> > printed in that case, from of_graph_get_remote_node():
> >
> >     OF: graph: no port node found in /phy@1234abcd
> >
> > Avoid printing that message by checking if port node exists in PHY node
> > before calling of_graph_get_remote_node().
>
> By some reason you have two separate messages (missed --thread when run `git
> format-patch ...`?).
>
> In any case I think it should be dropped or reworked and resent since patch 1/2
> got comments.
>

Yep, the patch version bit shouldn't be there, just forgot to remove
it after `git format-patch'. So this is not a series, just two
separate patches, and 2/2 was just dropped. Anyway, I'll resend this
one soon, to remove the confusing versioning part.

Thanks!

> --
> With Best Regards,
> Andy Shevchenko
>
>
