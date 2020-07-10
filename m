Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6313921BEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 22:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGJUjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgGJUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:39:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52CC08C5DC;
        Fri, 10 Jul 2020 13:39:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so2712090pls.9;
        Fri, 10 Jul 2020 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4hcFrNamD57M+KydyUHhxTo+wBFWfBERoQNWvfd5dk=;
        b=jHER2mq0RW3s7oUnT62BSuh+nJT18yv5xeSFCAZ4dvrFqjGih1qqq2+n6YtUUe23nR
         YOrlHesVve4UrjUZDGiIBmNqU/ygISCLFjzBRDAKKXlggFcsbhYTQ+XXuG4LvFydmEWY
         HMyZgo0pCyU4vQhaV7ViY9P1m7mYNsmRymR6qpqYv+CsVzvp1oXyiqZf0QpAhQ3QILg8
         Wun7fEGyWU9C8/EktMlJoKD2f1ygXF6HHeXXZ1LLgFO7U7qHCfEbD3vePscDM6+6U/M6
         S8gH/WE4B39qyZztKeZiGhskG+ApKI/alZBPyyPX3tA3x64BQU6/hy5j7tIISL9cJFgp
         ucrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4hcFrNamD57M+KydyUHhxTo+wBFWfBERoQNWvfd5dk=;
        b=aMYSynsyvQzv1v0wCDlw6VCLaFRW2mLZrf18J3XyH5A63ML1BXmmpy9UJYGec9WJzb
         4mXSAMD+5cYD44ZkRp8NIRcpSkDAbmjZGlt6gIkpzDbVfQX3OxHHtnLTCMNuH5nZrLRB
         EY0Rv6eD2lpgD1MKDsYiUjZTaLv+htSKVNERQCExtHnQug6vNq/nhkb4dOLxVd3Ch79h
         ZDmrpe9ZDtnqJm6qOtY2iF63798ezteqciVtPeLfLSBe5pp1+7pZcMU5fDuZ9q5eHMiq
         Xvqm43cKBy3DewpJttZ0rX6GFYnfrKUWgOv+VW3z8jirNrj7YReDo9/HHeoNg1L/mxgh
         fU3w==
X-Gm-Message-State: AOAM532yVWPHl0aY4WmUPJDt1+2aZd5psC9ZModR8edw+pp7hgXoQTWm
        eqi0h/mXPa1RtyjS/ZhQ1XjLYJ1F+qIvseKj5QQ=
X-Google-Smtp-Source: ABdhPJzik9IFjwpeSv1uyJTptrG9UO41kEEFUEDwuT9LSNlLnN6ThhdXipjvF8Ao9eTJHu6BHX4tnEYSQkgxeOEIGP4=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr7858831pjb.129.1594413546467;
 Fri, 10 Jul 2020 13:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200702085520.16901-1-aaron.ma@canonical.com> <20200710015614.3854-1-aaron.ma@canonical.com>
In-Reply-To: <20200710015614.3854-1-aaron.ma@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 23:38:50 +0300
Message-ID: <CAHp75Ve9KGS+3PWCt20=vshfsw5EEjw42FjDAnKE8gwLVpRB6Q@mail.gmail.com>
Subject: Re: [v3][PATCH] platform/x86: thinkpad_acpi: not loading
 brightness_init when _BCL invalid
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     mapengyu@gmail.com,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 4:56 AM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> When _BCL invalid, disable thinkpad_acpi backlight brightness control.
>
> brightness_enable is already checked at the beginning.
> Most new thinkpads are using GPU driver to control brightness now,
> print notice when enabled brightness control even when brightness_enable = 1.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index ff7f0a4f2475..2b36d5416a3b 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -6955,10 +6955,13 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
>                         pr_warn("Cannot enable backlight brightness support, ACPI is already handling it.  Refer to the acpi_backlight kernel parameter.\n");
>                         return 1;
>                 }
> -       } else if (tp_features.bright_acpimode && brightness_enable > 1) {
> -               pr_notice("Standard ACPI backlight interface not available, thinkpad_acpi native brightness control enabled\n");
> +       } else if (!tp_features.bright_acpimode) {
> +               pr_notice("ACPI backlight interface not available\n");
> +               return 1;
>         }
>
> +       pr_notice("ACPI native brightness control enabled\n");
> +
>         /*
>          * Check for module parameter bogosity, note that we
>          * init brightness_mode to TPACPI_BRGHT_MODE_MAX in order to be
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
