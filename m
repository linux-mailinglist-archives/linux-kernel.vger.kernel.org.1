Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C912EAEEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbhAEPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbhAEPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:41:02 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C39C061574;
        Tue,  5 Jan 2021 07:40:22 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id k9so35358oop.6;
        Tue, 05 Jan 2021 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6K+lbty0v1J5aqExSObUnzN5cHc7Shl/UPBkwpsnVQ=;
        b=XCK5Mjgc8OOYue48X/MXKAYhbOgZH98rnnW6TgWp3aN/mPp3na9ofjm3bpFd5pp/OS
         N0hfrklPWKhaeSdywpY9n+XnahosHAeI/2rnuk2LOqXZDyasaH2JI2KxCpJxPHtD0bmL
         N4264gqKbyLc3hWabFfQoGzmhhXeu2VhD+5WGKSziLZqEzsp8lZOOhjdDw7asxbtcFDO
         VNsdczIiHZ9AMXOKVnnK3MWNIHh56wma9HR3jMw2BrD8drASG9BJhHsQcB51V3ymOJ0O
         unPXlXWIAQ1MVdfeDirn0aULxLBZgIRsCO8a8iUxyl5V1yp/fRlcqOjbdNbQheA44N0r
         CyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6K+lbty0v1J5aqExSObUnzN5cHc7Shl/UPBkwpsnVQ=;
        b=SRGWl53W+fDjFemx4gHdKxKYZaEyG8umapP/21e/DI3rs7T+D+/lesk6TpuuD74li+
         ybnZEd3DBj6/v8uAVdn3ux3SvwJWdn4vSpzU1+9D95TKQxUBbnuE8tgFQlu0vrkBT29L
         JbDRZgSrd0W0220x59fjv8lGdeUUQopt/oY5aN0Nn5VKwStTqqnybI8fUWPHTtBCsu4M
         46slez9mQ27LN+l9fMrpt2c5vjiIooRL6+iLuqepTFkFxuKUve5tj6smIYN/mm1Cba0F
         lNFzwaeupZ7C2iYRIjACqvhXrB+WWxm8hNDMoYgRFzSaB3NusyH9vqZqmsJvnfEJET9M
         PVVw==
X-Gm-Message-State: AOAM531wGGnf5QzCbUNlfHBrVKDV+e2g/RdeftO716/PbTQ6NXa/4W1J
        odpjdaV+hJoUNrQWNWN6tNB77YegzRkKLSc2+4k=
X-Google-Smtp-Source: ABdhPJwEeCvr5Gf9lHnL9Nzj4AhlQzlbe/5d1giJjKnNX9Rir5gI9wSlmkVbi1lFzi54GajD8qvqTkxvnkU8qbGMzMU=
X-Received: by 2002:a4a:9c5:: with SMTP id 188mr52845323ooa.77.1609861221385;
 Tue, 05 Jan 2021 07:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20201229111219.200668-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20201229111219.200668-1-christophe.jaillet@wanadoo.fr>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 5 Jan 2021 17:39:54 +0200
Message-ID: <CAFCwf125zxK5hWEcGKqLXcz4JnES666GT4FFcdLdzk4OHzv14Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Use 'dma_set_mask_and_coherent()' instead of
 hand-writing it
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Lee Jones <lee.jones@linaro.org>,
        Tomer Tayar <ttayar@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 1:17 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Axe 'hl_pci_set_dma_mask()' and replace it with an equivalent
> 'dma_set_mask_and_coherent()' call.
>
> This makes the code a bit less verbose.
>
> It also removes an erroneous comment, because 'hl_pci_set_dma_mask()' does
> not try to use a fall-back value.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/habanalabs/common/pci.c | 42 ++++------------------------
>  1 file changed, 6 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
> index 923b2606e29f..eb8a784ba863 100644
> --- a/drivers/misc/habanalabs/common/pci.c
> +++ b/drivers/misc/habanalabs/common/pci.c
> @@ -301,40 +301,6 @@ int hl_pci_set_outbound_region(struct hl_device *hdev,
>         return rc;
>  }
>
> -/**
> - * hl_pci_set_dma_mask() - Set DMA masks for the device.
> - * @hdev: Pointer to hl_device structure.
> - *
> - * This function sets the DMA masks (regular and consistent) for a specified
> - * value. If it doesn't succeed, it tries to set it to a fall-back value
> - *
> - * Return: 0 on success, non-zero for failure.
> - */
> -static int hl_pci_set_dma_mask(struct hl_device *hdev)
> -{
> -       struct pci_dev *pdev = hdev->pdev;
> -       int rc;
> -
> -       /* set DMA mask */
> -       rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(hdev->dma_mask));
> -       if (rc) {
> -               dev_err(hdev->dev,
> -                       "Failed to set pci dma mask to %d bits, error %d\n",
> -                       hdev->dma_mask, rc);
> -               return rc;
> -       }
> -
> -       rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(hdev->dma_mask));
> -       if (rc) {
> -               dev_err(hdev->dev,
> -                       "Failed to set pci consistent dma mask to %d bits, error %d\n",
> -                       hdev->dma_mask, rc);
> -               return rc;
> -       }
> -
> -       return 0;
> -}
> -
>  /**
>   * hl_pci_init() - PCI initialization code.
>   * @hdev: Pointer to hl_device structure.
> @@ -371,9 +337,13 @@ int hl_pci_init(struct hl_device *hdev)
>                 goto unmap_pci_bars;
>         }
>
> -       rc = hl_pci_set_dma_mask(hdev);
> -       if (rc)
> +       rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(hdev->dma_mask));
> +       if (rc) {
> +               dev_err(hdev->dev,
> +                       "Failed to set dma mask to %d bits, error %d\n",
> +                       hdev->dma_mask, rc);
>                 goto unmap_pci_bars;
> +       }
>
>         return 0;
>
> --
> 2.27.0
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next
Oded
