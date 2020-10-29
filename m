Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03129EFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgJ2P0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2PZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:25:59 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E761C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:25:59 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id p16so775544vkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKA8BKb8i1utD9tGg1rDX3comc5+Hr03WuwdtvMqQLA=;
        b=Kp/b/eAolt5iKyiqV0LryXlku0eukwKvS7YYnx0Vu5M0emCJ0KYgTEIo704jzP4yyt
         OdLEOBhAqDfj091ssnVd8CGhjHebyVzGGApz5dLvDrsAooZmE/+AZKpFslKMMpUMMWac
         rsUGUV69EQoGuBDnMQVQktMf5j5std+OnmQ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKA8BKb8i1utD9tGg1rDX3comc5+Hr03WuwdtvMqQLA=;
        b=iiA9BeXDKxZKd0Jca7u1YB22TRw4luVebgSg60hfz2yDx89nEQWZj+XFnLBnm7hY+i
         i9ROXexuFes4cYsH94nMuCKHgQJG9KiIR8Kh4Ih1AgKFMDPIizdDC5rhTXA6UZNfTKjZ
         7MvBz9lxfAdKGNzLtrVIGTmw3oCwU3hxWvZbgddyknHeiCo/NOOtuWLnfyfhtUh7qM+4
         a9NvlsdyY6uivnYLhio8DaaE8dETXB7ZiBAcCfL4eDrzosLH4ILxxQ4jpMNJ9TY9CSam
         ctssIVMWSJreMhux2lQLWvfPgq6YLDqEd/L6RwWFOJ6xf9zQx/79uGszXw0h9jxoVSYj
         VnPw==
X-Gm-Message-State: AOAM531ZuX0pIHHK02WNymsaxRSCgDAnefAQS4xsIHcm+iTOSvkXPNVS
        9XwhwbNcl1wThdbYLuB8QZhqStLsPvZFZWAtTGwL1g==
X-Google-Smtp-Source: ABdhPJyTqDIYeWl5UkkdMDkJjpCaNs+GL2C8l11+oxl+W7oJCToCDgBfPA9iGP0UmOptGW9XZi2xsMw0u5z9inQT/xM=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr3615428vkj.11.1603985158633;
 Thu, 29 Oct 2020 08:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
In-Reply-To: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Oct 2020 16:25:47 +0100
Message-ID: <CAJfpegtcU_=hhmq9C-n1dkCBOcTX7VzkdXDpOZZNh1iZ73-t0w@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix potential accessing NULL pointer problem in fuse_send_init()
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linfeilong <linfeilong@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lihaotian <lihaotian9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 4:52 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>
>
> In fuse_send_init func, ia is allocated by calling kzalloc func, and
> we donot check whether ia is NULL before using it. Thus, if allocating
> ia fails, accessing NULL pointer problem will occur.

Note the __GFP_NOFAIL flag for kzalloc(), which ensures that it will not fail.

Thanks,
Miklos
