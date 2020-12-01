Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899A82CA49A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391519AbgLAN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgLAN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:56:02 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35EC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:55:21 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v14so2990019wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+PwXtTlcdJC6Kz6wHrFVenV3uj6g4mhzGOO7PCwpUDQ=;
        b=eUJWOYMj7hUEXl+QsjBQLb4Ml91vgJpJhCrjpxbqM+50vIH2ZQr0o0DZ8eYxOZyD2o
         qwK6VPbpB7r9OpI2pQzstBVO51hojkHH/0EuWCbkVWnDnxeTGQwxo7VZuIIWqFp8HMiM
         HVgkn/F6eMzurxhiSQXvv2Die4eIq572mY627xAt4ltupWKvoFDcjH8wfMXyaRjTxDbK
         P2fC1SvegV0bW8P/NfopNX6pZGUs2h4/HoDwq+NF7H6ZGOjbQupT8yplG2TwaL5YU7QG
         05vaH8BrE584TyNyIOq9F5K2WiZHXZ6N946VYV9SAcc566zeIk1Xid5fVDSMBBlJVcV6
         Khrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+PwXtTlcdJC6Kz6wHrFVenV3uj6g4mhzGOO7PCwpUDQ=;
        b=R37mBaZobwDURRgBo+FjzNlAN+39PVFVV+eChglvB1faOl2SfT/9q4xse2b+YSJo77
         2Et1V+MSfacK41oH1o1dMEWvUq2NQluPUqjIKQ/arkeOV3zM/mSyzdm3Wg+6lUxhORDY
         mnw6zRrciMz2qmnrlxXJXKDWGeatkH2kFjt6bbs8KPEZJXXXs42NxIoT7O9oqkbcbJm6
         GlDRZ40qwmnJAbJnYGniz/5oiEXRvz/1NjoaZDaa9NRV0hB1/+kDsfaGlB8fCR1PA4PK
         EXHzFsRZ1JPnp9m+B05jGUJ+Vna5HQhozIzrsq7Nq7GgcQgSssHxIiX99VBe7q72zntR
         nArg==
X-Gm-Message-State: AOAM532TVs7kVd8reVNXLmAyUkB5Nc/l6Tj5E7+FR98zV5dp2P0qcn6F
        n2SkgKEs8XzCv2g3HLZJM+ggLA==
X-Google-Smtp-Source: ABdhPJx0qfzSScy1bKvaj9lSd/UJsODYPKOs6sdmtZoDpxlKzd7namARNALtRyqKWoGJ6kLRj1q4lA==
X-Received: by 2002:a1c:e042:: with SMTP id x63mr2861883wmg.68.1606830918697;
        Tue, 01 Dec 2020 05:55:18 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:7c5f:5ab5:ac1f:89ce])
        by smtp.gmail.com with ESMTPSA id b12sm10194961wmj.2.2020.12.01.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:55:17 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:55:16 +0000
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
Subject: Re: [PATCH v3 05/23] arm64: Extract parts of el2_setup into a macro
Message-ID: <20201201135516.3ksifw3ynlxyok7k@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-6-dbrazdil@google.com>
 <20201126180608.GF38486@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126180608.GF38486@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mark,

> In the head.S code, this was under an ifdef CONFIG_ARM_GIC_V3, but that
> ifdef wasn't carried into the macro here, or into its use below. I'm not
> sure of the impact, but that does seem to be a functional change.
> 
> > +
> > +.macro __init_el2_hstr
> > +	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
> > +.endm
> 
> Likewise, this used to be be guarded by CONFIG_COMPAT, but that's not
> carried into the macro or its use.
> 
> If the intent was to remove the conditionality, then that should be
> mentioned in the commit message, since it is a potential functional
> change.

Apologies, and well spotted. Marc suggested removing the ifdefs as redundant
during his review of v2. I'll update the commit message to reflect that.

David
