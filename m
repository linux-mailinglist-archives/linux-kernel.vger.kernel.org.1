Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC7300246
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbhAVL7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbhAVL73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:59:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D109223122
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611316728;
        bh=41XhVrbJvMisGa8SgXuCEu++brb3jDfv//VVCcb6Xv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R8S7ai3B9wjt+jz8B29j0gmvRmpiy1hI+j3mdFJwiY/1GjpqQcMJNIqDYVbk8ovt0
         7yiEa9kZMU1JHuVZvTtsNGewi0mNlODWYdvUIePJyVlHj303YlVD0Fm5JHWD6jxKyS
         8Lb5uXP/i2NpoZu9jrM7v0q5+LEshfvjTsRygzEjl7hYFbId71HQBUQ62DwqtkQAnZ
         XKCx7Old5qYjm16uPERLEbbt8wJKeHfPfjiDZHIiQ1QOqzUItMXAjRcJfpUAOAxWfS
         oVbTVHruUVA0Brh/tc1ZkloBBN6OApcWT1rt9UwxcXs5idaV5bYHaEqzrItY+ujI0C
         PaRtjgAgIzirA==
Received: by mail-ot1-f42.google.com with SMTP id k8so4801596otr.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 03:58:48 -0800 (PST)
X-Gm-Message-State: AOAM533oABXUWGjMZbf+YyvYyaaSDtFE+vrFZ57sgDO7EWUFrUiBfNc/
        lBvWkSQL5GEUpDGuhVLfoS/T1FDBUsnKZWC9Tew=
X-Google-Smtp-Source: ABdhPJycmaBdJXVVoUWaFE1PP7kRN12+ViduvzvmGYSqXUZAs5iIe6UMvsh+HbH4Y8VOjMbFGbwXdR5WDYHItHQk/7Q=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr3018396otk.210.1611316728056;
 Fri, 22 Jan 2021 03:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20210122114358.39299-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210122114358.39299-1-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 22 Jan 2021 12:58:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2qdugQt61nZ-nabnCsDLCwD5r_9e6tXKksmbue4hJBoQ@mail.gmail.com>
Message-ID: <CAK8P3a2qdugQt61nZ-nabnCsDLCwD5r_9e6tXKksmbue4hJBoQ@mail.gmail.com>
Subject: Re: [PATCH v1] misc: pti: Remove driver for deprecated platform
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 12:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Intel Moorestown and Medfield are quite old Intel Atom based
> 32-bit platforms, which were in limited use in some Android phones,
> tablets and consumer electronics more than eight years ago.
>
> There are no bugs or problems ever reported outside from Intel
> for breaking any of that platforms for years. It seems no real
> users exists who run more or less fresh kernel on it. The commit
> 05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
> with this theory.
>
> Due to above and to reduce a burden of supporting outdated drivers
> we remove the support of outdated platforms completely.
>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Does this mean drivers/sfi/ can get killed off along with
arch/x86/platforms/{intel-mid,sfi}, or are there still other
machines using that?

         Arnd
