Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64F2EC6F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbhAFXj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbhAFXj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:39:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE05DC061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 15:38:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 4so2354728plk.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zo+uooqajJkVIc//qGbLq5a2/tbMq8FCHMG3Hgw2MPg=;
        b=EZN7MpBxbYHR9Lh0ewX4mZiq4ydtxnT0egjcjk7gNEwYb/IGUVMbHIxmyc7rXvP/ju
         5YpiG66ya+lrQwzp/2X4r/USBF2Xxkn5nYTwZteODtbSYNeKDwex4LiC/CMuVeHtcui/
         dTv7Ee789uT/X/ekZXgf2EBCsb3cXImFuV0HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zo+uooqajJkVIc//qGbLq5a2/tbMq8FCHMG3Hgw2MPg=;
        b=MxEfdPcuQLi47yrCS7MR1882CoEnzVwiQ96YiFWF1sLXRxDVPCXe7haHV9oz/bQ+LV
         ewanrnLydcMu8Z5KvBueaG3R6+C5YyzrIEsqcrAEHxUhExnY1ycm+rQwKjaYBovCv6Qn
         Yco7Tp4bK3RX4/KK58kpRigPyxYez4H+junFXSwyPz7BXoZ58Ag6v0ETDKpEVY/BKXvb
         UsJKivQGW5DveDo/8thkWAjUlYqLS2mxtWZ/B6wSsigtE3lPpujhqemhDXL5fGeYxh5R
         ID5Vjyvfa5rIk56r5IaFNhQl1jYSeegZJC1TpBIU3fcWhXW9T5QWNeKhd/qrpy5qYOqE
         085w==
X-Gm-Message-State: AOAM532r3gmF1SLlfbLPD4dQUKyfX1jJhPz54OC5I+wblLp4cnxNz91h
        YmT9oBIlHgNmkAAZvwbW0DMHEg==
X-Google-Smtp-Source: ABdhPJzFCUoLGe/zdRGGV12Za77C+HHWpBzk9SrAUn38P4fp0LVimmMsGeqXex9rQxO/w3gPNiIR5A==
X-Received: by 2002:a17:902:be0e:b029:dc:138c:b030 with SMTP id r14-20020a170902be0eb02900dc138cb030mr6509956pls.55.1609976328463;
        Wed, 06 Jan 2021 15:38:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t25sm3851890pgv.30.2021.01.06.15.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:38:47 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:38:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: use min() helper for namecmp()
Message-ID: <202101061538.AEF4E09D@keescook>
References: <20210104083221.21184-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104083221.21184-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 05:32:21PM +0900, Masahiro Yamada wrote:
> Make it slightly readable by using min().
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
