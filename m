Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248D42832B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgJEJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:03:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7CC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 02:03:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 133so3688590ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TLsUgbOGOIJXvR28fJ8SOdwuYiauERcW1VexhlIihlU=;
        b=osRu/0608bGzbyuCzkQ+bMc1pQIgNqGSKxssbdpT9mZ7GNp6aBeTpltAlFJD309zKb
         9zt6wJyRcvTnBWM0YIGKrIa4bq9xxrDSHv53+WS0sOsq7K+yr5oQR+S/nFG+0M8Jq0XT
         lFgdanyA38lE9mNhv3sKEiuVe09elhT0jI9/yh52G6E4WMpe1lm4m/RGrxQnSzik8sjb
         aEShnDrU/p2f7RH1JFxBE0C6GA62Dtv/3cleoKVN/fMIwMTbLPMb1ABo18WXv3tmYqeO
         lCkf194SCX2jpa6rL9/jkQBPzgbWFwz5DrLnJrbZ7UyV46ow/nLh8AsKqcHkqmMuhu/M
         jiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLsUgbOGOIJXvR28fJ8SOdwuYiauERcW1VexhlIihlU=;
        b=mApG53qCA/Z0SfND6nCGhRJV3halKTb8npop5iORHJMsQ4NXaQN0NQJZdt4KVUqs+A
         Za75lAs38qCWcrRUAaDT+xMF4O6sFBip8bohHnPUiTxhZwJiz9MUBFr3+GB8hSPTcUDe
         epY0X6ypGRUxUp+mksP6IoFJfLEb4nNpZetCZCmOu5R4Y4kwoR4CjKRki/Fsla1z2rbd
         dAuziYEh2OvemHE+fIb/KmpMYCx/vOLR3m9MOBKYExbU6vxRKsIvgcLDJG9wjTflERyJ
         Y/26Gw/NnTmEtRA34TnTIESKTNIfK8vKH7IEICvyuqL6VjwzTyeic+H46oDLuQTVPruE
         yt5A==
X-Gm-Message-State: AOAM532JVcBSuvtYKuY23+O+tgRk9nBaGzrdemfBWSeeySQtDzDpEVPk
        fUkbpxBq5lOI8RaEAgzmc3yx642oWpM=
X-Google-Smtp-Source: ABdhPJy3xtOS8DN1ediooShKqEXf4FSki/OPEzyl5SRbCslVwKUf2fMjHHVCTkmkrHc0OxFE3MXRcg==
X-Received: by 2002:a2e:9ed5:: with SMTP id h21mr3855477ljk.178.1601888610742;
        Mon, 05 Oct 2020 02:03:30 -0700 (PDT)
Received: from [192.168.1.89] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id n26sm3300666lfq.120.2020.10.05.02.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 02:03:30 -0700 (PDT)
Subject: Re: [PATCH] mm: optionally disable brk()
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <7d7b1ac5-d6a7-5e43-8fb8-12b844d7f501@gmail.com>
 <20201005082239.GQ4555@dhcp22.suse.cz>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <4f0b1f0e-ab26-cd4e-607c-2c5b9933f10a@gmail.com>
Date:   Mon, 5 Oct 2020 12:03:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005082239.GQ4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2020 11.22, Michal Hocko wrote:
> On Mon 05-10-20 11:11:35, Topi Miettinen wrote:
> [...]
>> I think hardened, security oriented systems should disable brk() completely
>> because it will increase the randomization of the process address space
>> (ASLR). This wouldn't be a good option to enable for systems where maximum
>> compatibility with legacy software is more important than any hardening.
> 
> I believe we already do have means to filter syscalls from userspace for
> security hardened environements. Or is there any reason to duplicate
> that and control during the configuration time?

This is true, but seccomp can't be used for cases where NoNewPrivileges 
can't be enabled (setuid/setgid binaries present which sadly is still 
often the case even in otherwise hardened system), so it's typically not 
possible to install a filter for the whole system.

-Topi
