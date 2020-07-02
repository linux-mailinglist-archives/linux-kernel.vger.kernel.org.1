Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437D4211FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGBJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:31:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042EBC08C5C1;
        Thu,  2 Jul 2020 02:31:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so5701058pjb.2;
        Thu, 02 Jul 2020 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQCFiGzSC0dQIzc+FHc1PqcfHEnA/cl3jUVDZmdRB1g=;
        b=C37eoVAss5f7k3Jv6M1iLAjeI0qjZql1L9XOz1cJU9NT4j+QdpYRAqo5uQ6Xa4HmaD
         4h99BFUHabpORXI0pNfdVpO/p4DR5w6RgW0AO3zzuRjY4/csAAqOjlnZ5uQ8b93fR1Q2
         pZgsuuZcBRreKuM37BSD9v5HCMhq8SPvdf18Ked0UwFkVaugq6ji2/7c301lfqXbMgTO
         zIeh3TZwtWfVHMurUj0AvYzbREUKmDjeFQgXeQrGQny0dwjY0xdtCzURvPlRfG8iPSIS
         UOCY8CkuNklRk5umzA7hxrh+EuM2MukAWKcNksgoH8oG1o35jUVpk8RNCgDpwHUFOtlf
         Wr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQCFiGzSC0dQIzc+FHc1PqcfHEnA/cl3jUVDZmdRB1g=;
        b=Nwzsit+1UowUpFzFqEWzjvIOoOCwrnM6shLKvwdEDo650g0KJgNFbHaaIkOBnigXCs
         scwwyxG3MW9FsfuT8EBtsznaJkA7PH482KUkM2iufwyOaxL5G7RuagvmPnynzdIxTQ0B
         VlHvs7frA5lQYAQsPneju9IZubT31W+uOELZm03pdffbUuF/dArx9Ex8qVWaJIRIUWek
         jrH3Wvn508DskmQ86AM6H/JRc7xM8lWIiUiL5Ed3eav/RGUMfoogyGHFw6xbZp4bR5lM
         J1CQWhbUli/Y0FgLRIZ89Aow1h0p7cRGCOlH6GS1XKlc1aGprAM/RZ3Hj7tG70KWijak
         UpeA==
X-Gm-Message-State: AOAM5339OUZqrXMsicsRCCbQjVvPZcqQJ1e1aHfOFhJfXDKclPTEY38i
        elFV5oh1nqGQhZyHT4Fd+CAF6AGNWYVeIR7gSMY=
X-Google-Smtp-Source: ABdhPJwzDsePThPXr8Uly2OY7DxQ0JKn7Q0cvpe4wEjpbNZ2ZOHX85j9e962wmtLBEBC4Dq2HnM3RGnphjPRRYtcQr8=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr27289148pjb.129.1593682276453;
 Thu, 02 Jul 2020 02:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200702085520.16901-1-aaron.ma@canonical.com>
In-Reply-To: <20200702085520.16901-1-aaron.ma@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jul 2020 12:30:59 +0300
Message-ID: <CAHp75VeCHW=GMgyHRswsTrZ7b3TEnFh15F-5fyHcUsqXzoFS_g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: not loading brightness_init
 when _BCL invalid
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

On Thu, Jul 2, 2020 at 11:55 AM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> When _BCL invalid, disable thinkpad_acpi backlight brightness control.
>
> brightness_enable is already checked at the beginning,

> Always print notice when enabled brightness control.

Why?

...

> +       pr_notice("thinkpad_acpi native brightness control enabled\n");

'notice' level is quite high, why do we spam users with this?

-- 
With Best Regards,
Andy Shevchenko
