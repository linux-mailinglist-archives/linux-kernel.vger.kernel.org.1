Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504B228DC81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgJNJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgJNJOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:14:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57555C051108
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:47:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so2332746wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aylbH1DfQpUcVy+Ho1mHnrhoBqnWuhaaKBVoBIsMNMs=;
        b=H+S8dxO/fHqBX1svmL9av09z204iJfBFG2dzmfW7kTLrlZE9K6GhQR4Nz18skneEkr
         Mib+Q/4QHhq2qxWIvJWXvKIyjkWSr3Qmf1XcG3Rseo4CExqdEJqGVfBuax9+JTG+jF7R
         NWB/q1BluISDD9mzR7tFLOd6mMgttQbPNOmtISbywT7LicAp0HjpSNrqFP6c2gmBPlZq
         EoPsAIYyJk+029iX1B7QTIKkU45VI7keIsRf+NT0BWJHaccKkDOx1PUbqK6UX9drWNXr
         vLo3I/EL5GEUlzrotBQKXLWtox3Vj1WDXGClbhoWWhyk3eY90fjHYCigDL573UDB3ooJ
         DjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aylbH1DfQpUcVy+Ho1mHnrhoBqnWuhaaKBVoBIsMNMs=;
        b=ao9PCZpjE8WZjsm1aLmHsITu+6Ju9i0fWkSKhkHBThHJPJ/rbTimi9EdbmBfUe8abt
         IupsEqiP7RF29dTmFB5zzjbv2od9+W8T9Faev346ulqeyuZ6u9/l3cPBRIAjDytjIju7
         q9XjoQqdi6h5qPx4f50ylnyYFDvn8RR5S6aTAMUfVU2qraN8InZF91c0JB+yi8aeVWEV
         o+famyKQKOpXj1Y6MPXnsuzABRp7YMM7fE009vbDRmIJRhP888Wlgfv3wuVbu8nRh6JJ
         ffDASI16R6mzxa6TrtQod9/A3Ecb61I1NVaaNgIiuhN3AaJnlrwSR5vU4HxcCXwIzn2a
         l8iQ==
X-Gm-Message-State: AOAM5334zTCrK8EnZa6Uo7UXYICY54JFZH1P7qqa/OI+z5azVMakWsfD
        GRxLpZII/E+qjDb4pY2pyWk1AG/AAurXWfDi
X-Google-Smtp-Source: ABdhPJypNMumZjt5eo37t9gtSa1xk32QUb4MQYkoQ6QNnE5TBzrbZrRPzTzszIZ3H7kVarfx7cK60Q==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr3903071wrq.254.1602658031098;
        Tue, 13 Oct 2020 23:47:11 -0700 (PDT)
Received: from felia ([2001:16b8:2da8:8200:4c70:9c82:f3bf:bebb])
        by smtp.gmail.com with ESMTPSA id f5sm2132307wmh.16.2020.10.13.23.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 23:47:10 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 14 Oct 2020 08:47:09 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
In-Reply-To: <04325089b524f20d3de167051bfb81b05083d8b1.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2010140842310.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com> <alpine.DEB.2.21.2010140734270.6186@felia> <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com> <alpine.DEB.2.21.2010140812370.6186@felia> <be7deeec0937327e0ddaadf8468d934ed363a533.camel@perches.com>
 <alpine.DEB.2.21.2010140829150.6186@felia> <04325089b524f20d3de167051bfb81b05083d8b1.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Joe Perches wrote:

> On Wed, 2020-10-14 at 08:36 +0200, Lukas Bulwahn wrote:
> > 
> > On Tue, 13 Oct 2020, Joe Perches wrote:
> > 
> > > On Wed, 2020-10-14 at 08:21 +0200, Lukas Bulwahn wrote:
> > > > What does checkpatch.pl warn about and what does clang-format still warn 
> > > > about, which is generally accepted okay as style in the kernel?
> > > 
> > > clang-format doesn't warn at all, it just reformats.
> > > 
> > You can run clang-format with --dry-run and then it would just state the 
> > proposed changes, right?
> 
> clang-format through at least version 10 does not have
> a --dry-run option.
> 
>

Just a quick check:

version 9 does not have the --dry-run option:

https://releases.llvm.org/9.0.0/tools/clang/docs/ClangFormat.html

version 10 does:

https://releases.llvm.org/10.0.0/tools/clang/docs/ClangFormat.html

and version 12 (under development) does keep it:

https://clang.llvm.org/docs/ClangFormat.html

I have not played around with that, though.

Lukas 
