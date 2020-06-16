Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293A81FBA06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbgFPQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 12:08:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732621AbgFPQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592323686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAmfsG1yWQp7htmzd31AkeGRX9NdjCJmJao6WCNJhSM=;
        b=BmJpuHEZwKXYSOnb4vbxjFOyA3bTGKge3rlhMwBTbDLm1hUmHJ0MH3hsorfYhHU4/EPHIA
        1CPTbLlU5gLDMAy5haVh8HtnixOVACJis5LJVEYuy/yIIwJks2vHhUsKO6VSvt5TN898LA
        mQtHotQj+4fjXK4BJx4x3vD6WVknkkc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4--i01vMbTPHimJat9megvSQ-1; Tue, 16 Jun 2020 12:08:04 -0400
X-MC-Unique: -i01vMbTPHimJat9megvSQ-1
Received: by mail-wm1-f72.google.com with SMTP id v24so1459552wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAmfsG1yWQp7htmzd31AkeGRX9NdjCJmJao6WCNJhSM=;
        b=mO38A1kZFb7Qps0tJD8/7PrIc6RMhFnH+r5zXg/0DtwtmsELFJk6eTxa1rOculyW4c
         r+07ZeB8SfOancqLOuA5TkfBn2Cl7oFxU4A6rtSVIKMmnjxTpbYJhVcdGJQaxeVj9pr/
         OYEUe38SnYtq07UazPgLELy2PI7pau3vXXbt/FwuFhiacEwIiBj6CvPwTGT5WHW9crgU
         qF6uZ1ePTjftUEJUeDLuFAmcbvY1zQc7LhzGa58x0Cw2eaEAuL6stceLNLrIvUr/BImx
         6jEBQ9tgEzAzgYPLfSaEtjKMhvtCqZtZS7+FLGtYxfGaZQ6t4dx7GkRRpBioF15NX4/U
         8f3g==
X-Gm-Message-State: AOAM531Ygyw3VWgDMZX/nw2VDOjpxPU3dGSULPGRMPd6pyIVBTWwuCbM
        p04Wndlx1wml2hy9NwmYAZxaSb0Zvho3O8xL6qNTFGvzom/5KTGwZZxJdCLS7H5+zEDJTWJMfA3
        z/eRu054jwlKercQdglbM6wzc
X-Received: by 2002:adf:f30d:: with SMTP id i13mr3605167wro.146.1592323682798;
        Tue, 16 Jun 2020 09:08:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb5FVBHSOCazvOPkG3bOZ/JxTqnrTMlUtzCXzy6s29kSBJKESc5gH7/BCfoimMoGcNzTEObQ==
X-Received: by 2002:adf:f30d:: with SMTP id i13mr3605125wro.146.1592323682491;
        Tue, 16 Jun 2020 09:08:02 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id z2sm28570535wrs.87.2020.06.16.09.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:08:01 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:07:57 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200616160757.vc2jsgilvsgnrf3p@steredhat>
References: <20200609142406.upuwpfmgqjeji4lc@steredhat>
 <CAG48ez3kdNKjif==MbX36cKNYDpZwEPMZaJQ1rrpXZZjGZwbKw@mail.gmail.com>
 <20200615133310.qwdmnctrir5zgube@steredhat>
 <f7f2841e-3dbb-377f-f8f8-826506a938a6@kernel.dk>
 <20200616091247.hdmxcrnlrrxih7my@steredhat>
 <9483bbde-b1de-93b1-a239-4ba3613a63e5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9483bbde-b1de-93b1-a239-4ba3613a63e5@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:26:31AM -0600, Jens Axboe wrote:
> On 6/16/20 3:12 AM, Stefano Garzarella wrote:
> > On Mon, Jun 15, 2020 at 11:00:25AM -0600, Jens Axboe wrote:
> >> On 6/15/20 7:33 AM, Stefano Garzarella wrote:
> >>> On Mon, Jun 15, 2020 at 11:04:06AM +0200, Jann Horn wrote:
> >>>> +Kees, Christian, Sargun, Aleksa, kernel-hardening for their opinions
> >>>> on seccomp-related aspects
> >>>>
> >>>> On Tue, Jun 9, 2020 at 4:24 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>>>> Hi Jens,
> >>>>> Stefan and I have a proposal to share with io_uring community.
> >>>>> Before implementing it we would like to discuss it to receive feedbacks and
> >>>>> to see if it could be accepted:
> >>>>>
> >>>>> Adding restrictions to io_uring
> >>>>> =====================================
> >>>>> The io_uring API provides submission and completion queues for performing
> >>>>> asynchronous I/O operations. The queues are located in memory that is
> >>>>> accessible to both the host userspace application and the kernel, making it
> >>>>> possible to monitor for activity through polling instead of system calls. This
> >>>>> design offers good performance and this makes exposing io_uring to guests an
> >>>>> attractive idea for improving I/O performance in virtualization.
> >>>> [...]
> >>>>> Restrictions
> >>>>> ------------
> >>>>> This document proposes io_uring API changes that safely allow untrusted
> >>>>> applications or guests to use io_uring. io_uring's existing security model is
> >>>>> that of kernel system call handler code. It is designed to reject invalid
> >>>>> inputs from host userspace applications. Supporting guests as io_uring API
> >>>>> clients adds a new trust domain with access to even fewer resources than host
> >>>>> userspace applications.
> >>>>>
> >>>>> Guests do not have direct access to host userspace application file descriptors
> >>>>> or memory. The host userspace application, a Virtual Machine Monitor (VMM) such
> >>>>> as QEMU, grants access to a subset of its file descriptors and memory. The
> >>>>> allowed file descriptors are typically the disk image files belonging to the
> >>>>> guest. The memory is typically the virtual machine's RAM that the VMM has
> >>>>> allocated on behalf of the guest.
> >>>>>
> >>>>> The following extensions to the io_uring API allow the host application to
> >>>>> grant access to some of its file descriptors.
> >>>>>
> >>>>> These extensions are designed to be applicable to other use cases besides
> >>>>> untrusted guests and are not virtualization-specific. For example, the
> >>>>> restrictions can be used to allow only a subset of sqe operations available to
> >>>>> an application similar to seccomp syscall whitelisting.
> >>>>>
> >>>>> An address translation and memory restriction mechanism would also be
> >>>>> necessary, but we can discuss this later.
> >>>>>
> >>>>> The IOURING_REGISTER_RESTRICTIONS opcode
> >>>>> ----------------------------------------
> >>>>> The new io_uring_register(2) IOURING_REGISTER_RESTRICTIONS opcode permanently
> >>>>> installs a feature whitelist on an io_ring_ctx. The io_ring_ctx can then be
> >>>>> passed to untrusted code with the knowledge that only operations present in the
> >>>>> whitelist can be executed.
> >>>>
> >>>> This approach of first creating a normal io_uring instance and then
> >>>> installing restrictions separately in a second syscall means that it
> >>>> won't be possible to use seccomp to restrict newly created io_uring
> >>>> instances; code that should be subject to seccomp restrictions and
> >>>> uring restrictions would only be able to use preexisting io_uring
> >>>> instances that have already been configured by trusted code.
> >>>>
> >>>> So I think that from the seccomp perspective, it might be preferable
> >>>> to set up these restrictions in the io_uring_setup() syscall. It might
> >>>> also be a bit nicer from a code cleanliness perspective, since you
> >>>> won't have to worry about concurrently changing restrictions.
> >>>>
> >>>
> >>> Thank you for these details!
> >>>
> >>> It seems feasible to include the restrictions during io_uring_setup().
> >>>
> >>> The only doubt concerns the possibility of allowing the trusted code to
> >>> do some operations, before passing queues to the untrusted code, for
> >>> example registering file descriptors, buffers, eventfds, etc.
> >>>
> >>> To avoid this, I should include these operations in io_uring_setup(),
> >>> adding some code that I wanted to avoid by reusing io_uring_register().
> >>>
> >>> If I add restrictions in io_uring_setup() and then add an operation to
> >>> go into safe mode (e.g. a flag in io_uring_enter()), we would have the same
> >>> problem, right?
> >>>
> >>> Just to be clear, I mean something like this:
> >>>
> >>>     /* params will include restrictions */
> >>>     fd = io_uring_setup(entries, params);
> >>>
> >>>     /* trusted code */
> >>>     io_uring_register_files(fd, ...);
> >>>     io_uring_register_buffers(fd, ...);
> >>>     io_uring_register_eventfd(fd, ...);
> >>>
> >>>     /* enable safe mode */
> >>>     io_uring_enter(fd, ..., IORING_ENTER_ENABLE_RESTRICTIONS);
> >>>
> >>>
> >>> Anyway, including a list of things to register in the 'params', passed
> >>> to io_uring_setup(), should be feasible, if Jens agree :-)
> >>
> >> I wonder how best to deal with this, in terms of ring visibility vs
> >> registering restrictions. We could potentially start the ring in a
> >> disabled mode, if asked to. It'd still be visible in terms of having
> >> the fd installed, but it'd just error requests. That'd leave you with
> >> time to do the various setup routines needed before then flagging it
> >> as enabled. My only worry on that would be adding overhead for doing
> >> that. It'd be cheap enough to check for IORING_SETUP_DISABLED in
> >> ctx->flags in io_uring_enter(), and return -EBADFD or something if
> >> that's the case. That doesn't cover the SQPOLL case though, but maybe we
> >> just don't start the sq thread if IORING_SETUP_DISABLED is set.
> > 
> > It seems to me a very good approach and easy to implement. In this way
> > we can reuse io_uring_register() without having to modify too much
> > io_uring_setup().
> 
> Right
> 
> >> We'd need a way to clear IORING_SETUP_DISABLED through
> >> io_uring_register(). When clearing, that could then start the sq thread
> >> as well, when SQPOLL is set.
> > 
> > Could we do it using io_uring_enter() since we have a flag field or
> > do you think it's semantically incorrect?
> 
> Either way is probably fine, I gravitated towards io_uring_register()
> since any io_uring_enter() should fail if the ring is disabled. But I
> guess it's fine to allow the "enable" operation through io_uring_enter.
> Keep in mind that io_uring_enter is the hottest path, where
> io_uring_register is not nearly as hot and we can allow ourselves a bit
> more flexibility there.

Right, now I see and I totally agree!

> 
> In summary, I'd be fine with io_uring_enter if it's slim and lean, still
> leaning towards doing it in io_uring_register as it seems like a more
> natural fit.

Thanks for the clarification. I'll take that into account.

Stefano

