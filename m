Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2427955A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIZAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729426AbgIZAGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:06:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601078776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lr4vbSW2IrU7YXNvvxdULdw0XL39ouWApcz+hc4IwGY=;
        b=Bi5L1tWrTwi0F5fDJz5ums5nt9LXyq/UTazCWuz1gUaAFRJteD4eJnoJ6Nk4QQmd2ooMPv
        jh8xBUSeUQMrbne3KLT+NbLeROkCzX9Gq8vkgxG3w7Pt/upbHBIOkWIN1CnkGWtQ21P8B7
        KQd7TaXRT2ci0JuYojM+HsuTbdSfvyg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-zTIF9AVDNpWtomc0hNha_A-1; Fri, 25 Sep 2020 20:06:15 -0400
X-MC-Unique: zTIF9AVDNpWtomc0hNha_A-1
Received: by mail-wr1-f70.google.com with SMTP id d13so1691775wrr.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lr4vbSW2IrU7YXNvvxdULdw0XL39ouWApcz+hc4IwGY=;
        b=QUkUnL+WRRr4D97YzcimLDdk6vtJ4yrzdxLcoEV5FeLOMwcj5qU+aYtYKNd3oQaIG+
         vVzEHERkOCKoUxrwfck/z/mIsqYyd8e9Hq1POMY+H/9B4n4Y5EFraYRq2ytJNe410LLS
         S2C4H2Fc/Tlm55BVFsl4qckhIQUio7cDadfEUW/TYnc1cget8dELqPQkY85GgGfBqIiE
         VeJP75Ac0bGi80OW0NSUE3H+zzkwhkB7scZ3JO0yWAW0mY4PtdpwQWCDsudNIHtfPmMA
         jGnI4j9md30wI7jETlEcYdJGL4TQIpvU3DpH1Co3McoxzMDcymEOwJ6oP32Tfq8GC4Yl
         gXYA==
X-Gm-Message-State: AOAM532+9++Ps1CLqEz+LNAi4v8fv/UqMcxQjkHgMg7/RuCDZxgbLXxp
        5AylFKZM+WAH/Uk6/MeGQDIqihTjPPtf/Ab+8AuJ29eXvkxFnPi2Z4Kddr0Iz0riKFrYcyxzJrv
        TMKtH9jLEHzSsPdvuBE6J1aan
X-Received: by 2002:adf:fa02:: with SMTP id m2mr6812356wrr.273.1601078773691;
        Fri, 25 Sep 2020 17:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaa34YmgMwKOPjOfXUAohWrRIyHfLKN5vteiY20bqkr8oDd5O0O/4vWVwGsXKBL2VSp9N5WQ==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr6812338wrr.273.1601078773469;
        Fri, 25 Sep 2020 17:06:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id u63sm681508wmb.13.2020.09.25.17.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 17:06:12 -0700 (PDT)
Subject: Re: [PATCH 03/22] kvm: mmu: Init / Uninit the TDP MMU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-4-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22ffacb6-7040-1869-0c69-3d99f2f1e044@redhat.com>
Date:   Sat, 26 Sep 2020 02:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-4-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
> +static bool __read_mostly tdp_mmu_enabled = true;
> +module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
> +

This would need some custom callbacks to avoid the warning in
is_tdp_mmu_enabled().

Paolo

