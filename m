Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F582AF948
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgKKTrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgKKTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:47:03 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B7C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:47:02 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id w142so4807026lff.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsnBQdrhUa/QAa8uquu/neDEB5Nejqa8rlSSCbSFDAQ=;
        b=iNm0A2ZsPVgUGNhmnm4Bsq7zInrL2JjhQcdACsrOt9mYmndn330XWcOtDuEG39alzm
         J3le2lMvlL2vfgGnxs5xrjbezCTd3D5AJGj7jRLxD4S/HIWq/nQLuBADwTKyKgRs/IUv
         jD+EM4LjRL/Q9K3jsw/2rekEsb4EH47OKl2F+lQT3VfUH8eeH5eDDxFbPG7ThwG0JVdg
         9a9mUo7wGX4cbPBOtCP7UYYdXchgNjo+zlaojJQOQmTVsz6QSCpi3YBtbuCM/M6qC0vA
         UUegdcAwXhSrItUwjZVL5yXqMJYipcJVH6IL//pKZtKQA+ZaPTbireRNJfZgT9v1ybtj
         UpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsnBQdrhUa/QAa8uquu/neDEB5Nejqa8rlSSCbSFDAQ=;
        b=htn74PFD4BxuTsrPWnFOvnLGqWWa4TUpoS+y+OAXp6eJlz7y1xmDvslZmntKPQTLS9
         Und+kkA0IVryk3w76GjYikR/MXj1sJl1YMCRK4jpEGH6Uw9et9xz+YedLEN5l0egwD2u
         9RBILA3i4oeYfAWsEVRFw5fPhE7j4HwkaJOa/dnSSKSqc4X7F/N2rOA0c0/utWtet1Uk
         Z1xSfA1EMX3r3VumlXcyrMb/Es2hJM6PTon7csHNutRvR8LpOOKLytBbKvS9wgBjroxC
         7paTAxwM5mWULlWjFaeL8LaQbDocQ3FdBcTBzVqLVrq87kvEhCVsrVmuZMe161VmtDEg
         BfHA==
X-Gm-Message-State: AOAM533wfCyG3bc2LVmuB5dgTQTjJLwaUtO6E4vd9tbRrmATQP7dlLdn
        2gfeTR8gTvatQyE7wxahfv4sOEjwR9j6jm0OkAM=
X-Google-Smtp-Source: ABdhPJzJgaDHcmCLUzy/XY8a3z7s4FIApr/2YqWldQBCP3B8DVuog/657U9KwRXn4KetzXdnEl2hffslp2tqd6smOQo=
X-Received: by 2002:ac2:418e:: with SMTP id z14mr9881908lfh.25.1605124020958;
 Wed, 11 Nov 2020 11:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20201111051859.2776-1-ivan.zaentsev@wirenboard.ru>
In-Reply-To: <20201111051859.2776-1-ivan.zaentsev@wirenboard.ru>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 Nov 2020 16:46:49 -0300
Message-ID: <CAOMZO5DXcQaZhujAq_KOEQgUNDx5cDsGnObVtadE5=qvWhUs7Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: mxs: Add serial number support for i.MX23, i.MX28 SoCs
To:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Evgeny Boger <boger@wirenboard.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On Wed, Nov 11, 2020 at 2:19 AM Ivan Zaentsev
<ivan.zaentsev@wirenboard.ru> wrote:
>
> i.MX23 and i.MX28 SoCs unique identifiers are factory-programmed
> in On-Chip OTP memory. i.MX28's 64-bit unique id is in
> HW_OCOTP_OPS2:HW_OCOTP_OPS3 (see MCIMX28 Ref. Man., sec. 20.4.22-23).
>
> i.MX23 provides 32-bit long unique id in HW_OCOTP_OPS3.
> Though not clearly documented, there is a clue in sec. 35.9.3.
>
> The unique id is reported in /sys/devices/soc0/serial_number
> and in /proc/cpuinfo
>
> Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
> Suggested-by: Evgeny Boger <boger@wirenboard.com>

It looks good, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
