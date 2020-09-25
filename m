Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA8278BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgIYPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgIYPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:04:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E543C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:04:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so3484742ejm.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L+qXNeLspy2/rNPk6Dvq02qKoxSfU6CIlz14LiobQSA=;
        b=jmJzUP1m/sfPTVzEBQhKNqC4Kzv6AhfyAPOOK2jiBYVm8QTT1amtVBT5L9fFCwUxtn
         4k367dkBis1/EeO7SCT9faxH/vGLeY44u581GeieLaw12d/aQLrCW7mmTA9wlDi9K3k5
         AsZYGGiFy+69VaXdshNy+oVJo+WOAtwGTkYu1NwDtHoD4j0K2PdtNa7LlXmc4okoH88N
         ptjwexvOtZeMHqH3FbzTf89VLzRcOpI2esh28uwq7N2bqf8sS0oX67YjGF50+pXh6cn2
         Y1cZ95C8wuGR/iYR2n/XbV68GRtrCPGy7cxTNhifPOxQQVv0mIaPWDW+HY0gtFEnqxao
         2Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L+qXNeLspy2/rNPk6Dvq02qKoxSfU6CIlz14LiobQSA=;
        b=OuSgYNCsBtUFXyVc5UplVEoJ8pQedEEQSeCQeHtFGkT7jTHZ7NGBILc8PGq1ksd2bl
         ZW1HP2ozGl2mTKCbZLbDW6myRtaPyjolq2kaHq9YtzICl5wg8Sk/tiT6cn99gk7FTyqr
         cEonqp7D/H3EyjlZuVIYdJrrXZ4gZ6gGDSBF/cxko9rci4/vwk4PSqJoxkVMVL5xjvKt
         Z5STjv1LBXNiZJcYX/lxBRWmrot2H4WMbBR5fyElOoZsggWancz+t4IZ3LmzWVr7Y1fL
         H4AJStU58aQfEt1uoAki1JkioImpiix/7iaArMvw7n6WqRDywb2MyIBam4ABDlHaqJzk
         t9+A==
X-Gm-Message-State: AOAM531feR5kf+VGuGujZwPmKWzGwxwYNOXGui4bOw+0NhJYhU2bONDp
        MlulwR2rxySU8M6BsTW1oWcKO5A/1d9Fpac9fCQnECkoJlA=
X-Google-Smtp-Source: ABdhPJwsfWbPhD5S5Zc9/CgTG1OKah8eMqkWuNiA3sLhY4UDsKXoT9imzLHFaPv9qxtcFA4wvNSy4+bQYTpbwFh0SkQ=
X-Received: by 2002:a17:906:e24d:: with SMTP id gq13mr3039230ejb.152.1601046250468;
 Fri, 25 Sep 2020 08:04:10 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 25 Sep 2020 20:33:59 +0530
Message-ID: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
Subject: KASLR support on ARM with Kernel 4.9 and 4.14
To:     open list <linux-kernel@vger.kernel.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ard.biesheuvel@linaro.org, arnd@arndb.de, nico@linaro.org,
        keescook@chromium.org, thgarnie@google.com, marc.zyngier@arm.com,
        Mark Rutland <mark.rutland@arm.com>, tony@atomide.com,
        matt@codeblueprint.co.uk, dave.martin@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is regarding the KASLR feature support on ARM for the kernel
version 4.9 and 4.14.

Is KASLR supported on ARM-32 Linux 4.9 and above ?
Is it dependent on CONFIG_RANDOMIZE_BASE or
/proc/sys/kernel/randomize_va_space ?
Is there any relation between these two?
Is the changing kernel symbols (in every boot), only possible if KASLR
is enabled, or there is another way it can happen?

I have these queries because,
In one of the arm-32 devices with Kernel 4.14, I observed that
CONFIG_RANDOMIZE_BASE is not available.
But /proc/sys/kernel/randomize_va_space is set to 2.
However, I also observed that symbol addresses are changing in every boot.

1st boot cycle:
[root ~]# cat /proc/kallsyms | grep "sys_open"
a5b4de92 T sys_open
[root@sa515m ~]#

2nd boot cycle:
[root ~]# cat /proc/kallsyms | grep "sys_open"
f546ed66 T sys_open

So, I am wondering how this is possible without KASLR
(CONFIG_RANDOMIZE_BASE) support in Kernel ?

Similarly, with Kernel 4.9 and CONFIG_RANDOMIZE_BASE is not available
but /proc/sys/kernel/randomize_va_space is set to 2.
But here, the addresses are remaining same.

1st Run:
[root~]# cat /proc/kallsyms | grep "sys_open"
c01ed68c T sys_open
[root ~]#

*** reboot ***
[root ~]# cat /proc/kallsyms | grep "sys_open"
c01ed68c T sys_open


Is there any other difference between these two kernel versions with
respect to changing symbol addresses ?

Thanks,
Pintu
