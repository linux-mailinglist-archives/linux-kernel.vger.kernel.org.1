Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775FD27E9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgI3NaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgI3NaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:30:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF51C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:30:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so2871544ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1LDkQQNXAVKEqr0+tqeGQXJ1mdD4On0ZbGgfQW9Bm0=;
        b=ehfWBFfOpeiXSM8K3ALecLLOYUcExD0bVjWpUSLJD+wC2rIkpXAlPehwx2dUEcr+E9
         jTjAtSSvApyOBbOpQ4PpEJp+KXQa/Uisja0tY8sp0ke4jUI1GEZvhgejqo/I0kHqtbpQ
         Zb3/DxG2Hmwuod4+XjdmzCrX+RUKW1gPmSEujGpcsjz6sTBwXPk9O+vRtjxqtbfGzer4
         8TLucGiGTJOoUyDllYv8wJU1EJFrxGAku7SNSdTs01ett8+66yMgsdCtQkG6nI28O1MY
         0APTctfFS7UMfUVLwFTZxbKRsAqWqetzK+DDxEvZ/gvmaEbqclc5JwjTIaLPoRDKt3vV
         CPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1LDkQQNXAVKEqr0+tqeGQXJ1mdD4On0ZbGgfQW9Bm0=;
        b=a/XVqBfzkYkrYniSWzSCmGerpVA+PXYN4c+UuZTJrSsBOaMJNiEagt/Yjt2D6fsjwB
         e8JMS9c5Pqu8evZgkpA7HELNSKmP6S5HzDakAXUHMEmOeitmVtebhIBZ6xCbC+HEVK/p
         uPxiDx6H7hY3blY+7zc7DBUjHfsVx1sGxpH9YOdson7z92KNl7pfSjlpf/Z8cM+CYOX5
         pGZBIjn1ZNM/uoIywjYYqDMoUdeIiuy565OCOquXtbb4o9wWpjky0V1LSyBTRRRLAW5j
         oQ2xk2UB/aH2rdBnf9SSS2xCyxrXTDN6+TInWEoU7kc2qQkcb9PW/6lFlaMclkgsbowf
         6BvQ==
X-Gm-Message-State: AOAM531SRBL15wvNF86jx3Lc7mzeYIP047sFLMyd3xZb/qdTh/gj/LpV
        dVhPtHkVNHnKeCoKaRukRU32LYfI5qF+Sx298994UnzvGXxvwQ==
X-Google-Smtp-Source: ABdhPJxexbd6G3TxMmQMKWcWvmbIx5AeUioE+moumV4nV8b1xn7KvTl+m9m58v9dQcMxkHLF1Cd3vFsJOAHoqsFR/lA=
X-Received: by 2002:a17:906:b24c:: with SMTP id ce12mr2896421ejb.353.1601472614378;
 Wed, 30 Sep 2020 06:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200918072356.10331-1-gi-oh.kim@clous.ionos.com> <CAMGffEn79RE=JbTPR0AzW+3EZO0MwemwTLwkc-LTnK8f06dKWA@mail.gmail.com>
In-Reply-To: <CAMGffEn79RE=JbTPR0AzW+3EZO0MwemwTLwkc-LTnK8f06dKWA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 30 Sep 2020 15:30:03 +0200
Message-ID: <CAMGffEkzEv7hEyVAw-tGLJ53cRv-tq+JrVD0oDWvqXtmYsrJLA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: send_msg_close if any error occurs after send_msg_open
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:18 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Fri, Sep 18, 2020 at 9:24 AM Gioh Kim <gi-oh.kim@cloud.ionos.com> wrote:
> >
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > After send_msg_open is done, send_msg_close should be done
> > if any error occurs and it is necessary to recover
> > what has been done.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Looks good to me!
> Thanks!
> Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
ping Jens, could you queue this up?
