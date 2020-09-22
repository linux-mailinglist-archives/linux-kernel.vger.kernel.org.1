Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD26F2747F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIVSIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:08:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:08:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so18101489wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S85mHKKhhbko2ySJAQKUTdWj1TX7uz3rxKtwsx1/9tE=;
        b=egbsABv+Cx3fjNH8Y0a//3+OdnXJ+m/wZrAgdar+SqABSl5c1bOOyzaNpuvwxHAJuE
         3haNe7U7B0RlMB9uM9lp344Xtdd0QkqhPCOru0VVSaoZzbOvQ18vAWFr9p1hkCMWK8He
         7gj28UrhzDDw1IXylghe+1z7Mz/7Lb1/yBsGZYN2Zhe6swSSiwkSg3HRZTe77xrtVm4H
         9l9Z6V/BKYjC31H5ZvRjEs0Ez3XNU+XtR4JSbCYjTyaDnE8w5KO5N5QaRCM0PsIPCpv6
         m/z+f+HRgyXG2Vu14cbIHijvbu7PvK6D2WKMb7m0iA+7LCbWzaB3fesklBa4SqJZtdyG
         bXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S85mHKKhhbko2ySJAQKUTdWj1TX7uz3rxKtwsx1/9tE=;
        b=U8STqzisvzzw+lrXAXkjSMYk6TTevnqZU8zAyAThJfhM1QMT4VcEJN5ar7RNlNqf6y
         rKfwDq4if2rTBbqtIt7tZgzt2W0iQeHOFNuXq3Hqp5AU+MsSqscMY0UziP5ebbsQN/+X
         Ihfe+yxgkEtyKNk6siFmiZugZ+QadUM0LmxIaIVG41c1t57ZQ4ya/Y3AokMWB0XMafNU
         ETtbnphZICnvtamjXOhtsICIZJv9gxZKc6lifR3rJu83dc3l64cuXsXydNpkuV1Hvcss
         Q2e0vrY/lyHV7OOXSX19KqN8m71Qbk5xQ3DrVlUn2WCFQ1Cj4xgR2th10pPuopwpCNOY
         ei9A==
X-Gm-Message-State: AOAM530atGuxCpbW3Q3YwB5J8HQP7asubrkX3wqn9MXXoXDfBQBgeVB3
        ZTjRKPWJduoQLfIxVytKphLX0g==
X-Google-Smtp-Source: ABdhPJzxYdJzCnmfgJwQkGcuUr41IDa7NW2BGo7rpNNeP8eDF9Limc0GeK+lSLgZCl9X6kBSEKAvfw==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr6709773wrt.84.1600798101991;
        Tue, 22 Sep 2020 11:08:21 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:55c2:2cdf:ff31:96a3])
        by smtp.gmail.com with ESMTPSA id p11sm5346000wma.11.2020.09.22.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:08:21 -0700 (PDT)
Date:   Tue, 22 Sep 2020 19:08:20 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 09/11] kvm: arm64: Mark hyp stack pages reserved
Message-ID: <20200922180820.gmt6ryhjj7gepqiu@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-10-dbrazdil@google.com>
 <20200918120044.GC31096@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918120044.GC31096@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:00:44PM +0100, Will Deacon wrote:
> On Wed, Sep 16, 2020 at 06:34:37PM +0100, David Brazdil wrote:
> > In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
> > stack using new helpers which automatically mark the pages reserved.
> 
> Given that this series doesn't get us that the point of having a stage-2 for
> the host, I don't see why we need this part yet.
> 
> Will

Dropped
