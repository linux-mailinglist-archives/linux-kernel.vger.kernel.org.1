Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835CD29A942
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897534AbgJ0KMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:12:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43975 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409953AbgJ0KMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:12:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id k68so618178otk.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+mmjbgxz7auKG04toQ6k7uU12GJAUkStUuedToR3Bg=;
        b=CXl7YDKdMYcJnNPdMOxXIQMkEmen0r+kn7D0AEpWZLSx/U7h7ljkava9ZDbIcxWAdq
         ek3D6RwGsxd4MEVV5J1xz8zl+jOZZN/z7C1nZqepyedmlSma2QxmGHSYYWHkMAvkE0NP
         CgX0qWdVxO+7Y+sWgyJbueWSqEbXOxsNx/Gjet9+cE5FHzeBih93aFQvr4hrc+wauJJE
         VXqF8HJL4RG4a5jgYGfkjGGvcsPADVHhMiUMFm2Du6P5mZa4Z1dUm3h0lqr5CyO/KScN
         5XqInig4D99TewwgJLR9JPQq2Kzlju761hqYpTVzIRnCPAxDkB1bnHeM9E19lEWynPhU
         4rsA==
X-Gm-Message-State: AOAM53246odm3+9P291PA3TDM5xvTF5tI7TOUObzsJc7Z8mi6IZbrDEg
        clQ4rq8XcLDUprTP7uLkahbbk8L25FK1KSSanFU=
X-Google-Smtp-Source: ABdhPJy1JLn34/LKUeA1d3fE8wATzvftpqnPpWaDKgVTpxj7P9r09MoOzRfFoZ4O7qE4ibsNZmPRpyaFA+rbSdm5ygM=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr941687otb.250.1603793524792;
 Tue, 27 Oct 2020 03:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200901224842.1787825-1-saravanak@google.com>
In-Reply-To: <20200901224842.1787825-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Oct 2020 11:11:53 +0100
Message-ID: <CAMuHMdUcxX1Zvb7X+uxLa1u0WkOtS8hAZ000+Ta+7SCdkeJO8g@mail.gmail.com>
Subject: Re: [PATCH v1] scripts/dev-needs: Add script to list device dependencies
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Wed, Sep 2, 2020 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> This script can be useful for:
> - Figuring out the list of modules you need to pack in initrd
> - Figuring out the list of drivers you need to modularize for a device
>   to be fully functional without building in any dependencies.
> - Figuring out which drivers to enable first, when porting drivers
>   between kernels (say, to upstream).
> - Plotting graphs of system dependencies, etc.
>
> Usage: dev-needs.sh [-c|-d|-m|-f] [filter options] <list of devices>
>
> This script needs to be run on the target device once it has booted to a
> shell.
>
> The script takes as input a list of one or more device directories under
> /sys/devices and then lists the probe dependency chain (suppliers and
> parents) of these devices. It does a breadth first search of the dependency
> chain, so the last entry in the output is close to the root of the
> dependency chain.

Thanks for your patch!

> --- /dev/null
> +++ b/scripts/dev-needs.sh
> @@ -0,0 +1,315 @@
> +#! /bin/sh

On Debian, where /bin/sh -> dash:

    dev-needs.sh: 6: dev-needs.sh: Syntax error: "(" unexpected

When using bash, I get:

# ./dev-needs.sh /sys/devices/platform/soc/feb00000.display
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found

# ./dev-needs.sh -c /sys/devices/platform/soc/feb00000.display
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found
./dev-needs.sh: line 255: detail: command not found

Which shell should I use?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
