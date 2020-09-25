Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E3279382
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgIYV1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbgIYV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:27:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601069239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Crsf2R3bRQc61jKhJAw3eZBcV4hzI60OjtOCQ7XYP9o=;
        b=MyLFe0AYVN0iR8emb38FywsmelMoo6ONsLJvmfAI7HJZhgmFy9GObwwobf1RhI3PLWj0A9
        tK3pUBtCcq3agGacjjxXmOZI1HCgJpz7U/MQ8ZqAtJzrjOXUr2WXHnjsy+YsYy1cKyYxtc
        SPtqehUOfVnCIEvaym5UP3RfWBbhR/A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-JQ6vt7dgPlSou-vfVQOyvg-1; Fri, 25 Sep 2020 17:27:17 -0400
X-MC-Unique: JQ6vt7dgPlSou-vfVQOyvg-1
Received: by mail-wr1-f72.google.com with SMTP id d9so1576545wrv.16
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Crsf2R3bRQc61jKhJAw3eZBcV4hzI60OjtOCQ7XYP9o=;
        b=eWIUZ1Zlz16MCAQh5XllE6/TEgTKW3zP2tcN1KL0sdfIP3SJI9UfFgT0ytaKaq3LvL
         +TRtCGjW0Qus6rYPMg6lzenQ+t9g7l+JgZi7k8fT9FUk196MYeSX+gvphV+0La4nSIDe
         PgYDzYM5+IekuxDrECtMV9f7EdUKnC4rEx91bnEitZxWeU22rlCc32Vq3JsRR7oUykfG
         P2uG2DEneonqDmGEtXnmA8UYgeJK3XTyHt2txxLf/8tNYVXmnaPD11g/sKVrW+eHHvQ8
         qEWmOqUIZ5DIuzjvZOjzgaZUmRIWqVq87RlmjMyvK2r301B6ZxhWGiUh98/bVxLcJDwz
         X3bA==
X-Gm-Message-State: AOAM5336no4LEh9gXFFy1WBo8lyqcqgAwqYogATWbMakCUtUniWBvTo+
        UQIfwZvde6QzuLk+872W1cTvng5JDFXpzLKiITc9iqy+8aZz6bUnMXuWIokDOqj3TqrnZgtMahJ
        NZoDI7h9Z1hulNHFfC/xMH/tw
X-Received: by 2002:adf:a3d8:: with SMTP id m24mr6401550wrb.418.1601069236689;
        Fri, 25 Sep 2020 14:27:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuBlTyhSiYV/dtPoa3ATjzVdo6sgCILiYSckf+ulxIpNspAHF6jpGisrFeK1f9TIeGIslOiQ==
X-Received: by 2002:adf:a3d8:: with SMTP id m24mr6401531wrb.418.1601069236475;
        Fri, 25 Sep 2020 14:27:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id v2sm4072448wrm.16.2020.09.25.14.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 14:27:15 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] KVM: x86/mmu: ITLB multi-hit workaround fixes
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junaid Shahid <junaids@google.com>
References: <20200923183735.584-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4eec29f9-def0-3292-4a88-1f6ff3e06b5e@redhat.com>
Date:   Fri, 25 Sep 2020 23:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923183735.584-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 20:37, Sean Christopherson wrote:
> Patch 1 is a minor fix for a very theoretical bug where KVM could skip
> the final "commit zap" when recovering shadow pages for the NX huge
> page mitigation.
> 
> Patch 2 is cleanup that's made possible by patch 1.
> 
> Patches 3-5 are the main course and fix bugs in the NX huge page
> accounting where shadow pages are incorrectly added to the list of
> disallowed huge pages.  KVM doesn't actually check to see if the page
> could actually have been a large page when adding to the disallowed list.
> This result in what are effectively spurious zaps.  The biggest issue is
> likely with shadow pages in the upper levels, i.e. levels 3 and 4, as they
> are either unlikely to be huge (1gb) or flat out can't be huge (512tb).
> And because of the way KVM zaps, the upper levels will be zapped first,
> i.e. KVM is likely zapping and rebuilding a decent number of its shadow
> pages for zero benefit.
> 
> Ideally, patches 3-5 would be a single patch to ease backporting.  In the
> end, I decided the change is probably not suitable for stable as at worst
> it creates an infrequent performance spike (assuming the admin isn't going
> crazy with the recovery frequency), and it's far from straightforward or
> risk free.  Cramming everything into a single patch was a mess.
> 
> Patches 6-8 are cleanups in related code.  The 'hlevel' name in particular
> has been on my todo list for a while.
> 
> v2:
>   - Rebased to kvm/queue, commit e1ba1a15af73 ("KVM: SVM: Enable INVPCID
>     feature on AMD").
> 
> Sean Christopherson (8):
>   KVM: x86/mmu: Commit zap of remaining invalid pages when recovering
>     lpages
>   KVM: x86/mmu: Refactor the zap loop for recovering NX lpages
>   KVM: x86/mmu: Move "huge page disallowed" calculation into mapping
>     helpers
>   KVM: x86/mmu: Capture requested page level before NX huge page
>     workaround
>   KVM: x86/mmu: Account NX huge page disallowed iff huge page was
>     requested
>   KVM: x86/mmu: Rename 'hlevel' to 'level' in FNAME(fetch)
>   KVM: x86/mmu: Hoist ITLB multi-hit workaround check up a level
>   KVM: x86/mmu: Track write/user faults using bools
> 
>  arch/x86/kvm/mmu/mmu.c         | 58 +++++++++++++++++++++-------------
>  arch/x86/kvm/mmu/paging_tmpl.h | 39 ++++++++++++-----------
>  2 files changed, 57 insertions(+), 40 deletions(-)
> 

Queued, thanks.

Paolo

