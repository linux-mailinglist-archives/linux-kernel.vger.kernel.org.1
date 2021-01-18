Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6650A2F9F25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbhARMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390951AbhARMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:09:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:08:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m5so9668315pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3v2cH7W2qE6kJHWq1MaPOhEvBwAyXgPklbh+UIScQBU=;
        b=cxJI/Xa4o5tz3je0WDqKhxjNXMl/s+4bBu9FsB5SPRt3EF5AmdTeJbXdceC6kC1h1b
         Rj+/X9Ml3Xb74y0g6ysAkcQhY+Ms+Ysjze2vEWselQeZPg6smSoWCOMXMS/8fwmfDlIU
         xeiyBT/0Uw8W09p8zjFjwh6+uydGX6MidiP3VOGj/0u5b9qe6pPAAeRK3XDfVfyvevd0
         vTuS7FrpZJrvTCm5/a/bFvj3tlaWSQHDhBoB+5T9PqPE+e1NQgg60Y6bRzqrhsOgkbHK
         c29oobQjC2Tx/XVg9mGzdHc7fhEtSoPjna9u+WpxnVyvtj98729f+ZuSI2r+O87YVVyy
         Ofog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3v2cH7W2qE6kJHWq1MaPOhEvBwAyXgPklbh+UIScQBU=;
        b=IzUmX/FqRVr/I25QEMxyf1QHpXFxOxShtTU8CuofcFA13baylcgKZNPryawRbZM9/G
         SgX+8dFr2H4Ya0heeWMGR9PA3s67oVNl3gkQDAYrK6e41EAYJElbgiSwEfRZU5aau1hm
         gD36H/x+b60+WM+K/l/HQNv5vZh6cXHvMJwCijrCiZc9xe6FLIGTH+XOQVhxgbPKUzao
         qpBcw+/E4oE7NJWcMNfj9Q5ulJcIo9D1xkDnVGpOYztKed/9G9MhTckaG8ZaRQJSikaf
         lo9c6SufAb6baDGdTK+I1iHUjpFUqAuuBx/gztbpg1E+vlV11wu5YTBUR271uHb09Uhk
         tWjg==
X-Gm-Message-State: AOAM533y+b3nfWjfi/VoXHeBvwNPBATFmCRgQUgPHxxqX/SSRM2rNOpV
        osuAamPRaQCrmENWIO/lhBrwcr7uUfs=
X-Google-Smtp-Source: ABdhPJwrftUf2lEYlkvTpSgnkJsd7tQf5BJiHa2zU9T/GHCXKcFCn4uYE5i0hB2sJIgvb+ZGV+f0eQ==
X-Received: by 2002:a17:903:1c2:b029:de:ad0a:2dbf with SMTP id e2-20020a17090301c2b02900dead0a2dbfmr5216275plh.44.1610971736571;
        Mon, 18 Jan 2021 04:08:56 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id a198sm15887522pfa.7.2021.01.18.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 04:08:55 -0800 (PST)
Date:   Mon, 18 Jan 2021 21:08:53 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: add arch/openrisc/Kbuild
Message-ID: <20210118120853.GG2002709@lianli.shorne-pla.net>
References: <20210117080332.2289077-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117080332.2289077-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 05:03:32PM +0900, Masahiro Yamada wrote:
> Describe the subdirectories under arch/openrisc/ in arch/openrisc/Kbuild
> so you can use the standard obj-y syntax.
> 
> I removed the CONFIG_OPENRISC_BUILTIN_DTB conditional because it is
> already controlled by arch/openrisc/boot/dts/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thank you, This looks OK to me, I have queued this for next.

There was a small conflict with the vmlinux.bin changes you reviewed earlier.
I resolved them and did a test bild and it seems to all be fine.

-Stafford

