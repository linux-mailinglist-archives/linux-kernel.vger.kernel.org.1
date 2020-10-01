Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C802427F928
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJAFrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:47:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EF5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:47:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so6200102ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=Os0kwHaWP4HngQKYbZ8BW7H6jfxa0Ee65qFqt2XMUT4=;
        b=movf5rdT4Ay9elSP0SpiuQlsDTlYi7oAO76+9Hg1LwREU3DP0dDaB1njKjmZyI+xrf
         oBPPfWYpBgeiOnVKJkYmMIAa752TOhEkCjMpU83bW7vPoxKyKN/bBtZ8qTl+pJlZdni+
         rV2GrMz8kbPWZ0Huo6xcE0KIXbjdB3z14RQ692oPhRobXZjweY37IbXT0Vv8qwD9zrD1
         IQYnbZ2aj/panNItCoXDjDVAFvxt6UfT2UbeQKwt+t+0vMNGppfrW2UxGkYB7tCRDa9q
         kmoAbpR98H3Cd1jYLRasqqeo1AmM5zPnMPkAppVZTjhxKfELfZDFsAaU2V4WhFj4hg0Q
         hZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=Os0kwHaWP4HngQKYbZ8BW7H6jfxa0Ee65qFqt2XMUT4=;
        b=FsKMaHNJpw3R1PdrpCftxQbf2mA/vxZs7KjQ8nyhq3xG69eWfZOPQXgUH9OBIJxr41
         qEyQBvNvxKusVKLLaRwogpTpUfUs2IyZsKx91tzR67HOlegZxLL5Kg0c03/2MXmTcc99
         65jSHOAs6Ef1onGenUEODEszU9TrI8mPphBD7kAm0jbBeLv8Fh5v83YxzLESLbYv8hDl
         nNdeFBbux41vnEFuI+tfvXQbudQHJEe8+IiPyUbWkP/pSCx8sGcgxIp/O8yq2N525DhW
         Dqc1oae1WvfIQPFgUwSHdrkZWk2mJyZZ3nnTwus9mwOfirpj9lqZWQzBWWU2ept5XcxU
         VfJA==
X-Gm-Message-State: AOAM5338wgetuKM4TOoV0lAYUUH7cQCmTz3MCE7ITlAXWem16LOlrTZ9
        Rtkfp2eWw+dCPWQ/cPP7656L0lgILMvihQ==
X-Google-Smtp-Source: ABdhPJxBNhhTY4Zg2XMcQTPQrWirIlnMmF+6K4YNVTBI+XdqwbftodApQvwSYLHUpoHBkkBCGT1l5A==
X-Received: by 2002:a17:906:3a0e:: with SMTP id z14mr6220594eje.192.1601531254120;
        Wed, 30 Sep 2020 22:47:34 -0700 (PDT)
Received: from x230 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id r20sm1699406edw.51.2020.09.30.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 22:47:33 -0700 (PDT)
Date:   Thu, 1 Oct 2020 07:47:31 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-kernel@vger.kernel.org, musl@lists.openwall.com
Subject: Re: [musl] [PATCH 1/1] linux/sysinfo.h: Add guarder for struct
 sysinfo
Message-ID: <20201001054731.GA193908@x230>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200930214636.186132-1-petr.vorel@gmail.com>
 <20200930234212.GK17637@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930234212.GK17637@brightrain.aerifal.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rich,

...
> I don't think this is the right way to do it. It prevents getting
> access to the kernel uapi structure (which may be wanted) if you're
> not using glibc or if you include kernel headers before any libc
> headers. Rather, <linux/kernel.h>, whose only real purpose is
> providing this structure to legacy applications that don't know the
> renamed name for it, should not be implicitly included by other
> headers. There's an existing thread on the topic but I don't have the
> link handy. IIRC I proposed moving the alignment macros or whatever
> other useful stuff is in <linux/kernel.h> to a separate header and
> getting rid of all the indirect inclusions of <linux/kernel.h>.

Thanks for a review and tip!

Kind regards,
Petr
