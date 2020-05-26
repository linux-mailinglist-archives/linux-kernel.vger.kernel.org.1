Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63BC1C7410
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgEFPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:18:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728959AbgEFPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588778282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnWUJGShEIEC2tJse85xpWYQfdXH3V6xxIKOsonZhS0=;
        b=ho47/w1sU08DqwsuLcJXRfABjRhfluifDNroByqLZvSjcaEw6WNgWIiUIEhbcn5eeouXT/
        3dpLVjANJm79azzfnR8k3R+bTOaT+593WoAutWZnfaUnB1k//tHztWJLeHvKaBsAiIXpiu
        lxJjRzPbxDmeaq4RWvaGIM7JI30XqHQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-5LFQ3VMzNrSIqs2PC4UEsw-1; Wed, 06 May 2020 11:18:01 -0400
X-MC-Unique: 5LFQ3VMzNrSIqs2PC4UEsw-1
Received: by mail-wr1-f72.google.com with SMTP id x8so1477827wrl.16
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lnWUJGShEIEC2tJse85xpWYQfdXH3V6xxIKOsonZhS0=;
        b=TMLzQEFVMJdu917vPMiI+m4hS2ShpkWAZpusA9NRzgHNnqoBj5vlU7icVseKMLSSrn
         7j7xneoVyOeORWhHduqdc9XYTQLAXXquMF/ABWaDD1nm+yxyDr1KReiXRMQHNIBsQuA0
         UpncyNImTeH9SBJg0AhwM6UQvI2lhkVL7Ert6uKEEjrBd8P5lnRBUkTomU57LXnhVTTG
         6v2rjPsfBhj3Q0m60PJ8jwhyUXSVRrCIeehwHhHMZVyO7Pqi0PZEWTA/kt8i5Sl3yZx/
         QZvc0Us7bYvvfN16vdLqwvc6JJDmveZ3YaUkjCTRXKBsYOsqugcVfUCEUwZyzvrsY76c
         x7Pw==
X-Gm-Message-State: AGi0PuY35tw7CZ7EafAnk/SvZFJIMkcUaEB1mtqPxovswcCwmaygzSgh
        b7eBn4S/6++kIZUap1qi9OCVw/dVzPVbIFdVZ+BIYKHFlXNlZMjaPV1dOi/otjdWbOFRUwR4MOr
        okl42gXo4X308weYpVWtmUN6m
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr5415360wmb.156.1588778280030;
        Wed, 06 May 2020 08:18:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypI4RpVdj46m5iqEv5/myfvTamsIAlmjdwYjSFRnScWUzUxtCUGtLP7QamnKNwjG9lTJmTreBw==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr5415334wmb.156.1588778279741;
        Wed, 06 May 2020 08:17:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n12sm3452451wrj.95.2020.05.06.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:17:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 1/6] Revert "KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Ready" exceptions simultaneously"
In-Reply-To: <20200505141603.GA7155@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-2-vkuznets@redhat.com> <20200505141603.GA7155@redhat.com>
Date:   Wed, 06 May 2020 17:17:57 +0200
Message-ID: <87y2q5ay8q.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Wed, Apr 29, 2020 at 11:36:29AM +0200, Vitaly Kuznetsov wrote:
>> Commit 9a6e7c39810e (""KVM: async_pf: Fix #DF due to inject "Page not
>> Present" and "Page Ready" exceptions simultaneously") added a protection
>> against 'page ready' notification coming before 'page not ready' is
>> delivered.
>
> Hi Vitaly,
>
> Description of the commit seems to suggest that it is solving double
> fault issue. That is both "page not present" and "page ready" exceptions
> got queued and on next vcpu entry, it will result in double fault.
>
> It does not seem to solve the issue of "page not ready" being delivered
> before "page ready". That guest can handle already and its not an issue.
>
>> This situation seems to be impossible since commit 2a266f23550b
>> ("KVM MMU: check pending exception before injecting APF) which added
>> 'vcpu->arch.exception.pending' check to kvm_can_do_async_pf.
>
> This original commit description is confusing too. It says.
>
> "For example, when two APF's for page ready happen after one exit and
>  the first one becomes pending, the second one will result in #DF.
>  Instead, just handle the second page fault synchronously."
>
> So it seems to be trying to protect against that two "page ready"
> exceptions don't get queued simultaneously. But you can't fall back
> to synchronous mechanism once you have started the async pf prototocol.
> Once you have started async page fault protocol by sending "page not
> reay", you have to send "page ready". So I am not sure how above commit
> solved the issue of two "page ready" not being queued at the same time.
>
> I am wondering what problem did this commit solve. It looks like it
> can avoid queueing two "page not ready" events. But can that even happen?
>
>> 
>> On x86, kvm_arch_async_page_present() has only one call site:
>> kvm_check_async_pf_completion() loop and we only enter the loop when
>> kvm_arch_can_inject_async_page_present(vcpu) which when async pf msr
>> is enabled, translates into kvm_can_do_async_pf().
>
> kvm_check_async_pf_completion() skips injecting "page ready" if fault
> can't be injected now. Does that mean we leave it queued and it will
> be injected after next exit.
>
> If yes, then previous commit kind of makes sense. When it will not
> queue up two exceptions at the same time but will wait for queuing
> up the exception after next exit. But commit description still seems
> to be wrong in the sense it is not falling back to synchronous page
> fault for "page ready" events.

As I'll be dropping 'page ready' event delivery via #PF this doesn't
really matter much but after staring at the code for a while I managed
to convince myself that this particular code patch is just unreachable.
I don't think we can get #DF now with two 'page not ready' exceptions,
kvm_can_do_async_pf() should now allow that.

>
> try_async_pf() also calls kvm_can_do_async_pf(). And IIUC, it will
> fall back to synchrounous fault if injecting async_pf is not possible
> at this point of time. So that means despite the fact that async pf
> is enabled, all the page faults might not take that route and some
> will fall back to synchrounous faults. 

This sounds correct.

> I am concerned that how will
> this work for reporting errors back to guest (for virtiofs use case).
> If we are relying on async pf mechanism to also be able to report
> errors back, then we can't afford to do synchrounous page faults becase
> we don't have a way to report errors back to guest and it will hang (if
> page can't be faulted in).

Currently, if 'page not ready' event was delivered then we can't skip
'page ready' event, we'll have to deliver it. 'Page not ready' is still
going to be delivered as exception and unless we really need to solve
complex problems like delivering nested exception this should work.

>
> So either we need a way to report errors back while doing synchrounous
> page faults or we can't fall back to synchorounous page faults while
> async page faults are enabled.
>
> While we are reworking async page mechanism, want to make sure that
> error reporting part has been taken care of as part of design. Don't
> want to be dealing with it after the fact.

The main issue I'm seeing here is that we'll need to deliver these
errors 'right now' and not some time later. Generally, exceptions
(e.g. #VE) should work but there are some corner cases, I remember Paolo
and Andy discussing these (just hoping they'll jump in with their
conclusions :-). If we somehow manage to exclude interrupts-disabled
context from our scope we should be good, I don't see reasons to skip
delivering #VE there.

For the part this series touches, "page ready" notifications, we don't
skip them but at the same time there is no timely delivery guarantee, we
just queue an interrupt. I'm not sure you'll need these for virtio-fs
though.

Thanks for the feedback!

-- 
Vitaly

