Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2880E2969D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375342AbgJWGic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368119AbgJWGic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:38:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:38:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so431446pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=du8DG9bmuPrMxShvvb8aQjcXCo588n8MEAUeaDJS0ro=;
        b=jTvjxTQfWphPej6/1PfD28lAXYm0U1g/W21bzQeCqu/U7L+Z4hR6zakhVUaNOBMqGx
         mee05wg+ZhnecR3FA+jjvoAjjCHhabm5pDHXc69JP7E9ZdS43xDoKP7XLQ3+Uja0jZqG
         NPq2zBHqVWTCr98O/4qBN7dFoxIbd3r/CeTdulmx/IJjhmbQlIVEjWRS17O6J/u6ZJsW
         VotXK4KtgnVJzmhe4O7e+1F2zIWGWFY0xSM3+B65H33q11j6GuukRYP0uEJmf+spdr9/
         CvGUqJPDdc1yrNfGrbcovPJGwQZ4ZZPZmtfaxsfm96t4Rp/VCF9GT0YOaexVWbXoCPvo
         O0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=du8DG9bmuPrMxShvvb8aQjcXCo588n8MEAUeaDJS0ro=;
        b=dGavMuroLj8hbBYZP7x3qa6sxPaLT1yCGEhw3VEW3+ezPx5k5QrbnUBftA6QCGOHZm
         N8S50stxnQ5RrXb0g7+vZ4UAjI4KEgTaYP4GlehIIlOqaaGM5BljO73NsN5c0sHgSo3x
         n5pU5Pleg2n/ZCqICB3gKpCz6IrUzPLVtaAB+e5tk8hfWRZADXWT5htzl959z7h7Ypt6
         4Z2qjkldyuSflFLlyHiyo4su0PotCzxw6y8PmfWh37EBYg+0LfVn8xUvnf9aj8LkmpY1
         nsOfT4k6L04a/9fhOOr2AipFa91rb+MBi/Ro35H8jMG3e9RzZtn6CtLmeMXxyvfuqBQe
         4o1A==
X-Gm-Message-State: AOAM533AdAMy4rcpTofMjVIVVSPM2k6rJ63aufn1j94Bv/P951+3jDy4
        P7YPOk9yWh/9QIUb0JRnmJA7WYKPD0tLYk6W
X-Google-Smtp-Source: ABdhPJzgGubHtwtPVlQoW1i1YjP4CmDgF6KXik8vWFvSdt5ceVFh7FEl9ivr6PamrnrGEDOveB0pig==
X-Received: by 2002:a17:90b:110b:: with SMTP id gi11mr819076pjb.25.1603435112090;
        Thu, 22 Oct 2020 23:38:32 -0700 (PDT)
Received: from ?IPv6:2402:3a80:429:6ba7:30ef:4722:a786:585f? ([2402:3a80:429:6ba7:30ef:4722:a786:585f])
        by smtp.gmail.com with ESMTPSA id l3sm741272pju.28.2020.10.22.23.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 23:38:31 -0700 (PDT)
Subject: Re: [PATCH v2] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Aditya <yashsri421@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
References: <20201022145021.28211-1-yashsri421@gmail.com>
 <4cbbd8d8b6c4d686f71648af8bc970baa4b0ee9b.camel@perches.com>
 <5121bf7c-a126-6178-62ff-e54f0bb4cb6e@gmail.com>
 <67247b2d51aa8b2da7377e400e9191733144ed0f.camel@perches.com>
 <edaa9012-d512-26fc-0aca-f0eaf889a050@gmail.com>
 <b853a8ab4daface74075e93d83f94655f13a2979.camel@perches.com>
 <8845d575-596e-b2e0-26c1-16e704074fc8@gmail.com>
Message-ID: <4d32f0db-0ab3-6a4d-9428-16e0651fbe29@gmail.com>
Date:   Fri, 23 Oct 2020 12:08:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8845d575-596e-b2e0-26c1-16e704074fc8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/20 12:03 pm, Aditya wrote:
> However, though such cases haven't occurred over v6..v8.
> 
> Actually, we could simplify it more on the basis of occurrences in
> v6..v8, for eg. if we check for /[0-9c-f][0-9a-f]+/ (instead of
> /[0-9a-f]{2,}/), it gives us desired result over v6..v8, but again
> we'll miss out cases such as:
> 

Sorry, v5.6..v5.8

