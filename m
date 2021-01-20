Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F192FD30E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbhATOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733139AbhATMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:54:32 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177BDC061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:53:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w14so5401299pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hB+1o0DrnShLgQiO0WE1Gdsq3IMq61KourkCYu6qcaY=;
        b=Seq9VaSKx/HQCC1k4Uz7Pk3ROqFrZ6fucBgqAuYXmtaLwbmKESKzwhLRK8Oi2p+612
         /34CKTXFTGzASV79GPoEG++AHzsWgeqWRZM5QBYCZgX3CgdgwPxRVrQxbexWbiPXKh2t
         NXZcZQBN/E/EPD0V8qzxmeJgEnmaA5YelJIkV6wANe38GBkU6vrh+V1sxNXPwGZh4Taa
         SPA8vttyYnWVeA1bDMnAE8TcJUUrT1C4rtP7HFeYUBBlKGcJ0STTqpOzeK9zFWJmAspR
         mh7smVY2msulNe2rFtBv2b+GjyZUfsNzZ/FJVvah9Jhriz87GZ4i1+Ky495MU2NN4W/5
         qFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hB+1o0DrnShLgQiO0WE1Gdsq3IMq61KourkCYu6qcaY=;
        b=UDt5Zv1bXIT2ey/qptKGyPYdRLiPJfI9XnFaiC3OOVgc2OMsY3HXwNrjOdVILueAOy
         GmfwdJhIavFClVQmyn1YeDZXWnQy+IGSnZFHlk9e5LW7f3f6PDQZvZRxRnmix7llmXxf
         Jy4Y0wurFnuhl4hqelXcRQPR7iIHuMW51X/GI0zP4/mX7NCrW0G2dUkH8vu6Br/9Uw/D
         Gv9WduX25ExjgMh1eyIqzUbKjRZB5EB5LXnpNHMeMNCZvQrXFQfoEMohRKFSJyqeeKkT
         fivnJclEcIiD4dGB2uGIvtkFoWYGHT6WSzKuKp78MB+7AILjXkUgdYmkSVVbnDdWajWD
         Ty2g==
X-Gm-Message-State: AOAM532rvbP2TyUM1reoOwcdOx50ehspkrxW9pmrSGl6WoS2ivNAMl6r
        MMXn+yv42azfDtwQHnq82ioc7TNXV0fHiQ==
X-Google-Smtp-Source: ABdhPJwa3aot/XiE+R+h1fEeREklj3vFnePmy4/tZlr4My0oqbnc+lzORozd6rTMDgtGrC545XsD8g==
X-Received: by 2002:a63:4504:: with SMTP id s4mr9089641pga.284.1611147203498;
        Wed, 20 Jan 2021 04:53:23 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:7054:d78f:3538:6af3? ([2405:201:600d:a089:7054:d78f:3538:6af3])
        by smtp.gmail.com with ESMTPSA id j17sm2242003pfh.183.2021.01.20.04.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 04:53:22 -0800 (PST)
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols in
 assembly files
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        broonie@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
References: <20210120072547.10221-1-yashsri421@gmail.com>
 <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com>
Date:   Wed, 20 Jan 2021 18:23:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/1/21 2:51 pm, Joe Perches wrote:
> On Wed, 2021-01-20 at 12:55 +0530, Aditya Srivastava wrote:
>> Local symbols prefixed with '.L' do not emit symbol table entries, as
>> they have special meaning for the assembler.
>>
>> '.L' prefixed symbols can be used within a code region, but should be
>> avoided for denoting a range of code via 'SYM_*_START/END' annotations.
>>
>> Add a new check to emit a warning on finding the usage of '.L' symbols
>> in '.S' files, if it lies within SYM_*_START/END annotation pair.
> 
> I believe this needs a test for $file as it won't work well on
> patches as the SYM_*_START/END may not be in the patch context.
> 
Okay.

> Also, is this supposed to work for local labels like '.L<foo>:'?
> I don't think a warning should be generated for those.
> 
Yes, currently it will generate warning for all symbols which start
with .L and have non- white character symbol following it, if it is
lying within SYM_*_START/END annotation pair.

Should I reduce the check to \.L_\S+ instead? (please note "_"
following ".L")
Pardon me, I'm not good with assembly :/

Thanks
Aditya
