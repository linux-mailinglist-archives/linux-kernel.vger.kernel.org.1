Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559AB303EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbhAZNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:39:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391582AbhAZNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611668257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TyWVTjlaOo6oRIw2dkI6QGbyH0y/a53XlLXFFwcB34=;
        b=aIXm+SlsOKpZCEoj/7cLHerYh/Wt8DRdCuRM2R50rFD1Rfny+D4EKmAnC1+rp+0jq02BFI
        /KfNaSytc766zizjBBOAsdgFmO0pHkL4QsWU0G7oOt6XMFsYllUxvhX0w8WUFoXkNlwVI5
        DFrnoUUtYihiOzEpWYSKFgCAjZguidI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-6Z-wYCKXOtyZo0HUCDQJ2w-1; Tue, 26 Jan 2021 08:37:35 -0500
X-MC-Unique: 6Z-wYCKXOtyZo0HUCDQJ2w-1
Received: by mail-ed1-f72.google.com with SMTP id m16so9327483edd.21
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8TyWVTjlaOo6oRIw2dkI6QGbyH0y/a53XlLXFFwcB34=;
        b=pgU/Lcvs8nAPdzOYFD2yADardtrMbGhVZIcuqmwsltuYOcJFXY5UMAlobfBi52xHpt
         FwFQnwTDISmOLHJ+efKe/psxiL7H98klfB005nkJ7rHnDgJNdaIZUNrbhAjiQv0wbuzm
         48usoVMoOqFwPEl1QqO3gQHdyOp6k7bo8a3HcS/GAhC+MWRZxRoRjwimIaghWtLaa3vG
         WqVATYcgeRh58zhtZPnc5wtAguPIgNsiLbZBz9H99CvVnhRap4pCeqUrB9hvI4PQ31FS
         s/HgXX0U3FW/0q5p5hPQZmfL4LpcHfrp3P7x2XryYjYdp+BEz9QSoSpNa3VHNL116AzA
         VukA==
X-Gm-Message-State: AOAM5329a2ej9CKi+K6eiRzxIlxMNnrYBUt8OK908Qnek+BRRH+6hqM6
        wguGbof/ER3Lr+kt2rvn7DRQa3eIwhfoHoL03BXapwXiTFuE+8I/RFoMPty2Zt6CSnl6sSB6cTJ
        rHFwb5YRRJVSTtbgRH7oAfSkW
X-Received: by 2002:a17:907:9483:: with SMTP id dm3mr3437687ejc.120.1611668254633;
        Tue, 26 Jan 2021 05:37:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGyzK0fAsrFSstAx+t/GMMgs8MBxN3xGakklU4iQlGLozOsBNIZgExzL4/3isBPTc7H3Ke1w==
X-Received: by 2002:a17:907:9483:: with SMTP id dm3mr3437672ejc.120.1611668254470;
        Tue, 26 Jan 2021 05:37:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i15sm9866203ejj.28.2021.01.26.05.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 05:37:33 -0800 (PST)
Subject: Re: [PATCH 19/24] kvm: x86/mmu: Protect tdp_mmu_pages with a lock
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-20-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14147680-740d-6e7f-e00d-aa7698fd2ba6@redhat.com>
Date:   Tue, 26 Jan 2021 14:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112181041.356734-20-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 19:10, Ben Gardon wrote:
> +	 *  May be acquired under the MMU lock in read mode or non-overlapping
> +	 *  with the MMU lock.
> +	 */
> +	spinlock_t tdp_mmu_pages_lock;

Is this correct?  My understanding is that:

- you can take tdp_mmu_pages_lock from a shared MMU lock critical section

- you don't need to take tdp_mmu_pages_lock from an exclusive MMU lock 
critical section, because you can't be concurrent with a shared critical 
section

- but then, you can't take tdp_mmu_pages_lock outside the MMU lock, 
because you could have

    write_lock(mmu_lock)
                                      spin_lock(tdp_mmu_pages_lock)
    do tdp_mmu_pages_lock stuff  !!!  do tdp_mmu_pages_lock stuff
    write_unlock(mmu_lock)
                                      spin_unlock(tdp_mmu_pages_lock)

Paolo

