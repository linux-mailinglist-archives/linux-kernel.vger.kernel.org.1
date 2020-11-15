Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A92B36DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 17:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgKOQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 11:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgKOQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 11:57:07 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAD2C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 08:57:05 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so17079350ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZhWNdmrv7uNC+shuTB5UrdMpVq8cOfsO/67ny1dABo=;
        b=GKe8HtSGVpql7itwBeLIkBdzeQTDlLA/NMjuNvTbYEKWXB7yyVUDwFWl9MTbBscdEJ
         hObKcjWJK90+BTLO+zgzmCcH+qCmtS9aZD909pSoyW/0/+CSK0ggGgVgQQGW5k7uiBQQ
         9/PazKzHsYQiacJMrzhtp0dCF64qWviUt14wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZhWNdmrv7uNC+shuTB5UrdMpVq8cOfsO/67ny1dABo=;
        b=VsazhAzqXHzcB6TFTMr7bTxUJ32tU7gwxYH7TGw0L/DqX69vffJf3dzoCLX2Sngz7b
         wkuqQQqmPtUAkcng5ZbX5dgiTGdYLL+8TX+UgL2BtonwVaCS+uW3/hPyGDbP7SNWFdFy
         Z37s3lAPhE5mqVL3PjALKgg8OHc+kcCgeW33dEyCHHyyhfZ6RQUhF1q92GnUMMWGBf2T
         G0scd/mvw51vwkMlk1EajB2hvlrz/Gc86PnJQcWafLtZeqfnobMcB1e7K62lBV//5bRt
         3fTp4WpjWlGKLWM7JLaQSOziWXsREgPRht94PEEbVTCEKe5u/Y1hpsTUwyhn8mlp0is1
         py+Q==
X-Gm-Message-State: AOAM530PM53R7wkdMyT4Pdhd8j7yMQkvOXFnNOFou00KgZHwtsruwevB
        JX5ykXLgZc4WSROtlt++bGhRwkm9+78S/A==
X-Google-Smtp-Source: ABdhPJwtujH1xhpY1ex8k/EYO7kIZiv2GQfKFRuO26jrpi6FJXUVnqGu73oIChiSJWwI/OeFCR8uAg==
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr4974587ljj.194.1605459423931;
        Sun, 15 Nov 2020 08:57:03 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id n186sm2380519lfa.271.2020.11.15.08.57.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 08:57:01 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id a9so20449204lfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 08:57:00 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr4592052lfd.603.1605459420530;
 Sun, 15 Nov 2020 08:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20201111222116.GA919131@ZenIV.linux.org.uk> <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk> <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk> <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk> <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk> <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201115155355.GR3576660@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Nov 2020 08:56:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisaN3QOEYq6XBSKyW_74X5GhdbyE5AnbLkh9krarhDAA@mail.gmail.com>
Message-ID: <CAHk-=wisaN3QOEYq6XBSKyW_74X5GhdbyE5AnbLkh9krarhDAA@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
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

On Sun, Nov 15, 2020 at 7:54 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK, I think I understand what's going on.  Could you check if
> reverting the variant in -next and applying the following instead
> fixes what you are seeing?

Side note: if this ends up working, can you add a lot of comments
about this thing (both in the code and the commit message)? It
confused both Christoph and me, and clearly you were stumped too.
That's not a great sign.

                  Linus
