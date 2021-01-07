Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72B2ED58C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbhAGR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbhAGR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:27:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209FC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:26:33 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i7so5398243pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6lWkPYmqT0bK/p92szu7J/reIaTk7BKnOinjKdXvDN8=;
        b=H58Wk18/UoqqmlC3FTHkIhsh5gQb7JOahE4qtlxf2WAsFOWRKSWzfyzBQUG4a1T4Xr
         NIvrYLeLcsaP/9EJtK6gnVr4ygLmGlPWDKCCijCB0Cc1SKVu6GS4QvJHE/KXSfLxu0zW
         TlEhQ3AvR+4kpFRhII6qUaLoipkhhQy03/rtDmPoQq+MqYWvdJf7NtyQP1nHw7NzY+cM
         iV4tiF+t5aGrrOEdbCYSS3YoakbJVvD0mw8IQLQ9I8upo81SZmJ9/N55LOwrwJ1nC3HV
         KZd9PUL73CyNUCwYGDFMTdoDKtUto+iWIezfC9NJtUlfqBNHCr4yZeojX9xaZP+xNBQG
         OwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6lWkPYmqT0bK/p92szu7J/reIaTk7BKnOinjKdXvDN8=;
        b=pZEOHvEkEq6eRVAzeQqf18VFI69OsoZEyZ3YzsNfl/z5mIPqJTKqxMAMtfIpOKfr48
         fN0ykKRX5DdWQL+QdzHyEytyagEAYLJFIBOe6yfoZFGKZcTGeu6P/nVXitVhA7atXSMq
         YPTQ5V4r/h7slgGopxF/DMhzTV4d4XU8kyZRdI6d49VNqHXw1PPUnUTBpyNdkXgr01cw
         hKzX9VBimMaFqG+azUPLIOan+Uj1ry5+UftKsZpAsJPNE5Rr95Iqrghei+Tz6jmTkkK0
         rdndUGPs5lV4lKp6Si4Wu5SinGum9GgwjddLWu1zfPDOkYcnzJHJQydAHrZ0v2sKhAQC
         S5+A==
X-Gm-Message-State: AOAM530gVBbRXBmHp/mI+fQw94oIRoBZOby2CXw9YGguRMQr+9BFuIP4
        EN4zUUVbfP4sWFma6Hk5YBm2RA==
X-Google-Smtp-Source: ABdhPJw/q/FMr9jxp6eEm5Nw6T0uz/rVWWCYZLX+6kNy8PPMligfp/kv10WzO7sQoFhXVM51+CcjMw==
X-Received: by 2002:a63:7402:: with SMTP id p2mr2866216pgc.101.1610040393358;
        Thu, 07 Jan 2021 09:26:33 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id z5sm6581160pff.44.2021.01.07.09.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 09:26:32 -0800 (PST)
Date:   Thu, 7 Jan 2021 09:26:25 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Steve Rutherford <srutherford@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dovmurik@linux.vnet.ibm.com" <dovmurik@linux.vnet.ibm.com>,
        "tobin@ibm.com" <tobin@ibm.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "frankeh@us.ibm.com" <frankeh@us.ibm.com>, jon.grimm@amd.com
Subject: Re: [PATCH v2 1/9] KVM: x86: Add AMD SEV specific Hypercall3
Message-ID: <X/dEQRZpSb+oQloX@google.com>
References: <CABayD+esy0yeKi9W3wQw+ou4y4840LPCwd-PHhN1J6Uh_fvSjA@mail.gmail.com>
 <765f86ae-7c68-6722-c6e0-c6150ce69e59@amd.com>
 <20201211225542.GA30409@ashkalra_ubuntu_server>
 <20201212045603.GA27415@ashkalra_ubuntu_server>
 <20201218193956.GJ2956@work-vm>
 <E79E09A2-F314-4B59-B7AE-07B1D422DF2B@amd.com>
 <20201218195641.GL2956@work-vm>
 <20210106230555.GA13999@ashkalra_ubuntu_server>
 <CABayD+dQwaeCnr5_+DUpvbQ42O6cZBMO79pEEzi5WXPO=NH3iA@mail.gmail.com>
 <20210107170728.GA16965@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107170728.GA16965@ashkalra_ubuntu_server>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021, Ashish Kalra wrote:
> Hello Steve,
> 
> On Wed, Jan 06, 2021 at 05:01:33PM -0800, Steve Rutherford wrote:
> > Avoiding an rbtree for such a small (but unstable) list seems correct.
> > 
> > For the unencrypted region list strategy, the only questions that I
> > have are fairly secondary.
> > - How should the kernel upper bound the size of the list in the face
> > of malicious guests, but still support large guests? (Something
> > similar to the size provided in the bitmap API would work).
> 
> I am thinking of another scenario, where a malicious guest can make
> infinite/repetetive hypercalls and DOS attack the host. 
> 
> But probably this is a more generic issue, this can be done by any guest
> and under any hypervisor, i don't know what kind of mitigations exist
> for such a scenario ?
> 
> Potentially, the guest memory donation model can handle such an attack,
> because in this model, the hypervisor will expect only one hypercall,
> any repetetive hypercalls can make the hypervisor disable the guest ?

KVM doesn't need to explicitly bound its tracking structures, it just needs to
use GFP_KERNEL_ACCOUNT when allocating kernel memory for the structures so that
the memory will be accounted to the task/process/VM.  Shadow MMU pages are the
only exception that comes to mind; they're still accounted properly, but KVM
also explicitly limits them for a variety of reasons.

The size of the list will naturally be bounded by the size of the guest; and
assuming KVM proactively merges adjancent regions, that upper bound is probably
reasonably low compared to other allocations, e.g. the aforementioned MMU pages.

And, using a list means a malicious guest will get automatically throttled as
the latency of walking the list (to merge/delete existing entries) will increase
with the size of the list.
