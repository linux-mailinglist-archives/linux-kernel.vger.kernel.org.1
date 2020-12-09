Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43912D4804
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgLIReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:34:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36068 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgLIReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:34:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id y24so2150650otk.3;
        Wed, 09 Dec 2020 09:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lwd8/l7feZCwoHFobcRWjKb7ZJVB2/QEsYxX7pRhBns=;
        b=Qie8maX/syVTDsD44v+8C/vK2e40+KreAlcjgsgGum0PJ3yHi8I3wCc9omss9Upcpi
         kVZcHotWWHTfRpLYFakWgLuepJRM1IutHbtSxdnE878quJ2mjOGM0qvzBF51g/iRv3xd
         B7CrlaIZPcMOY/0FW//RyS7dMqw5vLexppF66IMswSAPkU1Z7P5SScdJIiD0MxZhAg6R
         ZtiVXdHBDQa9mUIa/enPNNOMnFKUFaCwryeZqK1fh3ygs+ebZ5lq8tbX40bGN1Re57CI
         +uJyH6dbq0Ntcx5vgE396LIG9dPu3EqWizxcH3H3TcVhRGJ29zELXSMdV1tYuksSwY3U
         PqAQ==
X-Gm-Message-State: AOAM531UgtUcw1crR48b+W+BlgH5iFLOKLN1ZuvdlkqSfv88mQR10pci
        3RYdsMcZ8M4lBRO7rmTQ/g==
X-Google-Smtp-Source: ABdhPJz7fUonVxT0gZyV3veQWVtgfz40eGN12mJ23xkoOpk54Vde7VP/YSHxQb4AU/l2IfWl57cL9g==
X-Received: by 2002:a9d:be1:: with SMTP id 88mr2739822oth.210.1607535218842;
        Wed, 09 Dec 2020 09:33:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o63sm452791ooa.10.2020.12.09.09.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 09:33:37 -0800 (PST)
Received: (nullmailer pid 650380 invoked by uid 1000);
        Wed, 09 Dec 2020 17:33:35 -0000
Date:   Wed, 9 Dec 2020 11:33:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     mgross@linux.intel.com, daniele.alessandrelli@intel.com,
        markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
Message-ID: <20201209173335.GA644399@robh.at.kernel.org>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-3-mgross@linux.intel.com>
 <20201207160152.GB351233@robh.at.kernel.org>
 <ca099c0833dc79f0a88edecd9fb949157eacbf46.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca099c0833dc79f0a88edecd9fb949157eacbf46.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 06:42:07PM +0000, Daniele Alessandrelli wrote:
> Hi Rob,
> 
> Thanks for the feedback.
> 
> On Mon, 2020-12-07 at 10:01 -0600, Rob Herring wrote:
> > On Tue, Dec 01, 2020 at 02:34:51PM -0800, mgross@linux.intel.com wrote:
> > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > 
> > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > > enables communication between the Computing Sub-System (CSS) and the
> > > Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> > > Bay.
> > > 
> 
> [cut]
> 
> > > +
> > > +description:
> > > +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> > > +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> > > +  Keem Bay.
> > 
> > Sounds like a mailbox.
> 
> We did consider using the mailbox framework, but eventually decided
> against it; mainly because of the following two reasons:
> 
> 1. The channel concept in the Mailbox framework is different than the
>    channel concept in Keem Bay IPC:
> 
>    a. My understanding is that Mailbox channels are meant to be SW
>       representation of physical HW channels, while in Keem Bay IPC
>       channels are software abstractions to achieve communication
>       multiplexing over a single HW link
> 
>    b. Additionally, Keem Bay IPC has two different classes of channels 
>       (high-speed channels and general-purpose channels) that need to
>       access the same HW link with different priorities.
> 
> 2. The blocking / non-blocking TX behavior of mailbox channels is
>    defined at channel creation time (by the tx_block value of the
>    mailbox client passed to mbox_request_channel(); my understanding 
>    is that the tx_block value cannot be modified after the channel is
>    created), while in Keem Bay IPC the same channel can be used for
>    both blocking and non-blocking TX (behavior is controlled by the
>    timeout argument passed to keembay_ipc_send()).
> 
> Having said that, I guess that it could be possible to create a Mailbox
> driver implementing the core communication mechanism used by the Keem
> Bay IPC and then build our API around it (basically having two
> drivers). But I'm not sure that would make the code simpler or easier
> to maintain. Any thoughts on this?

The use of the mailbox binding and the kernel's mailbox framework are 
independent questions. I'm only concerned with the former (for purposes 
of this review).

Rob
