Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3262B8D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKSIdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKSIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:33:12 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF79C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:33:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id j7so5520136wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mT7p+ygMs80OOlLLDtUTXJKq2ctK4oP6GCRNYht5ITE=;
        b=p/kmwGO62WfItNBLk1iqXhGihrcrhM3nrZ+ZCCybKG7wYP24mkrevXgNWFLkBZO5Pa
         ygl6l2oyxpQ7QMXpyh0SwoL+ZE+UsJq1Q/4H6GX/2mffepZz0y5KisRh7GjiaPcSEzFH
         DS9+Q21I59ciSEDZaVwvp27HaLg8jXV8gUmzYDqPImrXtpyTr8RZISntawD8974u+4TY
         s8bSPA0689J/69iGYOKdurvrZKiQbgg8GNxgBj0TXBYT4pRWMUoK/NaSu+SIDb1iDvak
         243rVzmcEzAf6pGSBGz9On7CCeYYXdSrJLeFNdVx6FBdiJoZWSWWiPqLldkOirMAJyi9
         4cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mT7p+ygMs80OOlLLDtUTXJKq2ctK4oP6GCRNYht5ITE=;
        b=gIdbrDijXUfmwvKkXf82AV+QK6naRJNju7NFE87i1V9f18sPARLdBUpQWEnr9mHe5U
         Kj7QOcq1nQKbd9BT5G5Cc2yRGycXz17hMZvJgkG3o5LBrhsjsevaYJLADJe+s3qUtODp
         u2bwcfysgqJJZpGtBqwvjiAw5jiwshdEnsOOwvuuI1car+Eh8znN9RTdZ15ww+aadNXV
         V1N2wJpRc7O6VRfgBtDp12PSmmuGMGrvWt6U5+NCaUb5KoE3VERLf9GHkl9AoRPZbxDB
         JI4uCbJ1Pn7HnD5V1HV7lG4HcpHKMYg9BcfdD2idRuTBFnEYHC6hc3xGDzT/z1bxUTkt
         OU7A==
X-Gm-Message-State: AOAM5311HQsn1RgSCj0offFTnyOYIGKvptU2ABOIVioC0XjTtpxO9gNF
        GUlgCcEkSwNZb7AfYqCt6BgFhg==
X-Google-Smtp-Source: ABdhPJw8Vg1OcjLMQsbIJHJx4HEfhN8RJS+Zwh+q1zE/ojG2Yvcz3D5Bx99r+6xfnWsxTbjh+L4sqg==
X-Received: by 2002:a5d:6250:: with SMTP id m16mr8976722wrv.400.1605774790531;
        Thu, 19 Nov 2020 00:33:10 -0800 (PST)
Received: from dell ([91.110.221.241])
        by smtp.gmail.com with ESMTPSA id p12sm37031490wrw.28.2020.11.19.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 00:33:09 -0800 (PST)
Date:   Thu, 19 Nov 2020 08:33:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] Immutable branch between MFD and MediaTek due for the
 v5.11 merge window
Message-ID: <20201119083308.GW1869941@dell>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110161338.18198-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-mediatek-v5.11

for you to fetch changes up to 86b9d170da98bae13b307d621638954aef645331:

  mfd: syscon: Add syscon_regmap_lookup_by_phandle_optional() function. (2020-11-19 08:30:11 +0000)

----------------------------------------------------------------
Immutable branch between MFD and MediaTek due for the v5.11 merge window

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      mfd: syscon: Add syscon_regmap_lookup_by_phandle_optional() function.

 drivers/mfd/syscon.c       | 18 ++++++++++++++++++
 include/linux/mfd/syscon.h | 11 +++++++++++
 2 files changed, 29 insertions(+)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
