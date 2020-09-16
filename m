Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE526BE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIPHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgIPHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600242302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76Bg72r+p2k9IbrpPzmK8vSWwjQMu3f6+BQBefJMooI=;
        b=hJVqQNKLXlJG59WQ8DIloHugEiAaJ7ZTvY9WWanZgQG2d+4hkKTzkBT0JJzQGuTasCC7yi
        MwPeg16MdKdv6uGG51s7L0ZDwTBZ2tILO2t0Ui+CcVNXtyEx7c5fEHZMSAxQIRtjUEkXwe
        eMBN3iDeP6gQBoCJcoBKcLqL5FVkC8U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-OmJtXqokML-pa8glkHVIEA-1; Wed, 16 Sep 2020 03:45:00 -0400
X-MC-Unique: OmJtXqokML-pa8glkHVIEA-1
Received: by mail-wr1-f72.google.com with SMTP id o6so2215222wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=76Bg72r+p2k9IbrpPzmK8vSWwjQMu3f6+BQBefJMooI=;
        b=RKADLBAfLQjy6b1SB1a8klJw4R0sgBPv8ptdHQIUOfSrFT8dhW5riY+GJKZWoKcBq/
         pKwx0G+BvWMlYgvexpNPfgNUXDmb4W+Ia4BZGO9y00nFQEJKdJ96Okg1C5Bjz2EebiUy
         a6iiD+4nXDXN06V/fsyv9fezMhjc/ANNtXkp7hKZHb3uj66NwfeN3LdO4wShiUlH0l72
         4GmkNsxX5CqLLuwtj4dL3IXHqrAnAWUASVMPbBgsxrAyitq6rz4R8cqJxZmkW6qqxCuK
         RTbW7ZFihVSOh1WIs27HLuuXbGoRN7Sk2Awi9pPLocGFNQCyAoFu5n62sOfJRQ1jbIcF
         zGdA==
X-Gm-Message-State: AOAM532vlf8m6mIXsDllI7aLoaJj9GUt1cS0rz03OOC1Kj+8NiJJQvcn
        LRDuV8J7F4/fdL8MFHE1vipwyzNPXYDDjz/LRxDoeYkAEmUS66ar2zlBvVGJE0EjkLah0R6P9QY
        PM34LeORDMpN+v0jQLryS9VjB
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr24488481wrp.286.1600242298766;
        Wed, 16 Sep 2020 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsgIFXCA27c2dR/aCnezA+DSHlWHcYyw+U3VYecZmYQdFB52Dpqfdp2DqjmjEACv3IRl6R3Q==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr24488461wrp.286.1600242298564;
        Wed, 16 Sep 2020 00:44:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h186sm3815236wmf.24.2020.09.16.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 00:44:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Huang <wei.huang2@amd.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, Wei Huang <whuang2@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] KVM: x86: allow for more CPUID entries
In-Reply-To: <20200916034905.GA508748@weilap>
References: <20200915154306.724953-1-vkuznets@redhat.com> <20200915165131.GC2922@work-vm> <20200916034905.GA508748@weilap>
Date:   Wed, 16 Sep 2020 09:44:55 +0200
Message-ID: <87k0wui2rs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Huang <wei.huang2@amd.com> writes:

> On 09/15 05:51, Dr. David Alan Gilbert wrote:
>> * Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
>> > With QEMU and newer AMD CPUs (namely: Epyc 'Rome') the current limit for
>
> Could you elaborate on this limit? On Rome, I counted ~35 CPUID functions which
> include Fn0000_xxxx, Fn4000_xxxx and Fn8000_xxxx.

Some CPUID functions have indicies (e.g. 0x00000004, 0x8000001d, ...)
and each existing index requires a separate entry. E.g. on my AMD EPYC
7401P host I can see:

# cpuid -r -1 | wc -l
53

Hyper-V emulation accounts for 11 leaves (we don't currently set them
all in QEMU but eventually we will). Also, we sometimes set both Intel
and AMD cpuid leaves in QEMU (David can probably elaborate on which/why)
and this all adds up. '80' seems to be an easy target to hit even with
existing CPUs :-)

-- 
Vitaly

