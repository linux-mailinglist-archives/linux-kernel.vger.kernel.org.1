Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5412B2D6E27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 03:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391817AbgLKCce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 21:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391165AbgLKCcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 21:32:24 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E1DC0613CF;
        Thu, 10 Dec 2020 18:31:43 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z11so7162807qkj.7;
        Thu, 10 Dec 2020 18:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EeBE0q+ErDzzvoGT97HzZPFWnthYhh5V7M5ilZcCsbk=;
        b=Du/BFUZWIiV9QL9SLfwiNk/AcgiLYD23ezmHJCJ2GK/qX553KoC+/Uf6EzhR1Yqw0G
         wvR0KUDHEqgi1rekJ53m3hKY7xXF+lw9BVwPMc+4XMhWAwQ8vkrpEv5HVbXaMD2Qesd2
         G6CHOSmyP19f2EuKLase/8kzypAqf8cS6i9akAMQXHkVXk8HkfEkk6vd+31133nYPgG9
         B7PHwPENAnkxJBUfH2v/xnOsZ1Ya+EfZTgPGtlEydZSe+xamKxhX8aZ4PSrvIhT6No/t
         74lkI/yVPEd+SocUw3GUgomgNBL69lZyvmIPV+/RwGfYE2Bl4yTg4Bz8xNVEmgyJwwQB
         brew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EeBE0q+ErDzzvoGT97HzZPFWnthYhh5V7M5ilZcCsbk=;
        b=RPwyW8PR991ggeakceYmaiesfsI1XzOOcTcqiVSPAYcTQsVtsGEdYcQfIjmXRJIy8v
         GQSi8LrIT/Cj02QirUd6QQkldsAdpP3Bg6ezcWm/I/v4m85ESLUVYkJVslZjgGDMKzRN
         Hx8CL3+/PAyCBIMg2zPOjSjDb0qbSTqko5Au4NqDqBsey51qKS+uECQaOrqk9W5nKxd/
         3vc899491PJVKkijJyWOBt9qmIXfuXbczC8T5ZKOrALp0aPBGsz7H+R+dmiNd6C3OIML
         dLVe3R5v0OdNLE3Wo1/KRYRkILTpSrNOXo4Uv+px3swNjZWB9B7iqRmrAtRh81qx8TWf
         si+Q==
X-Gm-Message-State: AOAM5323jnt87HzQpDj8miycYD/qs+dU46YDpHU680tI4pzDN2K+jpoj
        ya4Yl4aZunhgEDm3fbkLMTvcPvx22etdV+BVvVVNW5bUKCtwng==
X-Google-Smtp-Source: ABdhPJxM9PzPaAMuDWF/f7hOuuVq3yPBdtl+Y6lFsJ2A+LYREf34G/MGnb3UMg/S0vlPucFwIc5OTk+Reg4tW708LYw=
X-Received: by 2002:a37:a7d1:: with SMTP id q200mr12770176qke.283.1607653903024;
 Thu, 10 Dec 2020 18:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20201210160357.27779-1-georgi.djakov@linaro.org>
In-Reply-To: <20201210160357.27779-1-georgi.djakov@linaro.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 11 Dec 2020 11:31:32 +0900
Message-ID: <CAAmzW4My=Abdv+GAe-nOdM0kbFFc28oQBxAM-hWfDLpj1AocdA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_owner: Record timestamp and pid
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, corbet@lwn.net,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        lmark@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 12=EC=9B=94 11=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:04, =
Georgi Djakov <georgi.djakov@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> From: Liam Mark <lmark@codeaurora.org>
>
> Collect the time for each allocation recorded in page owner so that
> allocation "surges" can be measured.
>
> Record the pid for each allocation recorded in page owner so that the
> source of allocation "surges" can be better identified.
>
> The above is very useful when doing memory analysis.  On a crash for
> example, we can get this information from kdump (or ramdump) and parse it
> to figure out memory allocation problems.
>
> Please note that on x86_64 this increases the size of struct page_owner
> from 16 bytes to 32.
>
> Vlastimil: it's not a functionality intended for production, so unless
> somebody says they need to enable page_owner for debugging and this
> increase prevents them from fitting into available memory, let's not
> complicate things with making this optional.
>
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This is useful. Our company already has an in-house patch to store
pid since a few years ago.

Thanks.
