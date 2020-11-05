Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2892A85AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgKESFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKESFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:05:53 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06336C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:05:53 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h22so2508232wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ddPVdHBBiZmCSF2nwCQf8bCJflaE3kiyL8B6pjedEwg=;
        b=sBau92ewJJW7KcBCfvxT20lEEY84WhnhAbBX0gUF28+ZrZnrhahdMNW6lp31qaHmYC
         UANyNk3iUSma3EhJ2xJzhdyry8i/oUA5trpOdiwVx5Qf2btMUba+BRctrAgCT0Pt+CJn
         d/SnqLLKya5L1Np7nEk/Dowf3ICjil/pCLApUDta3Z1dULYjaQ7E58wx8ER8bM0Vz4cq
         abdb2yLec2fB8Cjo/+52chnAvlZtwrtLcHmN7zGXudG71TFEnma/UCOTNerf3Yu2d9f+
         nL/5wPyVfw4j6Teq19rwufNKEPfE4RprFoUQZZ1WTTI0s2x0HQOJ24/C43hhOjHb0Oht
         AvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ddPVdHBBiZmCSF2nwCQf8bCJflaE3kiyL8B6pjedEwg=;
        b=I7V98LdqTbh7SqVci7KAX4ket7Oj4eMElQji4po8G9qWKxQN0wx+A1OiSdgLt07Sq9
         rC+JPaifqYWvgkxtY3iXw/OyxcDIQ6wKGbaZTxcn7OwB4+nXgbc6QKh8Lc2hBXwVEfy1
         6CwnosIlwdJC8U2U7xqOc+YVC/jKJB8SgimiAymW73m2OQdvByF87VkliO+dCkRfntCb
         fx+JA8ryOrutSZkB57RN4lzmDKfJvn0buygbV9x21BxvAgy3ttPdo0a2Oa8+rs1XaCSa
         LrY7mXabWo3sqBL5iyc/Cd3dOTZYa9Ei8lIAbvi68flNiC+ns6JRHH4Wxh7XTcdX9rFM
         nDNg==
X-Gm-Message-State: AOAM532TUAHc1TzxIdnCGROqOI1jsXaeudMNs4pyycZIHnVaS0i6BIw3
        +RBtxaMuWkV2mYpp3Y3DQsJjOp9Cr9a54V4A
X-Google-Smtp-Source: ABdhPJxuLkidDT0E0tOvNrylRZ2ydFSMCKpv8RDU9CIMzebL3uCc1EtXKKJ3NVio6HMtQoOabJqSow==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr4208961wmc.5.1604599551672;
        Thu, 05 Nov 2020 10:05:51 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id z5sm3624083wrw.87.2020.11.05.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:05:50 -0800 (PST)
Date:   Thu, 5 Nov 2020 18:05:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
Message-ID: <20201105180548.GM4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
 <6515b9ff5a9343f5a713e337f41450cc@AcuMS.aculab.com>
 <20201105112728.GJ4488@dell>
 <54D08301-C89F-4AEB-B9A0-6CED6D5EEDA6@microgate.com>
 <7C858DBE-A5A1-4027-A44B-85F6AE3AE579@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7C858DBE-A5A1-4027-A44B-85F6AE3AE579@microgate.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Paul Fulghum wrote:

> 
> Another candidate for removal is drivers/char/pcmcia/synclink_cs.c
> 
> Everything I said about synclink.c/synclinkmp.c is true of that as well: the hardware stopped being manufactured decades ago and is not available for testing. The possibility of these cards still being around/functional for use with the latest kernel is about zero.
> 
> If Lee Jones does wants to add that to his patch, great. If not then I can do so.

I'll probably send this as a follow-up, as it's easier to get merged
into a different subsystem if they patches are separate and
orthogonal.

Will submit them on the morrow.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
