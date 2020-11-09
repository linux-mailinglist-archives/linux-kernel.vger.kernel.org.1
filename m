Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127622AB3EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgKIJrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgKIJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:47:05 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68276C0613CF;
        Mon,  9 Nov 2020 01:47:04 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 2so3549247ybc.12;
        Mon, 09 Nov 2020 01:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+fXAPRsR/uex6VU5/EqCVLiWplbh7G5vxH2O/MlyR4=;
        b=pJhTvuH4nCUkAyElx/qD1AaanZ2cSIDtOfvdTAtsy5Ez/Lq7CqmANmvpLaG4Jv4C34
         jIEgyAzYdk6Do0yo+ry7bKyAIHSny1U3jwftJXUmXb+FAvTufJ8EKK7LnA0Jsb8wo01f
         csx9lYsaAEXeQhC3lFcAS1dUM0GrO0gH4ms7rHViqdvqpTp66RlaRtR2iZkrQUar1u16
         WIip1bxKzZiy+BjmPDHd5RI4bLLGPnZH0g+vyEWzoCDlGsWaZnCgFDaQQvJEzbzYjoOC
         syVJAJSWz0EMYHU6CnermmxeUw9tvwo+/wJ3RmlF0x9QfivT3R+3KM6BKC41MUENR42o
         mS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+fXAPRsR/uex6VU5/EqCVLiWplbh7G5vxH2O/MlyR4=;
        b=TG7mDiNFzStOgmC7cqhfMOpDb4bZU4r76uGZyYw9vuZTpKecNUgghNY5ZcpSDYbBqp
         j17XU5vhvhoCIRpof3IDLK8GrF7gRuYNAexWsix/UZ6Jq4q+3WVa+9TEjA/ovpAlOrbj
         56pPsf1R1kIJ/Vse/HuSD8paCL8qynmXjrpqLsWnkGqojtJeHe4gkTizbF/F30bjfC7l
         ApQfrJCbIGEr9Qt2/zDL/pefRJCnulKjf0EmJUd0+2oWMcuSZK02GAz5j2DbMqkkNPfk
         XSwroVnj2l7aoo6zdIo6M3J7IC6kQ++Uw5vBX8QMuqPE+97Zx7evH/32CgH0LCTXYWqt
         quBQ==
X-Gm-Message-State: AOAM533L5KdCl7KgQO9dGYITprRsiTn/JTPoCJ1SKDbWqjHMQmoVXOhx
        NuM+SEdnO5P9GhAk0+dlWN7NxQiU1gFXuskVOkA=
X-Google-Smtp-Source: ABdhPJxGPr4N79SqNn9JyWZYznr3r3+sTcgzE+d95uzXvdhAXmp0Nq/URccVL5pcH9BTmbsdb2XY4bCV0wI7l2V/nwg=
X-Received: by 2002:a25:bcc7:: with SMTP id l7mr8063390ybm.115.1604915223794;
 Mon, 09 Nov 2020 01:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20201106192415.GA2696904@mwanda>
In-Reply-To: <20201106192415.GA2696904@mwanda>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Nov 2020 10:46:53 +0100
Message-ID: <CANiq72m+_4K8RzR4JtdAq4o4uc_vBPmLZmgLiGB1jwd_FnjrZA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: fix use after free in lcd2s_i2c_remove()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 8:26 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The kfree() needs to be moved down a line to prevent a use after free.

Thanks Dan for catching this one up while in -next. I'll pick it up.

Cheers,
Miguel
