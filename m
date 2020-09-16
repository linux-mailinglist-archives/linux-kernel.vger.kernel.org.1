Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8126BC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIPGOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgIPGOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600236847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAy8F21gDH6+Sw9pecHci2b6o0ZbXZ2VL3vO/JJIxCg=;
        b=hZUD6T6wiJg028JQ0FU7As33zcsU5YNy7oeuCHMeYV5LIP0htdGvqMRjSzJ0jROMBArHCI
        uGx939JAh8CqokGYy6LEjStKtWt+43a9QZJYIdcxiE0ZA0fk/yrEltvgQY2kTPV7urmuSO
        2QhtI25UARakZXxpeyUo6gn+sfyvMY4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Km4s9r6EM76yl4uR_LH88A-1; Wed, 16 Sep 2020 02:14:06 -0400
X-MC-Unique: Km4s9r6EM76yl4uR_LH88A-1
Received: by mail-ed1-f70.google.com with SMTP id g16so2011102edy.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAy8F21gDH6+Sw9pecHci2b6o0ZbXZ2VL3vO/JJIxCg=;
        b=gYVCqSZbPOpP+jzOHVL+fzg6PJvBIB9fU/tdJi0OUixq/PKghumjQnA32U11mupaWY
         gZ4c+fWgPjRe/f+HcnjvRfi8GYWQGnO8Fwvx43joY/WSzn5q3ztIR3awYyIG8J1CHYp4
         iafSv3fsSP2N4cY2zOTeO9LkE7zqKm0mcnPUCyHhsvdkj7PGAP9ge93DYWYFMJsBSCoe
         NYU+szcX9g9N+B8uprQEZHFSsgyzFN+dxjeZSJvYv9SFf9Mh4iRuHwpmM6M0lkEqFH6d
         73Wf+YRqGC6Ag5IP6pPRwNg/1Dq0l8rdwVSxdbvoUgqMgr2KUPuZBMLlWFCv2L956r93
         Lz0g==
X-Gm-Message-State: AOAM530V0zzpFvChbLJjJvUYvSgWTj7WDi50h0dtdDdvzJkP+XoLMCyC
        e7UsSZz4NafZue7SEofWZKlGg9jiz/VBO0dF7A0mipiHCLYq7S9leefy4QEdWwgi6GeAGxjMWlO
        2ZWOOAEdt9It2CS6ZWgZsnQy3
X-Received: by 2002:aa7:c693:: with SMTP id n19mr26801637edq.101.1600236844786;
        Tue, 15 Sep 2020 23:14:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOj51KeyKT0NbzS0wwH7CKGKR5OD5UR2xdM1DwXRbWiZncCtgIlJTtmyzDAZRfw8qbkiFyyw==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr26801621edq.101.1600236844528;
        Tue, 15 Sep 2020 23:14:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id b5sm13086528edq.69.2020.09.15.23.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:14:03 -0700 (PDT)
Subject: Re: [PATCH] vboxsf: fix comparison of signed char constant with
 unsigned char array elements
To:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200915160336.36107-1-colin.king@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <65fbb23b-a533-aedb-75eb-69e1c53eaae9@redhat.com>
Date:   Wed, 16 Sep 2020 08:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915160336.36107-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/20 6:03 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The comparison of signed char constants with unsigned char array
> elements leads to checks that are always false. Fix this by declaring
> the VBSF_MOUNT_SIGNATURE_BYTE* macros as octal unsigned int constants
> rather than as signed char constants. (Argueably the U is not necessarily
> required, but add it to be really clear of intent).
> 
> Addresses-Coverity: ("Operands don't affect result")
> Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

A fix for this has already been queued up:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=fixes

Explicit nack for this one, since it will still apply, but combined
with the other fix, it will re-break things.

Regards,

Hans



> ---
>   fs/vboxsf/super.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 25aade344192..986efcb29cc2 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -21,10 +21,10 @@
>   
>   #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
>   
> -#define VBSF_MOUNT_SIGNATURE_BYTE_0 ('\000')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_1 ('\377')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_2 ('\376')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
> +#define VBSF_MOUNT_SIGNATURE_BYTE_0 0000U
> +#define VBSF_MOUNT_SIGNATURE_BYTE_1 0377U
> +#define VBSF_MOUNT_SIGNATURE_BYTE_2 0376U
> +#define VBSF_MOUNT_SIGNATURE_BYTE_3 0375U
>   
>   static int follow_symlinks;
>   module_param(follow_symlinks, int, 0444);
> 

