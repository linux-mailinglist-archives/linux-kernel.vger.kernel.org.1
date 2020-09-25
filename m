Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20E82792A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgIYUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIYUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:50:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601067012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3l0T9yYe9NbzcErpgFMneHQWiK+1fY8aylKjSft3rKY=;
        b=TnKCmjyPdzxlOt0L0JA86TbMx+uswrVWrgDKIppJ0YT1bmiwwneoY6DU3/1/MMTPHyZ79d
        zOnzv7fFpJsRUBkDXpdIbQk97K7O8W0TwfEPBDsLhUzNBIfFhziAbwRczuJuJEB9JpKql0
        m5ZB4BppaHgk+er8LQNIfOGW/CRbMhs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-JAvaKB9zPqOgTl5gdbUAsQ-1; Fri, 25 Sep 2020 16:50:11 -0400
X-MC-Unique: JAvaKB9zPqOgTl5gdbUAsQ-1
Received: by mail-wr1-f70.google.com with SMTP id a2so1540001wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3l0T9yYe9NbzcErpgFMneHQWiK+1fY8aylKjSft3rKY=;
        b=Jbz+VopJpi3OHHl0+0XhAT37CF341dCAiRGSl/mRjlSwSOm+sGXtVOKBd8gjdgHGr6
         gJQwoNCH4YviGVjPF0flt4z0P5Mzo4NQdyUw9fYC7y9HrmoCbonKf5x0brHOvZLg1qRA
         XpfenoSKXsgTrUZZ5ygDOJE+AKF98JSZRn8tLreWhq7heQidiLm7RSe2jbawQISXePYj
         uJkh2CHp6gNetAFp8Kl9TW+pCJAkwgwEyBEQzyRD9/z4sK7NUQ2RH6+3PQU9Jg/gXnPO
         wlfntKbLk01gg98GuoNrTd8a64jZ8jj+TxTGCgPgPKidmoZOdVo2KI5BUex5lRmhSHHW
         81jw==
X-Gm-Message-State: AOAM533XjJwimLI/pIA3bKVSYW7vQKVP9h4hdKIDV8kKDlhT9w/ySsdi
        kFp8i9lnjQIQtqWvhyk0O4xsrLRzDyzt75zt7/x/l+fq+/PhEvlg91HeV0B65H2DCnmAlqToB94
        Y1FarLbo2Zm/HR40+IS7edmup
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr374308wmo.183.1601067009867;
        Fri, 25 Sep 2020 13:50:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfBcvAqg33MQmqXRG0Dwa2ylGBcgivLaNHVhiSo9+k0jrr1zvmMT9x6crZ2aT1sUIBeAOSRg==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr374277wmo.183.1601067009627;
        Fri, 25 Sep 2020 13:50:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id d19sm237257wmd.0.2020.09.25.13.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 13:50:08 -0700 (PDT)
Subject: Re: [RFC V2 0/9] x86/mmu:Introduce parallel memory virtualization to
 boost performance
To:     Ben Gardon <bgardon@google.com>,
        yulei zhang <yulei.kernel@gmail.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>
References: <cover.1598868203.git.yulei.kernel@gmail.com>
 <CANRm+CwhTVHXOV6HzawHS5E_ELA3nEw0AxY1-w8vX=EsADWGSw@mail.gmail.com>
 <CANRm+CydqYmVbYz2pkT28wjKFS4AvmZ_iS4Sn1rnHT6G1S_=Mw@mail.gmail.com>
 <CANgfPd8uvkYyHLJh60vSKp1ZDi9T0ZWM9SeXEUm-1da+DqxTEQ@mail.gmail.com>
 <CACZOiM1JTX3w567dzThM-nPUrUksPnxks4goafoALDq1z_iNsw@mail.gmail.com>
 <CANgfPd-ZRW676grgOmm2E2+_RtFaiJfspnKseHMKgsHGfepmig@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2592097d-3190-1862-b438-9e1b16616b82@redhat.com>
Date:   Fri, 25 Sep 2020 22:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd-ZRW676grgOmm2E2+_RtFaiJfspnKseHMKgsHGfepmig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 19:30, Ben Gardon wrote:
> Oh, thank you for explaining that. I didn't realize the goal here was
> to improve LM performance. I was under the impression that this was to
> give VMs a better experience on startup for fast scaling or something.
> In your testing with live migration how has this affected the
> distribution of time between the phases of live migration? Just for
> terminology (since I'm not sure how standard it is across the
> industry) I think of a live migration as consisting of 3 stages:
> precopy, blackout, and postcopy. In precopy we're tracking the VM's
> working set via dirty logging and sending the contents of its memory
> to the target host. In blackout we pause the vCPUs on the source, copy
> minimal data to the target, and resume the vCPUs on the target. In
> postcopy we may still have some pages that have not been copied to the
> target and so request those in response to vCPU page faults via user
> fault fd or some other mechanism.
> 
> Does EPT pre-population preclude the use of a postcopy phase?

I think so.

As a quick recap, turn postcopy migration handles two kinds of
pages---they can be copied to the destination either in background
(stuff that was dirty when userspace decided to transition to the
blackout phase) or on-demand (relayed from KVM to userspace via
get_user_pages and userfaultfd).  Normally only on-demand pages would be
served through userfaultfd, while with prepopulation every missing page
would be faulted in from the kernel through userfaultfd.  In practice
this would just extend the blackout phase.

Paolo

> I would
> expect that to make the blackout phase really long. Has that not been
> a problem for you?
> 
> I love the idea of partial EPT pre-population during precopy if you
> could still handle postcopy and just pre-populate as memory came in.
> 

