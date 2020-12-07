Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C279B2D11AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgLGNRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgLGNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607346980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79CDQSAGopTcyYZWDZiCTCDAaMDLvT94+iPcW3Ja/gg=;
        b=LvLi/A5dfoYuRJy3OAC9ysOWrhyr4fHfCqo32guSrmwZmFWor3q/a9dBulAxx8zMBNwoEG
        vA/AUpZJiFSlwVgxNCu81KgnxCTrAqmtzHjLJhrj0lqtN9Me7peTiJbOQbB0l0lvCboBp0
        0hORq99iT7V2NQD/YO6vcnG8d4M5wTQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-4CCZEyHhO--Qqu8pk6iT7A-1; Mon, 07 Dec 2020 08:16:18 -0500
X-MC-Unique: 4CCZEyHhO--Qqu8pk6iT7A-1
Received: by mail-ed1-f71.google.com with SMTP id f19so5748668edq.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 05:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=79CDQSAGopTcyYZWDZiCTCDAaMDLvT94+iPcW3Ja/gg=;
        b=jct09zsuTpbEGWWW3ViqHndn7T/ZYJx6sTQLN6Ehfn2D1jE/szkkml7bhULKqj+tq7
         Nc7Y2K0Q6QrY4ifPZYvTCcpsuPOLgfw7CEz93NSskV12RXYTT72PuiNdlWIc9fLTC0zi
         K03025JqiW2b5K/Zqci6wCwQrmrxZ78mIHqzRXEZNLyrbqqrwbM6B1l67pw1UQ+p42wZ
         t/feGI1Ehxa2BArV1d//nnmd5OLAuw6cAlVE9ni+OEc+kiTXwZI3fCiaL06c8tLEHsOW
         2MUnZ3GWa2Ksi8uamzefizPmsjoJPzGXj8KvKlHwjua13q6ctl1puyOhioXtrOiZKkAG
         FiEA==
X-Gm-Message-State: AOAM532jh/5hpwQeyWxykqZChTNJQ/0a2hR6lN4MTKDCZFHcdEXpvYz6
        SzBOzISvZB0qn2SANXXyGtOPYTfLqVvXnA1p8NzMFRS4+Us6qIRSfnE339WXDwEIUL7jIT28wN2
        my1SwVkFIO63bOyXdExgL3hDz
X-Received: by 2002:a50:ff0c:: with SMTP id a12mr19974973edu.79.1607346977395;
        Mon, 07 Dec 2020 05:16:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl7wJhrOzNS1+1ArDJ93sSPPCNdBbU63ASXPczoyfqdvj9aq9nJs+MSWplfTwlW8IubCCmHg==
X-Received: by 2002:a50:ff0c:: with SMTP id a12mr19974957edu.79.1607346977230;
        Mon, 07 Dec 2020 05:16:17 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x20sm12357813ejv.66.2020.12.07.05.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:16:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
 <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
Date:   Mon, 07 Dec 2020 14:16:15 +0100
Message-ID: <87im9dlpsw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

>
> But other than that I don't mind making TSC offset global per VM thing.
> Paulo, what do you think about this?
>

Not Paolo here but personally I'd very much prefer we go this route but
unsynchronized TSCs are, unfortunately, still a thing: I was observing
it on an AMD Epyc server just a couple years ago (cured with firmware
update). We try to catch such situation in KVM instead of blowing up but
this may still result in subtle bugs I believe. Maybe we would be better
off killing all VMs in case TSC ever gets unsynced (by default).

Another thing to this bucket is kvmclock which is currently per-cpu. If
we forbid TSC to un-synchronize (he-he), there is no point in doing
that. We can as well use e.g. Hyper-V TSC page method which is
per-VM. Creating another PV clock in KVM may be a hard sell as all
modern x86 CPUs support TSC scaling (in addition to TSC offsetting which
is there for a long time) and when it's there we don't really need a PV
clock to make migration possible.

-- 
Vitaly

