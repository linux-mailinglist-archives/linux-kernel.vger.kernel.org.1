Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB402D34C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgLHVCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLHVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:02:35 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE34C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:01:54 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id o24so21988646ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skpauNrCohQyEEsv7QYK47OFlZchJzrtvUvgvaYlI0g=;
        b=ROtEO+OVS9RfjVYt13rb9bXwl6vWUQ0uLL0X6wygCiWrpFFIQVJPjqgKkj1v7UrNXO
         KDiY9qw9NYnKeQXvq82LKIFRDtuWh/xJCBAirqtHokmUbbpCucKnihw7UAohXOfdUzST
         R/beNSF/szQK06awRivcQ/EdxP5ry8GrnSbts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skpauNrCohQyEEsv7QYK47OFlZchJzrtvUvgvaYlI0g=;
        b=OcE+eq/9pqGvJDVz5xaAT2BuURKx3FW84Y2Fa2II+xYAm+PB1azehIjyc1sUX84CZt
         lXVmJ4kAuYur59H+iTAzHyGpGfAhcbL0dyc/6NX2iVj31k2qxkUoX8kEU7l7PMYjs0wZ
         iM4xSYLPcu2qz4FyyFAfJGC35cdFwPcP1PeceKSHbx7oh3cmQcmGPSfUHjgUo4aMOBlQ
         POP0wFmjJ7hT2XbYEX6oJxC3iKYfu+Wk1eAwBSiLFKQLtGu0vdfCE8y8dd4qPfkNP8q3
         5Jfv/gU8wndNXp9pQX3ihkfcRedcFeJtAL6bEp1ascs+ppWXUvpu/xQMK46I56zfF17N
         ivRQ==
X-Gm-Message-State: AOAM531FWXMfwpkK2N1ntM6sU6jtDXumwOGcQgOQZCmXYn0vIR7xLd8Q
        y+fA2H3c1cmGtdNkykrX9yuHdM6dLNyhfQ==
X-Google-Smtp-Source: ABdhPJzhJ9NUukf4IZ1YcWbLhFRQkgHlnPTc9W5FhxMlUWbGjO2e/Z8uUNj0mA6l+RiJ+WNn6E4V0w==
X-Received: by 2002:a2e:2417:: with SMTP id k23mr2601709ljk.373.1607461313023;
        Tue, 08 Dec 2020 13:01:53 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id n20sm3307009lfe.104.2020.12.08.13.01.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 13:01:49 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id h19so109139lfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:01:48 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr11218462lfb.421.1607461308477;
 Tue, 08 Dec 2020 13:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de> <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
 <20201208194935.GH3579531@ZenIV.linux.org.uk> <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
 <20201208205321.GI3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201208205321.GI3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 13:01:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU6pebnM6ei51T-UyVok7u5MF6ndaFr6T0PA3zajEgSw@mail.gmail.com>
Message-ID: <CAHk-=wjU6pebnM6ei51T-UyVok7u5MF6ndaFr6T0PA3zajEgSw@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 12:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  I've got
> fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
> and
> fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set
> in "to apply" pile; if that's what you are talking about,

Yup, those were the ones.

> I don't
> think they are anywhere critical enough for 5.10-final, but I might
> be missing something...

No, I agree, no hurry with them. I just wanted to make sure you're
aware of them.

                 Linus
