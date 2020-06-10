Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35F31F4EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 09:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgFJHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:34:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B12C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:34:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so1042356wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pPYsOkd0MaHFAV27/hleOZL5j8NZYoNpMPjKCa/pW6o=;
        b=cFrzZBDamQ0ImuwdVAAv5SjRaHfqNdiUIi6Qc/HehPCyDzY5hfUZAO1VME9wVuTrD/
         qBz6phph5DKUk7OUrcU2BTQYC4HauV9ooirfw0OPBJcrLz4bE0W5CnDp7NPnWS2TkFf4
         AX6Di1OlAIOceV5MZErq8tdDt+Gk+Gt9EdO1QLlxTlVzKA2EBqq+c2OeX1d0GDF9b/eH
         8jnSRagqTXZWRie2yKhEQj/ihPry8vjEBadq+j4UaNnxaZ6GJ6k/98uOv3vdc0Atcv4q
         xIUd1qGRKI/L/iRCpkHinfaxEvQFHYmGMlr//BUxZEYGnpXgpwXe/juoxCPLSQ7euUKl
         SrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pPYsOkd0MaHFAV27/hleOZL5j8NZYoNpMPjKCa/pW6o=;
        b=b6+azVLq2eMb974i807xdu+xjaguvi1Qa3UIsdcmIttvQ201BwHEmJ8edrnNV3Kq09
         O3esUT26uwvYtF6DWSMeTrTosX7ZeiBoJwNB5jOv3y04M1Sc9OpVGo9ruTuwIChoRHpa
         mO7V9mWiJ+WRoZTC3nUnDQ+SOZQjGmTy46PLAnyYNOTxQToe+bV4/flhLwstkjg4Z9l0
         ob8qKJuqwT7EotSjuezxSguMZ3+iiVcFnIao5fsdXoowjC76qfzMKpk6Gsz1smr7a8nF
         fHsrCn8Pecssi61J15Us7vAvDRwRtu55zOKhHk5ArlPD95/KVHHKdU+8zhxrRxN2THRR
         AroA==
X-Gm-Message-State: AOAM5303HIafxQRRW503NVDaLBkpVFEeFXGNya+soQXKwZV+l2LNSccR
        JszYelc97RG3Xs3fA+9PF5IIEw==
X-Google-Smtp-Source: ABdhPJxuuz7bGzKCDK+AhMAYdJjDkuPJpla8oMMTj5kVQ7X046F67WswfSJ4/YH22hWhWbx3A883UQ==
X-Received: by 2002:adf:8b0c:: with SMTP id n12mr2219342wra.340.1591774453182;
        Wed, 10 Jun 2020 00:34:13 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id h27sm7892299wrb.18.2020.06.10.00.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:34:12 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:34:10 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: defconfig: enable storage for qemu
Message-ID: <20200610073410.GA16313@Red>
References: <1583423303-25405-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583423303-25405-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 03:48:23PM +0000, Corentin Labbe wrote:
> The qemu versatilepb machine has some SCSI storage which cannot be used
> with this defconfig.
> The SCSI rely on PCI which is not enabled.
> So let's enable both PCI and SCSI.
> 
> This will permit to use LAVA tests for versatilepb in kernelCI.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm/configs/versatile_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
> index 767935337413..6171b96cf9b8 100644
> --- a/arch/arm/configs/versatile_defconfig
> +++ b/arch/arm/configs/versatile_defconfig
> @@ -96,3 +96,7 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_USER=y
>  CONFIG_DEBUG_LL=y
> +CONFIG_PCI=y
> +CONFIG_PCI_VERSATILE=y
> +CONFIG_SCSI=y
> +CONFIG_SCSI_SYM53C8XX_2=y
> -- 
> 2.24.1
> 

gentle ping
