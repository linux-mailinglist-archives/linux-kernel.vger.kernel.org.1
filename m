Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3568D287CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgJHUMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbgJHUMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:12:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B1C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 13:12:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w21so4892505pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WreWDI35pT37NfCuOvWMpspZ2aPXJW/j5j611lagGSs=;
        b=PZxUJluzIt1QggeTdkNp9OGJgg8XkikVmQtKopRptoci+IiyqJqGf+kVkFCc7cjq69
         ivlpz04pLJ09uusSJJ4LJMyd47n6LwU643lka2EaG7jq9Mau6Ss7URcohb2Qqly0mG0f
         trPTzA+vrmzueVq5pWh5d68dBmr+kkEQMWCG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WreWDI35pT37NfCuOvWMpspZ2aPXJW/j5j611lagGSs=;
        b=DKYHXIhCR54sC61JmIGwl46sYFE/spex/OIsQG1sCqzxuM9FOYmx6U1psUicLzpANA
         Qke2ZpdWtR2qE6POhIJb9sOG8/gqby4Vm/sF82S+7XC8YSCKo+HLppoejP2vINbxFvN2
         9alT4fNIJaVdoQY7KPBC0P3CPFEvyxQ9Y531K0SWNz9iPJKZS/6P0b5CPAEIwbFt+wKO
         UyeB/BWcNveydr143p5faWJNxgVbh7CcrqCyTGw9w8dvRo4thbWwRx+u/ZWCq+7W7UdZ
         NCh/pp/RDHxwRZviMLwDROcp7NdVQspn08bv5J7EpXYcfvBaU4jTvHaTE1VijhV19a2X
         3iJA==
X-Gm-Message-State: AOAM531IiCY8RlXMVAM/RlLibJk9GOFpwImXdp8YvJhTnzrH+HQ0+bR8
        gQPi0mG5z1X27YoFfUEbzvD9Mw==
X-Google-Smtp-Source: ABdhPJyGUn2XdCtbtFwE9c2ZDlXiVEtoo5s37rhpZqEX+8F+LyM3E7vOPmMHic1rOVByTegnMFuwvg==
X-Received: by 2002:a62:e104:0:b029:152:4f37:99da with SMTP id q4-20020a62e1040000b02901524f3799damr8922475pfh.17.1602187930094;
        Thu, 08 Oct 2020 13:12:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm8341727pjd.36.2020.10.08.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:12:09 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:12:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 02/13] selftests: pidfd: fix compilation errors due to
 wait.h
Message-ID: <202010081312.ACFDD219@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-3-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-3-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:22PM +0300, Tommi Rantala wrote:
> Drop unneeded <linux/wait.h> header inclusion to fix pidfd compilation
> errors seen in Fedora 32:
> 
> In file included from pidfd_open_test.c:9:
> ../../../../usr/include/linux/wait.h:17:16: error: expected identifier before numeric constant
>    17 | #define P_ALL  0
>       |                ^
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
