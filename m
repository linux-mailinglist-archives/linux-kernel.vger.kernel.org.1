Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247C32A1FA3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKAQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgKAQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:47:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695DDC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 08:47:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w13so1832203eju.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bJcbBpvhkooGVSa9uKVCzDUvc8XJYTQfbEGfDOmpH+0=;
        b=bQp75wUL5280tVqfadV9BdtzvQdKGQlBW1VZZAYRyVzaeWYRXGcxCP/iCl+ZH+6Vqr
         9IOpquW4sSWx8La40Bm74S06CrB4wl4s5cWw2PIMtZU356ypSHISF+L/zrlLP+ujVEJL
         GN0ZxuSwg3h/kEJpHEUV5lZo5dmrt6MFVwbrOXFsXS2RGE+2cSiB9qab3dl4jl9S1pD3
         8FTch+3P5JSYEUECsJx+w2bcMtRHq9kx0d/z4OmmQf3BDsSL+dHyZ400K3bmXoVZUZ8h
         SvKMX1FElumJZ7N9qe887gx2rxelNc58TvPqrswdDmzzW2kGitiVQ7iyEzyy0p5/tdzf
         N2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bJcbBpvhkooGVSa9uKVCzDUvc8XJYTQfbEGfDOmpH+0=;
        b=d5sx9yuP/5wAIlWkFlCtiZAcWy3+RSXvlDcpFxDkb4zih+KLnP/wGwCmuxRiz7vfro
         2f1VW8tgriec1w2XhchkYdr6kJaV5nJdNBYhLrh0GjH8AwWV0wDK2dDJTZDli526oSs/
         6XEgL7MxEomhVPsHfPquz6DS41DWqeCvJzSzwVMz+eIso+MU/o/pBVasUZuP5ykXbcsC
         uIqDUzjarVG0MP9fvA8rOkIHWg9L14qFZNLpGdI8bqEsztOAw6WMHuojqj+cz/ciygNu
         C8p60AlYtGNpE8twQ+a1G1LZ90zsJNqEgsAZQZ2pTKzooS3a+6C3wsrpzabzmz1p9JHY
         CD4w==
X-Gm-Message-State: AOAM533sRcWtI5T3xSkI5phjv7jLKPBacu/GAXvoC9EJd97pzkWPeQeD
        ALLRx2K5d0SPaqaH1+qvQ3E6lNr4Dy+uUDJxjVc5ePrOYP8yd7d5
X-Google-Smtp-Source: ABdhPJysHvCvTIDZJkoEkZMk9Rbwba3/BnCVz7jot0R5SCBIc0ckWqB8Ud/ckwGJsxjMZE6Zuqr/hGUc1weugV3HeZ8=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr11545879eji.320.1604249230906;
 Sun, 01 Nov 2020 08:47:10 -0800 (PST)
MIME-Version: 1.0
From:   NASA Jeff <tallboy258@gmail.com>
Date:   Sun, 1 Nov 2020 16:46:58 +0000
Message-ID: <CAN-MDmparVyT2ZRp4x2=cBxm_k+iuyAJ4_xTELT07w+f0hu2bg@mail.gmail.com>
Subject: Freezing between .48 and .51 when hitting swap.
To:     Linux Kml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have an issue on my laptop which is old but with 2.5gb of ram an ssd
hdd and using zram compression I believe.
When ever it hits swap the system completely locks up and I have to reboot.
This only started occurring in .51
I only have access to my phone at the moment though I=E2=80=99ve looked at =
the
code and have what I believe is a workable solution that should
mitigate against and future issues. The code base looked a little old
so was probably quite stable but it really could do with some
modernisation.
The issue was with the active app in user space.
What needs to be done is to swap out inactive pages in background user
apps prior to the active apps hitting the memory threshold which was
causing the lockup to occure.

An improvement on the existing code would be to swap in and out
inactive pages gradually so as to avoid any heavy system load.

It may also be an idea to set the up priority to near idel for such
heavy io background processes so that the overlapping io doesn=E2=80=99t ca=
use
issues with user space io.

I believe this is similar to the main Linux scheduler since bfs
because implementing a script to renice processes that started hitting
higish cpu and then again when their cpu dipped didn=E2=80=99t seem to make
much difference. It was unclear if this was also implemented for
cocurent io as the window managers now seem to queue io tasks instead
of executing them concurrently. Concurrent io was at least a historic
issue.

Kind regards,
Oliverthered
