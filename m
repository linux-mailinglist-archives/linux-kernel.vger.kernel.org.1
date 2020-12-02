Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93512CC9B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgLBWhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLBWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:37:03 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8FCC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:36:23 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id l7so4337qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rEgjTrC4/7Dg+sZl+wutgQTsmbE4uA5QTf2cc78ka1U=;
        b=foF+Q3QP29t9e2jf+X6vXvk1f2cC0DDaW5JZAEO7iWSDzpqUMI5rJ0SqZyroucEba5
         38R96K/QNhl5f4LKJg3339q6ipIrod01A5aZekPnTmOPOuM1wTqZIKk3QmaZAQv4aTzj
         6HyMhTIWdySLvJXysx9CEDPGlfU+qUHMPstSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rEgjTrC4/7Dg+sZl+wutgQTsmbE4uA5QTf2cc78ka1U=;
        b=ukwQ2e+DmTN6MrG+ebvuuFHmXkToKG9LY6aMWYSu6SMJND0A0BB670BA6VIoqvZTUg
         FN6OpUZxRMc8yITPW4oASxa0Yg88u/yeQwc2t4AJSuzkDY+nK/FXLduWOd7Yo6C/tBq7
         XDCMBDTGmBM09+w8wes7+y7s3e32ZtwToq1ZTxroCN24Rvalh5EkyvfIwCqPBn+Wn89Q
         /MSwmMUReVgxgpIH8qmchthVLK8cCLlIEw0xdhgo2c80musIPwC33uHUUsUGNFI2B+Jt
         YGpNcRthwvsmVDwHKU0trrf5r04/bfHn96r0dgsPZmhoTxTOtuXUyCojkJqpqcVVl9wE
         d1Vw==
X-Gm-Message-State: AOAM5327dj+IjPJ3du3mRTAySK2Ak7qOt95OgkMuOlHoQgCypWlD0KPd
        U5WHxqm3eoBRQx6iYtzEe1arZQ==
X-Google-Smtp-Source: ABdhPJyI4yPZNzsR5isJ019HapY5IROtZAK3TkB8eEunM1WZQecxkj1YlA7KzS0gMydSojFJIpJFaQ==
X-Received: by 2002:ac8:4554:: with SMTP id z20mr416668qtn.330.1606948582608;
        Wed, 02 Dec 2020 14:36:22 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id x21sm42077qkx.31.2020.12.02.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:36:22 -0800 (PST)
Date:   Wed, 2 Dec 2020 17:36:20 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: Move kmsg_bytes default into Kconfig
Message-ID: <20201202223620.hlsvm2gnjm2zs5ox@chatter.i7.local>
References: <20201201201234.137572-1-keescook@chromium.org>
 <20201202214257.36wf5a4ui2axr3es@chatter.i7.local>
 <202012021427.3E12CABB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202012021427.3E12CABB@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 02:30:08PM -0800, Kees Cook wrote:
> > Did you use the sendemail-validate hook for this?
> 
> In my scripts right now, I'm doing this before "git send-email":
> 
> # Construct header-based attestations
> b4 attest outgoing/*
> 
> I haven't yet converted to using the git hook.

You don't have to if you're already using wrapper scripts. It's more 
useful for folks who call git-send-email directly and don't want to 
remember to call "b4 attest" first.

Best regards,
-K
