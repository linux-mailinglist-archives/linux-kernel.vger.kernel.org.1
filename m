Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E492A7C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgKELE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgKELE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:04:56 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:04:56 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so1160119wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=122idc9ISzYUVyUTZxvj63kGf6qbL9E93JAVHSUYL5E=;
        b=AYd2XxNy9cevjTd5a9GWeI6c3UkIp+hfXlb81qU3LLyhlfpYBMPQeFuUFrRxGJiE/b
         hbzJiB1uhqyhYBuvVxRMQoz84h3qrKYEiUi8EQE1p9xbmZmf1cUK0oJglUKfEpDOPVTG
         UlJRyY5W+PhXM0/UUU0jUWEkA03sZMtCXRn1RmieN1Qid7ucRGZR2sxYXmVLa37b8APn
         t9uCN3tklmqFYC1u4TJLK7BW4hiQvmGuU891iKbJIhv/Z+5zwNY9Kr0Q//kuZRMJDXEL
         hB/NzXHCY44H5EDVI+GyC5OrXgWssnWs0Z3iT4+JAqYK4Z8jqVe3e1zUDlzHH1KKjIlJ
         oGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=122idc9ISzYUVyUTZxvj63kGf6qbL9E93JAVHSUYL5E=;
        b=KlGPShJD0HkeFWr8VLmvO3ateF7zbNtZHzondZ3m+eFdU+npEAx95T3ecTXirFCG6g
         Nyi0/QHgHM7XvqoA8nAU7Ky4P+tIifIXPNE+xHf5JneHZ6+lQV+KSBON7N5uzpQhiA5n
         XxFKB9t5+5YCTnAETffceSv0HlLJxx9GILN8zYHHPwCMrn4U2Hj7WZRkMAM77uD6zDNE
         dIYwgGZtrOLrRUT/txEFvWQ578UPVJvgSQI3tx23e6ezgSgZ7W3PfWXKF28Wbl2Gv/zx
         DR+Rd56wYqkvCYfQt8UV4DyI9MOAEsy0b/D0GfSCsh40siLMTvU5wFWRVTOQxTeTrMQF
         kczw==
X-Gm-Message-State: AOAM532C6x+ywXUN+mngQumNw4T5eqKOMOj4/lyL0mp/V3jpWDq0RP29
        E1j9wYHu/NAHhYGOXB2ofgdwhw==
X-Google-Smtp-Source: ABdhPJwDkxXA6NnnBuUAc9HIvD0y2HJ2+YaH0fpN0/rXlsl/uP2RFH5TYMmqQ4jC+tOsJPAgxuY5wQ==
X-Received: by 2002:a1c:e087:: with SMTP id x129mr2090930wmg.2.1604574294545;
        Thu, 05 Nov 2020 03:04:54 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:64da:f1d0:8ee7:66f5])
        by smtp.gmail.com with ESMTPSA id y185sm2168277wmb.29.2020.11.05.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:04:53 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:04:52 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Andrew Walbran <qwandor@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RFC PATCH 23/26] kvm: arm64: Intercept host's CPU_SUSPEND PSCI
 SMCs
Message-ID: <20201105110452.3ulxvaywgbqa6ilx@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
 <20201104183630.27513-24-dbrazdil@google.com>
 <CA+_y_2GgF7W8f=_3Y+-Nyb+JWTCqCvtE7OT=kabAqxnp6vLnOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_y_2GgF7W8f=_3Y+-Nyb+JWTCqCvtE7OT=kabAqxnp6vLnOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Add a handler of CPU_SUSPEND host PSCI SMCs. When invoked, it determines
> > whether the requested power state loses context, ie. whether it is
> > indistinguishable from a WHI or whether it is a deeper sleep state that
> Do you mean WFI?
Of course, sorry, just a typo.

