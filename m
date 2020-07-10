Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2429721BBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGJRNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJRNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:13:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778FC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:13:19 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a6so5651801ilq.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84ZXCV8hDQ+R5ezHGlVeKRrDnq+BIKMBqF4O35I2mAU=;
        b=uXRgs8RXS68b0Quf5QIP7lY7g8JASh2hxqEYYRrQeMoIGtj9erXk5JTXrFVc6cFhyr
         bG1/VNQVX9SeKZvwO0E5XiApXK7A5wmbjBDhXvBFfah+DKBdg1KxeAeS5ihfy8M6F+Uj
         Oj/Ax225XjIZ+NeX7sgaKdlOYfov+ZZh+RHNd71U6LWc6Ysql3GrCDci50+q3cnR4Xa9
         6QKuV7m2//VmHl/sZ7UYy0YYpZZtmUFNMVLwZ0I0WQfROWKprUXb0gtaeFvUyV5wIZrx
         v4OjT3xJta1onx8eUwTX7N9vq0bJwF/RoYaP6As9k7AhiYr6YgcBn2Gb9Z3GYtbeS5Qs
         leLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84ZXCV8hDQ+R5ezHGlVeKRrDnq+BIKMBqF4O35I2mAU=;
        b=sZwozw9D241oJ7c+/940LFvzfDFaRfBm51aG3NvXFCk31Frrn/jvKD4OnfHBW5Cn06
         JGyJdOtkl1JDdlkxeteOlStI/jNiUgaz5LIKUog6Lm6dSG0w4kiloSRJxDptJpgsBNQ8
         exH7JpI6iLPxKlQBhEs00/LcxKwhtFBJ0pZC4EJXDFbZG5l5fMZFWza8XvL1LuUmGxA7
         BIPQ3g5WrD6Szoj/Mgy6MkHQHEsCOIh13NBEF+6V9TIIWspnB5BsRRFDAbQQ2pGPS/4E
         mVKHEu6AbaoKDjd5215RiYw1zvN16dFon9KTeGlzqVqymK9nU3T/B6yMcbkmKYPtUVSR
         56eA==
X-Gm-Message-State: AOAM5339f0hWP4xPIGuSAN5UUCP/isxhc4KAL4ohxUDWp2SAV3DdfX7S
        +w20ChESWAxV8WHbeUiOrNvduMPi+sYlzIlaWchcmw==
X-Google-Smtp-Source: ABdhPJwBA5AirBckpFqBud4uPWIU+hnJlSHn3ByjqzmJ47BokabuqeNOCy1OQrj33SMvU88+SIo9y9H1TzuxucnwE7o=
X-Received: by 2002:a92:b60a:: with SMTP id s10mr49715934ili.119.1594401198223;
 Fri, 10 Jul 2020 10:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <CALMp9eRfZ50iyrED0-LU75VWhHu_kVoB2Qw55VzEFzZ=0QCGow@mail.gmail.com>
 <0c892b1e-6fe6-2aa7-602e-f5fadc54c257@redhat.com>
In-Reply-To: <0c892b1e-6fe6-2aa7-602e-f5fadc54c257@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Jul 2020 10:13:07 -0700
Message-ID: <CALMp9eQXHGnXo4ACX2-qYww4XdRODMn-O6CAvhupib67Li9S2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:06 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/07/20 18:30, Jim Mattson wrote:
> >>
> >> This can be problem when having a mixed setup of machines with 5-level page
> >> tables and machines with 4-level page tables, as live migration can change
> >> MAXPHYADDR while the guest runs, which can theoretically introduce bugs.
> >
> > Huh? Changing MAXPHYADDR while the guest runs should be illegal. Or
> > have I missed some peculiarity of LA57 that makes MAXPHYADDR a dynamic
> > CPUID information field?
>
> Changing _host_ MAXPHYADDR while the guest runs, such as if you migrate
> from a host-maxphyaddr==46 to a host-maxphyaddr==52 machine (while
> keeping guest-maxphyaddr==46).

Ah, but what does that have to do with LA57?
