Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB882CA4B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391530AbgLAN7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391510AbgLAN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:23 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13F7C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:58:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so2762388wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zt2RBjQQsixvf0OIS3lOKNTVHIXpo1Ycgu9q/WItOOU=;
        b=kNQC3DHqR4eA7lOiYZdlSgTkBybeYpTQTxmLdgRX7PhlUu58f/ZAMVICVZQH2fZdtk
         ZWhvbE8UMd+kryPj/PhfbhrFc75A9Iz0yHHF3v2cQjnoQ8w4cecIbOCd9Tla8Ok9ZBXp
         79TjQOwFXJZ/A9pd5mKgjghHBTGlEW3epSl/NEjIZVVmZdRSDbSFcYbyU9qd67Q80VUC
         vFmK2jjHZZAQdzNscAej4hLKUyvhDTh8dPWiuuNHh35dPbNUqYre7W2syUO/MXLPdXnw
         eJm/2T5RDcL2vfaXuOI53We9gOmSndVPxz2Lq5JjcEPyqUaR3I3QM6IFmyUIWRto58vS
         hc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zt2RBjQQsixvf0OIS3lOKNTVHIXpo1Ycgu9q/WItOOU=;
        b=ev15si1tcXwn+miJ6Y5vtU/xDtmq75zeVZ8cRF/HAY1YBxthQqiDzIS/J/YjhyjIme
         qUFcmA3cqP4zklUXh7HiudGYNdP0hYuWqu10Ci5moP3z2Yot/gXlujJ/SNHMg8/chemm
         oPSms1cCa6hobosub8wjrxC3vxxirtlGc/u2K2hH5Lx1bKoLI6QxRbFyXkHLBxpBpOfP
         qL3wuLfS04/qmUmZ6TpQXYK4SBwIjXpS8d7v47tyjPV1r4/bAx3GDg/gVcUNt/S4NDK9
         yvsqpOxkplbnhNM+tU5c49WSYYg1qMVUppIm1qkXB8huyL52JVLUr7mQuA99Q/nZLuAM
         0uEA==
X-Gm-Message-State: AOAM532YdclTyiFjOkqiByqVRZK2hemLQciHcLpbtP7Ken+F/tg2nk0O
        2DRvu9cT3rfJIbeMgP9p76k2bQ==
X-Google-Smtp-Source: ABdhPJyjTWVeFjDHUebqh352sK8hzDxuE5qee5pt97DkoN08upPYHvQfL+XqSsDLjMEAA2ajaICJuQ==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr4047848wrr.26.1606831121268;
        Tue, 01 Dec 2020 05:58:41 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:7c5f:5ab5:ac1f:89ce])
        by smtp.gmail.com with ESMTPSA id v7sm3162739wma.26.2020.12.01.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:58:40 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:58:39 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 04/23] arm64: Move MAIR_EL1_SET to asm/memory.h
Message-ID: <20201201135839.jsvplmeodjzsa4he@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-5-dbrazdil@google.com>
 <20201126173534.GE38486@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126173534.GE38486@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mark,

> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index cd61239bae8c..54a22cb5b17b 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -152,6 +152,19 @@
> >  #define MT_S2_FWB_NORMAL	6
> >  #define MT_S2_FWB_DEVICE_nGnRE	1
> >  
> > +/*
> > + * Default MAIR_ELx. MT_NORMAL_TAGGED is initially mapped as Normal memory and
> > + * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> > + */
> > +#define MAIR_ELx_SET							\
> > +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> > +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
> > +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
> 
> Patch 7 initializes MAIR_EL2 with this directly rather than copying it
> from MAIR_EL1, which means that MT_NORMAL_TAGGED will never be tagged
> within the nVHE hyp code.
> 
> Is that expected? I suspect it's worth a comment here (introduced in
> patch 7), just to make that clear.

Ouch, that didn't use to be there. In that case let's not build more implicit
assumptions into the code. I'll pass MAIR_EL1 in kvm_nvhe_init_params.

David
