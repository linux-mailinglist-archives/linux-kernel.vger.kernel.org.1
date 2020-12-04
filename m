Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E862CE990
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgLDI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728067AbgLDI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607070454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9Y6WzFRcgbtIi5LBno88YZfeKK7F+ba+sYdLaKYH9w=;
        b=Gg62bac1lWY9C3nvr1LFQkHRGjzBAKmpYjCuFkyRrbjzmO3uFwoH59bMyTpo4oWUwr+dSi
        WxsaxdpEeJhJDagllXhg4XIEm+M/Lyl9Gjr9sAszWEHm0rf6NFDvspz6YrNy3Gmz4AJY9o
        jVEG81aLGyknba9tOFPv4vnyheAcYAc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-ymZuN-dEO_2kCSJCDgX41g-1; Fri, 04 Dec 2020 03:27:32 -0500
X-MC-Unique: ymZuN-dEO_2kCSJCDgX41g-1
Received: by mail-ej1-f72.google.com with SMTP id t17so1805150ejd.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9Y6WzFRcgbtIi5LBno88YZfeKK7F+ba+sYdLaKYH9w=;
        b=Lg1K7WuDXZOiuBK+yjkYt74yh9ysjuYK5XafDmhjmyObnwb31M/rzwOWmncYDdY1Hc
         igUzaMg10mrPQ/A2PeNz0bMxwr4ZDZjG4VdwicjOv6z6CmW706bh+J4rMwPaWXswjJtT
         SpYfltKKsJsNYq7pQr58lbmrLBB7dCp1Qm1YOAA6wA0RhGQE34ZWrx9zcUtIoRjZIYQs
         8/MEEUQS4KvwhkVcKRUcjmN7oV2A4ftouVJnNKeYoRdSbKZoRnANpLTK9ZKQGs001T0M
         AO7pUa5HBVBSrrsKZlFFtZzfV/E9sGD4EDS49A7jk+Z4bJiU5Xg7fJnqsXTxO+Ish127
         mzKQ==
X-Gm-Message-State: AOAM531124lRNZZMwGw2uBZjlETt6s4hen+iYBUcua0/E5Q15LBJr2mW
        V9X56w+buVvScnsyj1De9jhnvJmj7khUaAYf9xL+Nz67eIz5cftPX1R7aapHLW09489Hrhtutnj
        BwuFnqgA4VcHvu7B9mSuqhPvX
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr6573309edl.18.1607070451482;
        Fri, 04 Dec 2020 00:27:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMIyz5LS2iwvNf1iWyhuXSvOdoCaeoLpxIQO9KF7bm/bHa+j5UQfAthZzEj17BWx0cIuFxUQ==
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr6573281edl.18.1607070451200;
        Fri, 04 Dec 2020 00:27:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dh23sm1155140edb.15.2020.12.04.00.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 00:27:30 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To:     Sasha Levin <sashal@kernel.org>
Cc:     Mike Christie <michael.christie@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <20201130173832.GR643756@sasha-vm>
 <238cbdd1-dabc-d1c1-cff8-c9604a0c9b95@redhat.com>
 <9ec7dff6-d679-ce19-5e77-f7bcb5a63442@oracle.com>
 <4c1b2bc7-cf50-4dcd-bfd4-be07e515de2a@redhat.com>
 <20201130235959.GS643756@sasha-vm>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c49ded5-bd8f-f219-0c51-3500fd751633@redhat.com>
Date:   Fri, 4 Dec 2020 09:27:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130235959.GS643756@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/20 00:59, Sasha Levin wrote:
> 
> It's quite easy to NAK a patch too, just reply saying "no" and it'll be
> dropped (just like this patch was dropped right after your first reply)
> so the burden on maintainers is minimal.

The maintainers are _already_ marking patches with "Cc: stable".  That 
(plus backports) is where the burden on maintainers should start and 
end.  I don't see the need to second guess them.

Paolo

