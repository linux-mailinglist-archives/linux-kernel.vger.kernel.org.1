Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8522A5D18
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgKDDZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKDDZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:25:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B3C061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 19:25:10 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so9765136pfz.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 19:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXtd9M/VJA7KERzf1z5aRtVCVWZB/O+8UhRoUUyuqwU=;
        b=jF3Ec+H0x1la5ZR75JBZYQ9dGZ/knj4zqqxKnpIMdeIBsH7ry20Pzw6aPCrJB2d/x4
         R5q9gCO16QRmSZ9QdYuzVtCt9ILzsmfK2A9NCEn7bU8PxQyjgHg7qBcFHo4SsM7XWUsI
         jvZQZALT8+Ipnq7EDt0i/jaYiKNCncWmHt3i/pB9dzFNs8ipXbt3/Am4FXppv0bInVl7
         qh7Wk3/MeI69Y3mOaBHFG79jshcu9NheKAxFdt+y/rkVr8VsvnjOUwSU9T+ioRy4/A64
         XLXlMxdZMeFjtiLeVXZCmXG/wEQDdN9kcl4imeFnn/m/J5AtJK3MeX5CSQv8Zx84jQQd
         EHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXtd9M/VJA7KERzf1z5aRtVCVWZB/O+8UhRoUUyuqwU=;
        b=eYPihM50E9ouNQceTxRpLPvDZ7dEel+lR6VDHE+JtAoTiJc9hQz0/5OCPjw1B6EaKZ
         dRO5exdCGtgYZqxaODPZi5EEipbinj0oTEQiHuQL8D1vAlY3+nJF6P+e+7xzOnQnmTD7
         XzMg+7lB78VXBTrSyvNalh7I86UPlX+qCt3xldzQhv3YljE2RMA2QS1FoFMG0xkMp32D
         4OdlFHq3XQmiTEBIW8Em6jVvZqZv7+AI2Q+hho67vDQY/ez567UBWRGYxDL29IwqLHVk
         HQqvuNEwPMa2p1eXl0d3wej3D5MDdR8pQh9E5/YKVwCYAyzWC8raqu38884GJufdBVMy
         32Fw==
X-Gm-Message-State: AOAM533Y7qdlWjXY6/1z/WMsU5XMnMAC4Wt6VJ4Cf9xs6jJrrPeUSg/S
        bpnpvMevRdxp2hs9AwsZmIA=
X-Google-Smtp-Source: ABdhPJwTnKhbGMc5L+1d3ykgF9a4raoVC7JrdoL5Z1pf5uvMbN4lX3IsR29dst2BfCFW/D3bklcmYw==
X-Received: by 2002:a63:1341:: with SMTP id 1mr18985608pgt.6.1604460309964;
        Tue, 03 Nov 2020 19:25:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x26sm526153pfn.178.2020.11.03.19.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 19:25:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] soc: bcm: brcmstb: pm: pm-arm: Provide prototype for brcmstb_pm_s3_finish()
Date:   Tue,  3 Nov 2020 19:25:07 -0800
Message-Id: <20201104032507.565008-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-2-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org> <20201103152838.1290217-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Nov 2020 15:28:14 +0000, Lee Jones <lee.jones@linaro.org> wrote:
> brcmstb_pm_s3_finish() cannot be made static because it is referenced
> from brcmstb_pm_s3(), so let's provide a prototype for it instead.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c:395:14: warning: no previous prototype for ‘brcmstb_pm_s3_finish’ [-Wmissing-prototypes]
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to drivers/next, thanks!
--
Florian
