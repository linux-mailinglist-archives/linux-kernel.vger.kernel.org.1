Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F62A7F51
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbgKEM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgKEM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:59:36 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77641C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:59:36 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id z123so713478vsb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJbxzbaK6alRkN3KAA7qm2brnHJLmJglDmQHC6FtNQo=;
        b=vcWgMVlhE34b/olsri9mfPB13ZaXcEYETJs1qQQzR07ZkuON1LaZ8aEEwlOXIFB5Y9
         qfcBeVJf+T1jW0qDs4GSwkdn6E7WLcKR4MwBHiWuuDOhJWVdUlMbKHj7boMMmXDHPVME
         t3PboL0B4NcAyAEKxGtZiqFVVdx75LIL8OswUPL8B0HINCN2mnT2d9k3prthz+NYVk3N
         rq4GxVuDVOvw0QisftrD1fBTqIp1jfi8pftfyKXAwnRuG4EKUWAny+ecMjcPv2wMM0Uu
         dDF4mxpq8ujzOEAp90ltQfgqvXKPPD6SmZAfWemTq1vjemDcHQzwqnhuX563ySNiMWFW
         kWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJbxzbaK6alRkN3KAA7qm2brnHJLmJglDmQHC6FtNQo=;
        b=PAvoTpHcNVqgUYJJcUGz6SLgyuJsVmaDmWR3oiIAyXe/roIUfFobiYIjSqS94HucqS
         AHz1XcEV72cyGHP/gx0MCxNGpB9NYVMIg6vpRlE84wLQe+g+LlHzX8KZpKbZq9UpX17y
         vSNGBamVpaFkbPWRItPZIZIptSXrdGgqAZJwozQiy/YOV6QyfuYZjY/tOaaF9FZ7bxtB
         DWXtSKj9MOg5bq0heuaugIr7Uu51D6sqsaMg7n1YbVrToHmiS4LrSTqVlhraKJU+iKiS
         BZfx+LqvxW+xAgom6V7BQt7bpggQN5hxuTmRl6e3nUsCzXfzlCaKSFUMpIUQIa/GmqL0
         sAUw==
X-Gm-Message-State: AOAM531gTKhU1BjD1Zi8VIm9LHOCrSCadEqkoWBK7JKDmy9N0uyEEeJ+
        brT0rk0nTAtI/oWPp0NqgjubRweetij6Z5RwaPucCg==
X-Google-Smtp-Source: ABdhPJzuaWYUBOkIwMRMHkD3BonAxkMWZ4mYIpHjfRENMAj704ilgvW/QZXAPp2KzESWhBRBWn2emfLqZwnsvGHyORk=
X-Received: by 2002:a67:f24e:: with SMTP id y14mr957295vsm.55.1604581175676;
 Thu, 05 Nov 2020 04:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20201031134818.2135446-1-trix@redhat.com>
In-Reply-To: <20201031134818.2135446-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:58:58 +0100
Message-ID: <CAPDyKFrC1Cy4gH9FOo90T7eCf8Gw1jgPGtDazGqF-q5SFW2dZA@mail.gmail.com>
Subject: Re: [PATCH] memstick: mspro_block: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 at 14:48, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/mspro_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index cd6b8d4f2335..afb892e7ffc6 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
>                 return "attr_devinfo";
>         default:
>                 return NULL;
> -       };
> +       }
>  }
>
>  typedef ssize_t (*sysfs_show_t)(struct device *dev,
> --
> 2.18.1
>
