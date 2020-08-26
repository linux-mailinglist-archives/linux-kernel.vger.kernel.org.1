Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9DA2527EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHZG5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 02:57:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52909 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgHZG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:57:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id x5so644520wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 23:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJ+z8sXxNjqoViIVlXVCjzuFqOhddkyEZDeuRaaH15c=;
        b=tN9NlSDuLypusjhP9qZ+JqxjNVSKxxA8E7X5kdFS0IioVxtsptIdnePnfHj2Ils4bW
         4BBFDAvyKvvl+QVkRWaWHGDyStP9WF1TKCNfd29NUo7PnNmLs01KfQ5GkwPJq8aIxb9+
         3/Oi54FQnwmL68SQY9F1sY181qLTKWCt4TktrL587u4OuVYEMiew1ToNGc7KdzogXcwr
         Hcl7cRaZXuIh0JX8lFY05jAh/r73f0h1Fydy+AdJE/Xl0DrXtHuwNOYy5ff8xRvW78SG
         5GlAUxLnoWG/FME5NNMWUKMB06rO1eXJbH09oev4XSgpTeM/xsYhZdyrFzTv+YM5Qb7X
         FnHg==
X-Gm-Message-State: AOAM530DKiJ2tIo5PxuGLVR5ULzSpOKw+K6N36khRwW0FYlg9TNepOGn
        r32YEOXXkUGNLBfb7VfG0zQ=
X-Google-Smtp-Source: ABdhPJyMIFK9fVPoNBmHgpxuiRD2DTrZb2oYglHZQ+uiQNO9/BKl5+nzUsm+D2GNouFk8XIn3keWjg==
X-Received: by 2002:a05:600c:514:: with SMTP id i20mr5622383wmc.102.1598425061379;
        Tue, 25 Aug 2020 23:57:41 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id 11sm2929545wmo.23.2020.08.25.23.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 23:57:40 -0700 (PDT)
Date:   Wed, 26 Aug 2020 08:57:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, andriy.shevchenko@intel.com,
        thomas.langer@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 1/9] extcon: extcon-ptn5150: Switch to GENMASK() for
 vendor and device ID's
Message-ID: <20200826065738.GA12271@pi3>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818065727.50520-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818065727.50520-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:57:19PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Switch to GENMASK() for vendor_id and device_id macros.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
