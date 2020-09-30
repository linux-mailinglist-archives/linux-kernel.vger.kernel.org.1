Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE027E73D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgI3Kym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3Kyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:54:41 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA51020754
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601463281;
        bh=ddv7KUcya5X97yhlDyId8wharLoZ0UcUxUGD2QWgNh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W1vVZaHGP6Bvxw+u+a9xRUNWaXlTJlVPvbqwQRlrxtJALTV91uN//I77wqvHT7moa
         SBBL6ZutpA/w8sIPiE21zUe7XFjde2zdYx41pXE1NB48hEO3dh66UFQNQW6XuCSqtW
         mzk3MftQZcmWO6STukPBpmv7e6+V8D+lAHu6qPCU=
Received: by mail-ej1-f52.google.com with SMTP id z23so2075998ejr.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:54:40 -0700 (PDT)
X-Gm-Message-State: AOAM531+v7ZAwu3Ctx6rp284ECcrWF+CcZTaYpRHMZBoqi1oxfrZi7Jp
        77tHYeQHTk9QYaDBsv0fnhMmuyeMeNSrqLJYkv0=
X-Google-Smtp-Source: ABdhPJxZAPYsXeGQmJUdOIf4BxUahQKpPUDBior8DwXyJMNMmx1LZGo0fZoMgLd7MLY4uOxPoHPKZ3MCf+itgq0axbs=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr2094592ejd.119.1601463279578;
 Wed, 30 Sep 2020 03:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200830122922.3884-1-shawnguo@kernel.org>
In-Reply-To: <20200830122922.3884-1-shawnguo@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 30 Sep 2020 12:54:28 +0200
X-Gmail-Original-Message-ID: <CAJKOXPekUJzdKBxtG7BSPbJw172hAogMgLrNDQEGBNnRjY+FxQ@mail.gmail.com>
Message-ID: <CAJKOXPekUJzdKBxtG7BSPbJw172hAogMgLrNDQEGBNnRjY+FxQ@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: add email addresses from dts files
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 at 14:31, Shawn Guo <shawnguo@kernel.org> wrote:
>
> MAINTAINER file will get bloated quickly if individual section entry
> is created for each .dts/.dtsi file.  Add the email address from dts
> files to get_maintainer output for saving unnecessary patching on
> MAINTAINER file.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  scripts/get_maintainer.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

I thought this was applied... but seems not, so my previous email
could be ignored.

I like this approach because contact details for specific boards are
useful. So +1 from me:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
