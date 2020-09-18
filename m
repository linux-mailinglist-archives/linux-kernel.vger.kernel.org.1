Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8326FC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIRMev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgIRMeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600432488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yFL1J1bN4oghdcZX9EfHyyg2YFZ2DjLqRasYbuBJRkE=;
        b=M1/eTZ708+2481zwbGWNeZJc3q49M3MovBuHLA890lKuXaJd1S6DlOBD9GoQ+ZV+g0ukaF
        TXf+c1Tt9HXzRdjsGzTTYQ7efasS0vortjtKkreZ9PkxtPMSM7u+PuqqrOwyqEHu4Xcfco
        bKGsOc6jCffE9cb31r+AivO6L1SDG/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-PuuqrAtCMU2qrJ_ftUDkXA-1; Fri, 18 Sep 2020 08:34:45 -0400
X-MC-Unique: PuuqrAtCMU2qrJ_ftUDkXA-1
Received: by mail-wm1-f69.google.com with SMTP id c200so2004232wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFL1J1bN4oghdcZX9EfHyyg2YFZ2DjLqRasYbuBJRkE=;
        b=QXxIAFgw8YsyV0tZHN9w0rCZOlYjLupu1NWofi8hzYqP1eLE4gKNSKKOZl5ofHsbKV
         NxFlURZHUY4WRfknr4FcBizIeQ8kRZeUw+nYC5OPpYJEh3GHpOMvee5DaIsuRvj0sWh6
         8v/s+PdiluEVrhLAKEPobg9WWkXStpaqnbAHEJeCuITM8NAWVtYd4fXLIqjusXKGqGwd
         PLRjLp7PYDnnt4VnljZyZc9Ft/D3e3DYMEE343/QwCbTM9O7h6zy5vVFdbAxR7Nsc/b3
         PbPug2eaJL+S47tgDs3isw6POHac5RkUczvaq3/400mDXv7lHWrMZ37hYw+cBWneo7An
         r4Tw==
X-Gm-Message-State: AOAM532jsB/o7SunfvxbYEromy4Nn2ODT5A6p/UUV9UesTS2JCLllnPr
        W1mbdogHFjCLsKf1vZg/NHc+oH1J9COSWR8Y7GqUmyWK6jouDJ/ABfVqBb6RbNo1f7vNX2UH8xH
        YHoG968w7O30OYaOiE0F9lnjK
X-Received: by 2002:adf:a29a:: with SMTP id s26mr33384938wra.197.1600432483972;
        Fri, 18 Sep 2020 05:34:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXdalGS6hlmyjOwZ5A9fIZmHXFJxHQpx7cr8E0X3hkQqD2L8q75gwzUbB84egoCSy/YGe2JA==
X-Received: by 2002:adf:a29a:: with SMTP id s26mr33384910wra.197.1600432483729;
        Fri, 18 Sep 2020 05:34:43 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net. [109.65.116.225])
        by smtp.gmail.com with ESMTPSA id k12sm5059326wrn.39.2020.09.18.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:34:41 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:34:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
Message-ID: <20200918083134-mutt-send-email-mst@kernel.org>
References: <20200825212526.GC8235@xz-x1>
 <87eenlwoaa.fsf@vitty.brq.redhat.com>
 <20200901200021.GB3053@xz-x1>
 <877dtcpn9z.fsf@vitty.brq.redhat.com>
 <20200904061210.GA22435@sjchrist-ice>
 <20200904072905.vbkiq3h762fyzds6@sirius.home.kraxel.org>
 <20200904160008.GA2206@sjchrist-ice>
 <874koanfsc.fsf@vitty.brq.redhat.com>
 <20200907072829-mutt-send-email-mst@kernel.org>
 <20200911170031.GD4344@sjchrist-ice>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911170031.GD4344@sjchrist-ice>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 10:00:31AM -0700, Sean Christopherson wrote:
> On Mon, Sep 07, 2020 at 07:32:23AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 07, 2020 at 10:37:39AM +0200, Vitaly Kuznetsov wrote:
> > > Sean Christopherson <sean.j.christopherson@intel.com> writes:
> > > 
> > > > On Fri, Sep 04, 2020 at 09:29:05AM +0200, Gerd Hoffmann wrote:
> > > >>   Hi,
> > > >> 
> > > >> > Unless I'm mistaken, microvm doesn't even support PCI, does it?
> > > >> 
> > > >> Correct, no pci support right now.
> > > >> 
> > > >> We could probably wire up ecam (arm/virt style) for pcie support, once
> > > >> the acpi support for mictovm finally landed (we need acpi for that
> > > >> because otherwise the kernel wouldn't find the pcie bus).
> > > >> 
> > > >> Question is whenever there is a good reason to do so.  Why would someone
> > > >> prefer microvm with pcie support over q35?
> > > >> 
> > > >> > If all of the above is true, this can be handled by adding "pci=lastbus=0"
> > > >> > as a guest kernel param to override its scanning of buses.  And couldn't
> > > >> > that be done by QEMU's microvm_fix_kernel_cmdline() to make it transparent
> > > >> > to the end user?
> > > >> 
> > > >> microvm_fix_kernel_cmdline() is a hack, not a solution.
> > > >> 
> > > >> Beside that I doubt this has much of an effect on microvm because
> > > >> it doesn't support pcie in the first place.
> > > >
> > > > I am so confused.  Vitaly, can you clarify exactly what QEMU VM type this
> > > > series is intended to help?  If this is for microvm, then why is the guest
> > > > doing PCI scanning in the first place?  If it's for q35, why is the
> > > > justification for microvm-like workloads?
> > > 
> > > I'm not exactly sure about the plans for particular machine types, the
> > > intention was to use this for pcie in QEMU in general so whatever
> > > machine type uses pcie will benefit. 
> > > 
> > > Now, it seems that we have a more sophisticated landscape. The
> > > optimization will only make sense to speed up boot so all 'traditional'
> > > VM types with 'traditional' firmware are out of
> > > question. 'Container-like' VMs seem to avoid PCI for now, I'm not sure
> > > if it's because they're in early stages of their development, because
> > > they can get away without PCI or, actually, because of slowness at boot
> > > (which we're trying to tackle with this feature). I'd definitely like to
> > > hear more what people think about this.
> > 
> > I suspect microvms will need pci eventually. I would much rather KVM
> > had an exit-less discovery mechanism in place by then because
> > learning from history if it doesn't they will do some kind of
> > hack on the kernel command line, and everyone will be stuck
> > supporting that for years ...
> 
> Is it not an option for the VMM to "accurately" enumerate the number of buses?
> E.g. if the VMM has devices on only bus 0, then enumerate that there is one
> bus so that the guest doesn't try and probe devices that can't possibly exist.
> Or is that completely non-sensical and/or violate PCIe spec?


There is some tension here, in that one way to make guest boot faster
is to defer hotplug of devices until after it booted.

-- 
MST

