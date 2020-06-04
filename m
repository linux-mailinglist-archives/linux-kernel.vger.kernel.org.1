Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE241EEA71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 20:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgFDSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 14:42:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726262AbgFDSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591296176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7PupmSHGY+zNvP6Gsjnrcdsr5C4naMtTGEaoTGjHh8=;
        b=AOo1Py8AAAdg1ip+5MEpC036Fjwwep6qTfN9cEe4NnyNd3NW2oBNCUzbiTTcuF6NJCML4I
        fOHH8IQlhLL64D8uVJGMMHnjjLSJMGBEadLa8OTk2yQHggPDD8SNWKbvurMDyrt9uaWN0T
        /9ZUrOj1qdQDDhUW7nDttP9OiJlXpYU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-YkrFZB50PwCkRNAopoApEw-1; Thu, 04 Jun 2020 14:42:53 -0400
X-MC-Unique: YkrFZB50PwCkRNAopoApEw-1
Received: by mail-wm1-f70.google.com with SMTP id b63so3061523wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 11:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W7PupmSHGY+zNvP6Gsjnrcdsr5C4naMtTGEaoTGjHh8=;
        b=ZyEQ0na1FQbPn3L0pQiYs3A1UGfMdrxaDDZ8KB3OhlGDsJhS47UG89e3ECcVDeAq+e
         83rmuBk4I9B4w50dufxTQXBurr77DWeXXBEeFgmReS0Ya0Z6YCGVytu91dylfhPpdYnw
         V9af2MXCJPyj02nG5rIyMvm+5xyci7ooQVY0l68l3664Z+HmX7PsAmHQzY7qxDHb7C7O
         NsryRwTyXofqrq4PqmGq6zEOZn3Bic1BQVJLpx7V9BjBV1pQPLN193JwJghQ0jNeW93X
         GVoH/kQUW2dGIYl8MW449GBSgWm0Rc3ZELQkgPypAEmsoZL7GRjTIcqXdJXDOIQXt7/x
         mHwA==
X-Gm-Message-State: AOAM533pP0qYkppwDcRaC2hnufwkqEoGef0CWtZvRy2YfMoClmGmf2q2
        2QkeXC4PtAl3RS7F5J6Sp/049iPnl2gYdMSkwVby6cRXFuWBWFqApHAaNWgkepkx+7NfAVujvxn
        gt8Rq22oHnCgksrhB+I+cEKMp
X-Received: by 2002:adf:aa97:: with SMTP id h23mr6126381wrc.251.1591296171177;
        Thu, 04 Jun 2020 11:42:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznAX0ROdSeZrRHnaqmouzsaV5mjG/PqHDp86o5qQ8VbvXbtz0L3ZbFDZfNb08OYjvzvJAqpQ==
X-Received: by 2002:adf:aa97:: with SMTP id h23mr6126361wrc.251.1591296170873;
        Thu, 04 Jun 2020 11:42:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id m129sm8974449wmf.2.2020.06.04.11.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 11:42:50 -0700 (PDT)
Subject: Re: [PATCH 0/3] avoid unnecessary memslot rmap walks
To:     Anthony Yznaga <anthony.yznaga@oracle.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, steven.sistare@oracle.com
References: <1591128450-11977-1-git-send-email-anthony.yznaga@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d440118-4325-6f68-75e7-dd5a74c4a7eb@redhat.com>
Date:   Thu, 4 Jun 2020 20:42:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1591128450-11977-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 22:07, Anthony Yznaga wrote:
> While investigating optimizing qemu start time for large memory guests
> I found that kvm_mmu_slot_apply_flags() is walking rmaps to update
> existing sptes when creating or moving a slot but that there won't be
> any existing sptes to update and any sptes inserted once the new memslot
> is visible won't need updating.  I can't find any reason for this not to
> be the case, but I've taken a more cautious approach to fixing this by
> dividing things into three patches.
> 
> Anthony Yznaga (3):
>   KVM: x86: remove unnecessary rmap walk of read-only memslots
>   KVM: x86: avoid unnecessary rmap walks when creating/moving slots
>   KVM: x86: minor code refactor and comments fixup around dirty logging
> 
>  arch/x86/kvm/x86.c | 106 +++++++++++++++++++++++++----------------------------
>  1 file changed, 49 insertions(+), 57 deletions(-)
> 

Queued, thanks.

Paolo

