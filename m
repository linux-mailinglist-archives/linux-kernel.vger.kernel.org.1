Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30A02AEFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKKLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKLbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:31:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCFC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:31:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o15so2201790wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U9WY4YwHoHsiLnMTjdtJfngq4inlaDzEyXm6ZeBp3Tk=;
        b=QU5fxZrGw6uKul6IuPlDVukJDFf/9w8mjopTg92s3jOuwPNLG2hAfJAdvlF9fg/Jz3
         iLmd8sMlfvwdFCY4C8OrmeUQb4J5rvRMcHgbwQUcWNKZO3sct8Ge+6GCLmXLBfS/XF4X
         Yq7XWiwRPbpZsxvUo/W3+ZIn/9Eiyd1KNe9EHHTbSeoKl8JHJv5nmFUofGid71w3ZjDm
         hjuWawWuTkiix/v2wCtK1tyemtdfp4wJSL6firAUZYMqDWHy/hR7079/G4y3PBHy88N+
         JJmPLFpPmjmsRb8YLdMt29Jt85/lzFMhMxuy3e9vb8ZK24eTRWuFhSko+r2BsdY9gikK
         TJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9WY4YwHoHsiLnMTjdtJfngq4inlaDzEyXm6ZeBp3Tk=;
        b=IQcGUofsD1716TpJzlbuzRzlMI/Sodrx1UBhZHfcHua4W1hSA+jZxJKLtGLeQtS6m0
         puy49iNOP8DsXgd5/dTwXLV2PXyI/qU2tzbV6p51mj8FFkT1Pxd9U+uaksJ5Z80CoTP7
         lKEYd82AKxKii5p9bzD3I6dFRE2UiXsX6USIFNo4w/6eOrPEJGNTwvg846BAljIBim+M
         pNXJ0OQCAYrRblAqKrnLGxNEZ+Lc5DpiMGSUdpqBqD9mOQUUGZAyos1eUjWTDLiTa6lO
         SEEQRxyAEwgrMCJ7iHlEIbmX5z8dtQS5eqnszhWzym4guGcdkDtE/qaOEVPa9He/jca3
         48ZA==
X-Gm-Message-State: AOAM531IbMHL5xj+r/1H2mT0A0F/kY2LKlORHGhRJqNFA1WzdBU4Kki4
        6eazGgp8wEd6qx5n2jfkO012tw==
X-Google-Smtp-Source: ABdhPJxdgoPMtvIpc8ik98fEm9DP705DkNY3XXFbPwfG7LegNZBJtunQHwh7cI5tVfwKzEHEOdLISA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr30133095wrp.156.1605094309513;
        Wed, 11 Nov 2020 03:31:49 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:2595:ed05:1717:fe6e])
        by smtp.gmail.com with ESMTPSA id c17sm2213099wml.14.2020.11.11.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 03:31:48 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:31:47 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 01/24] psci: Accessor for configured PSCI version
Message-ID: <20201111113147.ddoqadqaw6hcukow@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-2-dbrazdil@google.com>
 <ba9c8ccf25ff82b834ab78930570b993@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9c8ccf25ff82b834ab78930570b993@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> >  struct psci_operations {
> >  	u32 (*get_version)(void);
> >  	int (*cpu_suspend)(u32 state, unsigned long entry_point);
> 
> I still maintain that populating .get_version in all cases instead of
> duplicating an existing functionality is a better outcome. PSCI not
> supported would be implied by .get_version being NULL.
> 
> What breaks?

Must have missed that suggestion before. Good idea, I'll do that.
