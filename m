Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42C28C855
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 07:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgJMFlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 01:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbgJMFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 01:41:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB8C0613D0;
        Mon, 12 Oct 2020 22:41:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so20425073wmj.5;
        Mon, 12 Oct 2020 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=d9vylN65+yzj7mksBEpuNNWYvYrmZ1UZPFWpzN8ZJnc=;
        b=sCLwzONOmV2FgbEAOU83au8Xo+dLKC7HW9WDa6LSVfMb9V8Jl4KZPyzFI3tycA7Khb
         sS2veNiS+XGL2ioy2cMAiCv/qr20FWJR7NpMlD42nbgcmRZdQePe/O5oOzromG/qMjoE
         gqRdNEtLex937a3wvsxc1jwF0tBMMwDefp/2oH0Y1Zdiw/JCZtVXH0XvOXof1JzDgYNh
         pnhtMM2uwTQpjO4oWYpG5lx1gZUF5W1Iz8uv0Rs4AZNVlnrgT+Y7bXld0EmyqEN9YsZZ
         qKrpj1SvtscbuMFaKUbvbWvfTqhTrQ1K8QHDwKRgVYCnowgZZBvPy/oPTF6fzx1jk5ku
         mSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=d9vylN65+yzj7mksBEpuNNWYvYrmZ1UZPFWpzN8ZJnc=;
        b=I9OZxsNrIgwYBX/4UBCIEwWg+Dg8QfFkzn2Tkj0mPT/KWHgVJwxvC50YsqpCfvzgMc
         mig6nnXyXAT8eO1pEBRlM3h+yDDEqGXc4dyR5TyrUwPUw2PO0NyAdUg6XVh9QCiPD5QQ
         jX4iaUVppWv39iaTGJY0+3GOLo9I1ifY/YEmdoulXMLzlE0a99g9OwKuD7oif9FGWfts
         IMlb7Psy1XepoLZrykHgi4IhIRbC+nwBz0nJDxfk0Bbc9Wrd8QsrX5lXv6BNVeIEOSBE
         31bk3s13saYDEHBxq7wfULDwd/YYygyMaBGGrXytVkacwy8UWirVfQn+qm98RY8j91Ul
         CzZg==
X-Gm-Message-State: AOAM530jfxb/F9nCYmqRNanx3MrEpuLTmOJT0BqG/dIB8sbyqjpVPr3z
        A28iDkDbey+Puy6xt87lPFIFamzD2D2MD7UO
X-Google-Smtp-Source: ABdhPJyBxStNdGGvixqD19QWg9HaFQ15lb9VjTESTLLFfAXCJouGCu18qM+gVBG2G2S97MUHX7rWPA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr13768508wmi.84.1602567702684;
        Mon, 12 Oct 2020 22:41:42 -0700 (PDT)
Received: from felia ([2001:16b8:2d05:8100:95ae:bd1a:3e4e:4242])
        by smtp.gmail.com with ESMTPSA id u2sm28834532wre.7.2020.10.12.22.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 22:41:42 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 13 Oct 2020 07:41:40 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <20201013052150.GA330398@kroah.com>
Message-ID: <alpine.DEB.2.21.2010130737430.14590@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu> <alpine.DEB.2.21.2010121659040.6487@felia> <20201012160013.GA632789@rowland.harvard.edu>
 <alpine.DEB.2.21.2010122008370.17866@felia> <20201013052150.GA330398@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Greg Kroah-Hartman wrote:

> On Mon, Oct 12, 2020 at 08:17:34PM +0200, Lukas Bulwahn wrote:
> > > If you are suggesting some sort of special code annotation that the tool 
> > > would understand, I am open to that.  But I'm not aware of any even 
> > > vaguely standard way of marking up a particular function call to 
> > > indicate it will not return an error.
> > 
> > I cannot yet say if some annotation would work, we, Sudip and me, need to 
> > investigate. It could be that something like, assert(!IS_ERR(tt)), is 
> > sufficient to let the tools know that they can safely assume that the 
> > path they are complaining about is not possible.
> > 
> > We could make the assert() a nop, so it would not effect the resulting 
> > object code in any way.
> 
> Things like assert() have been rejected numberous times in the past in
> the kernel, good luck with that :)
>

Greg, we have been warned by you now; so, we are well aware what could 
await us just as numerous others before.

Lukas
