Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57B827D5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgI2SYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727605AbgI2SYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:24:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601403848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0D4KBdeUuvRAnC63+pSwTvaNI9ec0eOgL55xTD9Oy4=;
        b=bXhHcbmy9czn/Mx+HucdiKAMv+fJyd8Xdwi++9L51O0IJiWDaDaIQ4pQ2Et++fXl3AUKXm
        LinH+yl6qFESQTHKTitgRFBQActRINPKLfR+sDSfbszybVLmzkQWA5lMwS/25u5N7wwpYT
        GgJcUbj03Ik6uwmoVMkWwLGnri6vYoA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-PvLMQZ55NMGGqNTMoZwVkA-1; Tue, 29 Sep 2020 14:24:07 -0400
X-MC-Unique: PvLMQZ55NMGGqNTMoZwVkA-1
Received: by mail-wm1-f70.google.com with SMTP id 23so2022137wmk.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W0D4KBdeUuvRAnC63+pSwTvaNI9ec0eOgL55xTD9Oy4=;
        b=TogD+2tbBjr7BTZ052DjIinNWFRgaJX3xz3P0H8q3IuDJmIe/J+c9NLeFQyvEdEzEP
         Sx02MCTAk1QyXCDcU8ScyGdrGMCNkh4+VcoeNS29C7fgVeoA1qEljSRrBKnUgsdG3sMC
         +40yil9cHvxvj6TcceBQzIYEAMMBpsafHh5DO/oON6sYJTCAYnoKm+P/X1pM2ZCxedMF
         3BvA7zhzT+52UIaGe34IdSfqq2s4futc/8GCiK9+8hoKtk4zseWX6C82IFvt+7iuKi6P
         cKp7kVlJdgdcyrsRfPTRClaP9wxYV6pNa4quqww7FizJSXEbER008KWrl/7I+00TkMfq
         1ClA==
X-Gm-Message-State: AOAM530YAZc/cjojrvdpNKnxifTZmGuYEjVA1uaCEoBehDUeNMYocuLe
        ajd6jYQyrf+UaSOPMoH7DICnaX2k2XziNSIySxOp7+EHQAKDLLiEdy1f3N+leJz0Yk5jU+ojvu4
        ZRUwqcGwhT48kk3V8oOKWxxQl
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr6182743wmd.78.1601403845822;
        Tue, 29 Sep 2020 11:24:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl4Gxy9MKNRWrZ/3UbL0g+k1HsAv7oAxrL7Adf5VFPEq47gFKSxjs6VU8HPiyuAYm/s6DHdQ==
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr6182714wmd.78.1601403845596;
        Tue, 29 Sep 2020 11:24:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6? ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
        by smtp.gmail.com with ESMTPSA id y1sm6356454wma.36.2020.09.29.11.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 11:24:04 -0700 (PDT)
Subject: Re: [PATCH 20/22] kvm: mmu: NX largepage recovery for TDP MMU
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
 <20200925212302.3979661-21-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e19b77d8-26b3-2062-7c70-3f7280d277ad@redhat.com>
Date:   Tue, 29 Sep 2020 20:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-21-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:23, Ben Gardon wrote:
> +	struct list_head tdp_mmu_lpage_disallowed_pages;

This list is never INIT_LIST_HEAD-ed, but I see other issues if I do so
(or maybe it's just too late).

Paolo

> +	u64 tdp_mmu_lpage_disallowed_page_count;

