Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733C22FECC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbhAUOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbhAUOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:18:36 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95CC061757;
        Thu, 21 Jan 2021 06:17:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e7so2626541ljg.10;
        Thu, 21 Jan 2021 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qTWjoxSYUi4JL7bGI6mfUa/FE+ddTQPHgoii5uzinw0=;
        b=MfQrvkEZK9CkOFzUT8cOGuJ6bH8ktiBx14mSDSXrvWsZpQHpVcQH3oqhZkf02lJF0C
         Fawh5Yj42LIU4ovM2ZcxYgMFbrH7e+8xzu+RRpGB5kK0gxuyQAacbPRoVpQOGBxubkuv
         DtPe5FJRwE0fvVXkS2m6LIwTEd4pqFPCDMm1KUE1dpTR86T5M7+a/HcgMDT77MIYRAzc
         QHApmZahkmLmhcobgWFK7LJJcoJYtaE2FGcXjCUUvuIFQxajNOwAs+Dho48CrkhVwIJE
         b5jHi0XPOrSspT+N/DMLeU/HSPr2Yj9MoBMhY4uF83wL1YF1squYKfYXhqI/WtjwJ1Ey
         ddTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qTWjoxSYUi4JL7bGI6mfUa/FE+ddTQPHgoii5uzinw0=;
        b=FWWhzm9e1FoTcfBxr0N3lGiPSb/UvQ7gFOH77meWa268YXOOWX5+gb4cYfZXTbZPJL
         HdYB9Iqqdhh+PcHYftAWW2ktuogFP8drQhrB8106bhQs+choSM9CbMjfe6baRKxbpfZs
         X4733kxVSXQSUgEE44WBLBZxO8GFcHqbB48tnTSCSxBhpCrsAdFIfleMLi6GXfj2P0MA
         DlHcZtPW2AbwtI0MRrC7YHV3d1lvBAluUq4QCPK4JFqeopImrp2zx6Y3KxJ7O3L2EsA7
         SZaUczxvlh6OQNBXJnzMmRG2nzVoGMbyJ/tGJzzkdA0uATMRJ4Ho5hGH4Ztoh5fiU39v
         lpMg==
X-Gm-Message-State: AOAM53205ZKiEy6ZqCoyQERgFuVxcNqUsjGXCPjlC8qcwDAOhfa+jFXm
        +izf5xvvG5MyyQ+6VjZWcf3xFQnzl2Udt+yep0o=
X-Google-Smtp-Source: ABdhPJx93WQ8CoZI8mE7J68rG71XZsqOVgjBEeJUDpRKtaIMDc+3RuxzVQHDmOsEOMzo8NVMKPVAttXNgcLqJcxtfB4=
X-Received: by 2002:a2e:b556:: with SMTP id a22mr6794328ljn.264.1611238673776;
 Thu, 21 Jan 2021 06:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20210121061141.23062-1-o.rempel@pengutronix.de> <20210121061141.23062-7-o.rempel@pengutronix.de>
In-Reply-To: <20210121061141.23062-7-o.rempel@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Jan 2021 11:17:42 -0300
Message-ID: <CAOMZO5C6RM2vEMFJB-+Nen1Et8wn39JJVM1UcOcar0aMebKykQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ARM: dts: imx6dl-prtvt7: fix PWM cell count for
 the backlight node.
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

On Thu, Jan 21, 2021 at 3:12 AM Oleksij Rempel <o.rempel@pengutronix.de> wr=
ote:
>
> At some point PWM cell count was changed, but it didn't triggered any

It changed in this commit:

commit fa28d8212ede9c533ae87a737571a9d3b3eebb29
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Date:   Fri Jul 10 07:19:37 2020 +0200

    ARM: dts: imx: default to #pwm-cells =3D <3> in the SoC dtsi files

    The imx-pwm driver supports 3 cells and this is the more flexible setti=
ng.
    So use it by default and overwrite it back to two for the files that
    reference the PWMs with just 2 cells to minimize changes.

    This allows to drop explicit setting to 3 cells for the boards that alr=
eady
    depend on this. The boards that are now using 2 cells explicitly can be
    converted to 3 individually.

    Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>
