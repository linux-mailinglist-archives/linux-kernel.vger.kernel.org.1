Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18E2CC129
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgLBPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgLBPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:45:20 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC182C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 07:44:39 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so8506525wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/UHxwpIgzVzreRL98GaE+Nf+yyIwRliZkCO7QwUCEgs=;
        b=gp6qawBNxj20UMCB0qKbqw35Nh7dgu1epXjabfxPkvif2E6O8pV9qsix7Swhk16rgA
         7U8GXJzUXnwfKVqYUjOLrtRQrSChgE7vZnpjBYWcRpilLM2szXRG69gSh5qpxe+GDMQ9
         KDwdufKg3mdvIsTbFSBlskjEK0inIAModCfOxYOJpbqCX4Nt9eX7sJN2jICQ5ByfPXTx
         629pV2SxxiGkQCnmoA6E0i5XXYqDAJ3dQVWYMse12jjHf8G5E/9mMCEcUCiMne2eCFIS
         97aq1mVCe4qraq5zC1HtXSTmf47MvJ2/dkbIQdZ2PEPjc9OFMWBuVoSbVniM6Z9RX8/T
         sOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UHxwpIgzVzreRL98GaE+Nf+yyIwRliZkCO7QwUCEgs=;
        b=dhfqBwqyul7iRpo7vlL+AYVqEQfpTxGy4Xb6pkvthIYKyUMMycKNgC+bWeZyeAX0Nx
         sbDSHQ24CT/oR8h/JBWLxQh9P1K0tC5ioVWfiFE0u7FcAN6Eg0wp0eC9yX2zoljmlJBr
         PIMWEZ330xIEhGxaOW8YjCecJuyi7d3qsY9BzB6LWo5fWi/iyTPL4pxMGOjoXgHOrH3K
         8hNaQv2qTEBc6CtOroXs6FF1cSBATBJuu1qDVcMLZaLgbLACF0srSi8Xt7vcoG+URzCL
         wunP3If/eGqCnMXaa3/eWscAhdJP3i6GRd2zftf0qBEQW8NaXBlSHCN3ni6G7XsHAeMl
         ad6g==
X-Gm-Message-State: AOAM531YGSN4S0AVOxo3MDoB3UePvvEToZPGlKXiYg2M+kGkUwlP9De6
        jn7MrJFdTZnYPAzMgBpCd6K37A==
X-Google-Smtp-Source: ABdhPJzjZbg91HBzD7xhdNYxZfeVt0A22RkKuj4c+xnN4xgU/POWZiYJcdkezzLJU++VssNAnOmuew==
X-Received: by 2002:a1c:ddd5:: with SMTP id u204mr3724239wmg.174.1606923878152;
        Wed, 02 Dec 2020 07:44:38 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id y7sm2620731wrp.3.2020.12.02.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:44:37 -0800 (PST)
Date:   Wed, 2 Dec 2020 15:44:35 +0000
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
Subject: Re: [PATCH v3 03/23] arm64: Make cpu_logical_map() take unsigned int
Message-ID: <20201202154435.qpr7ow53xra3xjkd@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-4-dbrazdil@google.com>
 <20201126172838.GD38486@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126172838.GD38486@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:28:38PM +0000, Mark Rutland wrote:
> On Thu, Nov 26, 2020 at 03:54:01PM +0000, David Brazdil wrote:
> > CPU index should never be negative. Change the signature of
> > (set_)cpu_logical_map to take an unsigned int.
> > 
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> 
> Is there a function problem here, or is this just cleanup from
> inspection?
> 
> Core code including the cpuhp_*() callbacks uses an int, so if there's a
> strong justification to change this, it suggests there's some treewide
> cleanup that should be done.
> 
> I don't have strong feelings on the matter, but I'd like to understand
> the rationale.

Yeah, it's a mess. Marc and I felt that using a uint was less error-prone wrt
bounds checks. If this gets an int, it still works and only checking the upper
bound is required. Does that make sense?

David

