Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763B41E72F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 04:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407113AbgE2C5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 22:57:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35121 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405441AbgE2C5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:57:22 -0400
Received: by mail-io1-f67.google.com with SMTP id s18so829960ioe.2;
        Thu, 28 May 2020 19:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25sQ6aEE/07mgFvv8aMPG1iOVIhuVgnMe44YXtkJRi0=;
        b=ocwo5kxGJS9PpGCm83KEZJ2Mru8CrnPnCZb+URNGQC+Uq0FLMCEIiGJRZd1K+iPdoW
         v2B17x5ppV9h50vMMCgPnay6okSN+zVnbc+pwDBYEemb9ZCAAnNAkj4GDRO1I3mYhc2q
         JOZIybEWgHlLAhEUClqpnIFD392sH/fjSC7lzUVOEHqgXfBGvCbNOY1CStzcarW9ZNh5
         twXtfZd7ooOSUEIZdk/3D1NFZ4Tre3d1IDuB76WmHf8hMJnAPQtKnbCw/C1EVSWrtgsr
         cRelfZmjVqEwD/mn3yvqZzre3cfIPOqIWq/MlU2buDDBqI7Oo6GqIr3SUGRb2ngXPlYb
         dkYA==
X-Gm-Message-State: AOAM530bJB9FXl2vZTTLqv8j3QILNubWCvJMu9781oM6rsXTsh2EFu+q
        WkCZ9sNFenirE05t890aSg==
X-Google-Smtp-Source: ABdhPJyBow537kOqBKLqZJ1ZOCWyZZPMoSyOd8NokyBxfQP/zb9BdtNXndu6/s+C970Sf6dieRhYJw==
X-Received: by 2002:a02:3344:: with SMTP id k4mr5165400jak.140.1590721041298;
        Thu, 28 May 2020 19:57:21 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p7sm3283247iob.7.2020.05.28.19.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:57:20 -0700 (PDT)
Received: (nullmailer pid 1184575 invoked by uid 1000);
        Fri, 29 May 2020 02:57:19 -0000
Date:   Thu, 28 May 2020 20:57:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     devicetree@vger.kernel.org, frowand.list@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of/fdt: Remove redundant kbasename function call
Message-ID: <20200529025719.GA1184522@bogus>
References: <20200528132541.463300-1-arch0.zheng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528132541.463300-1-arch0.zheng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 21:25:41 +0800, Qi Zheng wrote:
> For version 1 to 3 of the device tree, this is the node full
> path as a zero terminated string, starting with "/". The
> following equation will not hold, since the node name has
> been processed in the fdt_get_name().
> 
> 	*pathp == '/'
> 
> For version 16 and later, this is the node unit name only
> (or an empty string for the root node). So the above
> equation will still not hold.
> 
> So the kbasename() is redundant, just remove it.
> 
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
> 
> Change in v2:
> 	remove another kbasename() also.
> 
>  drivers/of/fdt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Applied, thanks!
