Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6521E28C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbgEZR0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 13:26:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:41391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389264AbgEZR0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590513938;
        bh=jRQUdXsgzQMgsoTj3zhMgpmUWjrdF3Acrg1b6Z8xpEY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A4v0BslmcLcNmcz2gh40mjz6rRj+M0vuwF9XZQMXHAZGz9oh1R3fRf+rScycuHG1r
         6EpMTQHna3GgMiAVMoax5W78imf5tOzBhbUnQjBDSI4YN6X7zaS17eSB7n4vFHDUiq
         7/gthsuGZSN19ip9BjUk4s7t28S+o3i4QVaX+Y6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQiS-1jlvL22TNm-00ATza; Tue, 26
 May 2020 19:25:38 +0200
Date:   Tue, 26 May 2020 19:25:27 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/irqchip: Remove function callback casts
Message-ID: <20200526172527.GA3465@ubuntu>
References: <20200524162220.10186-1-oscar.carter@gmx.com>
 <87tv04z3kq.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv04z3kq.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:m3a9oA7bzONbhBBYj4xUCes6egeoZAkdLClOe9CxcLYlVv2WDx7
 piDTMdQa8GqFrmy/UXRI5cWUDxtlru51xuA0vJNzCs7krQU/IYQzwTuhwiQGr6dva8X3zu0
 Ock0CmFgaHXgmfmw/ejkQweQoAI8acoQbUYqm67xXiCKunRQtiEyKGRpJFLAAi9M6Z0Nwrk
 LQ+1km6ffx4pn+J+HhlbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wlQoGyY6xPI=:ZdCx4xCaBt1yGZvkZ5OVHZ
 P+VmGLfrCZ3t92BozzxtVGx1p7b4XlPel3ax6dpDeQjgN2/n17vyQO1gKZ/Rx3uNHqtPdgVWS
 nMREAez10oszqwO/zVM9reKtpU7rv1DbTbZEro7ZP2VxhZ+QTljJ+54NnEYdaEVlLaaVwyYBK
 qH8mXhYvP6jpMAXq8ah0NiKO/5YVzEdInSIY4xDfRIDQecHNoCTrYxGPN/iNyCrK63uluc6lq
 HulYS1lOjCYvvc97mam8JNVD699I+7JF+qJK4BuwUwP8hhtz9rsurzybu3Wk4Dw+8JrXld4OH
 /OnkgSKjU6VNyxAwhOSnCb903yoCYrODuHqJYoo1IhUgRk7BVe+nmI3WbfDXjRWFTTbhkbgcr
 lmtWkYRdr3we2z3ZiKuRqLa9aDXRNhZjsmJFMR4ZsQ4eRuJam0r4taW5bePNmY6uuh9/u5OoF
 fV6jCjfeYC0EgeUmeuEzQvIEGHgOguU8VotdRfsLLgwvRG5d+NUD6F99Lr6aD9RyxzTRRxZwX
 Y2WTbtKRm7ytDcoPDDpBCAE7x+btjP+dpDPgJ09j8u0GVks6sHZqO9QETtebTlnk7gPTm2m4T
 Yq4phjU17mFx8hswL7K5+V3kFnmbngvy+vDOdS6qJJzB+bvegb/xpI33YZCPIr6+qf778xUlY
 bsOlOD9C5+q9Y7HVRE9cQjZfeYg6ec3UNU3LgYNwzbdrIDOYSfidua1+57/gI6vQypsHUMlt/
 z7DVymVYPH9Yc1HGFHTm8DXMzVfyMCECY2OYKfV8EDoJMqWmv3cf0M8B3tuJy2IcWnbVhXxHD
 rwgzwQT0Kh1314oAn4kZSchByJLsRAvpOMzj4wsmCouJimvuh86U/a0bYZDXMpK9/yaEfUC23
 VSyUkomfQY/InFk3ggIOrWiq2AlgcNPRY9MPZTDRSQuvat2STYIC8ViGDF/AAJqVUKohc5f8I
 jQWhAJV16zpedNLy1Oa40Du8FAKsiHqIlNcyM8cw/R3ZjnGPMzYDZO3j4F0knoODCQsV2C8/X
 aotIAM2Ges62NO2DJ9E6RMsIwEyFbEewlZw8scrIW24FMs1rwBt5oh6n0JlHQvdQ5TqM16cV7
 /t2ouA8i08MnvinYe+9OXggPFxmg2U2C8XVjrmEIFoGYNSA+t0RND2RebSpDaWdqkasmvVgRy
 j35PPmVdpRzERW8/Z8LDxixCiLKTE2xHRPW8NoQz9D5T62arSY4QPeLq7DYQvksMUkAz1ODe8
 FDfTg9/c65KzF4lFP
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:55:33AM +0100, Marc Zyngier wrote:
> On Sun, 24 May 2020 17:22:20 +0100,
> Oscar Carter <oscar.carter@gmx.com> wrote:
> >
> >  include/linux/acpi.h    | 11 +++++++++++
>
> You now need to Cc the ACPI maintainers.

Sorry for forgetting.

> >  include/linux/irqchip.h |  5 +++--
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index d661cd0ee64d..fed49b276a90 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1154,6 +1154,17 @@ struct acpi_probe_entry {
> >  			.driver_data =3D data, 				\
> >  		   }
> >
> > +#define ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(table, name, table_id,	\
> > +					  subtable, valid, data, fn)	\
> > +	static const struct acpi_probe_entry __acpi_probe_##name	\
> > +		__used __section(__##table##_acpi_probe_table) =3D {	\
> > +			.id =3D table_id,					\
> > +			.type =3D subtable,				\
> > +			.subtable_valid =3D valid,			\
> > +			.probe_subtbl =3D (acpi_tbl_entry_handler)fn,	\
>
> It strikes me that under the guise of removing function casts, you are
> actually adding one! And this cast is actually hiding all sorts of
> sins (remove it, and see things exploding).

Yes, if I remove it I see things exploiding. I'm very sorry.

> I've fixed it with the patch below (ACPI is such a mess of data
> structure case...).

> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index d7006ef18a0d..3870e9d4d3a8 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2117,7 +2117,7 @@ static void __init gic_acpi_setup_kvm_info(void)
>  }
>
>  static int __init
> -gic_acpi_init(struct acpi_subtable_header *header, const unsigned long =
end)
> +gic_acpi_init(union acpi_subtable_headers *header, const unsigned long =
end)
>  {
>  	struct acpi_madt_generic_distributor *dist;
>  	struct fwnode_handle *domain_handle;
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 30ab623343d3..fc431857ce90 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1593,7 +1593,7 @@ static void __init gic_acpi_setup_kvm_info(void)
>  	gic_set_kvm_info(&gic_v2_kvm_info);
>  }
>
> -static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
> +static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
>  				   const unsigned long end)
>  {
>  	struct acpi_madt_generic_distributor *dist;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index fed49b276a90..4f4ddbfce3d3 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1150,7 +1150,7 @@ struct acpi_probe_entry {
>  			.id =3D table_id,					\
>  			.type =3D subtable,				\
>  			.subtable_valid =3D valid,			\
> -			.probe_table =3D (acpi_tbl_table_handler)fn,	\
> +			.probe_table =3D fn,				\
>  			.driver_data =3D data, 				\
>  		   }
>
> @@ -1161,7 +1161,7 @@ struct acpi_probe_entry {
>  			.id =3D table_id,					\
>  			.type =3D subtable,				\
>  			.subtable_valid =3D valid,			\
> -			.probe_subtbl =3D (acpi_tbl_entry_handler)fn,	\
> +			.probe_subtbl =3D fn,				\
>  			.driver_data =3D data,				\
>  		}
>

Thanks for your help with this patch. I will do all the necessary changes
and I will resend a new version.

Do you mind if I add these two lines:

Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>

in the next version to give you credit?

> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
Oscar
