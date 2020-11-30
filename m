Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC02C8935
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgK3QSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbgK3QSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606753026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buWVhHxgASs9AgCyEpqieZvu3CWe/BCx2B4/1qlbtuE=;
        b=EJlEJyMi+pUE9C+ZhRR0fN9+cO1INYQ9rNh4zG5K2/N5ilDw3eVfh2l4X1RcBZqxPCl3jf
        2xRMC/D5YzygbBXQh7v+GtTuX4sBxxC2w8qDIcZYkOreolkBGik4ohWyhrkAROdhUOwz+Z
        1lElhsuGfz677nMTgggQUJK3t3IEBAI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-Kz23Xpt4O1u-RM6s0kSluA-1; Mon, 30 Nov 2020 11:17:02 -0500
X-MC-Unique: Kz23Xpt4O1u-RM6s0kSluA-1
Received: by mail-qv1-f70.google.com with SMTP id d30so1435931qvf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=buWVhHxgASs9AgCyEpqieZvu3CWe/BCx2B4/1qlbtuE=;
        b=i7qNa13kTn01jxT4rdhRMlsgH47z1VyW2Q3AuGzU/crSpSywv2FrNMet1it01XITpL
         oEwxE5P6tuXM6dsq22Ogm4F6hkx3it0/ZfDYdO6yCxM3dMpwD9+2qp98qcm8z7O55QLM
         h6f7hlvWNVMVapT+dFcYUoVdCpRfU4A2/6HCCQK9pkYepGJXCDJegt4IByV7HV7FdX0K
         6dfV34CHBnC729KZIRARGQFp0lLp24HgIvnT1FalCjjORYRPP60h7h02PnEp7br0GsK/
         ZKR8dRmGOtr+Ru+DELuD9WkjZtmbO9fz9rW+haJmSZs/uUGCEq5qC/508KSav58ymXKD
         6dbw==
X-Gm-Message-State: AOAM5317fTLKvVPwnjcVfeM+V5F5Q9D0/BD+CdSJpyKxIfkHXkVvmkzK
        ezcMTEVPOOioPsYYYO3cPtanFAZMj6g6OzaEPcdykhwft5YCJPCOQx3zZjkW6IUgE+yHGCL//+Z
        jL6AfLRSem81RSlbGgBoBxA0GNQRvDWPmGJQ2HmZtENxlBUjfyDx4swbUTjQjuRYsztzIZO4=
X-Received: by 2002:ac8:5304:: with SMTP id t4mr22843568qtn.77.1606753022024;
        Mon, 30 Nov 2020 08:17:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj8FaPNbr09u+LpUyDT1y+WdRpGt8gF1fOEVd+1u8AkOkqUaiO5Ly2PC+Sp/MuoZclSgNO8Q==
X-Received: by 2002:ac8:5304:: with SMTP id t4mr22843535qtn.77.1606753021809;
        Mon, 30 Nov 2020 08:17:01 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k15sm15769338qke.75.2020.11.30.08.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 08:17:01 -0800 (PST)
Subject: Re: [PATCH] scsi: qla2xxx: remove trailing semicolon in macro
 definition
To:     Daniel Wagner <dwagner@suse.de>
Cc:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201127182741.2801597-1-trix@redhat.com>
 <20201130091753.4wyrzlbrqszdzy6s@beryllium.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3baa674f-ce34-34a9-26ec-1d3e0e2ebdcd@redhat.com>
Date:   Mon, 30 Nov 2020 08:16:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201130091753.4wyrzlbrqszdzy6s@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/20 1:17 AM, Daniel Wagner wrote:
> Hi Tom,
>
> On Fri, Nov 27, 2020 at 10:27:41AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The macro use will already have a semicolon.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>
>> ---
>>  drivers/scsi/qla2xxx/qla_def.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
>> index ed9b10f8537d..86d249551b2d 100644
>> --- a/drivers/scsi/qla2xxx/qla_def.h
>> +++ b/drivers/scsi/qla2xxx/qla_def.h
>> @@ -4970,7 +4970,7 @@ struct secure_flash_update_block_pk {
>>  } while (0)
>>  
>>  #define QLA_QPAIR_MARK_NOT_BUSY(__qpair)		\
>> -	atomic_dec(&__qpair->ref_count);		\
>> +	atomic_dec(&__qpair->ref_count)		\
> Nitpick, please insert an additional tab after the remove so that the
> backlashes align again.

How about removing the last escaped newline and the next empty line ?

Tom

>
> Thanks,
> Daniel
>

