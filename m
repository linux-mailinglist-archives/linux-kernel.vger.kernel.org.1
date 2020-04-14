Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A911A8AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504849AbgDNTc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 15:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504842AbgDNTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:32:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31AEC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:32:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a81so15586108wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r6dF4D+wN0hoeI/HD/8hpNX9Zi5cUiRTSVM80fnZiTg=;
        b=fBwO8IzrniZxcSL/9GbflmZPAl8MqOi6BSiWdmNVZDtvwiDrXcJ8sFwXX48lFfCr/X
         wAgnGE8TBRQDx7zep17eczot4owoqocmojJ2B1UIF3996KL5H5yKdjPmNSVnUf4AqjNa
         rln2yoActQTeguQWHfcZC3czrrvZnhzuMvVik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r6dF4D+wN0hoeI/HD/8hpNX9Zi5cUiRTSVM80fnZiTg=;
        b=jRZ/TtiuA3Grkkk4jpAsnki4NPcI4pB3Fnvx4W/Swty3O9+lriZC0KyXRUI3JuXTUY
         XC75oRFyUJkfZ1n3bfAYsXMU9hagDzSuu/YzDwYc8W+taNuUsU0fGoj54S8XqnsKvUQj
         aGxC5g5U1+qeG5vRxqZaBFXfhkK5A4fyOV9kImTHR+dQNa3LC46hDzXnMxCLXL1cc9ko
         BWjamDzYZjqgU3AdWYzmevaUWp4GATGPMnA7hX2luHdkpqpUUhJNHrxGfjyC29rg3ZXz
         UGMeaI67YALDLstW2z4od+uB0PKzah+U0C162cONTtYPNk2T9gMN0gChXZxzXGvNWKNT
         OU5A==
X-Gm-Message-State: AGi0PuZKGTUtS+4epN0/vaxddYm6xzBqMvg2nWQnUCi/OAMdC63f5s+T
        qMHwNABOYTr7XvRb59MsO+VVZG9ssxT3U6tPxtrC1w==
X-Google-Smtp-Source: APiQypLlztDYYEwUmNspxfYCm4X+JL6rjJrBiwa1m4IaNyse2DCEG6Vj7c7I41oPprzB2RKLqJ1TOmG77/BhEZSyEk4=
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr1303254wmj.12.1586892732880;
 Tue, 14 Apr 2020 12:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200306002112.255361-1-dbasehore@chromium.org> <ecbfb5f8-615a-4a88-5dac-de17158125bf@gmail.com>
In-Reply-To: <ecbfb5f8-615a-4a88-5dac-de17158125bf@gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Tue, 14 Apr 2020 12:32:01 -0700
Message-ID: <CAGAzgsqpjZxh7PEL_Dy7HrFeFGm7+=F6cL3QG9KmK9CHvDWZ9g@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] Panel rotation patches
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry, sorry for the late reply.

On Sun, Mar 8, 2020 at 12:25 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 06.03.2020 03:21, Derek Basehore =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > This adds the plumbing for reading panel rotation from the devicetree
> > and sets up adding a panel property for the panel orientation on
> > Mediatek SoCs when a rotation is present.
>
> Hello Derek and everyone,
>
> I'm looking at adding display rotation support to NVIDIA Tegra DRM
> driver because some devices have display panel physically mounted
> upside-down, and thus, display controller's scan-out needs to be rotated
> by 180=C2=B0 in this case.
>
> Derek, yours panel-rotation patches add support for assigning panel's
> orientation to the connector, but then only primary display plane
> receives rotation value in [1], while rotation needs to be applied to
> all available overlay/cursor planes and this should happen in other
> places than [1] as well.

This is intended. We don't correct the output in the kernel. We
instead rely on notifying userspace that the panel is rotated, then we
handle it there.

>
> [1] drm_client_modeset_commit_atomic()
>
> Please also note that in a case of the scan-out rotation, plane's
> coordinates need to be changed in accordance to the display's rotation.
>
> I looked briefly through the DRM code and my understanding that the DRM
> core currently doesn't support use-case where scan-out needs to rotated
> based on a panel's orientation, correct? Is it the use-case you're
> working on for the Mediatek driver?

Yes, we rely on userspace to rotate the output. The major reason for
this is because there may not be a "free" hardware rotation that can
be applied to the overlay. Sean Paul and others also preferred that
userspace control what is output to the screen instead of the kernel
taking care of it. This code just adds the drm property to the panel.
