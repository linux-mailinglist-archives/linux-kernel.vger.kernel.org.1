Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44EF28DBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgJNItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbgJNIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:49:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8DFC045877
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:21:16 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x7so3125237eje.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=w0VoM9xAwvRUotQsNwLM0X8/wXzOnrdS5rYvfsKNHkk=;
        b=FSgC/UZlIn6mQqyJ2OjRdizSEBNchUEudGmWrlEoM8iQ85X0ZqWdLwEAPPRTt0Z9wU
         Qdwb2tqHLKmFM/zq1cyoh/UA+nptPpe7zwTk/LR17Vh+vdy63EuKsoQZy9me9teHEbME
         69C7em7alXscX+u0iBGf0NfkOsYKU4Xb0usX5+u5HY5fwfZk7UGJWdO+2F9OaH9ob64c
         nn1h3VTNDK3imANJ4nXL7iS0BsomPh0lljLV/x1aJ3Sg53srkWd6/9YUaOph3t4ygZwP
         vL5WOKAxL1QSDJfjC7rBbjyn2fb6kh3FVH4IigBvRo8l7YdaJqE1vT5/K0pdtV9LQmxG
         Sb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=w0VoM9xAwvRUotQsNwLM0X8/wXzOnrdS5rYvfsKNHkk=;
        b=sGOJ3mnLY9TfcnKDt3yCSWBnG8IS/jlgtX6xVEY+kQRj1frnygr7S6GYZJPTxHT8Fl
         CRTNAcRamS9sO7PXyeQLl6r3Cw7QaLUS/VWQTOWmHZfLXCPH3QTgB81fk6wpyjaCnjgO
         viUjNXvcisGwMGXhp77sYvmHja0M6kY+ZFDmJLi6Pxq+f4B+z0GCgq/vWhe4zvm6D9+z
         0Soi1mmbseSMPQObORoTZtPemKCaB7IeCZLCDPowuaHq+a94cv8gDsyoAf9D8HgP2PW3
         XJeyZEtYmPqW8GxZPd3fOFZnMt3w5AFoNtIAZ6qfQfhMD0MGHPv9X9jVlcNtOlNrQDhn
         mWVw==
X-Gm-Message-State: AOAM530J2eLgjFYTKAVVCSLXvba90+LGgvgWYOgwD1E69G4ruoW5XZW/
        Bm6nH75Nn2INuZsqxp414iA=
X-Google-Smtp-Source: ABdhPJySkM0h6Zy115ghkMZgHgzrjTkrd3wXlp/7//bOPDm+1wxR5Q72+HcYv31dNBjY65s1IYfa0g==
X-Received: by 2002:a17:906:1953:: with SMTP id b19mr3805037eje.252.1602656475004;
        Tue, 13 Oct 2020 23:21:15 -0700 (PDT)
Received: from felia ([2001:16b8:2da8:8200:4c70:9c82:f3bf:bebb])
        by smtp.gmail.com with ESMTPSA id z22sm1015014ejw.107.2020.10.13.23.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 23:21:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 14 Oct 2020 08:21:13 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
In-Reply-To: <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2010140812370.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com> <alpine.DEB.2.21.2010140734270.6186@felia> <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Joe Perches wrote:

> On Wed, 2020-10-14 at 07:46 +0200, Lukas Bulwahn wrote:
> > Just one bigger project example: Comparing clang-format suggestions on 
> > patches against checkpatch.pl suggestions are fine-tuning both of them to fit to 
> > the actual kernel style.
> 
> Eek no.
> 
> Mindless use of either tool isn't a great thing.
>

I did not suggest applying the tool to the source code and just changing 
the code... that is not a good idea as it is not helping anyone and just 
causing churn and distraction.
  
> Linux source code has generally be created with
> human readability in mind by humans, not scripts.
> 
> Please don't try to replace human readable code
> with mindless tools.
>

The goal is to run both tools on the code base and with the comparison see
how both tools can be improved.

We basically assume that the code is in the style it is intended to be.
What does checkpatch.pl warn about and what does clang-format still warn 
about, which is generally accepted okay as style in the kernel?
 
Then, we can improve the checkpatch and clang-format rules.

> If there's something inappropriate in checkpatch,
> please mention it.
> 
> There is a _lot_ of relatively inappropriate
> output in how clang-format changes existing code
> in the kernel.
>

Agree.
 
> Try it and look at the results.
>

Agree, that was the proposal. Nothing else.
 
> Improving how .clang-format is created and its
> mechanisms (for example: continually out of date
> ForEachMacros lists) could be reasonably be done.
> 
>

And that is something I would hope that somebody looking at the results 
would spot and start improving.

Lukas
