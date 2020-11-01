Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958882A2127
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKATtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKATtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:49:40 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E002225C
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604260180;
        bh=lHzrhfrhc7DEksAwUXfiMVlFunQp6V9qP+SGxgZ+gEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QSFRf7JVZ+/aLy34eR+g7TKCLlgSmuqMyPH/X5bGAJQXbdertfo5ujDA65zxyKJSt
         C7n0qsta8HcIpRov2MYcqoVCaBEVMujHZzLnlKKy/pXp9RISLu/6njgX+6uGJE8YEa
         Xl6n4PtsC7JiV8NpZsjyWQAlpXD3uuEru/gHkKTE=
Received: by mail-qk1-f179.google.com with SMTP id k9so9802789qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 11:49:40 -0800 (PST)
X-Gm-Message-State: AOAM532i0N+3nuKwAW+TBT7iyePAK0u9fbnKvDZTGoSR2xfo0ELpzQwK
        zFh6i13xx71lNPNQbWUk4hJQRq8C1QalMypVPv4=
X-Google-Smtp-Source: ABdhPJwS0rufggBHCboTV3UJ+PnoqrAa/wlD2FT+7Oe/PbUr6mI4FpOqVyeEqS+Sft2Djy6PFEhDQHl7KD+xAPH1bP8=
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr11968244qki.286.1604260179399;
 Sun, 01 Nov 2020 11:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20201101170949.18616-1-harshalchau04@gmail.com>
In-Reply-To: <20201101170949.18616-1-harshalchau04@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 1 Nov 2020 20:49:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3fJqijYW-8eT7R+eTUwY_EL4LsG9bDzN2LxNHZ1vyc4A@mail.gmail.com>
Message-ID: <CAK8P3a3fJqijYW-8eT7R+eTUwY_EL4LsG9bDzN2LxNHZ1vyc4A@mail.gmail.com>
Subject: Re: [PATCH] misc: xilinx-sdfec: remove check for ioctl cmd and argument.
To:     Harshal Chaudhari <harshalchau04@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 6:09 PM Harshal Chaudhari
<harshalchau04@gmail.com> wrote:
>
> if (_IOC_TYPE(cmd) !=3D PP_IOCTL)
>         return -ENOTTY;
>
> Invalid ioctl command check normally performs by =E2=80=9Cdefault=E2=80=
=9D case.
>
> if (_IOC_DIR(cmd) !=3D _IOC_NONE) {
>        argp =3D (void __user *)arg;
>        if (!argp)
>              return -EINVAL; }
>
> And for checking ioctl arguments, copy_from_user()/copy_to_user()
> checks are enough.
>
> Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>

Thanks for following up on this,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
