Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ED3297DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763731AbgJXSMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763724AbgJXSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 14:12:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C704C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 11:12:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so314947plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mXaxBMgd3STA90Ceb6+dwFyt3TBhuPB650L6ZqSsYus=;
        b=CjomsHARkF6OFvaUIz5OWUzGWCtl/uIgu/hnqEb8I/qS0hRnAR+7eCLLZoyGyGAJAa
         c8xL2CusNyM85BGVKzufsCK0pdoWBsHFAvRgAgw6XSWTOwVZbJUrahw9+3tXhu82k5Mt
         DAdjO1lgsLUf7qjq5RMywce1ITKE5Y4g2SEuiCvq9s2A072W+p7l/Z8dCcW/9qDwgc8I
         twUeJ1W0J1GIj0dKto2lxnqKw0YAsTCDiS8S5PdLKqgkdURPeYSPY8Zvf7/JublWpp7X
         RQgKH+FhsvdrXpdXhGQGolmcG1SnqAvPGwN9A8dV1PaQUw0lxSfhAWqfflQ9NvKfqiEG
         P9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXaxBMgd3STA90Ceb6+dwFyt3TBhuPB650L6ZqSsYus=;
        b=iuOcb+VL4CIGeK90yvwNI7MNfeooK8ITg9ffpfL63QLG1XoI+W2qf4D0FTzRa9+TyD
         dtTOV7ZAJwUED4wCwY6IXjjIqplZS0x4fhsINp44/aYZX/fCkC7wwQKw7lnong5CFula
         RxqgPu8mfbZjrhKhu3+IhjOxWuOpgNiItw72Y5eJQ2+QqTgadDezUXMc7O6+Rz3AGknc
         RVoLYqwrH3tcU9CtMyZKZZBdv1qtj4bPgWLWhZU3JGvGdbqZUAlJsDcSmBdIlNzJrs7h
         8J7yhhKpRTyiGGyrp7LAw/iJh7MwD7+BwzBGTLdVFYXhWy49yUfg7/l05etORklPJWQW
         WC/Q==
X-Gm-Message-State: AOAM530fM99L6IkosBt0ZHWpPcJJkrMKn78k/qKzrvexnNEv7CZQkKiQ
        4wn2b2I9x5ZePMWrCRG2hNM=
X-Google-Smtp-Source: ABdhPJyZXmUv/FreBmEkmRMyIcS9k9Shgusj6xr2EAq/iECeEJiGZu7tyn9Ot7JUB87oFmATxFo2LA==
X-Received: by 2002:a17:90a:9206:: with SMTP id m6mr10377241pjo.42.1603563129587;
        Sat, 24 Oct 2020 11:12:09 -0700 (PDT)
Received: from ?IPv6:2409:4063:228f:175e:55ee:fad5:f15e:347e? ([2409:4063:228f:175e:55ee:fad5:f15e:347e])
        by smtp.gmail.com with ESMTPSA id v65sm5529364pgv.21.2020.10.24.11.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 11:12:09 -0700 (PDT)
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
References: <20201023133828.19609-1-yashsri421@gmail.com>
 <alpine.DEB.2.21.2010232104150.11676@felia>
 <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com>
 <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <2cbc0068-4e3e-17d5-6260-dda7c9f3a9b0@gmail.com>
Date:   Sat, 24 Oct 2020 23:42:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/20 9:03 pm, Joe Perches wrote:
> On Sat, 2020-10-24 at 18:54 +0530, Aditya wrote:
>>> Would you like to work on 
>>> further rules that can be improved with your evaluation approach?
>>
>> Yes, I would like work on further rules.
> 
> Some generic ideas:
> 
> How about working to reduce runtime and complexity by
> making the rules extensible or separable at startup.
> 
> Maybe move each existing rules into a separate
> directory as an individual file and aggregate them at
> checkpatch startup.
> 
> Maybe look at the existing rules that do not have a
> $fix option and add them as appropriate.
> 
> You could fix the multiline indentation where the
> current warning and fix is only for a single line
> 
> 	value = function(arg1,
> 		arg2,
> 		arg3);
> 
> where checkpatch emits only single warning and fix
> for the line with arg2, but not the line with arg3);
> 
> Maybe try to make the coding styles supported more
> flexible:
> 
> Allow braces in different places, support different
> tab indentation sizes, spacing rules around operators,
> function definition layouts, etc.
> 
> 
> 

Thanks for all these suggestions. I'll make observations regarding
these and get back to you :)

Aditya
