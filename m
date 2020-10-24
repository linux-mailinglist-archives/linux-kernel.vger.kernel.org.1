Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0165297C93
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761736AbgJXNY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761729AbgJXNY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 09:24:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26606C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 06:24:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r10so2468800plx.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WKK8YZuOj3Yh6We8Y+x2rmG2WWLX2F33ea9of7SdLcU=;
        b=PDnJMBsEhleRMRxBsspAd228iliqApLm5aVCYMsttPhfVahie7p50RrwWUOSUjRI1Z
         TQv4XzWWz+odtXmaeMo+TBM+p+qZJBOXDkmwLJtZdiNmiVVv+U6uY1doe1n41ec6vzCP
         RkFOOxSyBk4Fd85EFsx6dWUnIiqi8zXRYTIUlXeifUHSPQUmjdhxU3yxzroQMN+Um69Y
         4C/kk5pl3IdsQl9VNQWoLpiHyQ72LW9KzHeVXAJzmh8qZON0VnrlTjJUsmQkpevNEVi0
         wPw/TIV+HhxujKnF3kXtVs6llqtcPMKpHK6I5ylCeXJTFdlqdgqtFYkAbBtkOWLmqOZz
         2fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WKK8YZuOj3Yh6We8Y+x2rmG2WWLX2F33ea9of7SdLcU=;
        b=pFJx1SJuuKQ5hSrdG1/UqgQaE2AEKLGSeHufgtGQtCnwCD/U9cjHeM4ICGDOiavcS0
         SqGTEUBZun1hu0HiuRpxs4jBG2CO7vL02UK90ofQMC9Vhh2otdfkdI1t69hE9my0IvpU
         gOIS0gxchpHTQ2RXdYAj1btJHgZieVRxBuSCkb95C5uPzyWUmmDRRJe0KnH1rdzLmQsZ
         AqV5X487XJIElj+UtHtKn6fEH1VZsAMGLwW04iImTJwqz7jiCHKH6xfufcOVLAOIAk9n
         tFPCyzuphaSR9OHC3RPXIjlrQ4EVWAp6ne9gepuUuhnGWjgcL/Fo2l5oFMHDGvPTlI8L
         LuEQ==
X-Gm-Message-State: AOAM533P7M4RXtau2Ii5xXdE+alQ2mSQSjoFbF56y1ifPU1ZnUMJeIu2
        F4GCaMzRKY6JFMlESC5OM7g=
X-Google-Smtp-Source: ABdhPJzPcmq6tGCFnwdcWkYFySvcrzQ24fdevzf4NIsgatgYjtvgE7dokjoVc+RTHubxilthExFnoA==
X-Received: by 2002:a17:90a:c28f:: with SMTP id f15mr7591678pjt.143.1603545868511;
        Sat, 24 Oct 2020 06:24:28 -0700 (PDT)
Received: from ?IPv6:2402:3a80:40f:9156:55ee:fad5:f15e:347e? ([2402:3a80:40f:9156:55ee:fad5:f15e:347e])
        by smtp.gmail.com with ESMTPSA id j23sm5250323pgm.76.2020.10.24.06.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 06:24:27 -0700 (PDT)
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
References: <20201023133828.19609-1-yashsri421@gmail.com>
 <alpine.DEB.2.21.2010232104150.11676@felia>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com>
Date:   Sat, 24 Oct 2020 18:54:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2010232104150.11676@felia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/20 12:36 am, Lukas Bulwahn wrote:
> 
> 
> On Fri, 23 Oct 2020, Aditya Srivastava wrote:
> 
>> Presence of hexadecimal address or symbol results in false warning
>> message by checkpatch.pl.
>>
> 
> I think this strategy now makes sense and has the right complexity for a 
> good heuristics in this case.
> 
> Nice job, Aditya.
> 
> Are you ready for a next challenge of this kind? Would you like to work on 
> further rules that can be improved with your evaluation approach?
> 
> Lukas
> 

Yes, I would like work on further rules.

Thanks
Aditya
