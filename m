Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6F2B0901
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgKLPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgKLPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:54:30 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86ABC0613D1;
        Thu, 12 Nov 2020 07:54:29 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id i18so6041921ots.0;
        Thu, 12 Nov 2020 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MMQtN7Nbr6zgWARwui70WbLbCVVKRL1DcrlPGnl/Ue4=;
        b=EE7ELnPSH9qljHjoTnHA2ZP4SzySQWAi75w+rvGCgr6OpYHl/nUWBPMWiD7P1ZN+LW
         foQPoHUFiGKFRsvShNJfBayHKA6FAv05zLK5HJqc9vU83+hdJz778R8zVap4/EVFtpGY
         5+C3wVoWEWy/x9wkY4Rzrq1Qt2KRn6liZzLSsUaBc4Yml29fgGC8eIgEWHvBlF81F46F
         /zBW4B4V9gdc+8syWGvtNWV/ovHq5kO8i0MJNeZZzJsFPct5dN0PtVEFeIXirHYgSP7o
         f1kj4KsfwKXYwDjJcgW1xNMJRE2ScECjRWtiNRbIibIgsO5vJsNMHnzyjOcoJWYzssxo
         Do2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MMQtN7Nbr6zgWARwui70WbLbCVVKRL1DcrlPGnl/Ue4=;
        b=p1AMtXXS7Lc/AVqITGdHaMSbgDBzSjG4bYxqcjgt2kLAcDDi1HkNzDzgrXWfY9aOpz
         ACk7rixLanX+HrEZkkekqBzcMak6Qf8LTnC2XtpoBuNkeRr3fzX/QWj5BQGpmgtgPRAd
         93NDuH4EaDyBt3y4RpevH3eUs7yXEvOKuE078ZuhS6fl8A8JaNKvPO9t2coVdlqrfVYQ
         lX4gSYICJdVrF2n0fHhIeUYJrV9CPHJRcEX7UOhaad1HZLVvqo9HYa1xS8Fui/hCdwDh
         B5YSW3XlagtOj0S/QUftf1VH5ToH5vd+eIHsu7AbJYeQl6EsJpmh4NAfP7IZ9hiVuB4H
         JFmw==
X-Gm-Message-State: AOAM530DwzbwKa9Z+p4fwAVLUq6SYUstAX6SLngIvTJCLQoCRo2yhXpO
        gAHmEgP71gNmAeiCdoRYuutcK+qske/N3kve2KVwh1rh8wQ=
X-Google-Smtp-Source: ABdhPJwdGiaFxFk9fnJXsrIziAr7OViLgeoGxQozhv0pFjjs1JcwMznl5dpBiMeK/OBliZLiWSoJnsvSRuo7WlO5cUs=
X-Received: by 2002:a9d:3ef7:: with SMTP id b110mr21167453otc.333.1605196469227;
 Thu, 12 Nov 2020 07:54:29 -0800 (PST)
MIME-Version: 1.0
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
In-Reply-To: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
From:   John Boero <boeroboy@gmail.com>
Date:   Thu, 12 Nov 2020 15:54:17 +0000
Message-ID: <CAO5W59iCaHOZkjPvQ2zeSt6+T1pvhrDrKYfMqOkfCx7eQBVcsQ@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh for pete's sake.  That patch is backwards.  Sorry.
John

On Thu, Nov 12, 2020 at 3:52 PM John Boero <boeroboy@gmail.com> wrote:
>
> From 54f9886454e9a28e8d943c1cef15df9c11555df7 Mon Sep 17 00:00:00 2001
> From: JohnnyB <jboero@users.noreply.github.com>
> Date: Thu, 12 Nov 2020 15:28:29 +0000
> Subject: [PATCH] usb: core: Null deref in kernel with USB webcams.
>
> Fixes: Ubuntu Launchpad bug 1827452
>
> This is my first attempt at a kernel contribution so sorry if sloppy.
>
> There is some kind of race condition affecting Logitech
> webcams that crash USB with a null dereference.
> Affects raspberry pi devices as well as x86.
> No check on dev before dereference.
> Simple fix for issue experienced for months in
> both x86 and arm/rpi environments.
>
> Signed-off-by: John Boero <boeroboy@gmail.com>
>
> ---
> drivers/usb/core/usb.c | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index d8756ffe513a..9b4ac4415f1a 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -272,13 +272,9 @@ EXPORT_SYMBOL_GPL(usb_find_alt_setting);
> struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
>                                      unsigned ifnum)
> {
> -       struct usb_host_config *config = NULL;
> +       struct usb_host_config *config = dev->actconfig;
>        int i;
>
> -       if (!dev)
> -               return NULL;
> -
> -       config = dev->actconfig;
>        if (!config)
>                return NULL;
>        for (i = 0; i < config->desc.bNumInterfaces; i++)
> --
> 2.26.2
