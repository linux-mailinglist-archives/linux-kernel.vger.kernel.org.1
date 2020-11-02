Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5F2A31A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgKBRdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgKBRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:33:40 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF97C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:33:40 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v19so10984604lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zxi+DkPWMjinOcCeCZ9Cx94L36yTcmFlHJe6N5+L51M=;
        b=ZXhsqY6MCotjClhgvD+HFZ9GP8YgAa521KQd4bwv84NsEZUD2wdTaA1BfC04Wwl5nv
         v1o3y4j14Fear3HXXTYaJ6iGZ12dNiyJnHFekvcAWqN4QkgxAsVS8dzrEpp0du/7P0cu
         s4nSmydGx+B8pzds2DbdUbMC+3GLIoiPfe+YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zxi+DkPWMjinOcCeCZ9Cx94L36yTcmFlHJe6N5+L51M=;
        b=oBVv3nEhnMpv0kC0V+dbqjWirFi6FAYB1gVc3bAv4FqizKldIp+x6Hbsl7Ox0RNBkb
         OklK2TDlYiwiIrj1xDDe+PjOpus6gWI+B9GMhWK++exdGV4kAX894pMZryElgnIHIpE2
         XuFsb7VJr3QpLr/xQPa6xOTNeKnD98Ep0h/P/A8jISSAz4z0WZK+lkuB1C8IvgdK75uc
         UK/mkSI/gONYoYv52eAPh7juwP7xHofvcIKhgSbfDdqjZlR5tiy4rgFc+vK+JXVmI71v
         neiM4pkGm/Y8ut9az7rUnUfTnjb2zSzGx627ink33PTF5HVZNZHAChbtq2DH9WP8OQNI
         6z5A==
X-Gm-Message-State: AOAM532fWEPGXtTTbLZDjoGs9G/BoRrBjPZ/yH7FAudugT9LP3oxevZB
        JGxYLLNC5RDBgh3ZZkYRwFlfL6b5QNk7Sg==
X-Google-Smtp-Source: ABdhPJxxx4dQlTD9EJgXR3SiW4IaLR9vxPsTh16NjE4Ic4vVcwWCeNbq3J5parnpDOizJDM47EIw7Q==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr6763254ljn.126.1604338418124;
        Mon, 02 Nov 2020 09:33:38 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r6sm2494865lfm.242.2020.11.02.09.33.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 09:33:34 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id k25so15919630lji.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:33:34 -0800 (PST)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr6795547lji.102.1604338413799;
 Mon, 02 Nov 2020 09:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20201102105422.752202-1-geert+renesas@glider.be>
In-Reply-To: <20201102105422.752202-1-geert+renesas@glider.be>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Nov 2020 09:33:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFZRAVB_LUM+A24u2iubynmkbMDXb3rxy8GmRmKM7gfw@mail.gmail.com>
Message-ID: <CAHk-=wgFZRAVB_LUM+A24u2iubynmkbMDXb3rxy8GmRmKM7gfw@mail.gmail.com>
Subject: Re: [PATCH] of: Drop superfluous ULL suffix for ~0
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 2:54 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There is no need to specify a "ULL" suffix for "all bits set": "~0" is
> sufficient, and works regardless of type.  In fact adding the suffix
> makes the code more fragile.

I took this directly, since it was triggered by my code pattern rant.

Thanks,
                Linus
