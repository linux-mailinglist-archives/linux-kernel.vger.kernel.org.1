Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149E52E3205
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgL0Q7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgL0Q7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:59:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:58:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b26so19179957lff.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZkMPV9Td1S5uycOwIvh1VSBjqIoKt6ivrgzO9euGk6k=;
        b=h3UjHTQbZFTWREq+YdFLvQBlQCi9hnxTEZ/35Nh0HoABAJr5WfFqpVpjYGNaB1xmiV
         QSSwbOcRT9t5twuVfXp/+546HHtWj4ntWY8DIRAbGjsm6WyESRiQB8qRKg1zE/zQmJhR
         vmkb6o2KYncK60Tipdq1sej93wypwjkm5qYRGZ3G+doS/RWC/KhBNIeVETy8eNVWxH5F
         cwkOJeJkWFQADKjV/ZLeCANmoWJGRTUcqoRfcXIVI8oqOIuqjkP9zsTLvHY0+7J+wO+5
         AbZ6hNZZn4/D6ZIDjAHlITMUQAS11Z5CtC6iiAdKx1J4ysyEcRy1DseppeZ3nPk/NWrt
         7DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZkMPV9Td1S5uycOwIvh1VSBjqIoKt6ivrgzO9euGk6k=;
        b=sN5qYZBv7v2JBMOQOifj2/NLpMgQ5zy/oPZiKRrPdP3UTRJE68kfZLJlAKNRLjN30h
         J1ojzg2t+Fy4KbOt1xIFsxXwlu2BcJsMUbFvvQP4x4KSVKx3Tf3Jz6M7y1kY471TNX0V
         sgW7V93LzxsOhV6CEbwYevFYJIXJzR+MvXRmDFFWGFtQQf3Cg9xaSdgUk+oy8TeqmibI
         qrfbHgQIFQYyfQfxjgrEYX3OXh9tEO4x1O9xPoCVKJhYB9FNEeRRBxxDdK5m4cOjgQeZ
         I2HguR/HjmfLYJaTrllslDMVJXdONlJDdDXFGo4PsiDwR5JqJ+FyspR/UHfFM1oBenTc
         jBvA==
X-Gm-Message-State: AOAM531kkeNXOrRol6ZUBEoSBVuULBpD6Khin846sHb79GXeN/lHCIfi
        TSBJDUXml99kWJtf4U8GUAx1PQqAGoX+UV7V4pTPUefvhBpSgA==
X-Google-Smtp-Source: ABdhPJwa3TKMysxlJ5jAuwHJUdFJSYmcqOJkHmdRh2j7s+MTi2xaduXesCaOpK2yv7ARglvAc7DFLrxdqRWIuw0Nj+c=
X-Received: by 2002:ac2:4ec4:: with SMTP id p4mr19484820lfr.130.1609088311615;
 Sun, 27 Dec 2020 08:58:31 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPsXSTh+WO2XESOU+Q1ocrWmS1c1YJFarzmA=woK_ke5Q@mail.gmail.com>
In-Reply-To: <CABXGCsPsXSTh+WO2XESOU+Q1ocrWmS1c1YJFarzmA=woK_ke5Q@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 27 Dec 2020 21:58:20 +0500
Message-ID: <CABXGCsPBBDX3ozAgtT174nesiM+Gx4UkQi+PD27jB3i9OQ=G0g@mail.gmail.com>
Subject: Re: [bug] Radeon 3900XT not switch to graphic mode on kernel 5.10
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Dec 2020 at 21:39, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> I suppose the root of cause my problem here:
>
> [    3.961326] amdgpu 0000:0b:00.0: Direct firmware load for
> amdgpu/sienna_cichlid_sos.bin failed with error -2
> [    3.961359] amdgpu 0000:0b:00.0: amdgpu: failed to init sos firmware
> [    3.961433] [drm:psp_sw_init [amdgpu]] *ERROR* Failed to load psp firmware!
> [    3.961529] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init
> of IP block <psp> failed -2
> [    3.961549] amdgpu 0000:0b:00.0: amdgpu: amdgpu_device_ip_init failed
> [    3.961569] amdgpu 0000:0b:00.0: amdgpu: Fatal error during GPU init
> [    3.961911] amdgpu: probe of 0000:0b:00.0 failed with error -2
>

# dnf provides */sienna_cichlid_sos.bin
Last metadata expiration check: 3:01:27 ago on Sun 27 Dec 2020 06:53:25 PM +05.
linux-firmware-20201218-116.fc34.noarch : Firmware files used by the
Linux kernel
Repo        : @System
Matched from:
Filename    : /usr/lib/firmware/amdgpu/sienna_cichlid_sos.bin

linux-firmware-20201218-116.fc34.noarch : Firmware files used by the
Linux kernel
Repo        : rawhide
Matched from:
Filename    : /usr/lib/firmware/amdgpu/sienna_cichlid_sos.bin

# dnf install linux-firmware-20201218-116.fc34.noarch
Last metadata expiration check: 3:02:11 ago on Sun 27 Dec 2020 06:53:25 PM +05.
Package linux-firmware-20201218-116.fc34.noarch is already installed.
Dependencies resolved.
Nothing to do.
Complete!

Looks like firmware is present. So I didn't understand why the kernel
cannot read firmware.

--
Best Regards,
Mike Gavrilov.
