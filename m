Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9128D28DC56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgJNJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgJNJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:04:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A2C051102
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:36:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v19so1921926edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EguaRqzq7QWMC6R0E7Hu28+GwHJoGyftK6SvdsF+Dng=;
        b=VmRQmxUEEq27yW9fTeAiVbni+B4lNYYErr60qrGQDgYH4lButoELVopK65Prz0qmhl
         DSGoVN9ipRjTz6w6cDO3Aya2XBgjpcYqyP4ZxFqD0utKyms2orcHm3fmgrgM/De2KR0Y
         QDMY2yHTjsyP18eXQNGOiZwk6b7Yi9MEq6XqIL6xVundYQ9Sk2FvZDoMPxdXbv8MV0+c
         q/mpbHg09jJdOGK7Nck0FTFM8AXpXH3SIEy99PiuI07zTa5Alm8qxw+m0qcpfScz7w9y
         YsZ3Kpz5yPhFltlbB0V4Ytgx180c++gfj6OlPNxkqvD6sVSzAAOdVuI3Uss9vGvAUgQf
         pGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EguaRqzq7QWMC6R0E7Hu28+GwHJoGyftK6SvdsF+Dng=;
        b=NfnJgKBcbFjsucRGluBxYXB9K68vUSzSqcnxexAp4QLqmDnBdOkGOkDZ0jpQ4Davtj
         UoSdnbBYkk+5y3jGg0ryqutB3CtBoTOTnAg/2miFJ91KPWEEmXvgW7rnUq8I24YGHHf+
         s1rqJ40BVM0Seoq3FAZTzTZ7pG2mxRUqSUKQA6MyBDh9L5FPry6UKSylX3g1a30g5xUG
         unqLdajSMl3o2Sba/u3BsTJMxWpfJ1KuWeZdjynQo8/imp7SazML3s6xhqSStDktefBe
         PAq1FIuPeX15d2ZZ9yGn3780c/VE11SVBZR0chTQnp6AB5fXP8LjxK6l8qWAJoQGfTKX
         AolQ==
X-Gm-Message-State: AOAM533rlKtydfxCR5+gJJtJvUCUzdm7on358AXPX++YciF+7yzUkhWG
        WSGdNJAHNeEAuY+SahXhzbM=
X-Google-Smtp-Source: ABdhPJyZUmOFVwKt4/LKI5OkWYxaJWND+9ULPJji2D7959O7nwnNef7wpl4UuM5tOf0iMLyhRaCEPQ==
X-Received: by 2002:a05:6402:1684:: with SMTP id a4mr3650169edv.319.1602657369399;
        Tue, 13 Oct 2020 23:36:09 -0700 (PDT)
Received: from felia ([2001:16b8:2da8:8200:4c70:9c82:f3bf:bebb])
        by smtp.gmail.com with ESMTPSA id t10sm1057817ejc.38.2020.10.13.23.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 23:36:08 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 14 Oct 2020 08:36:07 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
In-Reply-To: <be7deeec0937327e0ddaadf8468d934ed363a533.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2010140829150.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com> <alpine.DEB.2.21.2010140734270.6186@felia> <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com> <alpine.DEB.2.21.2010140812370.6186@felia>
 <be7deeec0937327e0ddaadf8468d934ed363a533.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Joe Perches wrote:

> On Wed, 2020-10-14 at 08:21 +0200, Lukas Bulwahn wrote:
> > What does checkpatch.pl warn about and what does clang-format still warn 
> > about, which is generally accepted okay as style in the kernel?
> 
> clang-format doesn't warn at all, it just reformats.
>

You can run clang-format with --dry-run and then it would just state the 
proposed changes, right?

I am not the clang-format expert, though.
