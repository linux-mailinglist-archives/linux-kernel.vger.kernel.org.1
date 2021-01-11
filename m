Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EB12F0FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbhAKKIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbhAKKIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:08:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7751C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:07:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k10so13319788wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWzaRMbmt2By8y7NAjed3CzVmUPuMLhbIN6Z2HhRiPk=;
        b=OAWDr412aSMYDUxWwDp6pKiepwKUJnkIBsf/3qFDM7Go3GGi3j9O+EUop4t7xMxLJL
         KFPI1PCaURTTX/1vBW6Mcq+PEkFAkG9JwoM6YCRHgxPviy6x8ZdUNAHNK/dYF35eJffN
         D2q/BhbwjMjMesCNIKWjqpeUdS/RY9rBvev+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uWzaRMbmt2By8y7NAjed3CzVmUPuMLhbIN6Z2HhRiPk=;
        b=LO9uBfcXt2Irrl6UDKSydv+Tw+eztpybahFOSiSfCUi0BP8qipKqzbCNTbgXOAwe3w
         erdAxtDN4/Venziazi0m+bYTRx6TXyA/wRwY25rI0wMNWUSOnLDEcAh73E2k3mzIVqiv
         wpjJxiTb7uxcVRDSIxp6fknoHa5v7AVcK+Jdp5jbVqvRWLAgbpzoiAElXT3n51ZPgDMT
         AOrncMBwQtoIByyO0vCN4nOx+DG1IwOxbktD2dWsCtWDJaazAhWnUwdQ5okxGcTNN+fq
         BlhoDn0+ZV9gsSCWxGA2EPnUx2g/8MgLSB5XBa3r9h/o9vC1wGgKSclDX0KJkfIUaNCP
         //Cw==
X-Gm-Message-State: AOAM532pXQzlJfEUPgJHBZ602UYlmrF6z8DWUxG6WWzGE/7U2ndogj1P
        tDaC35zdGEVil6ycJbiLcld83Q==
X-Google-Smtp-Source: ABdhPJzfBNXH+bjslOlOA/6EO2izRzsf8AeNYCi7LatDfnaocu5Yh8op6AQw8R/KvstC7WsYcIoQyg==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr13815610wmb.125.1610359670546;
        Mon, 11 Jan 2021 02:07:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i16sm23321093wrx.89.2021.01.11.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 02:07:49 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:07:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     melissa.srw@gmail.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] drm/vkms: Add information about module options
Message-ID: <X/wjc/Hhv9PlnvgM@phenom.ffwll.local>
Mail-Followup-To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        melissa.srw@gmail.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1610200411.git.sylphrenadin@gmail.com>
 <68b521bc789640a5f6437bcaa5d5960799be59c9.1610200411.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b521bc789640a5f6437bcaa5d5960799be59c9.1610200411.git.sylphrenadin@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 07:35:41PM +0530, Sumera Priyadarsini wrote:
> Update vkms documentation to contain usage of `modinfo`
> command and steps to load vkms with module options enabled.
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  Documentation/gpu/vkms.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 9e030c74a82e..45fe02f643a8 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -35,6 +35,16 @@ Now, to load the driver, use::
>  On running the lsmod command now, the VKMS driver will appear listed.
>  You can also observe the driver being loaded in the dmesg logs.
>  

Maybe start out with "vkms has optional features to simulate different
kinds of hardware, which are exposed as module options." Just to make it
clear why you'd want to look at module options and set them.

Otherwise lgtm, with that change on the entire series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +You can use the `modinfo` command to see module options for vkms::
> +
> +  modinfo vkms
> +
> +Module options are helpful when testing, and enabling modules
> +can be done while loading vkms. For example, to load vkms with cursor enabled,
> +use::
> +
> +  sudo modprobe vkms enable_cursor=1
> +
>  To disable the driver, use ::
>  
>    sudo modprobe -r vkms
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
