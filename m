Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9372A7554
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgKECT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbgKECT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:19:57 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 18:19:55 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m16so590942ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 18:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7skSxIX4H4ERr2KWMBBNL6BPLI6dS/H7sqa5OXUDuu0=;
        b=QNv/w7aH0oP53J3Y59bUHS48Xks3iYgOQfXV54369dx1Z6kHPJDwCpizgx06CCZ4kn
         Tel6OfCmM9bunMFLvXtfH/QP7HzUoUIz+d02Fi3t+zfEgl5Ti6i8emrafuPWQ2TWowWV
         ihxcezBfT4TUDzZIcjP+IIfbbV15tJEP0gKwg6KL05QNOvgUCmAreZrxlGJAyGA9KtLV
         k3uc3fWqbOMMGbGCUi/eA8wTUZiPXWYJ+uUCFw4w8cna6uaf79YmbZ7iikDRCpBKUCXe
         KPPIsh7JPw+DludHrM6XU8uSwH2VdigxiALfsLR9CwBI/NI9ZKT2vI0LPbNgxV3dz8Cz
         ibNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7skSxIX4H4ERr2KWMBBNL6BPLI6dS/H7sqa5OXUDuu0=;
        b=ta/GwAlUcAIdCMHdfNP5T7Yl3pfkys65DiztGNVVHYQ7nY0Cy/NxHNI+OburEMcg4a
         Xqlkp8ZNmKB48tBt9MTgg40wcaUXyNxhD4rkCtmULdB2dVMJl6F8lo0xVo22x9HdLLic
         Nm1tQGT9BtlBWpIIEnG3vz0ZLfsRGJGHPtnFyDI0E6aNPAPfwu7zYwgncqEvOVFoGVgI
         RNwiK0lqGMbm3hkVAXgGMrbd+Y87JBn8FrMolYOxTtU1DjQ8N3GrdCR8Y0SaEekhD9xO
         4Xrda7Zo2Wp1t9W7DJmk1yo9Z0A3fcnZdIkcl60MPdMKxkkgaTHBKF/eKo8FUE2pm8ut
         jJKw==
X-Gm-Message-State: AOAM532CN46vH2PkbFxDVfpEC2t37IA5kRmBBloehmj8NtQPz4G6yKBT
        TrJYg+jb2DrM/Yy3G6lwtHhXPOdTo+6vEWhplgFCa2KD
X-Google-Smtp-Source: ABdhPJyusyBDGoC19aOti8XmQ85ELZMMzFwcU3LfkkNwF9bElNSWBL+4PwUw8N/q+Q1F9BeNRBHR6dTfuNASqM7FnsA=
X-Received: by 2002:a2e:6c11:: with SMTP id h17mr40022ljc.432.1604542794148;
 Wed, 04 Nov 2020 18:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20201104081936.2128-1-zhenzhong.duan@gmail.com> <67fd98a2-23a9-b69a-4d60-a0698e243a85@linux.intel.com>
In-Reply-To: <67fd98a2-23a9-b69a-4d60-a0698e243a85@linux.intel.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Thu, 5 Nov 2020 10:19:36 +0800
Message-ID: <CAFH1YnO4xas=YnUSYR3MjxRkFPvezHe7Rt4cdgZU4knvvQqzEA@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: remove redundant variable no_platform_optin
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thu, Nov 5, 2020 at 9:47 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Zhenzhong,
>
> On 11/4/20 4:19 PM, Zhenzhong Duan wrote:
> > no_platform_optin is redundant with dmar_disabled and it's only used in
> > platform_optin_force_iommu(), remove it and use dmar_disabled instead.
>
> It's actually not.
>
> If CONFIG_INTEL_IOMMU_DEFAULT_ON is not set, we will get "dmar_disable =
> 1" and "no_platform_optin = 0". In this case, we must force the iommu on
> and set dmar_disable = 0.
>
> The real use case: if a kernel built with [CONFIG_INTEL_IOMMU_DEFAULT_ON
> = n] running on a platform with thunderbolt ports, we must force IOMMU
> on so that the system could be protected from possible malicious
> peripherals.

Thanks for your explanation, clear now and sorry for the noise.

Regards
Zhenzhong
