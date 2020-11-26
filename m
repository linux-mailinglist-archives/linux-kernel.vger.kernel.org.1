Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EBB2C5719
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbgKZO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390457AbgKZO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:26:50 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7968EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:26:50 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id l10so443316ooh.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0EgbywxA+4sIDLWiLToUErSIiqJfS8oiujhpJBsJzR4=;
        b=CXzsjSr/LySmKrLzCjMzHQDW5ZbGijvcn+5lWCgXW7Ps+upKzWn9EC4MJquI3QahoH
         jPQkQHG72wTvNeLZLKaNz0w8szCwlk6YrBuTR/gSjORtaBSm4CBmhYPPyn3P9QDCHD5y
         I0QGfcvkHEC2XiOqvmuh38G7DuwAmh/dzXu7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0EgbywxA+4sIDLWiLToUErSIiqJfS8oiujhpJBsJzR4=;
        b=t/7LKiLOJuUs73gn3pVJGjcBRHvEzMXlaLfIWBcKhIQS9wElbAEbNxfaE9H5GJ6CEr
         2+9nJEF+wYWCVVOsDPXXoeBpjXS9rG0I5UqEqYMjIXIHG5z10n+P9hcLw1g+0gMsfmDZ
         rJPkDqirm8WENvL73Qp2zCQCEMDIq6w6LSRxCX53+wmvywml7TRf356jlnP9Tnz8UbE2
         t97yf68MNzywvXgtT0Ttst4d9QZScDNmINLb+d4O77rM5+ViBKvHYYJZKbJBjbquzsFC
         ax+nusUzb30jI6wJM8tecUlBOkB8rn2oyYYTPsYH44NjWqPps2oIBWES0I5LCqdTo1yn
         7D+A==
X-Gm-Message-State: AOAM531Sq2cTOK1ScTcgx9fMailIYE2Ch3s7NAwHThau46oLSmAwEGlg
        NyVv7BRoDzTUNDjc4R7BDuQsX74LhtD3sG1E9Hy5VbRMHwOdyA==
X-Google-Smtp-Source: ABdhPJwDw9/tK9Nhd9vwyktsfs20EHzhzqTAQOtoTIqN65dd5HrDmbhpn9hLgp3rrI/tFy3hsZOCjQJ95dI25IDbb70=
X-Received: by 2002:a4a:84c9:: with SMTP id o9mr2164600oog.28.1606400809735;
 Thu, 26 Nov 2020 06:26:49 -0800 (PST)
MIME-Version: 1.0
References: <20201125090903.4436-1-kuohsiang_chou@aspeedtech.com> <4d9d5c42-842b-1152-1b81-da634fe4f124@suse.de>
In-Reply-To: <4d9d5c42-842b-1152-1b81-da634fe4f124@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 26 Nov 2020 15:26:38 +0100
Message-ID: <CAKMK7uEEi3SCS7VQ6CzfPaasygD5VCfV7US2ZS=OkKPEvmwQCQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ast: Fixed CVE for DP501
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>, jenmin_yuan@aspeedtech.com,
        tommy_huang@aspeedtech.com, arc_sung@aspeedtech.com,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 1:51 PM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi,
>
> please see below for a review.
>
> Am 25.11.20 um 10:09 schrieb KuoHsiang Chou:
> > [Bug][DP501]
> > 1. For security concerning, P2A have to be disabled by CVE regulation.
> > 2. FrameBuffer reverses last 2MB used for the image of DP501
> > 3. If P2A is disallowed, the default "ioremap()" behavior is non-cached
> >     and could be an alternative accessing on the image of DP501.
>
> Please provide a more verbose description of the change. Which problem
> does this patch solve?

We also need a signed-off-by line per

https://dri.freedesktop.org/docs/drm/process/submitting-patches.html#sign-y=
our-work-the-developer-s-certificate-of-origin

Otherwise we cannot merge a patch.
-Daniel

> > ---
> >   drivers/gpu/drm/ast/ast_dp501.c | 131 +++++++++++++++++++++++--------=
-
> >   drivers/gpu/drm/ast/ast_drv.h   |   2 +
> >   drivers/gpu/drm/ast/ast_main.c  |  12 +++
> >   drivers/gpu/drm/ast/ast_mm.c    |   1 +
> >   4 files changed, 110 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_=
dp501.c
> > index 88121c0e0d05..7640364ef2bc 100644
> > --- a/drivers/gpu/drm/ast/ast_dp501.c
> > +++ b/drivers/gpu/drm/ast/ast_dp501.c
> > @@ -189,6 +189,8 @@ bool ast_backup_fw(struct drm_device *dev, u8 *addr=
, u32 size)
> >       u32 i, data;
> >       u32 boot_address;
> >
> > +     if (ast->config_mode !=3D ast_use_p2a) return false;
> > +
>
> The coding style is incorrect. 'Return false' needs to be on the next
> line, indented by an additional tab. Here and in other place.
>
>
> >       data =3D ast_mindwm(ast, 0x1e6e2100) & 0x01;
> >       if (data) {
> >               boot_address =3D get_fw_base(ast);
> > @@ -207,6 +209,8 @@ static bool ast_launch_m68k(struct drm_device *dev)
> >       u8 *fw_addr =3D NULL;
> >       u8 jreg;
> >
> > +     if (ast->config_mode !=3D ast_use_p2a) return false;
> > +
>
> Coding style.
>
> >       data =3D ast_mindwm(ast, 0x1e6e2100) & 0x01;
> >       if (!data) {
> >
> > @@ -272,24 +276,51 @@ u8 ast_get_dp501_max_clk(struct drm_device *dev)
> >       u32 boot_address, offset, data;
> >       u8 linkcap[4], linkrate, linklanes, maxclk =3D 0xff;
> >
> > -     boot_address =3D get_fw_base(ast);
> > -
> > -     /* validate FW version */
> > -     offset =3D 0xf000;
> > -     data =3D ast_mindwm(ast, boot_address + offset);
> > -     if ((data & 0xf0) !=3D 0x10) /* version: 1x */
> > -             return maxclk;
> > -
> > -     /* Read Link Capability */
> > -     offset  =3D 0xf014;
> > -     *(u32 *)linkcap =3D ast_mindwm(ast, boot_address + offset);
> > -     if (linkcap[2] =3D=3D 0) {
> > -             linkrate =3D linkcap[0];
> > -             linklanes =3D linkcap[1];
> > -             data =3D (linkrate =3D=3D 0x0a) ? (90 * linklanes) : (54 =
* linklanes);
> > -             if (data > 0xff)
> > -                     data =3D 0xff;
> > -             maxclk =3D (u8)data;
> > +     if (ast->config_mode =3D=3D ast_use_p2a) {
> > +             boot_address =3D get_fw_base(ast);
> > +
> > +             /* validate FW version */
> > +             offset =3D 0xf000;
> > +             data =3D ast_mindwm(ast, boot_address + offset);
> > +             if ((data & 0xf0) !=3D 0x10) /* version: 1x */
> > +                     return maxclk;
>
> Please give these constants some meaningful names. I suggest something li=
ke
>
> #define AST_DP501_FW_VERSION_MASK       GENMASK(7, 4)
> #define AST_DP501_FW_VERSION_1          BIT(4)
>
> There are already a few constants in ast_drv.h. I'd put them there as
> well. It's better than a comment.
>
> > +
> > +             /* Read Link Capability */
> > +             offset  =3D 0xf014;
>
> Please give the offset a meaningful name.
>
>
> > +             *(u32 *)linkcap =3D ast_mindwm(ast, boot_address + offset=
);
>
> The cast shoudl go to the right-hand side of the assignment.
>
> > +             if (linkcap[2] =3D=3D 0) {
> > +                     linkrate =3D linkcap[0];
> > +                     linklanes =3D linkcap[1];
> > +                     data =3D (linkrate =3D=3D 0x0a) ? (90 * linklanes=
) : (54 * linklanes);
> > +                     if (data > 0xff)
> > +                             data =3D 0xff;
> > +                     maxclk =3D (u8)data;
> > +             }
> > +     }
> > +     else {
>
> else goes on the same line as }
>
> > +             if (!ast->reservedbuffer) return 65;    /* 1024x768 as de=
fault */
>
> Coding style. Please give a meaningful name to 65.
>
> > +
> > +             /* dummy read */
> > +             offset =3D 0x0000;
> > +             data =3D *(u32 *) (ast->reservedbuffer + offset);
>
> Why is this required?
>
> reservedbuffer is I/O memory accessed in 32-bit chunks. You should use
> readl and writel to access its content.
>
> > +
> > +                     /* validate FW version */
> > +                     offset =3D 0xf000;
>
> The indention is off.
>
> > +             data =3D *(u32 *) (ast->reservedbuffer + offset);
> > +                     if ((data & 0xf0) !=3D 0x10) /* version: 1x */
> > +                             return maxclk;
>
> Indention.
>
> > +
> > +             /* Read Link Capability */
> > +             offset  =3D 0xf014;
> > +             *(u32 *)linkcap =3D *(u32 *) (ast->reservedbuffer + offse=
t);
> > +             if (linkcap[2] =3D=3D 0) {
> > +                     linkrate =3D linkcap[0];
> > +                     linklanes =3D linkcap[1];
> > +                     data =3D (linkrate =3D=3D 0x0a) ? (90 * linklanes=
) : (54 * linklanes);
> > +                     if (data > 0xff)
> > +                             data =3D 0xff;
> > +                     maxclk =3D (u8)data;
> > +             }
> >       }
> >       return maxclk;
> >   }
> > @@ -299,25 +330,53 @@ bool ast_dp501_read_edid(struct drm_device *dev, =
u8 *ediddata)
> >       struct ast_private *ast =3D to_ast_private(dev);
> >       u32 i, boot_address, offset, data;
> >
> > -     boot_address =3D get_fw_base(ast);
> > -
> > -     /* validate FW version */
> > -     offset =3D 0xf000;
> > -     data =3D ast_mindwm(ast, boot_address + offset);
> > -     if ((data & 0xf0) !=3D 0x10)
> > -             return false;
> > -
> > -     /* validate PnP Monitor */
> > -     offset =3D 0xf010;
> > -     data =3D ast_mindwm(ast, boot_address + offset);
> > -     if (!(data & 0x01))
> > -             return false;
> > +     if (ast->config_mode =3D=3D ast_use_p2a) {
> > +             boot_address =3D get_fw_base(ast);
> >
> > -     /* Read EDID */
> > -     offset =3D 0xf020;
> > -     for (i =3D 0; i < 128; i +=3D 4) {
> > -             data =3D ast_mindwm(ast, boot_address + offset + i);
> > -             *(u32 *)(ediddata + i) =3D data;
> > +             /* validate FW version */
> > +             offset =3D 0xf000;
> > +             data =3D ast_mindwm(ast, boot_address + offset);
> > +             if ((data & 0xf0) !=3D 0x10)
> > +                     return false;
> > +
> > +             /* validate PnP Monitor */
> > +             offset =3D 0xf010;
>
> Please name the constant.
>
> > +             data =3D ast_mindwm(ast, boot_address + offset);
> > +             if (!(data & 0x01))
>
> Please name the constant.
>
> > +                     return false;
> > +
> > +             /* Read EDID */
> > +             offset =3D 0xf020;
> > +             for (i =3D 0; i < 128; i +=3D 4) {
> > +                     data =3D ast_mindwm(ast, boot_address + offset + =
i);
> > +                     *(u32 *)(ediddata + i) =3D data;
>
> writel for I/O access
>
> > +             }
> > +     }
> > +     else {
>
> else on wrong line
>
> > +             if (!ast->reservedbuffer) return false;
> > +
> > +             /* dummy read */
> > +             offset =3D 0x0000;
> > +             data =3D *(u32 *) (ast->reservedbuffer + offset);
> > +
> > +             /* validate FW version */
> > +             offset =3D 0xf000;
> > +             data =3D *(u32 *) (ast->reservedbuffer + offset);
> > +             if ((data & 0xf0) !=3D 0x10)
> > +                     return false;
> > +
> > +             /* validate PnP Monitor */
> > +             offset =3D 0xf010;
> > +             data =3D *(u32 *) (ast->reservedbuffer + offset);
> > +             if (!(data & 0x01))
> > +                     return false;
> > +
> > +             /* Read EDID */
> > +             offset =3D 0xf020;
> > +             for (i =3D 0; i < 128; i+=3D4) {
> > +                     data =3D *(u32 *) (ast->reservedbuffer + offset +=
 i);
> > +                     *(u32 *)(ediddata + i) =3D data;
> > +             }
> >       }
> >
> >       return true;
> > diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_dr=
v.h
> > index 6b9e3b94a712..cd17e0683fd7 100644
> > --- a/drivers/gpu/drm/ast/ast_drv.h
> > +++ b/drivers/gpu/drm/ast/ast_drv.h
> > @@ -121,12 +121,14 @@ struct ast_private {
> >
> >       void __iomem *regs;
> >       void __iomem *ioregs;
> > +     void __iomem *reservedbuffer;
>
> reservedbuffer has no meaning. As it stores the DP501's firmware, I'd
> call it dp501_fw.
>
> >
> >       enum ast_chip chip;
> >       bool vga2_clone;
> >       uint32_t dram_bus_width;
> >       uint32_t dram_type;
> >       uint32_t mclk;
> > +     uint32_t vram_size;
> >
> >       int fb_mtrr;
> >
> > diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_m=
ain.c
> > index 4ec6884f6c65..4477b4cf1b06 100644
> > --- a/drivers/gpu/drm/ast/ast_main.c
> > +++ b/drivers/gpu/drm/ast/ast_main.c
> > @@ -393,6 +393,7 @@ static void ast_device_release(void *data)
> >
> >       /* enable standard VGA decode */
> >       ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x04);
> > +     pci_iounmap(ast->base.pdev, ast->reservedbuffer);
> >   }
> >
> >   struct ast_private *ast_device_create(struct drm_driver *drv,
> > @@ -449,6 +450,17 @@ struct ast_private *ast_device_create(struct drm_d=
river *drv,
> >       if (ret)
> >               return ERR_PTR(ret);
> >
> > +     /* map reserved buffer */
> > +     ast->reservedbuffer =3D NULL;
> > +     if (ast->vram_size < pci_resource_len(dev->pdev, 0)) {
> > +             ast->reservedbuffer =3D ioremap( \
> > +                     pci_resource_start(ast->base.pdev, 0) + (unsigned=
 long)ast->vram_size, \
> > +                     pci_resource_len(dev->pdev, 0) - ast->vram_size);
>
> Use pci_iomap_range() instead. The function's offset parameter is
> vram_size, the function's maxlen parameter is 0.
>
> You also won't need pci_iounmap(). pci_iomap_range() sets up the cleanup
> for you.
>
> > +             if (!ast->reservedbuffer) {
>
> No braces around single-line branch.
>
> > +                     DRM_INFO("failed to map reserved buffer! \n");
>
> Use drm_info() instead
>
> > +             }
> > +     }
> > +
> >       ret =3D ast_mode_config_init(ast);
> >       if (ret)
> >               return ERR_PTR(ret);
> > diff --git a/drivers/gpu/drm/ast/ast_mm.c b/drivers/gpu/drm/ast/ast_mm.=
c
> > index 8392ebde504b..c6fd24493fb3 100644
> > --- a/drivers/gpu/drm/ast/ast_mm.c
> > +++ b/drivers/gpu/drm/ast/ast_mm.c
> > @@ -90,6 +90,7 @@ int ast_mm_init(struct ast_private *ast)
> >       int ret;
> >
> >       vram_size =3D ast_get_vram_size(ast);
> > +     ast->vram_size =3D (uint32_t) vram_size;
>
> You don't need to store vram_size. Look at dev->vram_mm->vram_size instea=
d.
>
> >
> >       ret =3D drmm_vram_helper_init(dev, pci_resource_start(dev->pdev, =
0),
> >                                   vram_size);
> > --
> > 2.18.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
