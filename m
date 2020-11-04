Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06C02A6E66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgKDT6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:58:17 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48048 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:58:17 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by linux.microsoft.com (Postfix) with ESMTPSA id 98F6620BE4BC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:58:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98F6620BE4BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604519896;
        bh=uZrUpx0ezj073Sw3cdaOE2LEpaHDc19xq9VTUAz7ZmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mZdHOnZCairN+zku98+LatzUP3LmP35C07cxaSN/K/npciEb5X69A7CuLKCEKRji/
         FpLlESngm/M+ucs3ZYJmNetzGWBRMT71iiNb/FrEEPUp5Y9XjrBfpHAooWUxPCW6LJ
         /dUwLaeXNTFzRTm8pddAMthIHFrnsPpaDAJX/1ko=
Received: by mail-qv1-f41.google.com with SMTP id bl9so10514989qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:58:16 -0800 (PST)
X-Gm-Message-State: AOAM532tQyrUHnwAFLXiTYv8rjrfaP6d0vMm08XoTaGy1t2P0Loe65au
        QbR5VCRXOCqJLdEZgEdI0ruYNy9TvH0HUMLAmII=
X-Google-Smtp-Source: ABdhPJxnuK3c8xVgc4tG9EcoXlGa7nMcpFGmCt0H1uiCcAJN/kZMzKV6QBYQFJKLoCVNY7haFpjzB6FYI5w/Oog5aQs=
X-Received: by 2002:ad4:58d3:: with SMTP id dh19mr35064427qvb.14.1604519895686;
 Wed, 04 Nov 2020 11:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20201104194156.105814-1-mcroce@linux.microsoft.com>
In-Reply-To: <20201104194156.105814-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 4 Nov 2020 20:57:39 +0100
X-Gmail-Original-Message-ID: <CAFnufp3GFaQ2qJE2kwXHUqyTd1NZhkvAdcbr+D2kqsv=Vs=Xww@mail.gmail.com>
Message-ID: <CAFnufp3GFaQ2qJE2kwXHUqyTd1NZhkvAdcbr+D2kqsv=Vs=Xww@mail.gmail.com>
Subject: Re: [PATCH] reboot: allow to specify reboot mode via sysfs
To:     linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 8:42 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> +#ifdef CONFIG_SYSFS
> +
> +#define STARTS_WITH(s, sc) (!strncmp(s, sc, sizeof(sc)))
> +

Just noticed an off-by-one here, it should be sizeof(sc)-1 because of
the null terminator.
This way, the CR usually added by echo will be skipped.

Regards,
-- 
per aspera ad upstream
