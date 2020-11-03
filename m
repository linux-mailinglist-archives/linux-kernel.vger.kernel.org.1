Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B996A2A406F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgKCJgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:36:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbgKCJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604396204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUMHDTJBLCaRWYxgda6KW+xkxsOmPbNb2PBmBlfchk4=;
        b=Q5JeW9FW+QLrHry3D4GZOFs2qGiTyP99+qGzr/gce7RdbX+PBG76DsshoMpvHU7RlYJmcg
        y1qDAmjTcSW8BQIBshJc3m3w+dRzXpkwpVdWAZ3Rro3FwwYzN1Wf2ARtuoNCc0SeIwLiqd
        x+AR8yfxtiO+7he3X11qPxIDqa0U6Zw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-d2vtfvddMxC3WAdMxjrAvQ-1; Tue, 03 Nov 2020 04:36:42 -0500
X-MC-Unique: d2vtfvddMxC3WAdMxjrAvQ-1
Received: by mail-ed1-f71.google.com with SMTP id c24so245205edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 01:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUMHDTJBLCaRWYxgda6KW+xkxsOmPbNb2PBmBlfchk4=;
        b=IItLl2j0qY+oPdDt95QbkY1JjGXUHZkZfKliQ/vzlUkdiNeGoquA46VLkRCWh6fYe2
         pQnXmacNom5znl5VoWOMKvjSmKIH/P9xjBwQPdeACLRMfWztsNt7T9G3n/jBzWiBe5eV
         EfM3HldLSNSAuEB2dOaPEKrjCmcyg69pF14gkpMdEO+3tHJhZ4csCOXQd6/7/wzQpQUT
         DxKMhJEfQEY1T5N420NwFJZh2ynL+qRjnsV47JwGRT/UU1kaA2vpXxiL4cc9za2+fNJL
         aV3y92qm+6ojyDtGnMgOnUoRK3X/3A4RVqtit6KtPG/NIOgpDk6RKY4YnSKLSo82YTVh
         X9vw==
X-Gm-Message-State: AOAM532WDj4sNm97Lu+p3cpcOh/9cV71sZ5ZbxF8jPXCQzXE+ymoPuEY
        eCV48aF5juGbxw++LCKFIH0jvas/5QUoIcNGB2Uas/zPTsD+JpW4SJhBsOGtklIWdTs3Lr7OX+8
        sfvb3J7g7YLDdMV8VPSNmfTSZ
X-Received: by 2002:a50:e185:: with SMTP id k5mr20293568edl.48.1604396201357;
        Tue, 03 Nov 2020 01:36:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXywKSj01gUxrjIrNyJsNPVtGRWns5Aei8RiIonJXze9dVkccSo7BfBJKeu8i57PlhjhQlfQ==
X-Received: by 2002:a50:e185:: with SMTP id k5mr20293555edl.48.1604396201157;
        Tue, 03 Nov 2020 01:36:41 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id f9sm4878958ejd.85.2020.11.03.01.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 01:36:40 -0800 (PST)
Subject: Re: [PATCH -next v3] platform/x86/dell-wmi-sysman: Make some symbols
 static
To:     Zou Wei <zou_wei@huawei.com>, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1604107922-14950-1-git-send-email-zou_wei@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ccfa1a29-6e1a-1ec7-4dd6-15d81b945f0e@redhat.com>
Date:   Tue, 3 Nov 2020 10:36:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604107922-14950-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/31/20 2:32 AM, Zou Wei wrote:
> Fix the following sparse warnings:
> 
> ./passobj-attributes.c:38:23: warning: symbol 'po_is_pass_set' was not declared. Should it be static?
> ./passobj-attributes.c:70:23: warning: symbol 'po_current_password' was not declared. Should it be static?
> ./passobj-attributes.c:99:23: warning: symbol 'po_new_password' was not declared. Should it be static?
> ./passobj-attributes.c:103:23: warning: symbol 'po_min_pass_length' was not declared. Should it be static?
> ./passobj-attributes.c:107:23: warning: symbol 'po_max_pass_length' was not declared. Should it be static?
> ./passobj-attributes.c:116:23: warning: symbol 'po_mechanism' was not declared. Should it be static?
> ./passobj-attributes.c:129:23: warning: symbol 'po_role' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> v2:
> - put all of them in a way that each occupies only a single line
> v3:
> - shorten the warning paths
> - put the static codes a single line
>  .../x86/dell-wmi-sysman/passobj-attributes.c        | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
> index e6199fb..3abcd95 100644
> --- a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
> +++ b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
> @@ -35,8 +35,7 @@ static ssize_t is_enabled_show(struct kobject *kobj, struct kobj_attribute *attr
>  	return ret;
>  }
>  
> -struct kobj_attribute po_is_pass_set =
> -		__ATTR_RO(is_enabled);
> +static struct kobj_attribute po_is_pass_set = __ATTR_RO(is_enabled);
>  
>  static ssize_t current_password_store(struct kobject *kobj,
>  				      struct kobj_attribute *attr,
> @@ -67,8 +66,7 @@ static ssize_t current_password_store(struct kobject *kobj,
>  	return count;
>  }
>  
> -struct kobj_attribute po_current_password =
> -		__ATTR_WO(current_password);
> +static struct kobj_attribute po_current_password = __ATTR_WO(current_password);
>  
>  static ssize_t new_password_store(struct kobject *kobj,
>  				  struct kobj_attribute *attr,
> @@ -96,16 +94,13 @@ static ssize_t new_password_store(struct kobject *kobj,
>  	return ret ? ret : count;
>  }
>  
> -struct kobj_attribute po_new_password =
> -		__ATTR_WO(new_password);
> +static struct kobj_attribute po_new_password = __ATTR_WO(new_password);
>  
>  attribute_n_property_show(min_password_length, po);
> -struct kobj_attribute po_min_pass_length =
> -		__ATTR_RO(min_password_length);
> +static struct kobj_attribute po_min_pass_length = __ATTR_RO(min_password_length);
>  
>  attribute_n_property_show(max_password_length, po);
> -struct kobj_attribute po_max_pass_length =
> -		__ATTR_RO(max_password_length);
> +static struct kobj_attribute po_max_pass_length = __ATTR_RO(max_password_length);
>  
>  static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
> @@ -113,8 +108,7 @@ static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
>  	return sprintf(buf, "password\n");
>  }
>  
> -struct kobj_attribute po_mechanism =
> -	__ATTR_RO(mechanism);
> +static struct kobj_attribute po_mechanism = __ATTR_RO(mechanism);
>  
>  static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
> @@ -126,8 +120,7 @@ static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
>  	return -EIO;
>  }
>  
> -struct kobj_attribute po_role =
> -	__ATTR_RO(role);
> +static struct kobj_attribute po_role = __ATTR_RO(role);
>  
>  static struct attribute *po_attrs[] = {
>  	&po_is_pass_set.attr,
> 

