Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846E62FD627
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391489AbhATQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391224AbhATQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:38:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F11C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:37:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kx7so2497237pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/DhG0PPxm0vKgWn3ZUodFL5gREX9ouvD4YqI6sx3m0=;
        b=T5xizAhCUnokT5bbT4Dz2K7SWIx4lepR61GZQ3HYDfJVWkirqLoPYTENaBy0UESLVT
         HQ9LdIC/+DMy6GeeZSgu5eQudCxPQfMFsGM4mcx9pxxZVjTwLGiiUrshA07jFyBRiOAj
         J5aimP/fSm8b9zSInqaq7Q+U9hCGwgpkAv/MshMoGh05QKecI8RiOHvXEngqRru0WpUY
         SPzdtNptVXkmPQaFHmMFBJAw+7c+Gq4nYiTgv7BETFlXp66C5H2wbwf1Sxx4NhyeY4HO
         RQpf/I3APZggx/HkIAuajo/CoJVwxeptNzt4uikARVj87NRj6wROC3lJgqFmeyMx6/z1
         wSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/DhG0PPxm0vKgWn3ZUodFL5gREX9ouvD4YqI6sx3m0=;
        b=mhF2tNcBcVcU8gsWvi+KUHyYFYfI837PUSr+JE8mOY7qGJmpf3WRLvv4Vmhj63/rdU
         LUrvyWauZLQ8L284fPF97/lC2owsxhSTPUVZHRHhufL6lWzj+wu1Ux+THhB4C9Rc9qxm
         AqAzWAJXxV6bO+fX9w339aczec3cJPWPYK5td4C9FJh7KBR7OzgIU59H/WD3ScIN+STH
         uM/A1a4SYz7rM5QOlJNUSypEQcDl6bUcSM9PtK3KE3MhvFmsbkEM3+bbyZRYq87/E+oh
         iPTBnERo2USRouSU0OlKj70+swg1YYf0saHHxHDK9GbviyCgtL4Lua9aQOVeae09HHWn
         /s2w==
X-Gm-Message-State: AOAM532TCmK8k6FotyDnwFAjcU77SnYUGOL0dQQyxUmKsShel+tlBNzS
        Pu7xIGU3904m6AixQUIntU+i
X-Google-Smtp-Source: ABdhPJwYzAMEAtg9/JFbhiEuwp4XYSlhS8FCZoRDmYqnHbumm4A5Hob0ASGs5q1KrV8/8oB0j4+sVg==
X-Received: by 2002:a17:90a:d913:: with SMTP id c19mr2267949pjv.19.1611160663340;
        Wed, 20 Jan 2021 08:37:43 -0800 (PST)
Received: from thinkpad ([2409:4072:409:c713:3d52:1d51:c724:155d])
        by smtp.gmail.com with ESMTPSA id a9sm2889668pfn.178.2021.01.20.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:37:42 -0800 (PST)
Date:   Wed, 20 Jan 2021 22:07:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okukatla@codeaurora.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SDX55 interconnect provider
 driver
Message-ID: <20210120163735.GC54606@thinkpad>
References: <20210120080627.20784-1-manivannan.sadhasivam@linaro.org>
 <20210120080627.20784-3-manivannan.sadhasivam@linaro.org>
 <cb0f56b6-a75c-51a8-d640-08896d459a68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0f56b6-a75c-51a8-d640-08896d459a68@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On Wed, Jan 20, 2021 at 04:59:31PM +0200, Georgi Djakov wrote:
> Hi Mani,
> 
> Thanks for the patch!
> 
> On 1/20/21 10:06, Manivannan Sadhasivam wrote:
> > Add driver for the Qualcomm interconnect buses found in SDX55 based
> > platforms. The topology consists of several NoCs that are controlled by
> > a remote processor that collects the aggregated bandwidth for each
> > master-slave pairs.
> > 
> > Based on SM8250 driver and generated from downstream dts.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/interconnect/qcom/Kconfig  |  10 +
> >   drivers/interconnect/qcom/Makefile |   2 +
> >   drivers/interconnect/qcom/sdx55.c  | 356 +++++++++++++++++++++++++++++
> >   drivers/interconnect/qcom/sdx55.h  |  70 ++++++
> >   4 files changed, 438 insertions(+)
> >   create mode 100644 drivers/interconnect/qcom/sdx55.c
> >   create mode 100644 drivers/interconnect/qcom/sdx55.h
> > 
> > diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> > index a8f93ba265f8..6df7e2161a0a 100644
> > --- a/drivers/interconnect/qcom/Kconfig
> > +++ b/drivers/interconnect/qcom/Kconfig
> > @@ -65,6 +65,16 @@ config INTERCONNECT_QCOM_SDM845
> >   	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
> >   	  platforms.
> > +config INTERCONNECT_QCOM_SDX55
> > +	tristate "Qualcomm SDX55 interconnect driver"
> > +	depends on INTERCONNECT_QCOM
> > +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> 
> Why not use depends on INTERCONNECT_QCOM_RPMH_POSSIBLE?
>

I just followed the same pattern as other RPMh based drivers. And I don't get
what you are suggesting here! Can you please explain?
 
Thanks,
Mani
