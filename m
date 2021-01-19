Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF72FBFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391715AbhAST0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390680AbhASTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:12:23 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C75C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:11:42 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id i18so5185521ooh.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjMT7wy0I3au65qf7KQzj6Sfm9enWQl80vCDCkue1vM=;
        b=CkzEjvUreKeWVVae5rT3JvRCspan9QX3/eg9rdt2OiUoCCDs7bz0HuW5RMeks5o7Bv
         eRrznhzjXOO29PXC8V8/LLSMRVUIfyUDYXGLZkciPj1qvlWw+XfkBQ5ji4bLwR+hgRd2
         D0KP8bBemEWuajX/igR1eIdySrhTYsjkgHm/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjMT7wy0I3au65qf7KQzj6Sfm9enWQl80vCDCkue1vM=;
        b=EN3iI+10M9iZSB+nVbOq+ZM0hcy2oRm/2OtXJ7gxBLTNWM4OGqIMLQ5FJIJyNjqmzz
         KUM2PdpnwG5LyEJOkXlb9civlCNRcWA+/DLmcFnmYLSjIfBSMDrbC+mEk3106/L4mzKz
         N0yhZ1EMRJhl72XYPWVdRm9wbcFPZodOX++l/RHTEb55ZP5rBukG7I5HSGuG/Belf8tq
         BubCVQar8FmdTpm6fxnCBFGKhzBv9NtBNhKQguUP10PV1J2csItSy09DjhItdmLifwvO
         CgUvAMKSWaWuwoAGuiFiJqORJFZiBPknlciWKZ3tOBta0MprSNbT9rIoDvsZMy329/32
         /84w==
X-Gm-Message-State: AOAM5332e10WLhaQGGvozVoBPzEJ9QyNqNOvQmbZMraYPPAUSE76W03W
        0hSM0euXa7DGXM5O6dodkdGnt9Sx33B67w==
X-Google-Smtp-Source: ABdhPJwmCPYBXG5Uji0lMe8U3EJFZS2xmE9xT34W/xjVy2ChX5YOO2A/iUDltJBAdTsSMo36m9x0Sg==
X-Received: by 2002:a4a:d148:: with SMTP id o8mr3842119oor.16.1611083501026;
        Tue, 19 Jan 2021 11:11:41 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id n124sm1832059oig.33.2021.01.19.11.11.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:11:39 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id v1so2815935ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:11:39 -0800 (PST)
X-Received: by 2002:a9d:744a:: with SMTP id p10mr4554986otk.203.1611083499205;
 Tue, 19 Jan 2021 11:11:39 -0800 (PST)
MIME-Version: 1.0
References: <1610703513-933-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1610703513-933-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 19 Jan 2021 11:11:27 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
Message-ID: <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
Subject: Re: [PATCH] marvell/mwifiex: replace one-element array with
 flexible-array member.
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 15, 2021 at 1:39 AM Jiapeng Zhong
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the follow coccicheck warnings:
>
> ./drivers/net/wireless/marvell/mwifiex/fw.h: WARNING use flexible-array
> member instead(https://www.kernel.org/doc/html/latest/process/
> deprecated.html#zero-length-and-one-element-arrays)
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Past experience unfortunately requires me to ask: did you test your
changes? I understand that's a mostly legit warning, and a good
deprecation notice, but that doesn't mean this is the right fix. One
probably should instead audit the usage sites to see if they *are*
already making proper sizeof (or other) comparisons, and if not, fix
those first. And if any sites *are* doing correct sizeof computations
using the existing struct layouts, then you are probably breaking
them.

Or if you have audited the usage of these structs, it's nice to make a
small explanation of why this is correct, so I (and other readers)
don't have to ask these questions :)

Regards,
Brian
