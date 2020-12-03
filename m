Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98B22CD3FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbgLCKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388715AbgLCKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:51:46 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF28C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:51:06 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v14so2326793wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J635piZ/rKtx29aOFmG6FBeR7lY3a126JY0Ld6qBL8E=;
        b=fni8XWXJ65ktP4os0NGZmoCZnWcQlMQwfmVk+oa0QMvzC/S/FiZu5x4NUr6/TfBu2u
         aGL0yFbeRZ+leewJ5jdWZ870HeL1nfnq7hYaQLKPB7AUeIDrnL2/sLEotr4DN2JkzHBT
         pwHykLj1/wxm2FwPVt9ebwwP5LZdSYfrdyvZlYYHfQBYFvg0GEXdqNSiipAaWOtyhQwC
         oq3G8GuN5Z3jcOfF0QT51qncDQ7x5Cy6mzbRYDZ5RmR6unquAdOJIlwLxq5lgUEjQTgp
         akHOiyxmgEY5yWCmR3qVBpFsKv80keuCej/CLKHSQ9v8LQytI21vDmBRO8PTmbn6/fAI
         J+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J635piZ/rKtx29aOFmG6FBeR7lY3a126JY0Ld6qBL8E=;
        b=eMj2P5GHOLH2UmnxJffbh9NMaFoMwDlDkhy2a1EgtrdyqEpPwxXEThfqNjRbVXUni8
         dqMwpbcy/XguU5hyjNFcS6VOqFTdgf4kOBXGujVhQ0p2tHiszWylo/FYNifIsgdCRGPw
         wTxvCRQXMyWZnvlLIXWMfrZsFZWQuagvlnKOGhQhTFNvK+LKqG21BHXHvskvD7ieBfnj
         Z8vCwAsCR0A6zWF6FlGE3wpROPZIbJK+bsnuV0phmHkfqY0A+cbzvtoqmf2QIi1S7ACM
         rKaksMoSNwQKCFtXMygV29oxIA6JLbhN6iLAbMvK4alpP0UV7Ees9dUe8FGIUtfhdGP6
         P/vA==
X-Gm-Message-State: AOAM5339o93OIEOPnrbvDUA3BD50YDvkpbMgYtegiqMf7OX2/jhBeDAA
        XRbKrL6SQrbweznqnNvSu8+Sng==
X-Google-Smtp-Source: ABdhPJwGxdGvAQwd3g9g/37YjONjS4wKyf5gl3p84BlZU5tkURTC0Xd03MbOOLQNl0Y5+ujoR/UhFw==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr2603884wmb.101.1606992664603;
        Thu, 03 Dec 2020 02:51:04 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id u66sm1073595wmg.30.2020.12.03.02.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 02:51:03 -0800 (PST)
Date:   Thu, 3 Dec 2020 10:51:02 +0000
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
Subject: Re: [PATCH v4 06/26] psci: Add accessor for psci_0_1_function_ids
Message-ID: <20201203105102.zpnjielsqdf3z3ox@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-7-dbrazdil@google.com>
 <20201203104712.GC96754@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203104712.GC96754@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 10:47:12AM +0000, Mark Rutland wrote:
> On Wed, Dec 02, 2020 at 06:41:02PM +0000, David Brazdil wrote:
> > Make it possible to retrieve a copy of the psci_0_1_function_ids struct.
> > This is useful for KVM if it is configured to intercept host's PSCI SMCs.
> > 
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> ... just to check, does KVM snapshot which function IDs are valid, or do
> we want to add that state here too? That can be a follow-up if
> necessary.

Ah, that's a good point. It doesn't, but can infer that from psci_ops.
