Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58062F1FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391316AbhAKTyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391120AbhAKTyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:54:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AEC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:53:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t22so592485pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W0UlAxGx6cPxB4zsQ5Of6JULhAu0iyeaTVS9cOPK46I=;
        b=VW3dSKL+bJ20iXDQ+WZdKqlDxeEzFsKqzZoXuGrbF+8CQIrYRSuZG4goyMkpX40eA3
         uB0C6ciBfzCFnXWxGHgQ/CM+VPkcfPElIjx7QM1HhV5xphqnm18WvMBMXD96CZm4Ij1i
         90cIexWfOGevlvpLeE6B89uqWV4HzDoEzLlvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W0UlAxGx6cPxB4zsQ5Of6JULhAu0iyeaTVS9cOPK46I=;
        b=tJIaucqrmTcNpe5QB3fsiKTBARoxViIo8FBzgPKyHLsaNTBl0M7cUrRDgtYiC+8ESr
         Tk8Y+Pe/UV2rOhbSPPNi75RNL6101jK5OcOj30hfedMo5jI6+Q8iL3TghYCMEtzNjVBN
         fFLgSId+mQcECSVNg5S2vL56/J6lnvyJ6Oxn4MP/3aWOImyqikRP0KmhmaeuAZQTe3jU
         zo408rewHdNMmM5PkfmjK380DbO0gHM7bXUDn5RKnuP01RJPyD2Z6lzUIcm4XCxV+nhM
         X9IoZwbV1GPyQ3YyyHF30QN5Pdns6m1aWxPKKnhNQfOJNnpAdket6fCHD1CuI8qRHxu+
         f+Dg==
X-Gm-Message-State: AOAM531cyQH+D0j+su7Lpbte3NiC1KaFYjPn0CAvOQqdVkDaQF8xrNfO
        DYWG73cFaXS0L3X96c4Qu2LpXw==
X-Google-Smtp-Source: ABdhPJw2BN4eAX7M+aIWRedzewZCg+mGNrwLK3EwxX2Rf67dDYux13ZIapgIQP4dD7XDkrDjNm9pAA==
X-Received: by 2002:a62:19ca:0:b029:19d:cd0d:af83 with SMTP id 193-20020a6219ca0000b029019dcd0daf83mr994521pfz.51.1610394815031;
        Mon, 11 Jan 2021 11:53:35 -0800 (PST)
Received: from cork (c-73-93-175-39.hsd1.ca.comcast.net. [73.93.175.39])
        by smtp.gmail.com with ESMTPSA id z12sm423456pfn.186.2021.01.11.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:53:33 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:53:23 -0800
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        andreyknvl@google.com, jannh@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH mm 1/2] kfence: add option to use KFENCE without static
 keys
Message-ID: <20210111195323.GA842777@cork>
References: <20210111091544.3287013-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111091544.3287013-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:15:43AM +0100, Marco Elver wrote:
> For certain usecases, specifically where the sample interval is always
> set to a very low value such as 1ms, it can make sense to use a dynamic
> branch instead of static branches due to the overhead of toggling a
> static branch.

I ended up with 100µs and couldn't measure a performance problem in our
benchmarks.  My results don't have predictive value for anyone else, of
course.

> Therefore, add a new Kconfig option to remove the static branches and
> instead check kfence_allocation_gate if a KFENCE allocation should be
> set up.
> 
> Suggested-by: Jörn Engel <joern@purestorage.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Jörn Engel <joern@purestorage.com>

Jörn

--
One of the things I’ve discovered over the years, is that you can
create change or you can receive credit – not both.
-- Stephen Downes
