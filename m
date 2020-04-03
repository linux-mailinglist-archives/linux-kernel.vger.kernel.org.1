Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985EA19E100
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 00:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgDCWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 18:17:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40463 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgDCWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:17:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so7072303lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EY7qB3E4P6Av4/deoAxdabDPQIzZPIH5u9Ftk9FOSQo=;
        b=YSBJ3oV1jxYF8RIhzB4D+ZfKeaM1i/0AX1gBJ1YLkF+JaYTdvk2SqChmLe5N7UtSbI
         +WaG4YYN9t4kIo8ZufNiDHCOa+RnaDbI8K1I1tSUGy1jVminpUhSiRyfx+WSqJyXObIc
         kXudSlflVn2bUsmuT5NSQqdTcX4y4JLC5RMQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EY7qB3E4P6Av4/deoAxdabDPQIzZPIH5u9Ftk9FOSQo=;
        b=jVvk+XwDY/Q1P5GzX767IhomJqd3TcY5D6TppnhJ65M6M6louwzVa0MJ5l0q2yuey6
         bq+LoH1GgGyRWqCR1yHCQ0Z4igLVH4V9lD2c9iuuTTvqE9WhQJsxfaRRpu/F27UVW4Fi
         21FgXlz3V5hXuPOama5tuH1wwIMVg/3p7CO6wPehnADpP14gJbEgiuNe2s7S+xGrpTZe
         2A8lYhXlSOJltqnfhM21YpO2Pc2R8M5liDiTkekx666TXXTCI5j+jqg/EGUc680gQuNN
         5+3MYa5iWX5CUMr/j9LGyb5LEJLRaWsYx6UEo3lnJGxJtYYe369DvWgDPfFFNyTs7m2q
         IuZA==
X-Gm-Message-State: AGi0PubkK8ZIFOS0vfOmwgkwPcojuK7/WpSiOXNpJM3AajNBYs3erydZ
        ztFmpPQeV3hYMFQVkNu9ciEQDvRT3fU=
X-Google-Smtp-Source: APiQypI9aP1niRpwYyyKyz/6ou+TwyHGh1SiZFKrS6YzHoxsk+LWMAuhW/6kkJYUPu84LXX+3vaIMA==
X-Received: by 2002:a19:7913:: with SMTP id u19mr6682422lfc.114.1585952256783;
        Fri, 03 Apr 2020 15:17:36 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 64sm5531651ljj.41.2020.04.03.15.17.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 15:17:36 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id t11so7086209lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:17:35 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr6780889lfk.30.1585952255484;
 Fri, 03 Apr 2020 15:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
 <CAK8P3a3OPgCzLxzd=7Ng=jregKB0HycLLrfA4xYd7-4Te-kHMA@mail.gmail.com>
In-Reply-To: <CAK8P3a3OPgCzLxzd=7Ng=jregKB0HycLLrfA4xYd7-4Te-kHMA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 15:17:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtkiTh+M55onqQJ7TdBvTnAzHFNG77NmsBsDMyV82OQw@mail.gmail.com>
Message-ID: <CAHk-=wgtkiTh+M55onqQJ7TdBvTnAzHFNG77NmsBsDMyV82OQw@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] ARM: defconfig updates
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 2:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> tags/arm-defconfig-5.7

This caused a conflict in 'omap2plus_defconfig'.

I resolved it, but honestly, I couldn't find it in myself to care that
deeply about a defconfig conflict.

So I think somebody might want to check it and maybe re-generate that
thing if it matter.

                 Linus
